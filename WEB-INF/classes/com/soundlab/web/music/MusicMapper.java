package com.soundlab.web.music;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MusicMapper {
	 public List<Map<?,?>> top50List(HashMap<?,?> map);
	 public List<Map<?,?>> top50lineChart(HashMap<?,?> map);
	 public List<Map<?,?>> infiSc(HashMap<?,?> map);
	public List<Map<?, ?>> infiScMap(HashMap<?, ?> map);
}

