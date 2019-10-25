#!/usr/local/bin/bash

dependenciesJsonFile=./dependencies.json

declare -a all=(\
'default'   'springBootVersion'          'org.springframework.boot'  'spring-boot-dependencies'                'http://repo1.maven.org/maven2' \
'default'   'springCloudVersion'         'org.springframework.cloud' 'spring-cloud-dependencies'               'http://repo1.maven.org/maven2' \
'snapshots' 'springCloudVersion'         'org.springframework.cloud' 'spring-cloud-dependencies'               'https://repo.spring.io/milestone' \
'default'   'springCloudContractVersion' 'org.springframework.cloud' 'spring-cloud-starter-contract-verifier'  'http://repo1.maven.org/maven2' \
'snapshots' 'springCloudContractVersion' 'org.springframework.cloud' 'spring-cloud-starter-contract-verifier'  'https://repo.spring.io/milestone' \
'default'   'springCloudContractVersion' 'org.springframework.cloud' 'spring-cloud-contract-gradle-plugin'     'http://repo1.maven.org/maven2' \
'plugin'    'springCloudContractVersion' 'org.springframework.cloud' 'spring-cloud-contract-gradle-plugin'     'http://repo1.maven.org/maven2' \
'default'   'resilience4jVersion'        'io.github.resilience4j'    'resilience4j-spring-cloud2'              'http://repo1.maven.org/maven2' \
'groovy'    'groovyAllVersion'           'org.codehaus.groovy'       'groovy-all'                              'http://repo1.maven.org/maven2' \
'groovy'    'spockVersion'               'org.spockframework'        'spock-core'                              'http://repo1.maven.org/maven2' \
'default'   'logbackVersion'             'ch.qos.logback'            'logback-classic'                         'http://repo1.maven.org/maven2' \
'default'   'snakeYamlVersion'           'org.yaml'                  'snakeyaml'                               'http://repo1.maven.org/maven2' \
'default'   'picocliVersion'             'info.picocli'              'picocli'                                 'http://repo1.maven.org/maven2' \
'default'   'junitJupiterVersion'        'org.junit.jupiter'         'junit-jupiter'                           'http://repo1.maven.org/maven2' \
)

declare -A latestVersionsHash
declare -A actualVersionsHash

for (( i=0; $i < ${#all[@]}; i+=5 )); do
    repo=${all[$i+4]}
    searchUrl="${repo}/${all[$i+2]//./\/}/${all[$i+3]}/maven-metadata.xml"
    latest=$(http --body "$searchUrl" | grep '<latest>.*</latest>' | sed -E 's#^.*<latest>(.*)</latest>.*$#\1#')
    latestVersionsHash["${all[$i+1]}"]=$latest
    actual=$(sed -E '/ *"'${all[$i+0]}'":/,/}/!d; s/ *"'${all[$i+1]}'": *"([^"]*)".*/\1/p;d' $dependenciesJsonFile)
    actualVersionsHash["${all[$i+1]}"]=$actual
    echo "${searchUrl//?/=}" # underline
    echo    "${all[$i+1]}: latest: ${latest}"
    echo -n "${all[$i+1]}: actual: ${actual}"
    if [ "$latest" != "$actual" ]; then echo -e " !!!!!!!!!!!!!!!!!!!!!!!!!\n${searchUrl}"; else echo ""; fi
    #echo "$searchUrl"
    #echo "${searchUrl//?/=}" # underline
    #echo "latest:  ${all[$i+1]}:${all[$i+2]}:$latest"
    #echo "actual:  ${all[$i+1]}:${all[$i+2]}:$latest"
done


echo ""
echo "####################################"
echo "#####  Gradle Plugins:      ########"
echo "####################################"

declare -a plugins=( \
'dependencyManagementPluginVersion' 'io.spring.dependency-management'      'https://plugins.gradle.org/plugin' \
'springCloudContractVersion'        'org.springframework.cloud.contract'   'https://plugins.gradle.org/plugin' \
'artifactoryPluginVersion'   'com.jfrog.artifactory'                       'https://plugins.gradle.org/plugin' \
'dockerPluginVersion'        'com.bmuschko.docker-spring-boot-application' 'https://plugins.gradle.org/plugin' \
'gitPropertiesPluginVersion' 'com.gorylenko.gradle-git-properties'         'https://plugins.gradle.org/plugin' \
)

for (( i=0; $i < ${#plugins[@]}; i+=3 )); do
    repo=${plugins[$i+2]}
    searchUrl="${repo}/${plugins[$i+1]}"
    latest=$(http --body $searchUrl | grep "<h3>Version .* (latest) </h3>" | sed -E 's#.*<h3>Version (.*) \(latest\) </h3>.*#\1#')
    actual=$(sed -E '/ *"plugin":/,/}/!d; s/ *"'${plugins[$i+0]}'": *"([^"]*)".*/\1/p;d' $dependenciesJsonFile)
    echo ${searchUrl//?/=} # underline
    echo    "${plugins[$i]}: ${latest}"
    echo -n "${plugins[$i]}: ${actual}"
    if [ "$latest" != "$actual" ]; then echo -e " !!!!!!!!!!!!!!!!!!!!!!!!!\n${searchUrl}"; else echo ""; fi
    echo $searchUrl
done

