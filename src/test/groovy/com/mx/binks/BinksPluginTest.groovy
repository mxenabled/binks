package com.mx.binks

import org.gradle.testkit.runner.GradleRunner
import org.gradle.testkit.runner.TaskOutcome

import spock.lang.Specification
import spock.lang.TempDir

class BinksPluginTest extends Specification {
  @TempDir
  File testProjectFolder
  File buildFile

  def setup() {
    buildFile = new File(testProjectFolder, "build.gradle")
    buildFile << """
      plugins {
        id 'com.mx.binks'
      }
      version '0.0.1'
      """
  }

  def "releases"() {
    when:
    def result = GradleRunner.create()
        .withProjectDir(testProjectFolder)
        .withArguments("release", "--check-only", "--ignore-dirty-tree", "--force")
        .withPluginClasspath()
        .build()

    then:
    result.task(":release").outcome == TaskOutcome.SUCCESS
    result.output.contains("Released")
  }
}
