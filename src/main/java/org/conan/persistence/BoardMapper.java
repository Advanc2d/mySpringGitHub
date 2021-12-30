package org.conan.persistence;

import java.util.List;

import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;

public interface BoardMapper {
//	@Select("select * from tbl_board where bno>0")
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public BoardVO read(long bno);
	
	public long delete(long bno);
	
	public int update(BoardVO board);
	
	public long insertSelectKey(BoardVO board);
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
}
// xml에 정의하기 위해 인터페이스로 선언하는 공간 
