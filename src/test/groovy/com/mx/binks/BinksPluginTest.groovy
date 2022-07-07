package com.mx.binks

import org.gradle.internal.impldep.org.junit.Rule
import org.gradle.internal.impldep.org.junit.rules.TemporaryFolder
import org.gradle.testkit.runner.GradleRunner
import org.gradle.testkit.runner.TaskOutcome

import spock.lang.Specification

class BinksPluginTest extends Specification {
  @Rule
  TemporaryFolder testProjectFolder = new TemporaryFolder()
  File buildFile

  def setup() {
    testProjectFolder.create()
    buildFile = testProjectFolder.newFile("build.gradle")
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
        .withProjectDir(testProjectFolder.root)
        .withArguments("release", "--check-only", "--ignore-dirty-tree", "--force")
        .withPluginClasspath()
        .build()

    then:
    result.task(":release").outcome == TaskOutcome.SUCCESS
    result.output.contains("Released")
  }
}
