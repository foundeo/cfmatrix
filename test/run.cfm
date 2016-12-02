<cfcontent type="text/plain" reset="true">
This is where your test runner goes.

If tests pass make sure it returns a HTTP 200 status code, if tests fail make sure it returns a failure code such as 500.

<cfoutput>Server Version: <cfif structKeyExists(server, "lucee")>Lucee: #server.lucee.version#<cfelse>ColdFusion #server.coldfusion.productversion#</cfif></cfoutput>