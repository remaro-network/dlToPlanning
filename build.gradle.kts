import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar

plugins {
    kotlin("jvm") version "1.9.23"
    id("com.github.johnrengelman.shadow") version "8.1.1"
    id("java")
}

group = "no.uio.tobiajoh"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
    gradlePluginPortal()
}



dependencies {
    testImplementation(kotlin("test"))
    implementation("net.sourceforge.owlapi:owlapi-distribution:5.5.0")
    implementation("org.slf4j:slf4j-nop:2.0.0-alpha1")
    implementation("com.github.ajalt.clikt:clikt:4.3.0")
    implementation("io.kotlintest:kotlintest-runner-junit5:3.4.0")
    //testImplementation("org.jetbrains.kotlin:kotlin-test-junit")

}

tasks.test {
    useJUnitPlatform()
}
kotlin {
    jvmToolchain(17)
}



tasks.withType<ShadowJar> {
    manifest {
        attributes("Main-Class" to  "no.uio.tobiajoh.MainKt")
    }
}

tasks.withType<Jar> {
    manifest {
        attributes("Main-Class" to  "no.uio.tobiajoh.MainKt")
    }
}
