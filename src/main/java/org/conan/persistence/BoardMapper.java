package org.conan.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.conan.domain.BoardVO;

public interface BoardMapper {
//	@Select("select * from tbl_board where bno>0")
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public BoardVO read(long bno);
	
	public long delete(long bno);
	
	public int update(BoardVO board);
	
}
// xml에 정의하기 위해 인터페이스로 선언하는 공간 
