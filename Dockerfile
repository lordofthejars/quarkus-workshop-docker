FROM maven:3.6.1-jdk-8

RUN git clone https://github.com/redhat-developer-demos/quarkus-tutorial.git

WORKDIR /quarkus-tutorial/work/

RUN mvn -s /usr/share/maven/ref/settings-docker.xml io.quarkus:quarkus-maven-plugin:0.15.0:create -DprojectGroupId=org.acme -DprojectArtifactId=getting-started -DclassName="org.acme.quickstart.GreetingResource" -Dpath="/hello"

COPY settings.xml /quarkus-tutorial/work/getting-started/settings.xml

WORKDIR /quarkus-tutorial/work/getting-started

RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package

COPY pom.xml /tmp/pom.xml
RUN mvn -B -f /tmp/pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve

EXPOSE 8080 5005

