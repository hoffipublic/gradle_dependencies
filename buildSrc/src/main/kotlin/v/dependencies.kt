package v

// singleton definitions
    object Latest {
        enum class Release(val version: String) {
            springBoot("2.2.2.RELEASE"),
            springCloud("Hoxton.SR1"),
            micrometerRegistryPrometheus("latest.release"),
            springCloudContract("2.2.1.RELEASE"),
            resilience4j("1.2.0"),
            logback("1.2.3"),
            graphqlJava("13.0"),
            graphqlSpring("1.0"),
            snakeYaml("1.25"),
            jacksonModuleKotlin("2.10.0"),
            braveInstrumentation("5.6.9"),
            commonsLang3("3.9"),
            commonsText("1.8"),
            picocli("4.1.4"),
            junitJupiter("5.5.2")
        }
        enum class Snapshot(val version: String) {
            springCloud(""),
            springCloudCircuitbreaker("1.0.0.BUILD-SNAPSHOT"),
            springSleuth(""),
            springCloudContract("")
        }
        enum class Plugin(val version: String) {
            dependencyManagement("1.0.8.RELEASE"),
            springCloudContract("2.2.1.RELEASE"),
            propdeps("0.0.9.RELEASE"),
            cfGradle("1.1.3"),
            docker("6.1.1"),
            artifactory("latest"),
            jenkins("1.3.6"),
            gitProperties("2.2.0")
        }
    }
    // Extension functions on gradles DependencyHandler class
    val springBootLatest = Latest.Release.springBoot.version
    val springCloudLatest = Latest.Release.springCloud.version
    val micrometerRegistryPrometheusLatest = Latest.Release.micrometerRegistryPrometheus.version
    val springCloudContractLatest = Latest.Release.springCloudContract.version
    val resilience4jLatest = Latest.Release.resilience4j.version
    val logbackLatest = Latest.Release.logback.version
    val graphqlJavaLatest = Latest.Release.graphqlJava.version
    val graphqlSpringLatest = Latest.Release.graphqlSpring.version
    val snakeYamlLatest = Latest.Release.snakeYaml.version
    val jacksonModuleKotlinLatest = Latest.Release.jacksonModuleKotlin.version
    val braveInstrumentationLatest = Latest.Release.braveInstrumentation.version
    val commonsLang3Latest = Latest.Release.commonsLang3.version
    val commonsTextLatest = Latest.Release.commonsText.version
    val picocliLatest = Latest.Release.picocli.version
    val junitJupiterLatest = Latest.Release.junitJupiter.version

    val springCloudSnapshot = Latest.Snapshot.springCloud.version
    val springCloudCircuitbreakerSnapshot = Latest.Snapshot.springCloudCircuitbreaker.version
    val springSleuthSnapshot = Latest.Snapshot.springSleuth.version
    val springCloudContractSnapshot = Latest.Snapshot.springCloudContract.version

    val dependencyManagementPlugin = Latest.Plugin.dependencyManagement.version
    val springCloudContractPlugin = Latest.Plugin.springCloudContract.version
    val propdepsPlugin = Latest.Plugin.propdeps.version
    val cfGradlePlugin = Latest.Plugin.cfGradle.version
    val dockerPlugin = Latest.Plugin.docker.version
    val artifactoryPlugin = Latest.Plugin.artifactory.version
    val jenkinsPlugin = Latest.Plugin.jenkins.version
    val gitPropertiesPlugin = Latest.Plugin.gitProperties.version
