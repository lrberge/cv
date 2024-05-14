

//
// Font awesome 
//

/*
Install the fontawesome fonts:
- 1: download -- https://fontawesome.com/download
- 2: go to the folder otfs and install the fonts
- 3: use: #text(font: "Font Awesome 6 Free")[\u{f09b}]

*/

#let fa-github = text(font: "Font Awesome 6 Free")[\u{f09b}]
#let fa-envelope = text(font: "Font Awesome 6 Free")[\u{f0e0}]
#let fa-link = text(font: "Font Awesome 6 Free")[\u{f08e}]

#let the_month = datetime.today().display("[month repr:long] [year]")

#set page(
  paper: "a4",
  margin: (bottom: 1.6cm, x: 1.15cm, top: 2cm),
  footer: {
    set align(center + horizon)
    counter(page).display(
      "1 / 1",
      both: true,
    )
  },
  header: {
    context {
      if here().page() > 1 {
        set align(center + horizon)
        set text(10pt)
        box(width: 100%, stroke: (bottom: stroke(0.5pt)), inset: (bottom: 5pt))[
          #smallcaps[
            CV -- #the_month #h(1fr) Laurent R. Bergé
          ]
        ]
      }
    }
  }
)

#set text(font: "Fira Sans", size: 11pt)
// #set text(font: "Poppins", size: 10pt)

#show par: set block(above: 1em)

#let content_to_text(x) = {
  
  if x.has("text") {
    return x.text
  } else if x.has("children") {
    let res = ""
    
    for xi in x.children {
      res += content_to_text(xi)
    }
    
    return res
  } else if x.func() == [ ].func() {
    return " "
  } else {
    return x
  }
}

// #let a = [bon: jour les gens]

// #{
//   repr(a)
//   parbreak()
//   let b = a.children
  
//   repr(b)
//   repr(b.at(1).func())
  
//   repr(b.at(2).func() == [ ].func())
// }

// #repr(content_to_text(a))

// Headers
#set heading(numbering: "1")
#show heading: x => {
  context {
    
    let height_total = page.height - page.margin.bottom
    let y_remaining = height_total - here().position().y
    
    let nb_raw = counter(heading).get()
    let nb_fmt = text(18pt)[#numbering(x.numbering, ..nb_raw)]
    let size = measure(nb_fmt)
    let nb_height = size.height
    let height_heading = nb_height + 1cm
    
    let add_pb = y_remaining < 2 * height_heading
    if y_remaining < 2 * height_heading {
      [#hide[hidden text necessary for page break] \ #pagebreak(weak: false)]
    }
    
    let header_fmt = [#x.body]
    block(stroke: (bottom: 0pt), width: 100%, inset: (bottom: 3pt))[
      #set text(13pt)      
      #place(dx: -size.width - 0.15cm, dy: 0cm)[#nb_fmt]
      #underline(evade: true, offset: 5pt, stroke: (paint: black, thickness: 1.1pt))[
        #header_fmt#text(fill:white)[#box(width: 1fr)[#repeat[.]]]
      ]
    ]
    
  }
  
  v(0.15cm)
}

#let avoid_orphan() = {
  context { 
    let height_total = page.height - page.margin.bottom
    let y_remaining = height_total - here().position().y
    
    if y_remaining < 2.5cm {
      [#hide[hidden text necessary for page break] \ #pagebreak(weak: false)]
    }
    
  }
}

// Links
#show link: set text(fill: rgb(16%, 32%, 75%))

//
// DOCUMENT 
//


#align(center)[
  #text(20pt)[*Laurent R. Bergé*]

  #text(12pt)[_ #the_month _]
]

#set table(stroke: 0pt)

#table(
  columns: (60%, 40%),
  
  [*Personal information*], 
  [*Professional address*],
  
  
  [French citizen, born 1985],
  [
    University of Bordeaux \     
    BSE, UMR CNRS 6060
  ],
  
  table.cell(align: bottom)[
    #link("mailto:laurent.berge@u-bordeaux.fr")[#box(width: 2em)[#fa-envelope] laurent.berge\@u-bordeaux.fr]\
    #link("https://sites.google.com/site/laurentrberge/home")[#box(width: 2em)[#fa-link] #link("https://sites.google.com/site/laurentrberge/home")]
  ],
  [
    16, avenue Léon Duguit CS 50057 \
    33608 Pessac \ 
    FRANCE
  ],
  
  table.cell(colspan: 2, inset: (top: 15pt))[*Fields of interest:* _applied micro-economics #sym.star economics of innovation #sym.star labor mobility #sym.star statistics_]  
)

#let date_table(..all_lines, line_sep: false) = {
  // format: date: stuff, in content form
  
  all_lines = all_lines.pos()
  
  table(
    columns: (15%, 1fr),
    
    ..for line in all_lines {
      
      if line == [] or line == [ ] {
        ([], [])
        continue
      }
    
      let all_elements = line.children
      let date = all_elements.at(0)
      
      let i = 1
      while all_elements.at(i) != [:] {
        date += all_elements.at(i)
        i += 1
      }
      
      // skip ':'
      i += 1
      
      let desc = []
      while i < all_elements.len() {
        desc += all_elements.at(i)
        i += 1
      }
      
      (table.cell(align: right)[#date], [#desc])
      
      if line_sep {
        ([], [])
      }
    }
  )
}


= Current Position

#date_table(
  [2020--#sym.dots.h: *Associate Professor of Economics (Maître de Conférences)* \ BSE (UMR CNRS 6060), University of Bordeaux]
)

= Previous Positions

#date_table(
  [2016--2020: *Postdoctoral Researcher in Economics* \ Department of Economics and Management, University of Luxembourg],
  [2016: *Postdoctoral Researcher in Statistics* \ MAP5 (UMR CNRS 8145), University Paris Descartes],
)

= Research Visits

#date_table(
  [Oct. 2013 --Jan. 2014 : *Visiting Researcher in Residence* \ London School of Economics, Department of Geography and Environment ],
)

= Education

#date_table(
  [2015: *Ph.D. in Economics*, GREThA, University of Bordeaux],
  [2010: *M.S. Economics & Statistics*, University Paris#{sym.space.hair}1],
  [2009: *M.S. Economics*, University of Bordeaux],
  [2008: *B.A. Economics*, University of Bordeaux],
  [2006: *B.S. Mathematics*, University of Bordeaux],
)

= Awards

#date_table(
  [2019:	Department of Economics and Management Award for Young Researchers, University of Luxembourg],
  [2018:	Martin Beckmann Award (best paper published in _Papers in Regional Science_ in 2017) for the article "Network proximity in the geography of research collaboration."]
)


= Publications

#let linkfun = link
#let output_item(
  title: [#text(red)[Insert a title]], 
  year: none, 
  authors: none,
  venue: none,
  number: none,
  link: none,
  extra: none,
  format: "#title #authors \ #venue#number, #year.#extra",
  format_number: ", #number",
  format_extra: "\ #emph[#extra]",
  format_venue: "#emph[#venue]",
  ) = {
  
  let title_fmt = [#title]
  if link != none {
    title_fmt = linkfun(link, title_fmt)
  }
  
  let authors_fmt = []
  if authors != none {
    authors_fmt = [w/~#authors.join(", ", last: " and ")]
  }
  
  let venue_fmt = []
  if venue != none {
    if format_venue == none {
      venue_fmt = venue
    } else {
      venue_fmt = eval(format_venue, mode: "markup", scope: (venue: venue))
    }
  }
  
  let number_fmt = []
  if number != none {
    if format_number == none {
      number_fmt = number
    } else {
      number_fmt = eval(format_number, mode: "markup", scope: (number: number))
    }
  }
  
  let extra_fmt = []
  if extra != none {
    if format_extra == none {
      extra_fmt = extra
    } else {
      extra_fmt = eval(format_extra, mode: "markup", scope: (extra: extra))
    }
  }
  
  // let format_new = format.replace("title", "title_fmt").replace("authors", "authors_fmt")
  
  let dict = (title: title_fmt, year: year, authors: authors_fmt, venue: venue_fmt, 
              number: number_fmt, extra: extra_fmt)
  
  let entry = eval(format, mode: "markup", scope: dict)
  
  list(entry)
  
}

#let publi = output_item

/*
#publi(title: "",
       link: "",
       authors: ("", ""),
       venue: "",
       number: "", 
       year: 2022)
*/

#publi(title: "How patent rights affect university science.",
       link: "https://doi.org/10.1093/icc/dtac044",
       authors: ("Thorsten Doherr", "Katrin Hussinger"),
       venue: "Industrial and Corporate Change",
       number: "dtac044", 
       year: 2022)

#publi(title: "Unintended triadic closure in social networks: The strategic formation of research collaborations between French inventors.",
       link: "https://doi.org/10.1016/j.jebo.2018.10.009",
       authors: ("Nicolas Carayol", "Lorenzo Cassi", "Pascale Roux"),
       venue: "Journal of Economic Behavior and Organization",
       number: "169", 
       year: 2019)

#publi(title: "The Latent Topic Block Model for the co-clustering of textual interaction data.",
       link: "https://doi.org/10.1016/j.csda.2019.03.005",
       authors: ("Charles Bouveyron", "Marco Corneli", "Pierre Latouche"),
       venue: "Computational Statistics and Data Analysis",
       number: "137", 
       year: 2019)

#publi(title: "How do inventors networks affect urban invention?",
       link: "https://doi.org/10.1016/j.regsciurbeco.2018.05.002",
       authors: ("Nicolas Carayol", "Pascale Roux"),
       venue: "Regional Science and Urban Economics",
       number: "71", 
       year: 2018)

#publi(title: "Bridging centrality as an indicator to measure the 'bridging role' of actors in networks: An application to the European nanotechnology co-publication network.",
       link: "https://doi.org/10.1016/j.joi.2017.09.004",
       authors: ("Thomas Scherngell", "Iris Wanzenböck"),
       venue: "Journal of Informetrics",
       number: "11(4)", 
       year: 2017)

#publi(title: "Centrality of regions in R&D networks: A new measurement approach using the concept of bridging paths.",
       link: "https://doi.org/10.1080/00343404.2016.1269885",
       authors: ("Thomas Scherngell", "Iris Wanzenböck"),
       venue: "Regional Studies",
       number: "51(8)", 
       year: 2017)

#publi(title: "Network proximity in the geography of research collaboration.",
       link: "https://doi.org/10.1111/pirs.12218",
       venue: "Papers in Regional Science",
       number: "96(4)", 
       year: 2017, extra: "Beckmann Award 2018 (Best PiRS paper of 2017)")

#publi(title: "HDclassif: An R package for model-based clustering and discriminant analysis of high-dimensional data.",
       link: "https://doi.org/10.18637/jss.v046.i06",
       authors: ("Charles Bouveyron", "Stéphane Girard"),
       venue: "Journal of Statistical Software",
       number: "46(6)", 
       year: 2012)

= Publications in French

#publi(title: "Le déploiement du très haut débit a-t-il favorisé la numérisation des entreprises? Une évaluation du Plan France Très Haut Débit.",
       link: "https://www.cairn.info/revue-economique-2024-2-page-301.htm",
       authors: ("Chloé Duvivier", "Florian Léon"),
       venue: "La Revue Économique",
       number: "75",
       year: 2024)

= Book Chapters

#publi(title: "Bridging centrality: A new indicator for the positioning of actors in complex networks.",
       link: "https://www.amazon.com/Innovation-Complexity-Policy-Contributions-innovation/dp/3631723156",
       authors: ("Thomas Scherngell", "Iris Wanzenböck"),
       venue: [In Weber (ed.): _Innovation Complexity and Policy. Contributions from 30 years of innovation policy research in Austria_, pp. 85-100, Peter Lang, Frankfurt am Main `[ISBN 978-3-631-72315-9]`],
       year: 2017, format_venue: none)

= Refereed Conference Proceedings

#publi(title: "Software patents and scientific publications.",
       link: "https://doi.org/10.5465/AMBPP.2017.214",
       authors: ("Thorsten Doherr", "Katrin Hussinger"),
       venue: "Best Paper Proceedings of the Academy of Management",
       number: "n°13779", 
       year: 2017)

= Working Papers

#publi(title: "Efficient estimation of maximum likelihood models with multiple fixed-effects: the R package FENmlm",
       link: "https://github.com/lrberge/fixest/blob/master/_DOCS/FENmlm_paper.pdf",
       venue: "CREA Discussion papers",
       number: "13", 
       year: 2018)

= Work in Progress

#let simple_pub = output_item.with(format: "#title #authors #extra")

#simple_pub(title: "How access to knowledge shapes innovation: The case of the ARPANET.",
            authors: ("Christian Fons-Rosen", "Myra Mohnen"))

#simple_pub(title: "Does job mobility increase innovation? A case study of the fall of Nortel.",
            authors: ("Nicolas Jonard", "Ruth Samson"))

= Patents

#simple_pub(title: "Method for co-clustering senders and receivers based on text or image data files.",
            link: "https://patents.google.com/patent/EP3591545A1/en",
            authors: ("Charles Bouveyron", "Marco Corneli", "Pierre Latouche"),
            extra: [\ _European Patent Office_, filed 2018, `EP18305896.5`, `PCT PCTEP2019/068011`.],
            format_extra: none)

= Ph.D.

*Supervision.*

#date_table(
  [2019--2023:	Ruth Samson, on Job Mobility and Innovation. Jointly supervised with Nicolas Jonard.]
)

*PhD comitees.*

#date_table(
  [2022--#sym.dots.h:	Amal Boughim (BSE)],
  [2022--#sym.dots.h:	Kevin Souchard (BSE)]
)

= Grants

#date_table[
  2020:	France Stratégie, "#link("https://www.strategie.gouv.fr/sites/strategie.gouv.fr/files/atoms/files/etude_inrae_retombees_du_plan_france_tres_haut_debit_sur_les_entreprises.pdf",)[_Retombées du déploiement du très haut débit sur les entreprises: Quels effets sur les usages numériques, l'innovation, et la performance ?_]" (Evaluating the economic impact of ultra-fast broadband deployment in France) \ 
  w/ Claire Buissière, Chloé Duvivier (PI) and Florian Léon `[91,000€]`
]


= Communications

#let st = super[st]
#let nd = super[nd]
#let rd = super[rd]
#let th = super[th]
#let eme = super[ème]
#let emes = super[èmes]
#let sep = sym.parallel

#date_table(
  [2019: 3#rd Luxembourg Workshop on Innovation, Luxembourg #sep 12#th Annual Northwestern/USPTO Conference on Innovation Economics, Chicago, USA #sep University Paris Dauphine, Governance Analytics seminars, Paris, France],
  [],
  [2018: 2#nd Luxembourg Workshop on Innovation, Luxembourg #sep 13#th European Policy for Intellectual Property conference, Berlin, Germany #sep 4#th Geography of Innovation Conference, Barcelona, Spain],
  [],
  [2017: GREThA seminars, Bordeaux, France #sep BETA seminars, Strasbourg, France #sep 12#th European Policy for Intellectual Property conference, Bordeaux, France #sep 77#th Academy of Management conference, Atlanta, USA #sep 54#eme colloque de l'ASRDLF, Athens, Greece #sep 7#th ZEW/MaCCI Conference on the Economics of Innovation and Patenting, Mannheim, Germany #sep 1#st Luxembourg workshop on Innovation, Luxembourg #sep RSA annual conference, Dublin, Ireland],
  [2016: 3#rd Geography of Innovation Conference, Toulouse #sep 33#emes journées de la microéconomie appliquée, Besançon #sep Journée R, Muséum National D'Histoire Naturelle, Paris #sep 56#th congress of the European Regional Science Association, Vienna, Austria #sep Barcelona workshop on regional an urban economics, Barcelona, Spain],
  [],
  [2012--2015: NetWorkshop, Pécs, Hungary #sep 55#th congress of the European Regional Science Association, Lisbon, Portugal #sep Econ-Geo seminars, University of Utrecht, Utrecht, The Netherlands #sep 54#th congress of the European Regional Science Association, Saint-Petersburg, Russia (#sym.times 2 presentations) #sep 53#rd congress of the European Regional Science Association, Palermo, Italy #sep Economic Geography seminars, London School of Economics, London, England #sep 22#eme Séminaire Européen des Doctorants en Économie Régionale, Bordeaux],
)

= Refereeing Activities

#let nb(n) = [(#sym.times~#n)]

#par(hanging-indent: 0.5em)[
  #box(width: 4em)[*Articles.*] 
  Regional Studies #nb(4), Industry and Innovation #nb(4), Science and Public Policy #nb(1), PLoS One #nb(1), Scientometrics #nb(4), Tijdschrift voor economische en sociale geografie #nb(1), Journal of Economics & Management Strategy #nb(1), Review of Industrial Organization #nb(1), Journal of Statistical Software #nb(1).

  #box(width: 4em)[*Grants.*]
  Agence Nationale de la Recherche #nb(1).
]
= Academic Responsibilities

#date_table(
  [2021--#sym.dots.h: Director of a special teaching program in law and economics at the University of Bordeaux \ _(Directeur d'étude du parcours renforcé L1 AES)_],
  [2021--#sym.dots.h: Elected member of the scientific board of BSE, University of Bordeaux.],
  [2018--2020: Appointed member of the scientific board of the department of economics and management (postdoc representative), University of Luxembourg],
  [2013--2015: Elected member of the scientific board of the laboratory GREThA (PhD representative), University of Bordeaux.],
)

= Organization

#date_table(
  [2017--2019: Co-organizer of the 1#st, 2#nd and 3#rd Luxembourg workshops on Innovation],
  [2013--2014: Organizer of the first economics Ph.D. lunch seminars -- GREThA, University of Bordeaux],
)

= Teaching Experience

#let simple_table(..all_lines) = {
  all_lines = all_lines.pos()
  
  let first_line = all_lines.at(0).split(";")
  let ncols = first_line.len()
  
  set align(center)
  
  table(
    columns: ncols,
    align: (x, y) => if x == 0 {left} else {center},
    
    ..for line in all_lines {
      let all_values = line.split(";")
      for i in range(all_values.len()) {
        if i == 0 {
          (strong(all_values.at(i)),)
        } else {
          (eval(all_values.at(i), mode: "markup"),)
        }
      }
    }
    
  )
}

*2023--2024, University of Bordeaux.*

#simple_table(
  "Capitalism and Global Wealth ; Undergraduate ; 24h",
  "Introduction to economics ; Undergraduate ; 12h",
  "R's Shiny ; Graduate ; 6h",
  "Webscraping ; Graduate ; 6h",
  "Introduction to R ; Graduate ; 2#sym.times~12h",
  "Data management in R ; Graduate ; 15h",
  "R Programming for Environmental Economics ; Graduate ; 15h",
  "Introduction to Econometrics ; Graduate ; 24h",
  "Methodology ; Undergraduate ; 15h"
)

#avoid_orphan()
*Previous experience (lectures only).*

#simple_table(
  "Data visualization ; Graduate ; 6h ; 2022",
  "Webscraping ; Graduate ; 6h ; 2022",
  "Mathematics for Economics ; Undergraduate ; 18h ; 2021,2022",
  "European Economics	; Undergraduate ; 18h ; 2021, 2022",
  "Introduction to R programming ; PhD ; 15h ; 2018, 2019",
)

= Software Products: R Packages

_Over 950,000 downloads as of March 2024 (CRAN downloads only)._

#let soft_item(pkg, desc) = {
  set par(first-line-indent: 1em)
  [#fa-github #link("https://github.com/lrberge/" + pkg)[#strong(pkg)] ~ #desc]
}

#soft_item("fixest")[Fast and user-friendly estimation of econometric models with multiple fixed-effects.]

#soft_item("stringmagic")[The easiest way to perform complex string operations compactly and efficiently. ]

#soft_item("indexthis")[Highly optimised algorithm to create indexes.]

#soft_item("fplot")[The easiest way to plot graphs of regular/conditional/weighted distributions.]

#soft_item("hdd")[Class of data allowing the easy manipulation of out of memory data sets.]

#soft_item("dreamerr")[Tools to make error-handling a piece of cake.]

#soft_item("HDclassif")[Tools to create coherent groups of observations based on observables (clustering).]

