package com.mx.binks

import org.gradle.api.Plugin
import org.gradle.api.Project

class BinksPlugin : Plugin<Project> {
  @Suppress("MaxLineLength")
  override fun apply(project: Project) {
    var dependenciesExtension = project.extensions.create("binks", BinksExtension::class.java)

    project.afterEvaluate {
    }

    project.tasks.register("release") { task ->
      task.doLast {
        println("Released")
      }
    }
  }
}
