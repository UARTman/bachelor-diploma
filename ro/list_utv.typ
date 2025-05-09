
#set text(font: "Times New Roman", size: 12pt, lang: "ru")
#set page(paper: "a4", margin: (left: 10mm, right: 10mm, top: 20mm, bottom: 20mm), header: [])
#set table(stroke: 0.5pt + black)


#let document-id = [RU.17701729.04.43-01 34 01-1-ЛУ]
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
#let document-name = [Руководство оператора]

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
    // *
    #context counter(page).get().at(0) \
    #document-id
    // *
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
= НАЗНАЧЕНИЕ ПРОГРАММЫ
== Наименование программы
Наименование программы: "Мономорфизатор нерекурсивных зависимых типов".

Наименование программы на английском языке: "Non-recursive dependent type monomorphiser".
== Краткая характереистика области применения программы

Мономорфизатор нерекурсивных зависимых типов -- метапрограмма, позволяющая производить мономорфизацию подмножества типов языка Idris2. Помимо этого, она предоставляет API для унификации выражений Idris2, подстановки в них значений переменных, и их анализа на предмет наличия квотирования и затенения переменных.

Мономорфизатор предназначен для дальнейшей интеграции в дериватор библиотеки property-based тестирования DepTyCheck. Это расширит множество типов, для которых DepTyCheck поддерживает автоматическое выведение реализации генераторов значений.

В настоящий момент, DepTyCheck не поддерживает выведение генераторов для параметрически полиморфных типов. После внедрения мономорфизатора, DepTyCheck получит возможность выводить генераторы для вариантов параметрически полиморфных типов, в которых известны все типовые параметры путём их мономорфизации.

#pagebreak()
= УСЛОВИЯ ВЫПОЛНЕНИЯ ПРОГРАММЫ
== Рекомендуемый состав аппаратурных и программных средств в среде для локальной разработки и тестирования
Рекомендуется наличие персонального компьютера, удовлетворяющего следующим требованиям:
+ Операционная система Linux
+ Оперативная память 16 Гб
+ Свободное место на диске 32 Гб
+ 4 ядра процессора архитектуры x86_64
+ Стабильное подключение к сети интернет
+ Установленный менеджер пакетов Pack
+ Установленная утилита Git

== Минимальный состав аппаратурных и программных средств в продуктовой среде
Требуется наличие машины, удовлетворяющей следующим требованиям:
+ Операционная система Linux
+ Оперативная память 8 Гб
+ 4 ядра процессора архитектуры x86_64
+ Стабильное подключение к сети интернет
+ Установленный менеджер пакетов Pack
+ Установленная утилита Git

#pagebreak()
= ВЫПОЛНЕНИЕ ПРОГРАММЫ
== Описание процедур запуска программы в локальной среде для разработки и тестирования
Для сборки библиотеки dtc-utils необходимо:
+ Клонировать git-репозиторий, выполнив команду `git clone github.com/DepTyCheck/dtc-utils`
+ Перейти в директорию репозитория, выполнив команду `cd dtc-utils`
+ Собрать библиотеку, выполнив команду `pack build`

После сборки библиотеки для запуска метапрограммы мономорфизации типов необходимо:
+ Загрузить интерактивную среду Idris2, выполнив команду `pack repl src/Language/Reflection/Monomorphisation.idr`
+ Запустить мономорфизатор, выполнив команду вида `monomorphise' <TypeTask> "<TypeName>"`, где `<TypeTask>` -- типовое выражение, задающее мономорфизацию, а `<TypeName>` -- имя, которое будет присвоено мономорфизированному типу.

Для запуска набора тестов необходимо:
+ Перейти в директорию test, выполнив команду `cd test`
+ Собрать набор тестов, выполнив команду `pack build`
+ Запустить набор тестов, выполнив команду `pack run`

== Развертывание приложения в продуктовой среде
Для использования библиотеки dtc-utils в других проектах на языке Idris2 необходимо:
+ Клонировать git-репозиторий, выполнив команду `git clone github.com/DepTyCheck/dtc-utils`
+ Перейти в директорию репозитория, выполнив команду `cd dtc-utils`
+ Собрать библиотеку, выполнив команду `pack build`
+ Установить библиотеку, выполнив команду `pack install`


#pagebreak()
= СООБЩЕНИЯ ОПЕРАТОРУ

== Сообщения об ошибке мономорфизатора

При корректной работе мономорфизатора вывода сообщений не происходит.

Ошибки при работе мономорфизатора приводят к ошибкам компиляции.

=== Failed to extract invocation from lambda

В поле задачи мономорфизации было передано выражение, не соответствующее требованиям к заданию мономорфизации.

=== Couldn't get type name

При поиске информации о типе произошла внутренняя ошибка компилятора.

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

