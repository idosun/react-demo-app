# Must have `sentry-cli` installed globally
# SENTRY_AUTH_TOKEN variable must be set in your bash profile or as an env variable.
# To generate an Org Auth token, create a new app in our integration platform as described here:
# https://docs.sentry.io/workflow/integrations/integration-platform/#auth-tokens-1
SENTRY_ORG=testorg-az
SENTRY_PROJECT=ido-react-hardware
VERSION=`sentry-cli releases propose-version`
PREFIX=static/js
ENVIRONMENT=Canary
SENTRY_LOG_LEVEL=info

setup_release: create_release associate_commits upload_sourcemaps deploy_release

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION) 

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --commit --initial-depth  idosun/react-demo-app@204f7b03c7f5514d540e8ef7fa6037c8b29aac55 --commit idosun/react-demo-app@0ad4fe9c81093ad2dd55edcd032bb78b5413905f $(VERSION)
#	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(VERSION)
# sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --commit "idosun/react-demo-app@f92fab9a247cf6b08afdcd7a2a3f2edc6f8c4739..ea21dfbfddcc1df99916fe8c979c136cf374193c" $(VERSION)

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(VERSION) \
		upload-sourcemaps --rewrite --url-prefix "~/$(PREFIX)" --validate build/$(PREFIX)

deploy_release:
	sentry-cli releases -o $(SENTRY_ORG) deploys $(VERSION) new -e $(ENVIRONMENT)
