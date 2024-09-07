exports.handler = async (event, context) => {
  console.log("viewer-request type");
  const request = event.Records[0].cf.request;
  const host = request.headers.host[0].value;

  request.headers["x-host"] = [{ key: "x-host", value: host }];

  console.log(`forwarding host: ${host}`);

  return request;
};
