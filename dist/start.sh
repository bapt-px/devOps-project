#!/bin/sh

/usr/local/glassfish4/bin/asadmin start-domain
/usr/local/glassfish4/bin/asadmin -u admin deploy /projet.war
/usr/local/glassfish4/bin/asadmin stop-domain
/usr/local/glassfish4/bin/asadmin start-domain --verbose
