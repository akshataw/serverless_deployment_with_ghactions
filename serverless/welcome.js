'use strict';

module.exports.welcome = async (event) => {
  let html = `
    <h1>Welcome to ${process.env.appName}</h1>
    <p>Stage: ${event.requestContext.stage}</p>`;
  
  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'text/html',
    },
    body: html
  };
};
