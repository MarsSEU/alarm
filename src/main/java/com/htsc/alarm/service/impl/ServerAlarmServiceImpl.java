package com.htsc.alarm.service.impl;

import com.alibaba.fastjson.JSON;
import com.htsc.alarm.common.util.IPUtils;
import com.htsc.alarm.dao.*;
import com.htsc.alarm.domain.*;
import com.htsc.alarm.service.ServerAlarmService;
import com.htsc.alarm.vo.ServerAlarmInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by mars_wang on 2016/7/13.
 */
@Service(value = "serverAlarmService")
public class ServerAlarmServiceImpl implements ServerAlarmService {

    private static final Logger LOG = LoggerFactory.getLogger(ServerAlarmServiceImpl.class);

    @Autowired
    TriggerDomainMapper triggerDomainMapper;

    @Autowired
    HostDoaminMapper hostDoaminMapper;

    @Autowired
    ItemDomainMapper itemDomainMapper;

    @Autowired
    ServiceDomainMapper serviceDomainMapper;

    @Autowired
    AlarmInfoMapper alarmInfoMapper;

    @Override
    public List<AlarmInfo> severAlarmJudge(String alarmInfo, HttpServletRequest request) {
        String ip = "";
        try {
            ip = IPUtils.getIPAddress(request);
        } catch (IOException e) {
            LOG.error("getting ip error:[]", e);
        }
        if(ip.equals(""))
            return null;
        HostDomain hostDomain = hostDoaminMapper.queryByIp(ip);
        if(hostDomain == null)
            return null;
        List<ServerAlarmInfo> serverAlarmInfos = JSON.parseArray(alarmInfo, ServerAlarmInfo.class);
        List<ServiceDomain> services = new ArrayList<>();
        List<AlarmInfo> alarmInfos = new ArrayList<>();
        for(int i = 0; i < serverAlarmInfos.size(); ++i){
            Integer hostId = hostDomain.getHostId();
            String target = serverAlarmInfos.get(i).getTarget();
            ItemDomain itemDomain = itemDomainMapper.queryItemByHost(hostId, target);
            if(itemDomain == null)
                continue;
            ServiceDomain service = serviceDomainMapper.queryServiceByHostItem(hostDomain.getHostId(),itemDomain.getItemId());
            if(service == null)
                continue;
            TriggerDomain trigger = triggerDomainMapper.selectByPrimaryKey(service.getTriggerId());
            if(trigger == null)
                continue;
            //新建AlarmInfo对象
            AlarmInfo alarm = new AlarmInfo();
            alarm.setIpSource(hostDomain.getHostIp());
            alarm.setAlarmName(itemDomain.getItemName());
            alarm.setAlarmType(itemDomain.getMonitorType()+":"+itemDomain.getMonitorTarget());
            alarm.setAlarmLevel("INFO");
            alarm.setAlarmValue(serverAlarmInfos.get(i).getValue().toString());
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            alarm.setStartDatetime(new Date());
            String judgmentCondition = trigger.getJudgmentCondition();
            Boolean result = false;
            List<Integer> params = JSON.parseArray(trigger.getParameters(), Integer.class);
            if(judgmentCondition.equals("gt")){
                if(serverAlarmInfos.get(i).getValue() > params.get(0) ){
                    result = true;
                }
            }else if (judgmentCondition.equals("lt")){
                if(serverAlarmInfos.get(i).getValue() < params.get(0)  ){
                    result = true;
                }
            }else if (judgmentCondition.equals("notbetween")){
                if(serverAlarmInfos.get(i).getValue() < params.get(0) || serverAlarmInfos.get(i).getValue() > params.get(1))
                    result = true;
            }
             if(result == true){
                 alarm.setAlarmLevel("ERROR");
                 alarmInfos.add(alarm);
             }
            //存表
            alarmInfoMapper.insertSelective(alarm);
        }
        return alarmInfos;
    }

    @Override
    public Integer solveAlarm(Integer alarmInfoId, String clearRecord) {
        Integer result  = alarmInfoMapper.updateAlarmClear(alarmInfoId, clearRecord);
        return result;

    }
}
