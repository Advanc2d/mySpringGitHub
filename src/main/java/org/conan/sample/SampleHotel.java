package org.conan.sample;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Component
@ToString
@Getter
@AllArgsConstructor //(or @RequiredArgsConstructor)
public class SampleHotel {
//	@NonNull
	private Chef chef;
//	public SampleHotel(Chef chef) {
//		this.chef = chef;
//		
//	}
}
