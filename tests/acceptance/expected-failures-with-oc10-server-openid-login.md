## Scenarios from web tests that are expected to fail on oC10

Lines that contain a format like "[someSuite.someFeature.feature:n](https://github.com/owncloud/web/path/to/feature)"
are lines that document a specific expected failure. Follow that with a URL to the line in the feature file in GitHub.
Please follow this format for the actual expected failures.

Level-3 headings should be used for the references to the relevant issues. Include the issue title with a link to the issue in GitHub.

Other free text and markdown formatting can be used elsewhere in the document if needed. But if you want to explain something about the issue, then please post that in the issue itself.

### [WebUI Login](https://github.com/owncloud/web/issues/4677)
-   [webUILogin/openidLogin.feature:50](https://github.com/owncloud/web/blob/master/tests/acceptance/features/webUILogin/openidLogin.feature#L50)
-   [webUILogin/openidLogin.feature:60](https://github.com/owncloud/web/blob/master/tests/acceptance/features/webUILogin/openidLogin.feature#L60)
