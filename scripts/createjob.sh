#!/bin/bash

if [ $# -lt 7 ] ;  then
  echo "Usage:" $0 "jobname template node os distro arch script [script_args]"
  exit
fi

NAME=$1
TEMPLATE=$2
NODE=$3
OS=$4
DISTRO=$5
ARCH=$6
SCRIPT=$7

cnt=1
SCRIPT_ARGS=""
for i in $*
do
  if [ $cnt -gt 7 ] ; then
    SCRIPT_ARGS=`echo $SCRIPT_ARGS $i`
  fi
  cnt=$(($cnt+1))
done

JENKINS_URL=${JENKINS_URL:-http://jenkinshrg.a01.aist.go.jp}

REPO_URL=https://github.com/jenkinshrg/drcutil.git
REPO_DIR=drcutil
BRANCH=jenkins

if [ "$OS" = "debian" ]; then
MIRROR=http://ftp.jp.debian.org/debian/
COMPONENTS=main,contrib,non-free
INCLUDE=iproute,iputils-ping,sudo
elif [ "$OS" = "ubuntu" ]; then
MIRROR=http://ftp.jaist.ac.jp/pub/Linux/ubuntu/
COMPONENTS=main,restricted,universe,multiverse
INCLUDE=iproute,iputils-ping,sudo
fi

wget -q $JENKINS_URL/jnlpJars/jenkins-cli.jar

if [ "$TEMPLATE" = "scm" ]; then
cat << EOF | java -jar jenkins-cli.jar -s $JENKINS_URL create-job $NAME
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <jenkins.model.BuildDiscarderProperty>
      <strategy class="hudson.tasks.LogRotator">
        <daysToKeep>-1</daysToKeep>
        <numToKeep>100</numToKeep>
        <artifactDaysToKeep>-1</artifactDaysToKeep>
        <artifactNumToKeep>-1</artifactNumToKeep>
      </strategy>
    </jenkins.model.BuildDiscarderProperty>
  </properties>
  <scm class="org.jenkinsci.plugins.multiplescms.MultiSCM" plugin="multiple-scms@0.5">
    <scms>
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
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
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>ssh://atom.a01.aist.go.jp/git/HRP2</url>
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
            <relativeTargetDir>src/HRP2</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>HRP2</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>ssh://atom.a01.aist.go.jp/git/HRP2KAI</url>
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
            <relativeTargetDir>src/HRP2KAI</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>HRP2KAI</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
          <hudson.plugins.git.UserRemoteConfig>
            <url>ssh://atom.a01.aist.go.jp/git/hrpsys-private</url>
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
            <relativeTargetDir>src/hrpsys-private</relativeTargetDir>
          </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
          <hudson.plugins.git.extensions.impl.ScmName>
            <name>hrpsys-private</name>
          </hudson.plugins.git.extensions.impl.ScmName>
        </extensions>
      </hudson.plugins.git.GitSCM>
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
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
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
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
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
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
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
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
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
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
      <hudson.plugins.git.GitSCM plugin="git@2.4.2">
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
  <assignedNode>$NODE</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <hudson.triggers.SCMTrigger>
      <spec>H 0-4,9-23 * * *</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders/>
  <publishers/>
  <buildWrappers>
    <hudson.plugins.ansicolor.AnsiColorBuildWrapper plugin="ansicolor@0.4.1">
      <colorMapName>xterm</colorMapName>
    </hudson.plugins.ansicolor.AnsiColorBuildWrapper>
    <hudson.plugins.timestamper.TimestamperBuildWrapper plugin="timestamper@1.7.4"/>
  </buildWrappers>
</project>
EOF
elif [ "$TEMPLATE" = "upstream" ]; then
cat << EOF | java -jar jenkins-cli.jar -s $JENKINS_URL create-job $NAME
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <jenkins.model.BuildDiscarderProperty>
      <strategy class="hudson.tasks.LogRotator">
        <daysToKeep>-1</daysToKeep>
        <numToKeep>100</numToKeep>
        <artifactDaysToKeep>-1</artifactDaysToKeep>
        <artifactNumToKeep>-1</artifactNumToKeep>
      </strategy>
    </jenkins.model.BuildDiscarderProperty>
  </properties>
  <scm class="hudson.scm.NullSCM"/>
  <assignedNode>$NODE</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <jenkins.triggers.ReverseBuildTrigger>
      <spec></spec>
      <upstreamProjects>drcutil</upstreamProjects>
      <threshold>
        <name>SUCCESS</name>
        <ordinal>0</ordinal>
        <color>BLUE</color>
        <completeBuild>true</completeBuild>
      </threshold>
    </jenkins.triggers.ReverseBuildTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>#!/bin/bash
set -xe
if [ &quot;\$(sudo docker images -q base/$OS:$DISTRO)&quot; = &quot;&quot; ]; then
rm -fr docker
git clone --depth 1 https://github.com/docker/docker.git
cd docker/contrib
sudo ./mkimage.sh -t base/$OS:$DISTRO debootstrap --variant=buildd --include=$INCLUDE --components=$COMPONENTS --arch=$ARCH $DISTRO $MIRROR
cd ../..
rm -fr docker
fi

rm -fr $REPO_DIR
git clone --branch $BRANCH --single-branch $REPO_URL $REPO_DIR

sudo docker run --rm -t -v \$HOME:\$HOME -v \$WORKSPACE:\$WORKSPACE base/$OS:$DISTRO /bin/bash -c &quot;\$(cat &lt;&lt; EOL
source \$HOME/.jenkinshrg/env.sh
set -xe
export WORKSPACE=\$WORKSPACE
export JOB_NAME=\$JOB_NAME
export BUILD_URL=\$BUILD_URL
if [ -f \$HOME/.gitconfig ]; then
  cp -a \$HOME/.gitconfig /root
  chown root.root /root/.gitconfig
fi
if [ -f \$HOME/.git-credentials ]; then
  cp -a \$HOME/.git-credentials /root
  chown root.root /root/.git-credentials
fi
if [ -d \$HOME/.ssh ]; then
  cp -a \$HOME/.ssh /root
  chown -R root.root /root/.ssh
fi
if [ -d \$HOME/.jenkinshrg ]; then
  cp -a \$HOME/.jenkinshrg /root
  chown -R root.root /root/.jenkinshrg
fi
cd \$WORKSPACE/$REPO_DIR
source $SCRIPT $SCRIPT_ARGS
EOL
)&quot;</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.tasks.ArtifactArchiver>
      <artifacts>*.log,*.txt</artifacts>
      <allowEmptyArchive>true</allowEmptyArchive>
      <onlyIfSuccessful>false</onlyIfSuccessful>
      <fingerprint>false</fingerprint>
      <defaultExcludes>true</defaultExcludes>
      <caseSensitive>true</caseSensitive>
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
    <xunit plugin="xunit@1.100">
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
    <hudson.plugins.plot.PlotPublisher plugin="plot@1.9">
      <plots>
        <hudson.plugins.plot.Plot>
          <title>used memory</title>
          <yaxis>MB</yaxis>
          <series>
            <hudson.plugins.plot.CSVSeries>
              <file>system.csv</file>
              <label></label>
              <fileType>csv</fileType>
              <inclusionFlag>OFF</inclusionFlag>
              <exclusionValues></exclusionValues>
              <url></url>
              <displayTableFlag>false</displayTableFlag>
            </hudson.plugins.plot.CSVSeries>
          </series>
          <group>system</group>
          <numBuilds></numBuilds>
          <csvFileName>1886652548.csv</csvFileName>
          <csvLastModification>0</csvLastModification>
          <style>line</style>
          <useDescr>false</useDescr>
          <keepRecords>false</keepRecords>
          <exclZero>false</exclZero>
          <logarithmic>false</logarithmic>
        </hudson.plugins.plot.Plot>
        <hudson.plugins.plot.Plot>
          <title>used memory</title>
          <yaxis>KB</yaxis>
          <series>
            <hudson.plugins.plot.CSVSeries>
              <file>choreonoid.csv</file>
              <label></label>
              <fileType>csv</fileType>
              <inclusionFlag>OFF</inclusionFlag>
              <exclusionValues></exclusionValues>
              <url></url>
              <displayTableFlag>false</displayTableFlag>
            </hudson.plugins.plot.CSVSeries>
          </series>
          <group>choreonoid</group>
          <numBuilds></numBuilds>
          <csvFileName>2034364873.csv</csvFileName>
          <csvLastModification>0</csvLastModification>
          <style>line</style>
          <useDescr>false</useDescr>
          <keepRecords>false</keepRecords>
          <exclZero>false</exclZero>
          <logarithmic>false</logarithmic>
        </hudson.plugins.plot.Plot>
      </plots>
    </hudson.plugins.plot.PlotPublisher>
    <hudson.tasks.BuildTrigger>
      <childProjects>drcutil-upload</childProjects>
      <threshold>
        <name>FAILURE</name>
        <ordinal>2</ordinal>
        <color>RED</color>
        <completeBuild>true</completeBuild>
      </threshold>
    </hudson.tasks.BuildTrigger>
    <hudson.plugins.emailext.ExtendedEmailPublisher plugin="email-ext@2.40.5">
      <recipientList>\$DEFAULT_RECIPIENTS</recipientList>
      <configuredTriggers>
        <hudson.plugins.emailext.plugins.trigger.FailureTrigger>
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
        </hudson.plugins.emailext.plugins.trigger.FailureTrigger>
        <hudson.plugins.emailext.plugins.trigger.UnstableTrigger>
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
        </hudson.plugins.emailext.plugins.trigger.UnstableTrigger>
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
    <hudson.plugins.timestamper.TimestamperBuildWrapper plugin="timestamper@1.7.4"/>
  </buildWrappers>
</project>
EOF
elif [ "$TEMPLATE" = "periodic" ]; then
cat << EOF | java -jar jenkins-cli.jar -s $JENKINS_URL create-job $NAME
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <jenkins.model.BuildDiscarderProperty>
      <strategy class="hudson.tasks.LogRotator">
        <daysToKeep>-1</daysToKeep>
        <numToKeep>100</numToKeep>
        <artifactDaysToKeep>-1</artifactDaysToKeep>
        <artifactNumToKeep>-1</artifactNumToKeep>
      </strategy>
    </jenkins.model.BuildDiscarderProperty>
  </properties>
  <scm class="hudson.scm.NullSCM"/>
  <assignedNode>$NODE</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <hudson.triggers.TimerTrigger>
      <spec>H 0-4,9-23 * * *</spec>
    </hudson.triggers.TimerTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>#!/bin/bash
source \$HOME/.jenkinshrg/env.sh
set -xe
rm -fr $REPO_DIR
git clone --branch $BRANCH --single-branch $REPO_URL $REPO_DIR
cd $REPO_DIR
source $SCRIPT $SCRIPT_ARGS</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.tasks.ArtifactArchiver>
      <artifacts>*.log,*.txt,*.png,*.ogv,*.csv,*.tau,*.q,*.qRef</artifacts>
      <allowEmptyArchive>true</allowEmptyArchive>
      <onlyIfSuccessful>false</onlyIfSuccessful>
      <fingerprint>false</fingerprint>
      <defaultExcludes>true</defaultExcludes>
      <caseSensitive>true</caseSensitive>
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
    <xunit plugin="xunit@1.100">
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
          <pattern>*.xml</pattern>
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
    <hudson.plugins.plot.PlotPublisher plugin="plot@1.9">
      <plots>
        <hudson.plugins.plot.Plot>
          <title>used memory</title>
          <yaxis>MB</yaxis>
          <series>
            <hudson.plugins.plot.CSVSeries>
              <file>system.csv</file>
              <label></label>
              <fileType>csv</fileType>
              <inclusionFlag>OFF</inclusionFlag>
              <exclusionValues></exclusionValues>
              <url></url>
              <displayTableFlag>false</displayTableFlag>
            </hudson.plugins.plot.CSVSeries>
          </series>
          <group>system</group>
          <numBuilds></numBuilds>
          <csvFileName>1886652548.csv</csvFileName>
          <csvLastModification>0</csvLastModification>
          <style>line</style>
          <useDescr>false</useDescr>
          <keepRecords>false</keepRecords>
          <exclZero>false</exclZero>
          <logarithmic>false</logarithmic>
        </hudson.plugins.plot.Plot>
        <hudson.plugins.plot.Plot>
          <title>used memory</title>
          <yaxis>KB</yaxis>
          <series>
            <hudson.plugins.plot.CSVSeries>
              <file>choreonoid.csv</file>
              <label></label>
              <fileType>csv</fileType>
              <inclusionFlag>OFF</inclusionFlag>
              <exclusionValues></exclusionValues>
              <url></url>
              <displayTableFlag>false</displayTableFlag>
            </hudson.plugins.plot.CSVSeries>
          </series>
          <group>choreonoid</group>
          <numBuilds></numBuilds>
          <csvFileName>2034364873.csv</csvFileName>
          <csvLastModification>0</csvLastModification>
          <style>line</style>
          <useDescr>false</useDescr>
          <keepRecords>false</keepRecords>
          <exclZero>false</exclZero>
          <logarithmic>false</logarithmic>
        </hudson.plugins.plot.Plot>
      </plots>
    </hudson.plugins.plot.PlotPublisher>
    <hudson.tasks.BuildTrigger>
      <childProjects>drcutil-upload</childProjects>
      <threshold>
        <name>FAILURE</name>
        <ordinal>2</ordinal>
        <color>RED</color>
        <completeBuild>true</completeBuild>
      </threshold>
    </hudson.tasks.BuildTrigger>
    <hudson.plugins.emailext.ExtendedEmailPublisher plugin="email-ext@2.40.5">
      <recipientList>\$DEFAULT_RECIPIENTS</recipientList>
      <configuredTriggers>
        <hudson.plugins.emailext.plugins.trigger.FailureTrigger>
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
        </hudson.plugins.emailext.plugins.trigger.FailureTrigger>
        <hudson.plugins.emailext.plugins.trigger.UnstableTrigger>
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
        </hudson.plugins.emailext.plugins.trigger.UnstableTrigger>
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
    <hudson.plugins.timestamper.TimestamperBuildWrapper plugin="timestamper@1.7.4"/>
  </buildWrappers>
</project>
EOF
else
cat << EOF | java -jar jenkins-cli.jar -s $JENKINS_URL create-job $NAME
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <jenkins.model.BuildDiscarderProperty>
      <strategy class="hudson.tasks.LogRotator">
        <daysToKeep>-1</daysToKeep>
        <numToKeep>100</numToKeep>
        <artifactDaysToKeep>-1</artifactDaysToKeep>
        <artifactNumToKeep>-1</artifactNumToKeep>
      </strategy>
    </jenkins.model.BuildDiscarderProperty>
  </properties>
  <scm class="hudson.scm.NullSCM"/>
  <assignedNode>$NODE</assignedNode>
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
rm -fr $REPO_DIR
git clone --branch $BRANCH --single-branch $REPO_URL $REPO_DIR
cd $REPO_DIR
source $SCRIPT $SCRIPT_ARGS</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers>
    <hudson.plugins.ansicolor.AnsiColorBuildWrapper plugin="ansicolor@0.4.2">
      <colorMapName>xterm</colorMapName>
    </hudson.plugins.ansicolor.AnsiColorBuildWrapper>
    <hudson.plugins.timestamper.TimestamperBuildWrapper plugin="timestamper@1.7.4"/>
  </buildWrappers>
</project>
EOF
fi

rm jenkins-cli.jar
