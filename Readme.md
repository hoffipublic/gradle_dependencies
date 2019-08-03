
## usage in gradle

first lines of your gradle.build

```
import groovy.json.JsonSlurper

buildscript {
    ext {
        versions = new JsonSlurper().parseFile(rootProject.file('dependencies.json'), 'UTF-8')
        v = {  x -> versions.latest.default[x] }
        vp = { x -> versions.latest.plugin[x] }
    }
```

Be sure to link this project's dependencies.json into the project root folder of your project.


use above helpers functions to define your version dependencies, e.g.:


```
    dependencies {
        classpath "io.spring.gradle:dependency-management-plugin:${v('dependencyManagementPluginVersion')}"
        ...
```

If you need other parts of your json, adjust or add functions in buildscript ext above.
