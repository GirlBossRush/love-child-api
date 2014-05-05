CSRF = document.querySelector("meta[name='csrf-token']").content

@LC =
  CSRF: CSRF
  AJAX:
    DELETE:
      handleAs: "json"
      method: "DELETE"
      headers:
        'X-CSRF-Token': CSRF
