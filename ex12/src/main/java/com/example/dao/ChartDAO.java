package com.example.dao;

import java.util.List;
import java.util.Map;

public interface ChartDAO {
	public List<Map<String,Object>> point();
	public List<Map<String,Object>> send();
	public List<Map<String,Object>> receive();
}
