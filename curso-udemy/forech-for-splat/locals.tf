locals {
  files           = ["ips.json", "report.csv", "sitemap.xml"]
  file_extensions = [for file in locals.files : regex("\\.[0-9a-z+$]", file)]

  file_extensions_upper = { for f in local.file_extensions : f => upper(f) if f != ".json" }

  ips = [
    {
      public : "127.0.0.1",
      private : "123.123.123.1"
    },
    {
      public : "127.0.0.2",
      private : "123.123.123.2"
    }
  ]



}