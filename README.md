# RightsStatements.js

This package consumes the [RightsStatements.org RDF Data
Model](https://github.com/rightsstatements/data-model) and converts it
to JSON as well as exports it as a javascript array of
simplified statements.

# Use

```js
rightsStatements = require('rightsstatements')
rightsStatements.find(stmt => stmt.identifier === 'NKC')
```

```js
{ id: 'http://rightsstatements.org/vocab/NKC/1.0/',
  identifier: 'NKC',
  label: 'No Known Copyright',
  definition: 'The organization that has made the Item available
    reasonably believes that the Item is not restricted by copyright
    or related rights, but a conclusive determination could not be
    made.\n\nPlease refer to the organization that has made the Item
    available for more information.\n\nYou are free to use this Item
    in any way that is permitted by the copyright and related rights
    legislation that applies to your use.',
  scopeNote: 'This Rights Statement should be used for Items for
    which the copyright status has not been determined conclusively,
    but for which the organization that intends to make the Item
    available has reasonable cause to believe that the underlying
    Work is not covered by copyright or related rights anymore. This
    Rights Statement should not be used for Orphan Works (which are
    assumed to be in-copyright) or for Works where the organization
    that intends to make the Item available has not undertaken an
    effort to ascertain the copyright status of the underlying
    Work.',
  modified: '2015-10-16',
  versionInfo: '1.0' }
```

# License

-   [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
