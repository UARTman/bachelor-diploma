
#set text(font: "Times New Roman", size: 12pt, lang: "ru")
#set page(paper: "a4", margin: (left: 10mm, right: 10mm, top: 20mm, bottom: 20mm), header: [])
#set table(stroke: 0.5pt + black)


#let document-id = [RU.17701729.04.43-01 12 01-1-ЛУ]
#let vertical-table = rotate(-90deg, reflow: true)[
  #table(
    columns: 5,
    rows: (9mm, 9mm),
    [*Инв. № подл.*], [*Подп. и дата*], [*Взам. инв. №*], [*Инв. № дубл.*], [*Подп. и дата*],
  )
]
#let title-grid(table, mainText) = grid(
  columns: (20mm, 1fr),
  rows: 100%,
  align(horizon, table), mainText,
)
#let project-name = [МОНОМОРФИЗАТОР НЕРЕКУРСИВНЫХ ЗАВИСИМЫХ ТИПОВ]
#let document-name = [Текст программы]

#title-grid(
  vertical-table,
  [
    #align(center)[
      #align(center)[
        *
        ПРАВИТЕЛЬСТВО РОССИЙСКОЙ ФЕДЕРАЦИИ \
        ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ АВТОНОМНОЕ \
        ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ \
        НАЦИОНАЛЬНЫЙ ИССЛЕДОВАТЕЛЬСКИЙ УНИВЕРСИТЕТ \
        "ВЫСШАЯ ШКОЛА ЭКОНОМИКИ"
        *

        Факультет компьютерных наук \
        Образовательная программа бакалавриата "Программная инженерия"

        \

        #grid(
          columns: (1fr, 1fr),
          rows: auto,
          align(center)[
            СОГЛАСОВАНО \
            Руководитель,\
            профессор департамента \
            программной инженерии \
            факультета компьютерных наук, \
            доктор физико-математических наук \
            \
            #("_" * 18) А.К. Петренко \
            "#underline[24]" #underline[апреля] 2025 г.

          ],
          align(center)[
            УТВЕРЖДАЮ \
            Академический руководитель \
            образовательной программы \
            «Программная инженерия» \
            старший преподаватель департамента \
            программной инженерии \
            \
            #("_" * 18) Н.А. Павлочев \
            "#underline[24]" #underline[апреля] 2025 г.
          ],
        )

        \
        \

        *#project-name*

        \
        \

        #set text(size: 14pt)

        *#document-name*

        *ЛИСТ УТВЕРЖДЕНИЯ*

        *#document-id*
        #set text(size: 12pt)

        #(par()[] * 3)

        #grid(columns: (50%, 50%),
          [
            #set align(center)
            Соруководитель, \
            научный сотрудник ИСП РАН \
            #("_" * 15) Д.В. Буздалов \
            "#underline[24]" #underline[апреля] 2025 г.

          ],
          [
            #set align(center)
            Исполнитель \
            студент группы БПИ211 \
            #("_" * 15) А.А. Гусев \
            "#underline[24]" #underline[апреля] 2025 г.
          ])

        #align(bottom)[
          #set text(size: 14pt)
          *Москва 2025*
        ]
      ]
    ]
  ],
)

#pagebreak()

#title-grid(
  vertical-table,
  [
    #align(left)[
      #block(width: 50%)[
        #align(center)[
          УТВЕРЖДЕН \
          #document-id
        ]
      ]
    ]
    #(par()[] * 10)
    #set align(center)
    *#project-name*
    #set text(size: 14pt)

    *#document-name*

    *#document-id*

    *Листов #context {counter(page).final().at(0)}*

    #align(bottom)[
      *Москва 2025*
    ]

  ],
)

#let htable = table(
  columns : (auto, 1fr, 1fr, 1fr, 1fr),
  rows: (1.5em, 1.5em, 1.5em, 1.5em),
  [], [], [], [], [],
  [Изм.], [Лист], [№ докум.], [Подп.], [Дата],
  [#document-id], [], [], [], [],
  [Инв. № подл.], [Подп. и дата], [Взам. Инв. №], [Инв. № дубл.], [Подп. и дата],
)

#set page(
  margin: (left: 30mm, right: 10mm, top: 30mm, bottom: 35mm),
  header: align(center)[
    *
    #context counter(page).get().at(0) \
    #document-id
    *
  ], footer: align(top + center)[
    #set text(size: 11pt)
    #set align(left)
    #htable
  ],
  footer-descent: 15pt,
  header-ascent: 15pt
)

#set par(justify: true, first-line-indent: (amount: 1.25cm, all: true), spacing: 1.1em, leading: 1.1em)
#set heading(numbering: "1.1")

#show heading: it => [
  #set text(size: 12pt, font: "Times New Roman", lang: "ru", weight: "regular")
  #set par(justify: true)
  #if (it.depth == 1) [
    #set block(spacing: 1.1em)
    #set align(center)
    #upper[*#it*]
  ] else [
    #set block(spacing: 1.1em)
    #pad(left: 1.25cm)[*#it*]
  ]
]

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
       block(inset: (left: 1cm))[
        #it
      ]
    }
  })
  list-depth.update(n => n - 1)
}

#let thead = heading.with(numbering: none)

#thead[СОДЕРЖАНИЕ]

#outline(title: none)
#pagebreak()
= ВВЕДЕНИЕ
== Наименование программы
Наименование программы: "Мономорфизатор нерекурсивных зависимых типов".

Наименование программы на английском языке: "Non-recursive dependent type monomorphiser".
== Краткая характеристика области применения программы

Мономорфизатор нерекурсивных зависимых типов -- метапрограмма, позволяющая производить мономорфизацию подмножества типов языка Idris2. Помимо этого, она предоставляет API для унификации выражений Idris2, подстановки в них значений переменных, и их анализа на предмет наличия квотирования и затенения переменных.

Мономорфизатор предназначен для дальнейшей интеграции в дериватор библиотеки property-based тестирования DepTyCheck. Это расширит множество типов, для которых DepTyCheck поддерживает автоматическое выведение реализации генераторов значений.

В настоящий момент, DepTyCheck не поддерживает выведение генераторов для параметрически полиморфных типов. После внедрения мономорфизатора, DepTyCheck получит возможность выводить генераторы для вариантов параметрически полиморфных типов, в которых известны все типовые параметры путём их мономорфизации.

#pagebreak()
= ТЕКСТ ПРОГРАММЫ
Полный текст программы расположен в GitHub-репозитории DepTyCheck/dtc-utils @gh.

Программа состоит из библиоткеи на языке Idris2, метаданные которой описаны в файле dtc-utils.ipkg, и набору тестов для неё, метаданные которого описаны в  файле test/test.ipkg.

== Библиотека dtc-utils

Библиотека dtc-utils сотоит из пяти модулей:

- Language.Reflection.Monomorphisation (src/Language/Reflection/Monomorphisation.idr) -- Содержит реализацию мономорфизации типов Idris2.
- Language.Reflection.Unification (src/Language/Reflection/Unification.idr) -- Содержит реализацию унификации выражений Idris2.
- Language.Reflection.VarSubst (src/Language/Reflection/VarSubst.idr) -- Содержит реализацию подстановки значений переменных в выражениях Idris2.
- Language.Reflection.QuoteInfo (src/Language/Reflection/QuoteInfo.idr) -- Содержит реализацию сбора информации о квотировании внутри в выражений Idris2.
- Language.Reflection.ShadowingInfo (src/Language/Reflection/ShadowingInfo.idr) -- Содержит реализацию сбора информации о затенении переменных внутри выражений Idris2.

== Набор тестов для библиотеки

Набор тестов состоит из двух модулей:

- Main (test/src/Main.idr) -- содержит набор unit-тестов для библиотеки dtc-utils.
- GoldenRunner (test/src/GoldenRunner.idr) -- содержит вспомогательные функции для запука и проверки Golden-тестов.

=== Golden-тесты

Для тестирования метапрограмм на языке Idris2 используется Golden-тестирование, подразумевающее собой компиляцию кода, использующего метапрограмму внутри подпроцесса и сравнение результатов её работы с эталоном.

Каждый Golden-тест представляет собой поддиректорию внутри test/unification, содержащую следующие файлы:
- Spec.idr -- программа-тест
- test.ipkg -- метаданные программы-теста
- run -- shell-скрипт компиляции и запуска программы
- expected -- эталон результатов запуска программы

#pagebreak()
#bibliography("sources.bib", title: [СПИСОК ИСТОЧНИКОВ], style: "gost-r-705-2008-numeric", full: true)
#pagebreak()
#set page(margin: (left: 1cm))
#thead[ЛИСТ РЕГИСТРАЦИИ ИЗМЕНЕНИЙ]
#table(
  columns: 10,
  rows: (auto, auto) + (1.7em,) * 23,
  table.cell(rowspan: 2)[зм.],
  table.cell(colspan: 4)[Номера листов (страниц)],
  table.cell(rowspan: 2)[Всего листов (страниц) в документе],
  table.cell(rowspan: 2)[№ документа],
  table.cell(rowspan: 2)[Входящий № сопроводительного документа и дата],
  table.cell(rowspan: 2)[Подпись],
  table.cell(rowspan: 2)[Дата],
  table.cell()[измененных],
  table.cell()[замененных],
  table.cell()[новых],
  table.cell()[аннулированных],
)

