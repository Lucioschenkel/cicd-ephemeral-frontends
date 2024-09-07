const originRequest = require("./origin-request");
const viewerRequest = require("./viewer-request");

exports.handler = async (event, context) => {
  const config = event.Records[0].cf.config;

  switch (config.eventType) {
    case "viewer-request":
      return viewerRequest.handler(event, context);
    case "origin-request":
      return originRequest.handler(event, context);
    default:
      break;
  }
  return event.Records[0].cf.request;
};
