FROM eclipse-temurin:17-jdk-jammy
ADD jarstaging/com/valaxy/demo-workshop/2.1.3/demo-workshop-2.1.3.jar ttrend.jar 
ENTRYPOINT [ "java", "-jar", "ttrend.jar" ]