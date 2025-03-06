"use strict";

exports.handler = async (event, context) => {
  const s3DomainName = "${s3_domain_name}"

  console.log(JSON.stringify({ event }, null, 2));
  const { request } = event.Records[0].cf;
  const { headers } = request;
  const host = headers["host"][0].value;

  const getPath = (domain) => {
    const [subdomain] = domain.split(".");
    return '/'.concat(subdomain);
  };

  request.origin = {
    s3: {
      domainName: s3DomainName,
      region: "us-east-1",
      authMethod: "none",
      path: getPath(host),
      customHeaders: {},
    },
  };

  request.headers["host"] = [{ key: "host", value: s3DomainName }];
  console.log(JSON.stringify({ modifiedRequest: request }, null, 2));

  return request;
};
