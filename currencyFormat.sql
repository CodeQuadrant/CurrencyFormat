PROCEDURE render_item(p_item                IN apex_plugin.t_item,
                     p_plugin              IN apex_plugin.t_plugin,
                     p_param               IN apex_plugin.t_item_render_param,
                     p_result              in out nocopy apex_plugin.t_page_item_render_result)
                     
                     
IS
  
  -- custom plugin attributes
  l_result  apex_plugin.t_page_item_render_result;
  l_attr_01 p_item.attribute_01%TYPE := p_item.attribute_01;
  l_attr_02 p_item.attribute_02%TYPE := p_item.attribute_02;
  
  -- other vars
  l_name            VARCHAR2(30);
  l_escaped_value   VARCHAR2(4000);
  l_html_string     VARCHAR2(2000);
  l_html_string2     VARCHAR2(2000);
  l_element_item_id VARCHAR2(200);
 
  keyup_attr    varchar2(1000):='onKeyUp="';
  --
BEGIN
  
 
    l_element_item_id := p_item.name;
    l_name            := apex_plugin.get_input_name_for_page_item(FALSE);
    l_escaped_value   := apex_escape.html(p_param.value);
  
  
      keyup_attr:=keyup_attr||'apex.item(''';
      keyup_attr:=keyup_attr|| l_element_item_id;
      keyup_attr:=keyup_attr||''').setValue(runFormat('||l_element_item_id ||','|| l_attr_01 || '))';
      keyup_attr:=keyup_attr||'"';
      
  
    --
    -- build input html string
    
    l_html_string := '<input type="text" ';
    l_html_string := l_html_string || 'name="' || l_name || '" ';
    l_html_string := l_html_string || 'style="'|| 'text-align: left; direction: ltr;' || '" ';
    l_html_string := l_html_string || 'class="'|| p_item.element_css_classes||' apex-item-text text_field" '|| '" ';
    l_html_string := l_html_string || 'id="' || l_element_item_id || '" ';
    l_html_string := l_html_string || keyup_attr || '" ;=""';
    
    l_html_string := l_html_string || 'value="' || l_escaped_value  || '" ';
    l_html_string := l_html_string || 'currField="' || 'Yes'  || '" ';
    l_html_string := l_html_string || 'currCodeItem="' || l_attr_01  || '" ';
    l_html_string := l_html_string || 'size="' || p_item.element_width || '" ';
    l_html_string := l_html_string || ' ' || p_item.element_attributes ||  ' />';

   
    
    -- write item html
    htp.p(l_html_string);
    
     	
    apex_javascript.add_onload_code (
    'var lTest = "'||apex_javascript.escape(sys.htf.escape_sc(p_item.attribute_01))||'";'||chr(10)||
    'addChangeEvent(lTest);' );
    
    
   apex_javascript.add_onload_code (
    'var lTest = "'||apex_javascript.escape(sys.htf.escape_sc(p_item.attribute_01))||'";'||chr(10)||
    'currCodeChange(lTest);' );
    
   apex_javascript.add_onload_code ('apex.jQuery( apex.gPageContext$ ).on( "apexbeforepagesubmit", function () { submitAsNumber()} );');
    
    
   
   
     
    
    --
    -- add JavaScript files
    apex_javascript.add_library(p_name           => 'test_cf_2',
                                p_directory      => p_plugin.file_prefix,
                                p_version        => NULL,
                                p_skip_extension => FALSE);
 
  --
  l_result.is_navigable := TRUE;
  --RETURN l_result;
  --
END render_item;