
#let raw-iosevka(it) = {
  set text(
    font: "Iosevka Extended",
    features: (calt: 0, IDRS: 1),
  )
  it
}

#let raw-idris(it) = {
  set raw(
    syntaxes: "idris2.sublime-syntax",
    theme: "idris2.tmTheme",
  )
  it
}

#let idris-setup(it) = {
  show raw: raw-iosevka
  show raw.where(lang: "idris"): set raw(
    syntaxes: "idris2.sublime-syntax",
    theme: "idris2.tmTheme",
  )

  show raw.where(lang: "idris2"): set raw(
    syntaxes: "idris2.sublime-syntax",
    theme: "idris2.tmTheme",
  )

  it
}

#let c_listings = counter("listing")
#let c_drawings = counter("drawing")


#let gost-732-setup(
  it,
  font: "Times New Roman",
  font-size: 12pt,
  leading: 1.2em,
) = [
  #set page(paper: "a4", margin: (left: 30mm, right: 10mm, top: 20mm, bottom: 20mm), numbering: "1")

  #set text(font: font, size: font-size, lang: "ru")

  #show heading: it => [
    #set text(size: 12pt, font: "Times New Roman", lang: "ru", weight: "regular")
    #set par(justify: true, spacing: leading, leading: leading)
    #if (it.depth == 1) [
      #pagebreak(weak: true)
      #set block(spacing: leading)
      #set align(center)
      #upper[*#it*]
    ] else [
      #set block(spacing: leading)
      #pad(left: 1.25cm)[*#it*]
    ]
  ]

  #set heading(
    numbering: (..nums) => {
      if nums.pos().len() == 1 {
        [ГЛАВА #nums.pos().at(0).]
      } else {
        [#nums.pos().map(str).join("."). ]
      }
    },
  )

  #show figure: it2 => [
    #if it2.kind == raw {
      c_listings.step()
    }
    #if it2.kind == image {
      c_drawings.step()
    }
    #if it2.kind == raw {
      show raw.where(block: true): it => [
        #block(width: 85%)[
          #set align(left)
          #it
        ]
      ]
      set block(breakable: true)
      it2
    } else {
      it2
    }
  ]

  #set par(justify: true, spacing: leading, leading: leading, first-line-indent: (amount: 1.25cm, all: true))


  #let list-depth = counter("list-depth")
  #show enum: it => {
    list-depth.step()
    context list-depth.display(n => {
      if n == 1 {
        block(inset: (left: 1.25cm))[
          #it
        ]
      } else {
        it
      }
    })
    list-depth.update(n => n - 1)
  }
  #show list: it => {
    list-depth.step()
    context list-depth.display(n => {
      if n == 1 {
        block(inset: (left: 1.25cm))[
          #it
        ]
      } else {
        it
      }
    })
    list-depth.update(n => n - 1)
  }
  #show raw: it => {
    if (it.block) {
      set par(spacing: 1.2em, leading: 0.65em)
      it
    } else {
      it
    }
  }

  #it
]

#let c_chapters = counter("chapter")
#let chapter(content) = [
  #c_chapters.step()
  = #upper[#content]
]

#let n_chapters = context c_chapters.final().at(0)
#let n_sources = context query(ref).dedup().len()
#let n_pages = context { counter(page).final().at(0) }
#let n_listings = context c_listings.final().at(0)
#let n_drawings = context c_drawings.final().at(0)


#let toplevel-heading = heading.with(numbering: none, level: 1)


#let outline-page = [
  #heading(numbering: none, level: 1, outlined: false)[СОДЕРЖАНИЕ]
  #outline(title: none, indent: 1em)
]

#let section(name, it) = [
  #toplevel-heading[#name]
  #it
]

#let bib-page(sources) = [
  #toplevel-heading[СПИСОК ИСТОЧНИКОВ]
  #bibliography(sources, title: none, style: "gost-r-705-2008-numeric")
]
