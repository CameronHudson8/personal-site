<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Cameron Hudson</title>

        <!-- Links -->
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
        <link rel="manifest" href="/site.webmanifest">

        <!-- Styles -->
        <link rel="stylesheet" href="{{ secure_asset('css/bootstrap.min.css') }}">
        <link rel="stylesheet" href="{{ secure_asset('css/custom.css') }}">

    </head>
    <body class="pt-5">
      <div class="container">
        <div class="jumbotron text-center">

          <h1>Cameron Hudson</h1>
          <h2>Software Engineering Student</h2>

              <a class="btn btn-primary m-3 fixed-size" min-width="200px" href="https://github.com/CameronHudson8">
                <img src="{{ secure_asset('images/github-logo.png') }}" alt="Github Logo" style="width:15px;height:15px;" hspace="2px">
                Github Profile
              </a>
              <a class="btn btn-primary m-3 fixed-size" href="https://www.linkedin.com/in/cameronhudson8/">
                <img src="{{ secure_asset('images/linkedin-logo.svg') }}" alt="LinkedIn Logo" style="width:15px;height:15px;" hspace="2px">
                LinkedIn Profile
              </a>
              <a class="btn btn-primary m-3 fixed-size" href="https://github.com/CameronHudson8/Resume/raw/master/Resume.pdf">
                <img src="{{ secure_asset('images/document_icon.png') }}" alt="document icon" style="width:15px;height:15px;" hspace="2px">
                Resume
              </a>

        </div>
      </div>

      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

    </body>

</html>
