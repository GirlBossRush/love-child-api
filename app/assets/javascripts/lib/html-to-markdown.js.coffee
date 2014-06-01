# A quickly thought up method to convert HTML to Markdown.
# Consider this a first draft.

define ->
  (html = "") ->
    markdown = html
      .replace(/\r\n+|\r+|\n+|\t+/ig," ")
      .replace(/<h1>/g,"# ")
      .replace(/<\/h1>/g,"")
      .replace(/<strong>|<\/strong>/g,"**")
      .replace(/<em>|<\/em>/g,"*")
      .replace(/<blockquote>/g,"> ")
      .replace(/<\/blockquote>/g,"")
      .replace(/<p>|<\/p>/gi,"\n")
      .replace(/<br>/g,"\n")

    links = html.match(/<a href="(.+)">(.+)<\/a>/gi)

    if links != null
      for link, i in links
        tmpparent = document.createElement('div')
        tmpparent.innerHTML = links[i]

        tmp = tmpparent.firstChild

        href = tmp.getAttribute('href')
        linktext = tmp.textContent || tmp.innerText || ""

        markdown = markdown.replace(links[i],'['+linktext+']('+href+')')

    return markdown

