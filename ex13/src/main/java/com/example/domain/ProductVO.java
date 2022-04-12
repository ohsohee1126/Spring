package com.example.domain;

public class ProductVO {
	private int code;
	private String pid;
	private String image;
	private int price;
	private String title;
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Override
	public String toString() {
		return "ProductVO [code=" + code + ", pid=" + pid + ", image=" + image + ", price=" + price + ", title=" + title
				+ "]";
	}
}
