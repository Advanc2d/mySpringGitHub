package org.conan.service;

import java.util.List;

import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;
import org.conan.persistence.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServicelmpl implements BoardService {
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		// TODO Auto-generated method stub
		log.info("register.............." + board.getBno());
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		log.info("get.............." + bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		// TODO Auto-generated method stub
		log.info("modify.............." + board);
		return mapper.update(board)==1;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		log.info("remove.............." + bno);
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getList() {
		// TODO Auto-generated method stub
		log.info("getList..............");
		return mapper.getList();
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("getList With Criteria.............. cri");
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotalCount(Criteria cri) {
		log.info("get total count............");
		return mapper.getTotalCount(cri);
	}
//	@Override
//	public long insertSelectKey(BoardVO board) {
//		// TODO Auto-generated method stub
//		log.info("insertSelectKey..................");
//		return mapper.insertSelectKey(board);
//	}

}
