
[![Contributors][contributors-shield]][contributors-url]
[![MIT License][license-shield]][license-url]


<!-- PROJECT LOGO -->
<br />
<p align="center">
  
  <h3 align="center">Degree · CMS</h3>

  <p align="center">
    Degree is an <a href="https://pragdave.me/blog/2017/04/18/elixir-project-generator.html">Elixir project generator</a> template which will get you a boilerplate phoenix application with authentication, an admin engine built around <a href="https://github.com/infinitered/thesis-phoenix">Thesis CMS</a> and other useful features such as dynamic page creation and publishing or dynamic sitemap generation.
    <br />
    <br />
    <a href="https://github.com/luke-hawk/degree">Read Docs</a>
    ·
    <a href="https://github.com/luke-hawk/degree/issues">Report Bug</a>
    ·
    <a href="https://github.com/luke-hawk/degree/issues">Request Feature</a>
  </p>


![Product Name Screen Shot][product-screenshot]
</p>

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

Make sure to have [mix_templates](https://github.com/pragdave/mix_templates) and [mix_generator](https://github.com/pragdave/mix_generator) installed.
```sh
$ mix archive.install hex mix_templates
$ mix archive.install hex mix_generator
```

### Installation

You can then install ***Degree*** 
```sh
$ mix template.install git https://github.com/luke-hawk/degree
```

In order to start a new project with ***Degree*** as a boilerplate all you need to do is run
```sh
$ mix gen degree your_app
```

This will create a fresh phoenix application named `your_app` with all necessary files to run Degree. But first you need to finish the install by

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Install Node.js dependencies with `cd assets && npm install`
* Start Phoenix endpoint with `mix phx.server`

## Usage

Browse `localhost:4000/admin` in order to login with ***admin@admin.com*** and ***secret***. You can now create new users or dynamic pages. For use instructions of Thesis please refer to the [docs](https://github.com/infinitered/thesis-phoenix). 

After you've created a new dynamic page with Thesis it will be on staging by default. You can only view it as long as you're logged in as an admin or you've released it to public through hitting the *publish* button in the admin panel. 

<!-- CONTRIBUTING -->
## Contributing

Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[build-shield]: https://img.shields.io/badge/build-passing-brightgreen.svg?style=flat-square
[build-url]: #
[contributors-shield]: https://img.shields.io/badge/contributors-1-orange.svg?style=flat-square
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[license-shield]: https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square
[license-url]: https://choosealicense.com/licenses/mit
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: https://raw.githubusercontent.com/luke-hawk/degree/master/screenshot.png
