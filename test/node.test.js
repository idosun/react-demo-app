const NodeSentry = require('@sentry/browser')
const sentryTestkit = require("sentry-testkit")
const { createCommonTests } = require('./commonTests')

const { testkit, sentryTransport } = sentryTestkit()
// initialize your Sentry instance with sentryTransport
// Sentry.init({
//     dsn: 'some_dummy_dsn',
//     transport: sentryTransport
//     //... other configurations
//   })
  
//   // then run any scenario that should call Sentry.catchException(...)
  
//   expect(testKit.reports()).toHaveLength(1)
//   const report = testKit.reports()[0]
//   expect(report).toHaveProperty(/*...*/)

const DUMMY_DSN = 'https://acacaeaccacacacabcaacdacdacadaca@sentry.io/000001'
const Sentry = NodeSentry
describe('sentry test-kit test suite - @sentry/browser', function() {
  beforeAll(() =>
    Sentry.init({
      dsn: DUMMY_DSN,
      release: 'test',
      transport: sentryTransport,
      beforeSend(event) {
        event.extra = { os: 'mac-os' }
        return event
      },
    })
  )

  beforeEach(() => testkit.reset())

  createCommonTests({ Sentry, testkit })
})
