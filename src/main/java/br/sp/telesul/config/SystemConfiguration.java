/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.config;

import java.util.Locale;

/**
 *
 * @author lmohan
 */
public interface SystemConfiguration {

    public static final String DATE_FORMAT = "dd-MM-yyyy";
    public static final String TIME_FORMAT = "HH:mm:ss";
    public static final String TIME_HOUR_MINUTE_FORMAT = "HH:mm";
    public static final String DATE_TIME_FORMAT = "dd-MM-yyyy HH:mm:ss";
    public static final String DATE_TIME_ONLYHOURMIN_FORMAT = "dd-MM-yyyy HH:mm";
    public static final Locale defaultLocale = new Locale("pt", "BR");
    public static final String TASK_QUEUE = "/topic/taskqueue";
    public static final String STATUS_QUEUE = "/topic/statusqueue";
    public static final int maxSessions=3;
}
