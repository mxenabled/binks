package com.mx.binks

import org.gradle.api.Plugin
import org.gradle.api.Project

class BinksPlugin : Plugin<Project> {
  @Suppress("MaxLineLength")
  override fun apply(project: Project) {
    project.tasks.register("release", ReleaseTask::class.java)
  }
}
