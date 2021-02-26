/**
 * exclusive extends MyBase
 */
function MyExclusive(id) {
	MyBase.call(this, id, "decision");
	this.style = "image;image=static/js/platform/designer/images/48/gateway_exclusive.png;";
};
MyExclusive.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyExclusive.prototype.init = function() {
	this.initBase();
	this.name = "exclusive" + _countUtils.getExclusive();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyExclusive.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setExclusive(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	this.createRemarkDom(xmlValue);
	this.createEventDom(xmlValue, "qian_zhi_shi_jian", "start");//event
	this.createEventDom(xmlValue, "hou_zhi_shi_jian", "end");//event
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell());// 创建mxCell
	_myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyExclusive.prototype.getOtherAttr = function(node) {
	this.createEventXml(node, "qian_zhi_shi_jian", "start");
	this.createEventXml(node, "hou_zhi_shi_jian", "end");
	this.createRemarkXml(node);//备注
};
/**
 * 通过name解析数字，例如end1解析出数字:1
 */
MyExclusive.prototype.resolve = function() {
	return Number(this.name.replace("exclusive", ""));
};