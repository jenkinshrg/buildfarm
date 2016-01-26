#!/bin/bash

NAME=${1}
REPO_URL=${2}
REPO_DIR=${3}
BRANCH=${4}
NODE=${5-master}
TRIGGER=${6-none}
URL=${7:-http://localhost:8080}

wget -q ${URL}/jnlpJars/jenkins-cli.jar

if [ "${NODE}" = "slave" ]; then
cat << EOL | java -jar jenkins-cli.jar -s ${URL} create-job ${NAME}
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <logRotator class="hudson.tasks.LogRotator">
    <daysToKeep>7</daysToKeep>
    <numToKeep>-1</numToKeep>
    <artifactDaysToKeep>-1</artifactDaysToKeep>
    <artifactNumToKeep>-1</artifactNumToKeep>
  </logRotator>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="org.jenkinsci.plugins.multiplescms.MultiSCM" plugin="multiple-scms@0.5">
    <scms>
      <hudson.scm.SubversionSCM plugin="subversion@1.54">
        <locations>
          <hudson.scm.SubversionSCM_-ModuleLocation>
            <remote>https://atom.a01.aist.go.jp/svn/HRP2/trunk</remote>
            <local>src/HRP2</local>
            <depthOption>infinity</depthOption>
            <ignoreExternalsOption>false</ignoreExternalsOption>
          </hudson.scm.SubversionSCM_-ModuleLocation>
          <hudson.scm.SubversionSCM_-ModuleLocation>
            <remote>https://atom.a01.aist.go.jp/svn/hrprtc/trunk</remote>
            <local>src/hrpsys-private</local>
            <depthOption>infinity</depthOption>
            <ignoreExternalsOption>false</ignoreExternalsOption>
          </hudson.scm.SubversionSCM_-ModuleLocation>
        </locations>
        <excludedRegions></excludedRegions>
        <includedRegions></includedRegions>
        <excludedUsers></excludedUsers>
        <excludedRevprop></excludedRevprop>
        <excludedCommitMessages></excludedCommitMessages>
        <workspaceUpdater class="hudson.scm.subversion.UpdateUpdater"/>
        <ignoreDirPropChanges>false</ignoreDirPropChanges>
        <filterChangelog>false</filterChangelog>
      </hudson.scm.SubversionSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.0">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>https://github.com/fkanehiro/openhrp3.git</url>
          </hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
          <hudson.plugins.git.BranchSpec>
            <name>*/master</name>
          </hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
        <extensions>
          <hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
            <relativeTargetDir>src/openhrp3</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>openhrp3</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.0">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>https://github.com/jrl-umi3218/hrp2-drc.git</url>
          </hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
          <hudson.plugins.git.BranchSpec>
            <name>*/master</name>
          </hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
        <extensions>
          <hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
            <relativeTargetDir>src/HRP2DRC</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>HRP2DRC</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.0">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>https://github.com/fkanehiro/hrpsys-base.git</url>
          </hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
          <hudson.plugins.git.BranchSpec>
            <name>*/master</name>
          </hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
        <extensions>
          <hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
            <relativeTargetDir>src/hrpsys-base</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>hrpsys-base</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.0">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>https://github.com/jrl-umi3218/hmc2.git</url>
          </hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
          <hudson.plugins.git.BranchSpec>
            <name>*/master</name>
          </hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
        <extensions>
          <hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
            <relativeTargetDir>src/hmc2</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>hmc2</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.0">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>https://github.com/jrl-umi3218/hrpsys-humanoid.git</url>
          </hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
          <hudson.plugins.git.BranchSpec>
            <name>*/master</name>
          </hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
        <extensions>
          <hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
            <relativeTargetDir>src/hrpsys-humanoid</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>hrpsys-humanoid</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.0">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>https://choreonoid.org/git/choreonoid.git</url>
          </hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
          <hudson.plugins.git.BranchSpec>
            <name>*/master</name>
          </hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
        <extensions>
          <hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
            <relativeTargetDir>src/choreonoid</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>choreonoid</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.0">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>https://github.com/jrl-umi3218/hrpcnoid.git</url>
          </hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
          <hudson.plugins.git.BranchSpec>
            <name>*/master</name>
          </hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
        <extensions>
          <hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
            <relativeTargetDir>src/choreonoid/ext/hrpcnoid</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>hrpcnoid</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
    </scms>
  </scm>
  <assignedNode>${NODE}</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <hudson.triggers.SCMTrigger>
      <spec>0 * * * *</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders/>
  <publishers>
    <hudson.tasks.BuildTrigger>
      <childProjects>drcutil-64,drcutil-32</childProjects>
      <threshold>
        <name>SUCCESS</name>
        <ordinal>0</ordinal>
        <color>BLUE</color>
        <completeBuild>true</completeBuild>
      </threshold>
    </hudson.tasks.BuildTrigger>
    <hudson.plugins.emailext.ExtendedEmailPublisher plugin="email-ext@2.40.5">
      <recipientList>\$DEFAULT_RECIPIENTS</recipientList>
      <configuredTriggers>
        <hudson.plugins.emailext.plugins.trigger.StatusChangedTrigger>
          <email>
            <recipientList></recipientList>
            <subject>\$PROJECT_DEFAULT_SUBJECT</subject>
            <body>\$PROJECT_DEFAULT_CONTENT</body>
            <recipientProviders>
              <hudson.plugins.emailext.plugins.recipients.ListRecipientProvider/>
            </recipientProviders>
            <attachmentsPattern></attachmentsPattern>
            <attachBuildLog>false</attachBuildLog>
            <compressBuildLog>false</compressBuildLog>
            <replyTo>\$PROJECT_DEFAULT_REPLYTO</replyTo>
            <contentType>project</contentType>
          </email>
        </hudson.plugins.emailext.plugins.trigger.StatusChangedTrigger>
      </configuredTriggers>
      <contentType>default</contentType>
      <defaultSubject>\$DEFAULT_SUBJECT</defaultSubject>
      <defaultContent>\$DEFAULT_CONTENT</defaultContent>
      <attachmentsPattern></attachmentsPattern>
      <presendScript>\$DEFAULT_PRESEND_SCRIPT</presendScript>
      <attachBuildLog>false</attachBuildLog>
      <compressBuildLog>false</compressBuildLog>
      <replyTo>\$DEFAULT_REPLYTO</replyTo>
      <saveOutput>false</saveOutput>
      <disabled>false</disabled>
    </hudson.plugins.emailext.ExtendedEmailPublisher>
  </publishers>
  <buildWrappers>
    <hudson.plugins.ansicolor.AnsiColorBuildWrapper plugin="ansicolor@0.4.1">
      <colorMapName>xterm</colorMapName>
    </hudson.plugins.ansicolor.AnsiColorBuildWrapper>
    <hudson.plugins.timestamper.TimestamperBuildWrapper plugin="timestamper@1.7.2"/>
  </buildWrappers>
</project>
EOL
else
if [ "${TRIGGER}" = "periodic" ]; then
cat << EOL | java -jar jenkins-cli.jar -s ${URL} create-job ${NAME}
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <logRotator class="hudson.tasks.LogRotator">
    <daysToKeep>7</daysToKeep>
    <numToKeep>-1</numToKeep>
    <artifactDaysToKeep>-1</artifactDaysToKeep>
    <artifactNumToKeep>-1</artifactNumToKeep>
  </logRotator>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <assignedNode>${NODE}</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <hudson.triggers.TimerTrigger>
      <spec>0 * * * *</spec>
    </hudson.triggers.TimerTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>#!/bin/bash
set -xe

rm -fr ${REPO_DIR}
git clone --branch ${BRANCH} --single-branch ${REPO_URL} ${REPO_DIR}
cd ${REPO_DIR}

source .jenkins.sh</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.tasks.ArtifactArchiver>
      <artifacts>changes.txt,build.txt,artifacts.txt,jenkinshrg.txt,jenkinshrg.ogv,jenkinshrg.png,testbed-terrain.txt,testbed-terrain.png,testbed-terrain.ogv,drc-valves.txt,drc-valves.png,drc-valves.ogv,drc-wall-testbed.txt,drc-wall-testbed.png,drc-wall-testbed.ogv,irex-balance-beam-auto.txt,irex-balance-beam-auto.png,irex-balance-beam-auto.ogv</artifacts>
      <allowEmptyArchive>true</allowEmptyArchive>
      <onlyIfSuccessful>false</onlyIfSuccessful>
      <fingerprint>false</fingerprint>
      <defaultExcludes>true</defaultExcludes>
    </hudson.tasks.ArtifactArchiver>
    <hudson.plugins.cobertura.CoberturaPublisher plugin="cobertura@1.9.7">
      <coberturaReportFile>**/coverage.xml</coberturaReportFile>
      <onlyStable>false</onlyStable>
      <failUnhealthy>false</failUnhealthy>
      <failUnstable>false</failUnstable>
      <autoUpdateHealth>false</autoUpdateHealth>
      <autoUpdateStability>false</autoUpdateStability>
      <zoomCoverageChart>false</zoomCoverageChart>
      <maxNumberOfBuilds>0</maxNumberOfBuilds>
      <failNoReports>false</failNoReports>
      <healthyTarget>
        <targets class="enum-map" enum-type="hudson.plugins.cobertura.targets.CoverageMetric">
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>METHOD</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>8000000</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>LINE</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>8000000</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>CONDITIONAL</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>7000000</int>
          </entry>
        </targets>
      </healthyTarget>
      <unhealthyTarget>
        <targets class="enum-map" enum-type="hudson.plugins.cobertura.targets.CoverageMetric">
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>METHOD</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>LINE</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>CONDITIONAL</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
        </targets>
      </unhealthyTarget>
      <failingTarget>
        <targets class="enum-map" enum-type="hudson.plugins.cobertura.targets.CoverageMetric">
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>METHOD</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>LINE</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>CONDITIONAL</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
        </targets>
      </failingTarget>
      <sourceEncoding>ASCII</sourceEncoding>
    </hudson.plugins.cobertura.CoberturaPublisher>
    <org.jenkinsci.plugins.cppcheck.CppcheckPublisher plugin="cppcheck@1.21">
      <cppcheckConfig>
        <pattern>**/cppcheck.xml</pattern>
        <ignoreBlankFiles>false</ignoreBlankFiles>
        <allowNoReport>true</allowNoReport>
        <configSeverityEvaluation>
          <threshold></threshold>
          <newThreshold></newThreshold>
          <failureThreshold></failureThreshold>
          <newFailureThreshold></newFailureThreshold>
          <healthy></healthy>
          <unHealthy></unHealthy>
          <severityError>true</severityError>
          <severityWarning>true</severityWarning>
          <severityStyle>true</severityStyle>
          <severityPerformance>true</severityPerformance>
          <severityInformation>true</severityInformation>
          <severityNoCategory>true</severityNoCategory>
          <severityPortability>true</severityPortability>
        </configSeverityEvaluation>
        <configGraph>
          <xSize>500</xSize>
          <ySize>200</ySize>
          <numBuildsInGraph>0</numBuildsInGraph>
          <displayAllErrors>true</displayAllErrors>
          <displayErrorSeverity>true</displayErrorSeverity>
          <displayWarningSeverity>true</displayWarningSeverity>
          <displayStyleSeverity>true</displayStyleSeverity>
          <displayPerformanceSeverity>true</displayPerformanceSeverity>
          <displayInformationSeverity>true</displayInformationSeverity>
          <displayNoCategorySeverity>true</displayNoCategorySeverity>
          <displayPortabilitySeverity>true</displayPortabilitySeverity>
        </configGraph>
      </cppcheckConfig>
    </org.jenkinsci.plugins.cppcheck.CppcheckPublisher>
    <org.jenkinsci.plugins.valgrind.ValgrindPublisher plugin="valgrind@0.25">
      <valgrindPublisherConfig>
        <pattern>**/valgrind.xml</pattern>
        <failThresholdInvalidReadWrite></failThresholdInvalidReadWrite>
        <failThresholdDefinitelyLost></failThresholdDefinitelyLost>
        <failThresholdTotal></failThresholdTotal>
        <unstableThresholdInvalidReadWrite></unstableThresholdInvalidReadWrite>
        <unstableThresholdDefinitelyLost></unstableThresholdDefinitelyLost>
        <unstableThresholdTotal></unstableThresholdTotal>
        <publishResultsForAbortedBuilds>false</publishResultsForAbortedBuilds>
        <publishResultsForFailedBuilds>false</publishResultsForFailedBuilds>
        <failBuildOnMissingReports>false</failBuildOnMissingReports>
        <failBuildOnInvalidReports>false</failBuildOnInvalidReports>
      </valgrindPublisherConfig>
    </org.jenkinsci.plugins.valgrind.ValgrindPublisher>
    <xunit plugin="xunit@1.96">
      <types>
        <CTestType>
          <pattern>**/Test.xml</pattern>
          <skipNoTestFiles>true</skipNoTestFiles>
          <failIfNotNew>false</failIfNotNew>
          <deleteOutputFiles>true</deleteOutputFiles>
          <stopProcessingIfError>true</stopProcessingIfError>
        </CTestType>
        <GoogleTestType>
          <pattern>**/gtest.xml</pattern>
          <skipNoTestFiles>true</skipNoTestFiles>
          <failIfNotNew>false</failIfNotNew>
          <deleteOutputFiles>true</deleteOutputFiles>
          <stopProcessingIfError>true</stopProcessingIfError>
        </GoogleTestType>
        <JUnitType>
          <pattern>**/jenkinshrg.xml,**/testbed-terrain.xml,**/drc-valves.xml,**/drc-wall-testbed.xml,**/irex-balance-beam-auto.xml</pattern>
          <skipNoTestFiles>true</skipNoTestFiles>
          <failIfNotNew>false</failIfNotNew>
          <deleteOutputFiles>true</deleteOutputFiles>
          <stopProcessingIfError>true</stopProcessingIfError>
        </JUnitType>
      </types>
      <thresholds>
        <org.jenkinsci.plugins.xunit.threshold.FailedThreshold>
          <unstableThreshold>0</unstableThreshold>
          <unstableNewThreshold></unstableNewThreshold>
          <failureThreshold></failureThreshold>
          <failureNewThreshold></failureNewThreshold>
        </org.jenkinsci.plugins.xunit.threshold.FailedThreshold>
        <org.jenkinsci.plugins.xunit.threshold.SkippedThreshold>
          <unstableThreshold></unstableThreshold>
          <unstableNewThreshold></unstableNewThreshold>
          <failureThreshold></failureThreshold>
          <failureNewThreshold></failureNewThreshold>
        </org.jenkinsci.plugins.xunit.threshold.SkippedThreshold>
      </thresholds>
      <thresholdMode>1</thresholdMode>
      <extraConfiguration>
        <testTimeMargin>3000</testTimeMargin>
      </extraConfiguration>
    </xunit>
    <hudson.plugins.emailext.ExtendedEmailPublisher plugin="email-ext@2.40.5">
      <recipientList>\$DEFAULT_RECIPIENTS</recipientList>
      <configuredTriggers>
        <hudson.plugins.emailext.plugins.trigger.StatusChangedTrigger>
          <email>
            <recipientList></recipientList>
            <subject>\$PROJECT_DEFAULT_SUBJECT</subject>
            <body>\$PROJECT_DEFAULT_CONTENT</body>
            <recipientProviders>
              <hudson.plugins.emailext.plugins.recipients.ListRecipientProvider/>
            </recipientProviders>
            <attachmentsPattern></attachmentsPattern>
            <attachBuildLog>false</attachBuildLog>
            <compressBuildLog>false</compressBuildLog>
            <replyTo>\$PROJECT_DEFAULT_REPLYTO</replyTo>
            <contentType>project</contentType>
          </email>
        </hudson.plugins.emailext.plugins.trigger.StatusChangedTrigger>
      </configuredTriggers>
      <contentType>default</contentType>
      <defaultSubject>\$DEFAULT_SUBJECT</defaultSubject>
      <defaultContent>\$DEFAULT_CONTENT</defaultContent>
      <attachmentsPattern></attachmentsPattern>
      <presendScript>\$DEFAULT_PRESEND_SCRIPT</presendScript>
      <attachBuildLog>false</attachBuildLog>
      <compressBuildLog>false</compressBuildLog>
      <replyTo>\$DEFAULT_REPLYTO</replyTo>
      <saveOutput>false</saveOutput>
      <disabled>false</disabled>
    </hudson.plugins.emailext.ExtendedEmailPublisher>
  </publishers>
  <buildWrappers>
    <hudson.plugins.ansicolor.AnsiColorBuildWrapper plugin="ansicolor@0.4.1">
      <colorMapName>xterm</colorMapName>
    </hudson.plugins.ansicolor.AnsiColorBuildWrapper>
    <hudson.plugins.timestamper.TimestamperBuildWrapper plugin="timestamper@1.7.2"/>
  </buildWrappers>
</project>
EOL
else
cat << EOL | java -jar jenkins-cli.jar -s ${URL} create-job ${NAME}
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <logRotator class="hudson.tasks.LogRotator">
    <daysToKeep>7</daysToKeep>
    <numToKeep>-1</numToKeep>
    <artifactDaysToKeep>-1</artifactDaysToKeep>
    <artifactNumToKeep>-1</artifactNumToKeep>
  </logRotator>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <assignedNode>${NODE}</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>#!/bin/bash
set -xe

rm -fr ${REPO_DIR}
git clone --branch ${BRANCH} --single-branch ${REPO_URL} ${REPO_DIR}
cd ${REPO_DIR}

source .jenkins.sh</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.tasks.ArtifactArchiver>
      <artifacts>changes.txt,build.txt,artifacts.txt,jenkinshrg.txt,jenkinshrg.ogv,jenkinshrg.png,testbed-terrain.txt,testbed-terrain.png,testbed-terrain.ogv,drc-valves.txt,drc-valves.png,drc-valves.ogv,drc-wall-testbed.txt,drc-wall-testbed.png,drc-wall-testbed.ogv,irex-balance-beam-auto.txt,irex-balance-beam-auto.png,irex-balance-beam-auto.ogv</artifacts>
      <allowEmptyArchive>true</allowEmptyArchive>
      <onlyIfSuccessful>false</onlyIfSuccessful>
      <fingerprint>false</fingerprint>
      <defaultExcludes>true</defaultExcludes>
    </hudson.tasks.ArtifactArchiver>
    <hudson.plugins.cobertura.CoberturaPublisher plugin="cobertura@1.9.7">
      <coberturaReportFile>**/coverage.xml</coberturaReportFile>
      <onlyStable>false</onlyStable>
      <failUnhealthy>false</failUnhealthy>
      <failUnstable>false</failUnstable>
      <autoUpdateHealth>false</autoUpdateHealth>
      <autoUpdateStability>false</autoUpdateStability>
      <zoomCoverageChart>false</zoomCoverageChart>
      <maxNumberOfBuilds>0</maxNumberOfBuilds>
      <failNoReports>false</failNoReports>
      <healthyTarget>
        <targets class="enum-map" enum-type="hudson.plugins.cobertura.targets.CoverageMetric">
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>METHOD</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>8000000</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>LINE</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>8000000</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>CONDITIONAL</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>7000000</int>
          </entry>
        </targets>
      </healthyTarget>
      <unhealthyTarget>
        <targets class="enum-map" enum-type="hudson.plugins.cobertura.targets.CoverageMetric">
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>METHOD</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>LINE</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>CONDITIONAL</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
        </targets>
      </unhealthyTarget>
      <failingTarget>
        <targets class="enum-map" enum-type="hudson.plugins.cobertura.targets.CoverageMetric">
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>METHOD</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>LINE</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
          <entry>
            <hudson.plugins.cobertura.targets.CoverageMetric>CONDITIONAL</hudson.plugins.cobertura.targets.CoverageMetric>
            <int>0</int>
          </entry>
        </targets>
      </failingTarget>
      <sourceEncoding>ASCII</sourceEncoding>
    </hudson.plugins.cobertura.CoberturaPublisher>
    <org.jenkinsci.plugins.cppcheck.CppcheckPublisher plugin="cppcheck@1.21">
      <cppcheckConfig>
        <pattern>**/cppcheck.xml</pattern>
        <ignoreBlankFiles>false</ignoreBlankFiles>
        <allowNoReport>true</allowNoReport>
        <configSeverityEvaluation>
          <threshold></threshold>
          <newThreshold></newThreshold>
          <failureThreshold></failureThreshold>
          <newFailureThreshold></newFailureThreshold>
          <healthy></healthy>
          <unHealthy></unHealthy>
          <severityError>true</severityError>
          <severityWarning>true</severityWarning>
          <severityStyle>true</severityStyle>
          <severityPerformance>true</severityPerformance>
          <severityInformation>true</severityInformation>
          <severityNoCategory>true</severityNoCategory>
          <severityPortability>true</severityPortability>
        </configSeverityEvaluation>
        <configGraph>
          <xSize>500</xSize>
          <ySize>200</ySize>
          <numBuildsInGraph>0</numBuildsInGraph>
          <displayAllErrors>true</displayAllErrors>
          <displayErrorSeverity>true</displayErrorSeverity>
          <displayWarningSeverity>true</displayWarningSeverity>
          <displayStyleSeverity>true</displayStyleSeverity>
          <displayPerformanceSeverity>true</displayPerformanceSeverity>
          <displayInformationSeverity>true</displayInformationSeverity>
          <displayNoCategorySeverity>true</displayNoCategorySeverity>
          <displayPortabilitySeverity>true</displayPortabilitySeverity>
        </configGraph>
      </cppcheckConfig>
    </org.jenkinsci.plugins.cppcheck.CppcheckPublisher>
    <org.jenkinsci.plugins.valgrind.ValgrindPublisher plugin="valgrind@0.25">
      <valgrindPublisherConfig>
        <pattern>**/valgrind.xml</pattern>
        <failThresholdInvalidReadWrite></failThresholdInvalidReadWrite>
        <failThresholdDefinitelyLost></failThresholdDefinitelyLost>
        <failThresholdTotal></failThresholdTotal>
        <unstableThresholdInvalidReadWrite></unstableThresholdInvalidReadWrite>
        <unstableThresholdDefinitelyLost></unstableThresholdDefinitelyLost>
        <unstableThresholdTotal></unstableThresholdTotal>
        <publishResultsForAbortedBuilds>false</publishResultsForAbortedBuilds>
        <publishResultsForFailedBuilds>false</publishResultsForFailedBuilds>
        <failBuildOnMissingReports>false</failBuildOnMissingReports>
        <failBuildOnInvalidReports>false</failBuildOnInvalidReports>
      </valgrindPublisherConfig>
    </org.jenkinsci.plugins.valgrind.ValgrindPublisher>
    <xunit plugin="xunit@1.96">
      <types>
        <CTestType>
          <pattern>**/Test.xml</pattern>
          <skipNoTestFiles>true</skipNoTestFiles>
          <failIfNotNew>false</failIfNotNew>
          <deleteOutputFiles>true</deleteOutputFiles>
          <stopProcessingIfError>true</stopProcessingIfError>
        </CTestType>
        <GoogleTestType>
          <pattern>**/gtest.xml</pattern>
          <skipNoTestFiles>true</skipNoTestFiles>
          <failIfNotNew>false</failIfNotNew>
          <deleteOutputFiles>true</deleteOutputFiles>
          <stopProcessingIfError>true</stopProcessingIfError>
        </GoogleTestType>
        <JUnitType>
          <pattern>**/jenkinshrg.xml,**/testbed-terrain.xml,**/drc-valves.xml,**/drc-wall-testbed.xml,**/irex-balance-beam-auto.xml</pattern>
          <skipNoTestFiles>true</skipNoTestFiles>
          <failIfNotNew>false</failIfNotNew>
          <deleteOutputFiles>true</deleteOutputFiles>
          <stopProcessingIfError>true</stopProcessingIfError>
        </JUnitType>
      </types>
      <thresholds>
        <org.jenkinsci.plugins.xunit.threshold.FailedThreshold>
          <unstableThreshold>0</unstableThreshold>
          <unstableNewThreshold></unstableNewThreshold>
          <failureThreshold></failureThreshold>
          <failureNewThreshold></failureNewThreshold>
        </org.jenkinsci.plugins.xunit.threshold.FailedThreshold>
        <org.jenkinsci.plugins.xunit.threshold.SkippedThreshold>
          <unstableThreshold></unstableThreshold>
          <unstableNewThreshold></unstableNewThreshold>
          <failureThreshold></failureThreshold>
          <failureNewThreshold></failureNewThreshold>
        </org.jenkinsci.plugins.xunit.threshold.SkippedThreshold>
      </thresholds>
      <thresholdMode>1</thresholdMode>
      <extraConfiguration>
        <testTimeMargin>3000</testTimeMargin>
      </extraConfiguration>
    </xunit>
    <hudson.plugins.emailext.ExtendedEmailPublisher plugin="email-ext@2.40.5">
      <recipientList>\$DEFAULT_RECIPIENTS</recipientList>
      <configuredTriggers>
        <hudson.plugins.emailext.plugins.trigger.StatusChangedTrigger>
          <email>
            <recipientList></recipientList>
            <subject>\$PROJECT_DEFAULT_SUBJECT</subject>
            <body>\$PROJECT_DEFAULT_CONTENT</body>
            <recipientProviders>
              <hudson.plugins.emailext.plugins.recipients.ListRecipientProvider/>
            </recipientProviders>
            <attachmentsPattern></attachmentsPattern>
            <attachBuildLog>false</attachBuildLog>
            <compressBuildLog>false</compressBuildLog>
            <replyTo>\$PROJECT_DEFAULT_REPLYTO</replyTo>
            <contentType>project</contentType>
          </email>
        </hudson.plugins.emailext.plugins.trigger.StatusChangedTrigger>
      </configuredTriggers>
      <contentType>default</contentType>
      <defaultSubject>\$DEFAULT_SUBJECT</defaultSubject>
      <defaultContent>\$DEFAULT_CONTENT</defaultContent>
      <attachmentsPattern></attachmentsPattern>
      <presendScript>\$DEFAULT_PRESEND_SCRIPT</presendScript>
      <attachBuildLog>false</attachBuildLog>
      <compressBuildLog>false</compressBuildLog>
      <replyTo>\$DEFAULT_REPLYTO</replyTo>
      <saveOutput>false</saveOutput>
      <disabled>false</disabled>
    </hudson.plugins.emailext.ExtendedEmailPublisher>
  </publishers>
  <buildWrappers>
    <hudson.plugins.ansicolor.AnsiColorBuildWrapper plugin="ansicolor@0.4.1">
      <colorMapName>xterm</colorMapName>
    </hudson.plugins.ansicolor.AnsiColorBuildWrapper>
    <hudson.plugins.timestamper.TimestamperBuildWrapper plugin="timestamper@1.7.2"/>
  </buildWrappers>
</project>
EOL
fi
fi

rm jenkins-cli.jar
