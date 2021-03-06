load("//macros/user:user.bzl", "user_layer")
load("//scripts/versions:versions.bzl", "ELASTICSEARCH_VERSION")

ES_HOME = "/opt/elasticsearch"
ES_DATA = "/elasticsearch"
CONF_DIR = "/etc/elasticsearch"
DATA_DIR = ES_DATA + "/data"
LOG_DIR = ES_DATA + "/logs"
PLUGINS_DIR = "/opt/elasticsearch/plugins"
VERSION = ELASTICSEARCH_VERSION

user_layer(
  name = "user",
  id = "917",
  user = "elasticsearch",
  home = ES_DATA,
)

container_layer(
  name = "files",
  directory = "/opt",
  files = ["@elasticsearch//:elasticsearch-" + VERSION],
  symlinks = {
    "/opt/elasticsearch": "/opt/elasticsearch-" + VERSION,
  },
)

container_layer(
  name = "init",
  directory = "/",
  files = ["entrypoint-elasticsearch"],
)

container_layer(
  name = "config",
  directory = CONF_DIR,
  files = glob(["config/*"]),
)

container_image(
  name = "elasticsearch",
  base = "//java:zulu",
  layers = ["//base/gosu", ":user", ":files", ":init", ":config"],

  env = {
    "ES_HOME": ES_HOME,
    "ES_VERSION": VERSION,
    "ES_DATA": ES_DATA,
    "CONF_DIR": CONF_DIR,
    "DATA_DIR": DATA_DIR,
    "LOG_DIR": LOG_DIR,
    "PLUGINS_DIR": PLUGINS_DIR,

    "HEAP_SIZE_PERCENTAGE": "50",

    "ES_NETWORK_HOST": "0.0.0.0",
    "ES_CLUSTER_NAME": "Elasticsearch",
  },
  volumes = [ES_DATA, CONF_DIR, PLUGINS_DIR],
  ports = ["9200", "9300"],
  workdir = ES_DATA,
  entrypoint = ["/entrypoint-elasticsearch"],
  cmd = ["elasticsearch"],

  visibility = ["//visibility:public"],
)
