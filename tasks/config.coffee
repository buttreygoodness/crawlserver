module.exports =

  pkg: require "#{process.cwd()}/package.json"

  default:
    deps: ['spec', 'lint']

  spec:
    paths: ["#{process.cwd()}/spec/specs/**/*.coffee"]

    options:
      reporter: 'dot'

  lint:
    paths: ["#{process.cwd()}/{src,tasks,spec}/**/*.coffee"]