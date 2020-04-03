# Must have `sentry-cli` installed globally
# Following variable must be passed in
# SENTRY_AUTH_TOKEN
SENTRY_ORG=testorg-az
SENTRY_PROJECT=ido-react-hardware
VERSION=`sentry-cli releases propose-version`
PREFIX=static/js
ENVIRONMENT=Staging

setup_release: create_release associate_commits upload_sourcemaps deploy_release

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(VERSION)
	# sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --commit "idosun/react-demo-app@f92fab9a247cf6b08afdcd7a2a3f2edc6f8c4739..ea21dfbfddcc1df99916fe8c979c136cf374193c" $(VERSION)

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(VERSION) \
		upload-sourcemaps --no-rewrite --url-prefix "~/$(PREFIX)" --validate build/$(PREFIX)

deploy_release:
	sentry-cli releases -o $(SENTRY_ORG) deploys $(VERSION) new -e $(ENVIRONMENT)
