package org.conan.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.conan.domain.BoardAttachVO;
import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;
import org.conan.persistence.BoardAttachMapper;
import org.conan.persistence.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServicelmpl implements BoardService {
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		// TODO Auto-generated method stub
		log.info("register.............." + board.getBno());
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size()<=0) {
			return;
		}
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		log.info("get.............." + bno);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		// TODO Auto-generated method stub
		log.info("modify.............." + board);
		attachMapper.deleteAll(board.getBno());		//db에 모든 첨부파일 정보 삭제
		boolean modifyResult = mapper.update(board) ==1;
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return mapper.update(board)==1;
	}
	
	@Transactional
	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		log.info("remove.............." + bno);
		attachMapper.deleteAll(bno);
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
	
	public void updateReplyCnt(@Param("bno")Long bno, @Param("amount")int amount) {
		log.info("ReplyCnt--------------------");
		mapper.updateReplyCnt(bno, amount);
	}
//	@Override
//	public long insertSelectKey(BoardVO board) {
//		// TODO Auto-generated method stub
//		log.info("insertSelectKey..................");
//		return mapper.insertSelectKey(board);
//	}
	@Override
	public List<BoardAttachVO> getAttachList(Long bno){
		log.info("get Attach List by bno" + bno);
		return attachMapper.findByBno(bno);
	}

}
