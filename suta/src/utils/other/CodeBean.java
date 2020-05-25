/*
 * @(#) ModifyBean.java 2016年12月29日
 *
 * Copyright (c) 2015, XiaHeng NetWork. All Rights Reserved.
 * XiaHeng NetWork. CONFIDENTIAL
 */
package utils.other;

/**
 * 返回码
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @param <T>
 * @since 2016年12月29日
 */
public class CodeBean<T> {

	private int code = 200;

	private boolean success = false;

	private String message;

	private T data = null;

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public CodeBean(boolean success, String message) {
		super();
		this.success = success;
		this.message = message;
	}

	public CodeBean(int code, String message) {
		super();
		this.code = code;
		this.message = message;
	}

	public CodeBean(boolean success, String message, T data) {
		super();
		this.success = success;
		this.message = message;
		this.data = data;
	}

	public CodeBean(int code, boolean success, String message, T data) {
		super();
		this.code = code;
		this.success = success;
		this.message = message;
		this.data = data;
	}

	public CodeBean() {
		super();
	}

}
