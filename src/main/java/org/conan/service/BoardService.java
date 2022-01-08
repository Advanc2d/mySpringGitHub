package org.conan.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.conan.domain.BoardAttachVO;
import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;

public interface BoardService {
	
	/*
	 * @Insert("insert into tbl_board(title, content, writer) " +
	 * "values (#{title}, #{content}, #{writer})")
	 */
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
	
	/* @Select("select * from tbl_board where bno >0") */
	public List<BoardVO> getList();
	public List<BoardVO> getList(Criteria cri);
	public int getTotalCount(Criteria cri);
	public void updateReplyCnt(@Param("bno")Long bno, @Param("amount")int amount);
	public List<BoardAttachVO> getAttachList(Long bno);
//	public long insertSelectKey(BoardVO board);
}
