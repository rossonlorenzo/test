#import "./template/big_docs.typ": *

#show: project.with(
  title: "Norme di progetto",
  managers: p.rosson,
  recipients: (
    p.vardanega,
    p.cardin,
  ),
  changelog: (
    "1.0.0", "2023-11-13", p.rosson, p.rosson, "desc",
  ),
)

= Introduzione

== Scopo del documento
Pippo Baudo
