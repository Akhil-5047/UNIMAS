package com.vimal.unimas;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@SpringBootApplication
public class UnimasApplication {

	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
//		ds.setDriverClassName(oracle.jdbc.driver.OracleDriver.class.getName());
		ds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		ds.setUsername("c##unimasdup");
		ds.setPassword("orcl");
		return ds;
	}
	public static void main(String[] args) {
		SpringApplication.run(UnimasApplication.class, args);
	}

}
