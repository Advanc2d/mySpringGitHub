package org.conan.service;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.conan.domain.BoardVO;

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
}
