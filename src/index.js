import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './components/App';
import registerServiceWorker from './registerServiceWorker';

// var opentracing = require('opentracing');
// var lightstep   = require('lightstep-tracer');

// var tracer = new lightstep.Tracer({
//   component_name : 'idos-test-service',
//   access_token : '1ogVmDF7bHKSGd7r/2FlADQDsiPxOHcXlYsgWhkyNqwIUBkoE0A7N0L2AW/x4xntr2MsHngZVbeTh2RkuJ87LtT+2FbJWGWDAkKDLQS2',
// });

// opentracing.initGlobalTracer(tracer);

// var span = opentracing.globalTracer().startSpan('test_span');
// span.setTag('kind', 'server')
// span.log({ event: 'what a lovely day' })
// span.finish()

// // tracer.flush() will ensure that your span is sent
// tracer.flush()

  

ReactDOM.render(<App /> , document.getElementById('root'));

registerServiceWorker();
