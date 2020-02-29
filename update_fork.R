# Sincroniza una copia clonada de UCAanalytics con el respectivo master project.

if (!suppressWarnings(require(git2r))) {
  install.packages("git2r", repos="http://cran.r-project.org/", quiet=TRUE)
  library(git2r)
}

repo <- repository(".")
if (!("upstream" %in% remotes(repo))) {
  remote_add(repo, "upstream", "https://github.com/conciclicboy/UCAanalytics")
}

conf <- config(repo)
if (is.null(conf$local$user.name) && is.null(conf$global$user.name)) {
  message("Su usuario de Github username aún no ha sifo configurado para este repositorio.")
  config(repo, user.name=readline("Github username: "))
}

if (is.null(conf$local$user.email) && is.null(conf$global$user.email)) {
  message("Su email de Github aún no ha sifo configurado para este repositorio.")
  config(repo, user.email=readline("Github email: "))
}

fetch(repo, "upstream")
checkout(repo, "master")
merge(repo, "upstream/master")

message("
  Su copia local de UCAanalytics está ahora en sync con el master project.
  Usted puede actualizar su copia remota haciendo click en 'Push' en el panel de 'Git' panel o 
  ejecutando:
  
  push(repo, credentials=cred_user_pass(readline('Github username: '), readline('Github password: ')))
")