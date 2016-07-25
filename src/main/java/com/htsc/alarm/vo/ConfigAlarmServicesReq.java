package com.htsc.alarm.vo;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;
import java.util.List;

/**
 * Created by mars_wang on 2016/7/25.
 */
public class ConfigAlarmServicesReq {

    private Integer hostId;

    private Integer status;

    private Integer triggerId;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date serviceStart;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date serviceEnd;

    private List<Integer> dependencies;

    private String serviceActive;

    public Integer getHostId() {
        return hostId;
    }

    public void setHostId(Integer hostId) {
        this.hostId = hostId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getTriggerId() {
        return triggerId;
    }

    public void setTriggerId(Integer triggerId) {
        this.triggerId = triggerId;
    }

    public Date getServiceStart() {
        return serviceStart;
    }

    public void setServiceStart(Date serviceStart) {
        this.serviceStart = serviceStart;
    }

    public Date getServiceEnd() {
        return serviceEnd;
    }

    public void setServiceEnd(Date serviceEnd) {
        this.serviceEnd = serviceEnd;
    }

    public List<Integer> getDependencies() {
        return dependencies;
    }

    public void setDependencies(List<Integer> dependencies) {
        this.dependencies = dependencies;
    }

    public String getServiceActive() {
        return serviceActive;
    }

    public void setServiceActive(String serviceActive) {
        this.serviceActive = serviceActive;
    }
}
