package com.soundlab.web.bean;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data@Component
@Lazy
public class comment {
	private String memberId, msg,regidate;
	private int commentSeq,seqGroup;
}
