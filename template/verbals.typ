#import "info.typ": *

#let getSurname(a) = {
  return a.split().at(-1)
}

#let sortBySurname(a) = {
  let a = (a,).flatten().dedup()
  if a.last() == false {
    a.pop()
    return a
  }
  return a.sorted(key: getSurname)
}

#let project(
  title: none,
  managers: none,
  recipients: none,
  group_is_recipient: true,
  changelog: none,
  show_outline: true,
  outline_depth: none,
  heading_numbers: "1.1)",
  body,
) = {

  set text(font: "New Computer Modern", lang: "it")
  set heading(numbering: heading_numbers)
  show link: underline

  let version = changelog.at(0, default: none);
  let document_title = title
  if version != none {
    version = "v" + version
  }
  set document(author: g.name, title: document_title)

  set align(center)
  text(2.3em, weight: 700, title) + [\ #v(1.5em)]

  version
  set align(horizon)
  image(g.uni-logo, width: 42%)
  box(image(g.group-logo, width: 10%), baseline: 14pt)
  text(2.3em, g.name) + [\ #v(1.5em)]
  text(1.1em, link("mailto:"+g.mail))

  let keep(r) = {
    changelog.enumerate().filter(i => r.contains(i.first())).map(i => i.last())
  }
  let changelog_header = ([*Versione*], [*Data*], [*Scrittori*], [*Revisori*], [*Descrizione*])
  let r_editors = array.range(2, changelog.len(), step: changelog_header.len())
  let r_verifiers = r_editors.map(i => i+1)
  let editors = keep(r_editors)
  let verifiers = keep(r_verifiers)

  if group_is_recipient == true {
    recipients += ([Gruppo _#(g.name)_],)
  }

  set align(bottom)

  if version != none and changelog.len() > 2 {
    changelog = changelog_header + changelog;
    heading(
      outlined: false,
      numbering: none,
      [Registro delle modifiche]
    )
    table(
      fill: (_, row) => if calc.odd(row) { luma(215) } else { white },
      inset: 0.5em,
      columns: (auto,)*4 + (1fr,),
      ..changelog.map(el => text(size: 0.8em)[
        #par(justify: false,
          if type(el) == array {
            sortBySurname(el).join([,\ ])
          } else {
            el
          }
        )
      ]),
    )
    pagebreak()
  }

  set align(top + start)

  set page(
    footer: gridx(
      columns: (1fr, 1fr),
      align: (left, right),
      hlinex(stroke: 0.05em),
      box(
      image(g.group-logo, width:  1.5em), baseline: 0.4em) + 
      g.name,
      text("pagina: ") +
      counter(page).display(
      "1", 
    )
    ),
  )



  if show_outline == true {
    outline(depth: outline_depth, indent: true)
    pagebreak()
  }

  show heading: it => {
    if heading_numbers != none {
      counter(heading).display() + " "
    }
    it.body
    v(0.3em)
  }
  set align(start+top)
  set par(justify: true)
  set text(hyphenate: true)
  body
}

