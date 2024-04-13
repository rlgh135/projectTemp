package com.twojo.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
	Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception;
}
