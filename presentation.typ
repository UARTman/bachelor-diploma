// bamboo.typ
#import "@preview/touying:0.6.1": *
#import "@preview/pinit:0.2.2": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge

// Flowchart fletcher stuff
#let flowchart(..args) = {
  set par(leading: 0.65em)
  diagram(
    node-stroke: 1pt,
    node-shape: fletcher.shapes.rect,
    ..args,
  )
}
#let start-node = node.with(corner-radius: 2pt, extrude: (0, 3), outset: 3pt)
#let branch-node = node.with(shape: fletcher.shapes.diamond.with(fit: 0.7))
#let hackbr-node(pos, content, ..args) = node(
  pos,
  block(inset: (bottom: 1mm), spacing: 0em, align(center, content)),
  shape: fletcher.shapes.diamond,
  ..args,
)

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
#slide[
  - *Параметрический полиморфизм* — возможность обработки входных данных разных типов одним кодом
  - Присутствует в большинстве современных языков программирования со статической типизацией
][
  ```idris
  data List pin4: Type -> Type
  pin5length : List pin1tpin2 -> Nat

  ln : List Nat
  ln = [1,2,3,4,5]
  -- length ln == 5

  ls : List String
  ls = ["Hello", "World"]
  -- length ls == 2
  ```

  #pinit-point-from(2, fill: darkblue)[
    #set text(size: 18pt)
    Параметр типа
  ]
]

== МОНОМОРФИЗАЦИЯ

#slide[

  - *Мономорфизация* — процесс подстановки типовых параметров, в результате которого из полиморфного типа получается неполиморфный
  - Мономорфизация используется для кодогенерации в компиляторах (Rust, Swift, etc.)
][
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
#slide[
  - *Зависимые типы* -- это типы, принимающие параметры, не являющиеся другими типами
  - Позволяют выражать инварианты о значениях типа через его определение
  - Соответствуют логике первого порядка
  - Используются в некоторых языках функционального программирования и интерактивных решателях теорем
][
  ```idris
  data Vect : Nat -> Type -> Type
  (++) : Vect a t -> Vect b t 
                  -> Vect (a+b) t
  at : (i : Nat) -> Vect len t 
                 -> So (i <= len) => t 
 
  v1 : Vect 4 Nat
  v1 = [1,2] ++ [3,4]

  at 2 v1 -- Результат: 3
  at 4 v1 -- Ошибка компиляции!
  ```
]


== ЗАВИСИМЫЕ ТИПЫ В PBT

- Одна из областей применения зависимых типов – автоматическая генерация сложных данных
- Библиотека DepTyCheck на языке Idris позволяет автоматически генерировать значения зависимых типов
- В настоящий момент DepTyCheck не поддерживает генерацию типов, полиморфных по другим типам (например, списков, множеств, деревьев). Пользователям приходится вручную писать мономорфные версии таких типов
- Автоматизация процесса мономорфизации позволит добавить поддержку части полиморфных типов в библиотеку без существенного изменения её API или реализации

== ТЕКУЩЕЕ СОСТОЯНИЕ ПРОБЛЕМЫ

#slide[
  #set text(size: 22pt)
  - Проблема мономорфизации зависимых *типов* практически не рассматривалась
  - Единственная найденная работа, посвященная мономорфизации в контексте зависимых типов, рассматривала мономорфизацию *функций*
]

== ЦЕЛЬ И ЗАДАЧИ ВКР

=== Цель работы
Разработка алгоритма мономорфизации, поддерживающего практичное подмножество нерекурсивных зависимых типов.
=== Задачи работы
1. Ознакомиться с существующими алгоритмами мономорфизации типов
2. Выделить среди множества нерекурсивных зависимых типов классы типов, для которых мономорфизация возможна и практична
3. Разработать алгоритм мономорфизации для этих типов
4. Реализовать этот алгоритм в виде метапрограммы для языка Idris2
5. Произвести его тестирование

// == МОНОМОРФИЗАЦИЯ ЧЕРЕЗ ПОДСТАНОВКУ
// #slide[
//   - В большинстве нефункциональных ЯП мономорфизация эквивалентна подстановке значения переменной
//   - Функциональные ЯП используют *Алгебраические Типы Данных* (ADT)
//     - ADT имеет несколько конструкторов
//     - Каждый аргумент конструктора равноценен полю в нефункц. ЯП
//     - Мономорфизация ADT -- тоже подстановка
// ][
//   ```cpp
//   // Пример "мономорфизации" в C++
//   template<typename T> class vector {
//     T* ptr;
//     size_t length;
//   };
//   class vector_int {
//     int* ptr;
//     size_t length;
//   };
//   ```
//
//   ```idris
//   -- Мономорфизация ADT
//   data List t = Nil | Cons t (List t)
//   data List_Nat = Nil 
//                 | Cons Nat List_Nat
//   ```
// ]
== ПРОЦЕСС МОНОМОРФИЗАЦИИ GADT
#slide[
  #set text(size: 18pt)
  - Для мономорфизации в Idris2 подстановки недостаточно
  - Idris2 использует *Обобщённые алгебраические типы* (GADT)
  - GADT состоит из *конструкторов*, которые строят значение типа с конкретными аргументами
  - Необходимо проверить каждый конструктор на возможность вернуть искомый набор аргументов
    - Для такой проверки необходима *унификация*
][
  ```idris
  data A : Type -> Type
    ANat : A Nat 
    AStr : A String 
    ADep : t -> A t

  -- Результат мономорфизации A Nat
  data A_Nat:
    ANat : A_Nat -- ANat подходит
    -- AStr не подходит, опускается
    -- ADep подходит в частном случае
    ADep : Nat -> A_Nat  
  ```
]

== ЗАДАЧА УНИФИКАЦИИ

#slide[
  - Унификация принимает на вход пару выражений
    - Для каждого выражения дан набор *свободных переменных* в нём
  - Результат унификации --- набор значений *свободных переменных*, при котором выражения *равны*
][
  #figure()[
    #diagram(
      spacing: 1em,
      edge-stroke: darkblue,
      // debug:3,
      node((0, 0), [`SortedSet Nat `*`x`*` == SortedSet `*`y`*` String`]),
      edge("=>", "d"),
      node((0, 1), [${#[`x := String, y := Nat`]}$]),
      node(enclose: ((0, 0), (0, 1)), shape: fletcher.shapes.rect, stroke: darkblue, corner-radius: 10pt),
      node((-0.3, 2), [`5 == `*`x`*` + 1`]),
      edge("=>"),
      node((0.3, 2), [${#[`x := 4`]}$]),
      node(
        enclose: ((-0.3, 2), (0.3, 2), (-0.81, 2), (0.85, 2)),
        shape: fletcher.shapes.rect,
        stroke: darkblue,
        corner-radius: 10pt,
        width: 3em,
      ),
      node((-0.35, 3), [`True == False`]),
      edge("=>"),
      node((0.2, 3), [$exists.not$]),
      node(
        enclose: ((-0.35, 3), (0.2, 3), (-0.81, 3), (0.85, 3)),
        shape: fletcher.shapes.rect,
        stroke: darkblue,
        corner-radius: 10pt,
        width: 3em,
      ),

      node((-0.15, 4), [`1 == 1`]),
      edge("=>"),
      node((0.2, 4), [$emptyset$]),
      node(
        enclose: ((-0.15, 4), (0.3, 4), (-0.81, 4), (0.85, 4)),
        shape: fletcher.shapes.rect,
        stroke: darkblue,
        corner-radius: 10pt,
        width: 3em,
      ),
    )
  ]
]


== ИМЕЮЩИЕСЯ РЕШЕНИЯ ПО УНИФИКАЦИИ

#slide[
  #set text(size: 24pt)
  - Компилятор Idris2 имеет унификатор зависимых типов...
    - Но компилятор полагается на абстракции, к которым нет доступа у метапрограмм
  - Имеющиеся алгоритмы унификации зависимо типизированых выражений сложны в реализации за счёт избыточного функционала
  - Таким образом, реализуем свой, более простой и специализированный алгоритм
]
== ЗАДАЧА УНИФИКАЦИИ И ЗАВИСИМЫЕ ТИПЫ
  - При отсутствии зависимых типов, единственные параметры типов -- другие типы, задача решаема в общем виде
  - При наличии зависимых типов, аргументы -- *произвольные выражения* Idris2. Эти выражения могут содержать рекурсивные функции, локальные декларации, и т.д.
  - Задача унификации зависимых типов в общем виде слишком сложная
  - Основной критерий практичности мономорфизации зависимого типа -- практичность унификации выражений, которые в нём присутствуют
    - В частности, разрабатываемый алгоритм может не поддерживать унификацию выражений, редко встречающихся в сигнатурах конструкторов
== ВОЗМОЖНОСТИ РАЗРАБОТАННОГО АЛГОРИТМА

#slide[
  Алгоритм *может* унифицировать:
  - Чистые типовые выражения
  - Вызовы конструкторов
  - Блоки с локальными *cвязанными* переменными
][
  Алгоритм *не может* унифицировать:
  - Вызовы функций --- в связи с ограничениями среды исполнения метапрограмм Idris2
  - Лямбда-функции, сигнатуры зависимо-типизированных функций, pattern-matching --- в связи с отсутствием поддержки локальных *свободных* переменных
]

== ФОРДИНГ
#slide[
  - Как быть с нерешаемыми равенствами?
  - Вынести суждение о выполнении равенства в момент использования конструктора
  - Этот метод называется *фординг*
  - Для мономорфизации требуется фординг даже при "идеальном" алгоритме унификации
][
  #set text(size: 17pt)
  ```idris
  data A : Type -> Type
    ANat : A Nat 
    AStr : A String 
    ADependent : (b : Bool) ->
                 A (if b then Nat else String)

  data A_Nat:
    -- ANat подходит
    ANat : A_Nat
    -- AStr не подходит
    -- ADependent подходит, если b == True
    ADependent :
      (b : Bool) ->
      (if b then Nat else String) = Nat ->
      A_Nat
  ```
]

== РЕЗУЛЬТАТЫ
Поставленные задачи выполнены:
- Выделены классы типов, для которых мономорфизация практична на основе практичности унификации их конструкторов
- Реализован алгоритм мономорфизации, поддерживающий мономорфизацию по типовым параметрам
  - В его рамках реализованы алгоритм подстановки значений переменных в выражения и алгоритм унификации
- Алгоритм подстановки значений переменных тестируется на корректность, алгоритм мономорфизации - на отсутствие критических ошибок при исполнении и возможность использования результатов его работы

== НАПРАВЛЕНИЯ ДАЛЬНЕЙШЕЙ РАБОТЫ
- Поддержка унификации выражений, содержащих локальные свободные переменные
  - Требует добавления промежуточного представления и конвертации имён переменных в индексы Де Брёйна
- Интеграция мономорфизатора в библиотеку DepTyCheck
- Улучшение тестового покрытия:
  - End-to-end тестирование унификатора
  - Мокинг среды исполнения метапрограмм
  - Property-based тестирование мономорфизатора и унификатора

#focus-slide[
  Благодарю за внимание
]
