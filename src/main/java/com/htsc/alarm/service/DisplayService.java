package com.htsc.alarm.service;

import com.htsc.alarm.domain.AlarmInfo;

import java.util.List;

/**
 * Created by mars_wang on 2016/7/28.
 */
public interface DisplayService {

    List<AlarmInfo>  QueryMonitorInfos(Integer page, Integer pageRecords);

    Integer countAlarmInfos();
}
