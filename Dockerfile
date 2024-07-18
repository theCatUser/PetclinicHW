services:

  petclinic:
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      DATABASE: mysql
      SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/test?useSSL=false
      SPRING_DATASOURCE_USERNAME: root
      SPRING_DATASOURCE_PASSWORD: root
      SPRING_SQL_INIT_MODE: always
    ports:
      - "8081:8080"
    depends_on:
      mysql:
        condition: service_healthy
    networks:
      - petclinic

  mysql:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: test
    healthcheck:
      test: ["CMD-SHELL", "mysqladmin ping --silent"]
      interval: 30s
      timeout: 20s
      retries: 5
    restart: always
    volumes:
      - ./conf.d:/etc/mysql/conf.d:ro
    networks:
      - petclinic

  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins_home:/var/jenkins_home
    depends_on:
      - mysql
    networks:
      - petclinic


volumes:
  jenkins_home:
  db_data:

networks:
  petclinic:
    driver: bridge
