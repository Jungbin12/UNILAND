package com.elon.boot.domain.property.model.store;

import com.elon.boot.controller.dto.property.OptionAddRequest;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OptionMapper {
    int insertOption(OptionAddRequest oReq);

	PropertyOption selectOnesOption(Long id);

	List<PropertyOption> selectOptionsByPropertyNo(Long propertyNo);
}