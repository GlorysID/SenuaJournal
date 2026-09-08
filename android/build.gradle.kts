allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    if (project.name != "app" && !project.state.executed) {
        afterEvaluate {
            if (project.hasProperty("android")) {
                project.extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                    compileSdkVersion(36)
                    if (namespace == null) {
                        namespace = project.group.toString()
                    }
                }
            }
        }
    }
}


tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    configurations.all {
        resolutionStrategy {
            force("androidx.core:core:1.13.1")
            force("androidx.core:core-ktx:1.13.1")
        }
    }
}
