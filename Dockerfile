FROM eclipse-temurin:17-jdk-jammy
ADD target/demo-workshop-2.1.5.jar ttrend.jar 
ENTRYPOINT [ "java", "-jar", "ttrend.jar" ]