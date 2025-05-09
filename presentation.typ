// bamboo.typ
#import "@preview/touying:0.5.5": *
#import "@preview/pinit:0.2.2": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge

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

#show: idris-setup


#show raw: it => {
  show regex("pin\d"): it => pin(eval(it.text.slice(3)))
  it
}

#let leftblue = rgb("#0e2c67")
#let text_bold_blue = rgb("#0e2b67")
#let text_supernormal_blue = rgb("#0e2a67")
#let darkblue = rgb("#243956")
#let textblue = rgb("#000065")

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  // set page
  let header(self) = {
    set align(top)
    show: components.cell.with(fill: leftblue, inset: 1em)
    set align(horizon)
    set text(fill: self.colors.neutral-lightest, size: .7em)
    set text(size: 1.5em)
    grid(
      columns: (auto, 1fr),
      column-gutter: 1em,
      image("hselogo_onblue.png", fit: "stretch", height: 150%),
      [
        #set text(size: 25pt, weight: "bold")
        #utils.display-current-heading(level: 2)
      ],
    )
  }
  let footer(self) = {
    set align(bottom)
    show: pad.with(.4em)
    set text(fill: leftblue, 10.75pt)
    utils.call-or-display(self, self.store.footer)
    h(1fr)
    context utils.slide-counter.display()
    // + " / " + utils.last-slide-number
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  touying-slide(self: self, ..args)
})

#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()

  let body = {
    set align(center)
    set text(size: 14.5pt, fill: leftblue, font: "HSE Sans")
    block[
      Факультет компьютерных наук \
      Образовательная программа "Программная инженерия" \
      Выпускная квалификационная работа
    ]

    set align(horizon)
    set text(size: 18pt, fill: darkblue, weight: "bold")
    block[#upper[
        Разработка алгоритма мономорфизации не-\рекурсивных структур данных с зависимыми типами \ и его программная реализация

        Development of a monomorphiSation algorithm \ for non-recursive dependently typed data structures \ And its software implementation
      ]]
    set text(size: 14.5pt, fill: leftblue, font: "HSE Sans", weight: "regular")
    block[
      Проектно-исследовательская ВКР
    ]
    set text(size: 13.5pt, fill: textblue, weight: "regular")
    columns[
      Руководитель: \
      Профессор департамента \
      программной инженерии, д.ф-м.н. \
      А.К. Петренко\
      \
      Соруководитель: \
      Научный сотрудник ИСП РАН\
      Д.В. Буздалов\
      #colbreak()

      Выполнил студент группы БПИ211 \
      образовательной программы \
      09.03.04 «Программная инженерия» \
      Гусев Антон Алексеевич
    ]

    set align(bottom)
    set text(12pt, fill: leftblue)
    block[Москва, 2025]
  }
  self = utils.merge-dicts(
    self,
    config-page(
      background: [
        #set align(left)
        #block(width: 24.5%, height: 100%, fill: leftblue, inset: (top: 4.72%))[
          #set align(center + top)
          #image("hselogo_onblue.png", height: 25%)
        ]
      ],
      margin: (left: 24.5% + 1.5em, top: 1.5em),
    ),
  )
  touying-slide(self: self, body)
})

#let focus-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: self.colors.primary,
      margin: 2em,
    ),
  )
  set text(fill: self.colors.neutral-lightest, size: 2em)
  touying-slide(self: self, align(horizon + center, body))
})

#let bamboo-theme(
  aspect-ratio: "16-9",
  footer: none,
  ..args,
  body,
) = {
  set text(size: 20pt, font: "HSE Sans", fill: text_supernormal_blue)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 20.43% * 3 / 2, bottom: 1.5em, x: 2em),
    ),
    config-common(slide-fn: slide),
    config-methods(alert: utils.alert-with-primary-color),
    config-colors(
      primary: leftblue,
      // neutral-lightest: rgb("#ffffff"),
      // neutral-darkest: rgb("#000000"),
    ),
    config-store(
      title: none,
      footer: footer,
    ),
    ..args,
  )

  body
}


// main.typ
// #import "@preview/touying:0.5.5": *
// #import "bamboo.typ": *

#show: bamboo-theme.with(
  aspect-ratio: "16-9",
  footer: self => [
    #set text(10.75pt)
    #self.info.institution
    #h(1fr)
    А.А. Гусев, ВКР «Разработка алгоритма мономорфизации нерекурсивных структур данных с зависимыми типами»
  ],
  config-info(
    title: [Title],
    subtitle: [Subtitle],
    author: [Authors],
    date: datetime.today(),
    institution: [ФКН, ОП Программная инженерия, 2025],
  ),
)

#title-slide()

== ПАРАМЕТРИЧЕСКИЙ ПОЛИМОРФИЗМ
#columns[
  - *Параметрический полиморфизм* — возможность обработки входных данных разных типов одним кодом.
  - Присутствует в большинстве современных языков программирования со статической типизацией
  #colbreak()
  // #set align(center)
  ```idris
  data List pin4: Type -> Type
  pin5length : List pin1tpin2 -> Nat

  ln : List Nat
  ln = [1,2,3,4,5]
  -- length ln == 5

  ls : List String
  ls = ["Hello", "World"]
  -- length ls == 3
  ```
]


#pinit-point-from(2)[
  #set text(size: 18pt)
  Параметр типа
]

== МОНОМОРФИЗАЦИЯ

#columns[

  - *Мономорфизация* — процесс подстановки типовых параметров, в результате которого из полиморфного типа получается неполиморфный.
  - Мономорфизация используется для кодогенерации в компиляторах (Rust, Swift).
  #colbreak()
  ```idris
  data List : Type -> Type where
    Nil : List t
    (::) : t -> List t -> List t

  ln : List Nat = [1,2,3]

  data List_Nat : Type where
    Nil : List_Nat
    (::) : Nat -> List_Nat -> List_Nat

  ln' : List_Nat = [1,2,3]
  ```
]

== ЗАВИСИМЫЕ ТИПЫ
#columns[
  - *Зависимые типы* -- это типы, принимающие параметры-значения.
  - Позволяют выражать инварианты о значениях типа через его определение.
  - Используются в некоторых языках функционального программирования и интерактивных решателях теорем, например, Agda, Idris, Coq, Lean.
  #colbreak()
  ```idris
  data Vect : Nat -> Type -> Type
  concat :
    Vect a t -> Vect b t -> Vect (a+b) t
  fromList :
    (l : List t) -> Vect (size l) t

  v1 : Vect 5 Nat
  v1 = concat [1,2] [3,4,5]

  v2 : Vect 2 String
  v2 = fromList ["Hello World"]
  ```
]


== ЗАВИСИМЫЕ ТИПЫ В PBT

- Одна из областей применения зависимых типов – автоматическая генерация сложных данных.
- Входит в функционал нескольких библиотек property-based тестирования — QuickChick (Coq) и DepTyCheck (Idris).
- В настоящий момент DepTyCheck не поддерживает генерацию полиморфных типов (например, списков, множеств, деревьев). Пользователям приходится вручную писать мономорфные версии таких типов.
- Автоматизация процесса мономорфизации позволит добавить поддержку части полиморфных типов в библиотеку без существенного изменения её API или функционала.

== ТЕКУЩЕЕ СОСТОЯНИЕ ПРОБЛЕМЫ

- Проблема мономорфизации зависимых типов практически не рассматривалась.
- Единственная найденная работа, посвященная мономорфизации в контексте зависимых типов, рассматривала мономорфизацию функций.

// == ТРУДНОСТИ МОНОМОРФИЗАЦИИ \ ЗАВИСИМЫХ ТИПОВ
// === Присутствие зависимых типов значительно усложняет проблему мономорфизации типов:
// - Требуется делать суждения о потенциальных результатах *произвольных выражений*
// - Нет однозначного решения, которое бы удовлетворяло всем целям мономорфизации
//   - Например, мономорфизация вектора из 100 элементов создаст 100 новых типов
//   - В этой работе рассматривается мономорфизация зависимых типов, *не требующих* рекурсивного вызова алгоритма.

== ЦЕЛЬ И ЗАДАЧИ ВКР

=== Цель работы
Разработка алгоритма мономорфизации, поддерживающего практичное подмножество нерекурсивных зависимых типов.
=== Задачи работы
1. Ознакомиться с существующими алгоритмами мономорфизации типов
2. Выделить среди множества нерекурсивных зависимых типов классы типов, для которых мономорфизация возможна и практична
3. Разработать алгоритм мономорфизации для этих типов
4. Реализовать этот алгоритм в виде метапрограммы для языка Idris2
5. Произвести его тестирование
// == ОЖИДАЕМЫЕ РЕЗУЛЬТАТЫ
// 1. Анализ частных случаев зависимой типизации, для которых мономорфизация возможна и практична
// 2. Алгоритм их мономорфизации
// 3. Метапрограмма на языке Idris2, реализующая этот алгоритм

== МОНОМОРФИЗАЦИЯ ЧЕРЕЗ ЗАМЕНУ
#columns[
  - В большинстве нефункциональных ЯП мономорфизация -- простая замена
  - Функциональные ЯП используют *Алгебраические Типы Данных* (ADT)
    - ADT имеет несколько конструкторов
    - Каждый аргумент конструктора равноценен полю в нефункц. ЯП
    - Мономорфизация ADT -- тоже простая замена
  #colbreak()

  ```cpp
  // Пример "мономорфизации" в C++
  template<typename T> class vector {
    T* ptr;
    size_t length;
  };
  class vector_int {
    int* ptr;
    size_t length;
  };
  ```

  ```idris
  -- Мономорфизация ADT
  data List t = Nil | Cons t (List t)
  data List_Nat = Nil | Cons Nat List_Nat
  ```
]
== ПРОЦЕСС МОНОМОРФИЗАЦИИ GADT
#columns[
  - Idris использует расширенную версию ADT -- *Обобщённые ADT* (GADT).
  - В отличие от ADT, конструкторы GADT могут возвращать инстанцию типа с любым набором параметров.
  - Для их мономорфизации, необходимо проверить каждый конструктор на возможность вернуть искомый набор параметров.
    - Это -- *задача унификации*.
  #colbreak()
  #set text(size: 18pt)
  ```idris
  -- Искомый тип - A Nat
  data A : Type -> Type
    ANat : A Nat -- Подходит
    AStr : A String -- Не подходит
    -- Подходит, если b == True
    ADependent : (b : Bool) ->
                 (if b then Nat else String)

  -- Результат мономорфизации
  data A_Nat:
    ANat : A_Nat
    ADependent : (b : Bool) ->
                 (b = True) -> A_Nat

  ```
]

== ИМЕЮЩИЕСЯ РЕШЕНИЯ ПО УНИФИКАЦИИ

#block[
  #set text(size: 24pt)
- Компилятор Idris2 имеет унификатор зависимых типов...
  - Но компилятор полагается на абстракции, к которым не доступа у метапрограмм
- Имеющиеся алгоритмы унификации зависимо типизированых выражений слишком широкие по назначению
- Таким образом, реализуем свой, более простой и узкий алгоритм
]
== ЗАДАЧА УНИФИКАЦИИ И ЗАВИСИМЫЕ ТИПЫ
- При отсутствии зависимых типов, единственные аргументы типов -- другие типы, задача решаема в общем виде
- При наличии зависимых типов, аргументы -- *произвольные выражения* Idris2. Эти выражения могут содержать рекурсивные функции, локальные декларации, и т.д.
- Задача унификации зависимых типов в общем виде слишком сложная
- Основной критерий практичности мономорфизации зависимого типа -- практичность унификации выражений, которые в нём присутствуют

== АБСТРАКТНЫЙ АЛГОРИТМ УНИФИКАЦИИ ТИПОВ


#align(center)[
  #set text(size: 15pt)
  #diagram(
    node-stroke: 1pt,
    spacing: 2em,
    node((0, 0), [Старт], corner-radius: 2pt, extrude: (0, 3)),
    edge("-|>"),
    node((0, 1), [Сбор требований]),
    edge("-|>"),
    node(
      (0, 2),
      block(inset: (bottom: 1mm), spacing: 0em)[
        #align(center)[
          Найдены\ противоречия?
        ]
      ],
      shape: fletcher.shapes.diamond,
    ),
    edge("l,d,d", "-|>", [Да]),
    node((-1, 4), [Унификация \ невозможна]),
    edge((0, 2), (0, 3), "-|>", [Нет]),
    node((0, 3), [Объединение требований]),
    edge("-|>"),
    node(
      (0, 4),
      block(inset: (bottom: 1mm), spacing: 0em)[
        #align(center)[
          Найдены\ противоречия?
        ]
      ],
      shape: fletcher.shapes.diamond,
    ),
    edge("-|>", [Нет]),
    edge((0, 4), (-1, 4), "-|>", [Да]),
    node((1, 4), [Унификация успешна]),
  )
]


== СБОР ТРЕБОВАНИЙ


#align(center)[
  #set text(size: 12pt)
  #diagram(
    node-stroke: 1pt,
    spacing: 3em,
    node((0, 0), [Старт], corner-radius: 2pt, extrude: (0, 3)),
    edge("-|>"),
    node(
      (0, 1),
      block(inset: (y: 1mm), spacing: 0em)[
        #align(center)[
          Свободные\ переменные?
        ]
      ],
      shape: fletcher.shapes.diamond,
    ),
    edge("l", "-|>", [Обе]),
    edge("r", "-|>", [Одна]),
    edge("d", "-|>", [Нет]),
    node((-1.5, 1), [Свободные \ переменные \ должны быть \ равны друг другу]),
    node((1.5, 1), [Свободная \ переменная \ должна быть\ равна значению], shape: fletcher.shapes.rect),
    node(
      (0, 2),
      block(inset: (y: 1mm), spacing: 0em)[
        #align(center)[
          Типы\ совпадают?
        ]
      ],
      shape: fletcher.shapes.diamond,
    ),
    edge("-|>", [Да]),
    node(
      (0, 3),
      block(inset: (bottom: 1mm), spacing: 0em)[#align(center)[Тип \ выражения?]],
      shape: fletcher.shapes.diamond,
    ),
    edge((0, 3), (-1.5, 3), "-|>", [Вызов]),
    edge("rr", "-|>", [Переменная]),
    node((-1.5, 3), [Собрать требования\ аргументов]),
    edge((-1.5, 3), (-2.5, 3), (-2.5, 0), (-0.23, 0), "-|>"),
    node(
      (2, 3),
      block(inset: (top: 1mm), spacing: 0em)[
        #align(center)[
          Равны между\ собой?
        ]
      ],
      shape: fletcher.shapes.diamond,
    ),
    edge("u", "-|>", [Да]),
    edge("r", "-|>", [Нет]),
    node((2, 2), [Нет требований]),
    node((3, 3), [Противоречие]),
  )
]


== ФОРДИНГ
#columns[
  #set text(size: 18pt)
  - Единственный способ унификации зависимых выражений -- вынести суждение о них в момент использования конструктора.
  - Этот метод называется *фординг*.
  - Основные недостатки -- усложнение автогенерации инфраструктуры и пользования получившимся типом.

  #colbreak()
  #set text(size: 17pt)
  ```idris
  -- Целевой тип - A Nat
  data A : Type -> Type
    ANat : A Nat -- Fits
    AStr : A String -- Doesn't fit
    -- Условие вхождения -- b == True
    ADependent : (b : Bool) ->
                 (if b then Nat else String)

  -- Мономорфизация с фордингом
  data A_Nat:
    ANat : A_Nat
    ADependent :
      (b : Bool) ->
      (if b then Nat else String) = Nat ->
      A_Nat


  ```
]

== УНИФИКАЦИЯ С ФОРДИНГОМ



#align(center)[
  #set text(size: 15pt)
  #diagram(
    node-stroke: 1pt,
    spacing: 3em,
    node((0, 0), [Старт], corner-radius: 2pt, extrude: (0, 3)),
    edge("-|>"),
    node(
      (0, 1),
      block(inset: (bottom: 1mm), spacing: 0em)[
        #align(center)[
          Зависимое\ выражение?
        ]
      ],
      shape: fletcher.shapes.diamond,
    ),
    edge("l", "-|>", [Нет]),
    edge("d", "-|>", [Да]),
    node((-1, 1), [Унификация\ типового выражения]),
    node(
      (0, 2),
      block(inset: (bottom: 1mm), spacing: 0em)[
        #align(center)[
          Результат-тип?
        ]
      ],
      shape: fletcher.shapes.diamond,
    ),
    edge("r", "-|>", [Да]),
    edge("d", "-|>", [Нет]),
    node((1.2, 2), [Унификация невозможна]),
    node((0, 3), [Фординг]),
  )
]


== РЕЗУЛЬТАТЫ
Поставленные задачи выполнены:
- Реализован прототип алгоритма мономорфизации, поддерживающий мономорфизацию по типовым параметрам.
  - В его рамках реализован алгоритм подстановки значений переменных в выражении.
- Алгоритм подстановки значений переменных тестируется на корректность, алгоритм мономорфизации - на отсутствие критических ошибок при исполнении и возможность использования результатов его работы.


// == ТЕКУЩЕЕ СОСТОЯНИЕ ЗАДАЧ
// 1. Ознакомиться с существующими алгоритмами мономорфизации типов — *выполнена*
// 2. Выделить среди множества нерекурсивных зависимых типов классы типов, для которых мономорфизация возможна и практична — *выполнена*
// 3. Разработать алгоритм мономорфизации для этих типов — *выполнена*
// 4. Реализовать этот алгоритм в виде метапрограммы для языка Idris2 — **
// 5. Произвести его тестирование — *в процессе*
//
// == СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ
// #bibliography("sources.bib", title: none, style: "gost-r-705-2008-numeric")

#focus-slide[
  Благодарю за внимание
]
