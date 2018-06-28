/*
Write a function that when given a URL as a string, parses out just the domain name and returns it as a string. For example:

domainName("http://github.com/carbonfive/raygun") == "github"
domainName("http://www.zombie-bites.com") == "zombie-bites"
domainName("https://www.cnet.com") == "cnet"
*/

function domainName(url){
  return url.match(/^(https?\:\/\/)?(www\.)?([a-z0-9\-]+)\.[a-z0-9]+\/?.*$/)[3];
}

domainName("http://github.com/carbonfive/raygun");  // == "github"
domainName("http://www.zombie-bites.com");          // == "zombie-bites"
domainName("https://www.cnet.com");                 // == "cnet"
domainName("https://youtube.com");                  // == "youtube"
