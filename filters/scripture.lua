-- Verse numbers and scripture blocks for PDF output.
-- HTML and EPUB are styled with CSS (styles/*.css); this filter only acts on LaTeX.
if not FORMAT:match("latex") then return {} end

function Span(el)
  if el.classes:includes("vn") then
    -- keep the span (Pandoc turns its id into a \label) but typeset the number
    el.content = { pandoc.RawInline("latex", "\\vn{" .. pandoc.utils.stringify(el.content) .. "}") }
    return el
  end
end

function Div(el)
  if el.classes:includes("scripture") then
    table.insert(el.content, 1, pandoc.RawBlock("latex", "\\begin{scripture}"))
    table.insert(el.content, pandoc.RawBlock("latex", "\\end{scripture}"))
    return el
  end
end
