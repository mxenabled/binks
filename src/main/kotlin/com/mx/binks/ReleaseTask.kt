package com.mx.binks

import com.mx.binks.core.Git
import com.mx.binks.core.cyan
import com.mx.binks.core.exceptions.ReleaseError
import com.mx.binks.core.green
import com.mx.binks.core.red
import com.mx.binks.core.yellow
import org.gradle.api.DefaultTask
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.options.Option

@Suppress("UnstableApiUsage")
open class ReleaseTask : DefaultTask() {
  init {
    description = "Validate and push version tag to launch release pipeline."
    group = "Publishing"
  }

  @set:Option(
    option = "check-only",
    description = "Does a dry run. Just check the version. Don't tag or push."
  )
  @get:Input
  var checkOnly: Boolean = false

  @set:Option(
    option = "force",
    description = "Force tag. Moves existing tag to current hash"
  )
  @get:Input
  var force: Boolean = false

  @set:Option(
    option = "ignore-dirty-tree",
    description = "Don't check for dirty tree. Release with uncommitted changes."
  )
  @get:Input
  var ignoreDirtyTree: Boolean = false

  @set:Option(
    option = "refresh-tags",
    description = "Clean out all local tags and fetch from origin"
  )
  @get:Input
  var refreshTags: Boolean = false

  @TaskAction
  fun release() {
    if (!ignoreDirtyTree && Git(false).isDirty()) {
      throw ReleaseError("${red("You'sa in big doodoo, dis time!")}\n${yellow("Dirty git tree. Commit your changes or use --ignore-dirty-tree")}")
    }

    if (refreshTags) {
      Git(true).deleteLocalTags()
    }

    val branch = Git(false).currentBranch()
    val version = project.version.toString()
    val tags = Git(false).allTags()

    if (!force && tags.contains(project.version.toString())) {
      println(cyan("Existing tags:"))
      for (tag in tags) {
        if (tag == version) {
          println(red("> $tag"))
        } else {
          println(cyan(tag))
        }
      }
      throw ReleaseError(
        "${
          red("You'sa in big doodoo, dis time!")
        }\n${
          yellow("Version ($version) already in use. Change the version or use --force")
        }"
      )
    }

    if (!checkOnly) {
      Git(true).applyTag(version, force)
      Git(true).pushTag(version, force)
    }

    println(green("Released $version from $branch${if (checkOnly) " (DRY RUN)" else ""}"))
  }
}
