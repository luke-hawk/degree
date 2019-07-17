defmodule Degree do

  @moduledoc File.read!(Path.join([__DIR__, "../README.md"]))
  
  use MixTemplates,
    name:       :degree,
    short_desc: "An admin engine build around Thesis-CMS",
    source_dir: "../template"

  
end
