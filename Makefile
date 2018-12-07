URL = 'https://raw.githubusercontent.com/rightsstatements/data-model/master/rights-statements.ttl' 

# Download rights statements as RDF
# 
# `rdfpipe` is installed with rdflib, json-ld output enabled by rdflib-jsonld
# see requirements.txt. How does pip work?
rights-statements.jsonld:
	rdfpipe $(URL) --output='json-ld' \
			> tee rights-statements.jsonld

# Convert to an array of JSON objects with basic info for each statement
rights-statements.json: rights-statements.jsonld
	@jq '.[0]["@graph"] | map({ \
	  id: .["@id"], \
		identifier: .["http://purl.org/dc/elements/1.1/identifier"], \
		label: .["http://www.w3.org/2004/02/skos/core#prefLabel"], \
		definition: .["http://www.w3.org/2004/02/skos/core#definition"], \
		scopeNote: .["http://www.w3.org/2004/02/skos/core#scopeNote"], \
		modified: .["http://purl.org/dc/terms/modified"], \
		versionInfo: .["http://www.w3.org/2002/07/owl#versionInfo"] \
	}) \
  | map(select(.definition)) \
	| map(with_entries(.value |= ((. | strings) // \
		if (. | length) == 1 then \
	    .[0]["@value"] \
		elif (.[0] | has("@language")) then \
		  .|map(select(.["@language"] == "en"))[0]["@value"] \
		else \
		  "unhandled value" \
		end))) \
	' $< | tee rights-statements.json

#\
# . | map(select(.["@language"] == "en")) \

.PHONY: rights-statements.json

# Export the same basic data as a javascript module to include in other projects
index.js: rights-statements.json
	@(printf 'module.exports = '; \
	jq -c '.' $<) | tee index.js
