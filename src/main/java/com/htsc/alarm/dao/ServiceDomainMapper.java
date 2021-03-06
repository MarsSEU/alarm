package com.htsc.alarm.dao;

import com.htsc.alarm.domain.ServiceDomain;
import com.htsc.alarm.domain.ServiceDomainExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ServiceDomainMapper {
    int countByExample(ServiceDomainExample example);

    int deleteByExample(ServiceDomainExample example);

    int deleteByPrimaryKey(Integer serviceId);

    int insert(ServiceDomain record);

    int insertSelective(ServiceDomain record);

    List<ServiceDomain> selectByExample(ServiceDomainExample example);

    ServiceDomain selectByPrimaryKey(Integer serviceId);

    int updateByExampleSelective(@Param("record") ServiceDomain record, @Param("example") ServiceDomainExample example);

    int updateByExample(@Param("record") ServiceDomain record, @Param("example") ServiceDomainExample example);

    int updateByPrimaryKeySelective(ServiceDomain record);

    int updateByPrimaryKey(ServiceDomain record);

    int deleteByService(ServiceDomain service);

    int getPrimeryKey(ServiceDomain serviceDomain);

    ServiceDomain queryServiceByHostItem(@Param("host") Integer hostId, @Param("item") Integer itemId);

    List<ServiceDomain> selectAllRecords();
}