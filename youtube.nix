{config,pkgs,...}:

{
  home.packages = with pkgs; [
    perl538Packages.WWWYoutubeViewer
  ];
  home.file.".config/youtube-viewer/api.json".text = ''
  {
    "key": "AIzaSyBBg3P6vl5kck4rBrTp5wWXgGjFVTSLtEU",
    "client_id": "439593665286-1f23mt5c8kc26khcs0c4detqcm0m50l4.apps.googleusercontent.com",
    "client_secret": "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"
  }
  '';
}

