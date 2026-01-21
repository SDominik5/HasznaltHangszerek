let _token = "";
const _baseUrl = "http://localhost:5260/api/";

async function callAPI(url, method, data) {
  const options = {
    body: JSON.stringify(data),
    headers: {
      Authorization: "Bearer " + _token,
      "Contetn-Type": "application/json",
    },
    method: method,
    mode: "no-cors",
  };

  fetch(`${_baseUrl}/${url}`, options)
    .then(
      (resp) => {
        return resp.json;
      },
      (reason) => {
        console.log(reason);
      },
    )
    .then((data) => data);

  await fetch(`${_baseUrl}/${url}`, options);
}
