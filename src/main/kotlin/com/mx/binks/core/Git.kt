package com.mx.binks.core

import com.lordcodes.turtle.shellRun

class Git(val verbose: Boolean) {
  fun allTags(): List<String> {
    shellRun("git", listOf("fetch", "--tags", "--force"))
    val tagList = shellRun("git", listOf("tag", "-l"))
    return tagList.trim().split("\n")
  }

  fun deleteLocalTags() {
    val tags = shellRun("git", listOf("tag", "-l")).split("\n")
    for (tag in tags) {
      out(shellRun("git", listOf("tag", "-d", tag)))
    }
  }

  fun applyTag(tag: String, force: Boolean) {
    var params = listOf("tag", tag)
    if (force) {
      params = params + listOf("-f")
    }
    out(shellRun("git", params))
  }

  fun currentBranch(): String {
    return shellRun("git", listOf("rev-parse", "--abbrev-ref", "HEAD")).trim()
  }

  fun isDirty(): Boolean {
    return shellRun("git", listOf("diff", "--stat")).trim().isNotBlank()
  }

  fun pushTag(tag: String, force: Boolean) {
    var params = listOf("push", "origin", "tag", tag)
    if (force) {
      params = params + "-f"
    }
    out(shellRun("git", params))
  }

  private fun out(str: String) {
    if (verbose) {
      println(str)
    }
  }
}
