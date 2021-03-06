package org.conan.test;

import java.util.List;
import java.util.stream.IntStream;

import org.conan.domain.Criteria;
import org.conan.domain.ReplyVO;
import org.conan.persistence.ReplyMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {
	@Setter(onMethod_= @__({@Autowired}))
	private ReplyMapper mapper;
	private Long[] bnoArr = {2L, 3L, 4L, 8L, 9L};
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {ReplyVO vo = new ReplyVO();
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글 테스트" + i);
			vo.setReplyer("replyer" + i);
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testRead() {
		Long targetRno = 3L;
		ReplyVO vo = mapper.read(targetRno);
		log.info(vo);
	}
	
	@Test
	public void testDelete() {
		Long targetRno = 5L;
		mapper.delete(targetRno);
	}
	
	@Test
	public void testUpdate() {
		Long targetRno = 9L;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("Update Reply");
		int count = mapper.update(vo);
		log.info("Update Count : " + count);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2,5);		// 2번 페이지에 5개씩 출력
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 2L);		// 2L은 게시판 번호
		replies.forEach(reply -> log.info(reply));
		
	}
	
}
