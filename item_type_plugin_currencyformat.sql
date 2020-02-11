prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_190200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2019.10.04'
,p_release=>'19.2.0.00.18'
,p_default_workspace_id=>6639891808473068214
,p_default_application_id=>37140
,p_default_id_offset=>0
,p_default_owner=>'TIMTEST'
);
end;
/
 
prompt APPLICATION 37140 - Test App
--
-- Application Export:
--   Application:     37140
--   Name:            Test App
--   Date and Time:   18:43 Tuesday February 11, 2020
--   Exported By:     TIM.SCHMUHL@ORACLE.COM
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 6964284037523032092
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     63102946836549
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/currencyformat
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(6964284037523032092)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'CURRENCYFORMAT'
,p_display_name=>'CurrencyFormat'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PROCEDURE render_item(p_item               IN apex_plugin.t_item,',
'                     p_plugin              IN apex_plugin.t_plugin,',
'                     p_param               IN apex_plugin.t_item_render_param,',
'                     p_result              in out nocopy apex_plugin.t_page_item_render_result)',
'                     ',
'                     ',
'IS',
'  ',
'  -- custom plugin attributes',
'  l_result  apex_plugin.t_page_item_render_result;',
'  l_attr_01 p_item.attribute_01%TYPE := p_item.attribute_01;',
'  l_attr_02 p_item.attribute_02%TYPE := p_item.attribute_02;',
'  ',
'  ',
'  -- other vars',
'  l_name            VARCHAR2(30);',
'  l_escaped_value   VARCHAR2(4000);',
'  l_html_string     VARCHAR2(2000);',
'  l_html_string2     VARCHAR2(2000);',
'  l_element_item_id VARCHAR2(200);',
' ',
'  keyup_attr    varchar2(1000):=''onKeyUp="'';',
'  --',
'BEGIN',
'  ',
' ',
'    l_element_item_id := p_item.name;',
'    l_name            := apex_plugin.get_input_name_for_page_item(FALSE);',
'    l_escaped_value   := apex_escape.html(p_param.value);',
'  ',
'  ',
'      keyup_attr:=keyup_attr||''apex.item('''''';',
'      keyup_attr:=keyup_attr|| l_element_item_id;',
'      keyup_attr:=keyup_attr||'''''').setValue(runFormat(''||l_element_item_id ||'',''|| l_attr_01 || ''))'';',
'      keyup_attr:=keyup_attr||''"'';',
'      ',
'  ',
'    --',
'    -- build input html string',
'    ',
'    l_html_string := ''<input type="text" '';',
'    l_html_string := l_html_string || ''name="'' || l_name || ''" '';',
'    l_html_string := l_html_string || ''style="''|| ''text-align: ''|| l_attr_02 || ''; direction: ltr;'' || ''" '';',
'    l_html_string := l_html_string || ''class="''|| p_item.element_css_classes||'' apex-item-text text_field" ''|| ''" '';',
'    l_html_string := l_html_string || ''id="'' || l_element_item_id || ''" '';',
'    l_html_string := l_html_string || keyup_attr || ''" ;=""'';',
'    ',
'    l_html_string := l_html_string || ''value="'' || l_escaped_value  || ''" '';',
'    l_html_string := l_html_string || ''currField="'' || ''Yes''  || ''" '';',
'    l_html_string := l_html_string || ''currCodeItem="'' || l_attr_01  || ''" '';',
'    l_html_string := l_html_string || ''size="'' || p_item.element_width || ''" '';',
'    l_html_string := l_html_string || '' '' || p_item.element_attributes ||  '' />'';',
'',
'   ',
'    ',
'    -- write item html',
'    htp.p(l_html_string);',
'    ',
'     	',
'    apex_javascript.add_onload_code (',
'    ''var lTest = "''||apex_javascript.escape(sys.htf.escape_sc(p_item.attribute_01))||''";''||chr(10)||',
'    ''addChangeEvent(lTest);'' );',
'    ',
'    ',
'   apex_javascript.add_onload_code (',
'    ''var lTest = "''||apex_javascript.escape(sys.htf.escape_sc(p_item.attribute_01))||''";''||chr(10)||',
'    ''currCodeChange(lTest);'' );',
'    ',
'   apex_javascript.add_onload_code (''apex.jQuery( apex.gPageContext$ ).on( "apexbeforepagesubmit", function () { submitAsNumber()} );'');',
'    ',
'    ',
'   ',
'   ',
'     ',
'    ',
'    --',
'    -- add JavaScript files',
'    apex_javascript.add_library(p_name           => ''test_cf_2'',',
'                                p_directory      => p_plugin.file_prefix,',
'                                p_version        => NULL,',
'                                p_skip_extension => FALSE);',
' ',
'  --',
'  l_result.is_navigable := TRUE;',
'  --RETURN l_result;',
'  --',
'END render_item;'))
,p_api_version=>2
,p_render_function=>'render_item'
,p_standard_attributes=>'VISIBLE:SESSION_STATE:READONLY:QUICKPICK:SOURCE:ELEMENT:WIDTH:HEIGHT:ELEMENT_OPTION:PLACEHOLDER:ENCRYPT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/CodeQuadrant/CurrencyFormat/blob/master/README.md'
,p_plugin_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'APEX Plugin providing live, as you type, formatting of currencies.',
'',
'No longer worry about which grouping and decimal separtors your app will need. This plugin uses the browser language to determine the appropriate symbols and format accordingly.',
'',
'Currencies that can support all currencies listed at here',
'',
'Javascript is also used to convert to number before submit for easy use when combining with SQL or PL/SQL functions.'))
,p_files_version=>49
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(6964284249746032100)
,p_plugin_id=>wwv_flow_api.id(6964284037523032092)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Currency Code Item'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(6964284642181032102)
,p_plugin_id=>wwv_flow_api.id(6964284037523032092)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Number Alignment?'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'Left'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(6964286006107032104)
,p_plugin_attribute_id=>wwv_flow_api.id(6964284642181032102)
,p_display_sequence=>10
,p_display_value=>'Left'
,p_return_value=>'Left'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(6964285569166032104)
,p_plugin_attribute_id=>wwv_flow_api.id(6964284642181032102)
,p_display_sequence=>20
,p_display_value=>'Center'
,p_return_value=>'Center'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(6964285069290032103)
,p_plugin_attribute_id=>wwv_flow_api.id(6964284642181032102)
,p_display_sequence=>30
,p_display_value=>'Right'
,p_return_value=>'Right'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E206765744C616E672829207B2072657475726E20286E6176696761746F722E6C616E6775616765207C7C206E6176696761746F722E6C616E6775616765735B305D7C7C27656E27297D3B0D0A0D0A0D0A66756E6374696F6E20666F72';
wwv_flow_api.g_varchar2_table(2) := '6D6174417343757272656E63792876616C7565203D302C2063757272656E637929207B0D0A20202069662863757272656E637920213D3D202727297B0D0A20200D0A2020766172206C6F63616C65203D206765744C616E6728293B0D0A20200D0A202072';
wwv_flow_api.g_varchar2_table(3) := '657475726E202076616C75652E746F4C6F63616C65537472696E6728206C6F63616C652C207B0D0A202020207374796C653A202763757272656E6379272C0D0A2020202063757272656E63793A2063757272656E63792C0D0A202020206D696E696D756D';
wwv_flow_api.g_varchar2_table(4) := '4672616374696F6E4469676974733A20300D0A202020207D290D0A2020207D3B0D0A7D3B0D0A0D0A66756E6374696F6E206164644368616E67654576656E7428705F636F6465297B0D0A20202020646F63756D656E742E676574456C656D656E74427949';
wwv_flow_api.g_varchar2_table(5) := '6428705F636F6465292E73657441747472696275746528226F6E6368616E6765222C202263757272436F64654368616E676528746869732E6964293B22293B202F2F686F7720646F20492064796E616D6963616C6C7920736574207468652076616C7565';
wwv_flow_api.g_varchar2_table(6) := '206F6620746865206375727220636F6465206669656C643F0D0A7D3B0D0A202020200D0A202020200D0A66756E6374696F6E2063757272436F64654368616E676528705F636F646529207B0D0A20200D0A202020207661722078203D20646F63756D656E';
wwv_flow_api.g_varchar2_table(7) := '742E717565727953656C6563746F72416C6C2827696E7075745B637572726669656C645D27293B0D0A2020202076617220693B0D0A20202020666F72202869203D20303B2069203C20782E6C656E6774683B20692B2B29207B0D0A20202020202020200D';
wwv_flow_api.g_varchar2_table(8) := '0A20202020202020207661722063757272436F6465203D20646F63756D656E742E676574456C656D656E744279496428785B695D2E6E616D65292E676574417474726962757465282263757272636F64656974656D22293B0D0A20202020202020200D0A';
wwv_flow_api.g_varchar2_table(9) := '20202020202020206966202863757272436F6465203D3D20705F636F6465297B0D0A20202020202020202020202020202020617065782E6974656D28785B695D2E6E616D65292E73657456616C75652872756E466F726D617428785B695D2E6E616D652C';
wwv_flow_api.g_varchar2_table(10) := '20705F636F646529293B0D0A2020202020202020202020207D3B0D0A20202020202020207D3B0D0A7D3B0D0A0D0A66756E6374696F6E2072756E466F726D617428705F76616C75652C20705F636F6465297B0D0A202020200D0A0D0A2020202076617220';
wwv_flow_api.g_varchar2_table(11) := '63757272656E6379537472696E67203D20617065782E6974656D28705F76616C7565292E67657456616C756528293B202F2F4765742076616C7565206F6620776861746576657220697320696E207468652063757272656E6379206669656C640D0A0D0A';
wwv_flow_api.g_varchar2_table(12) := '202020207661722063757272656E63794E756D626572203D2063757272656E6379537472696E672E7265706C616365282F5C442F672C2727293B202F2F666F726D617420737472696E672076616C756520746F2074616B65206F757420616E79206E6F6E';
wwv_flow_api.g_varchar2_table(13) := '2D6E756D6572696320636861726163746572732E205374696C6C206973206120737472696E672062757420776974686F757420616E79206C6574746572732F73796D626F6C730D0A0D0A2020202069662863757272656E63794E756D626572203D3D2027';
wwv_flow_api.g_varchar2_table(14) := '27297B0D0A202020202020202063757272656E63794E756D6265723D2730273B0D0A202020207D0D0A0D0A202020207661722063757272656E6379436F6465203D20617065782E6974656D28705F636F6465292E67657456616C756528293B202F2F6765';
wwv_flow_api.g_varchar2_table(15) := '742076616C7565206F662063757272656E637920636F64652073656C65637465640D0A202020200D0A2020202069662863757272656E6379436F6465203D3D202727297B0D0A202020202020202063757272656E6379436F64653D27555344273B0D0A20';
wwv_flow_api.g_varchar2_table(16) := '2020207D0D0A202020200D0A2020202072657475726E20666F726D6174417343757272656E6379287061727365496E742863757272656E63794E756D626572292C63757272656E6379436F6465293B202F2F736574207468652076616C756520666F7220';
wwv_flow_api.g_varchar2_table(17) := '746865206974656D207573696E6720746865204A532066756E6374696F6E2E200D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(18) := '202020202020202020202020202020202020202020202F2F5061727365496E74206E65656465642061732063757272656E63794E756D626572206973207374696C6C20746563686E6963616C6C79206120737472696E67206265666F7265207061727365';
wwv_flow_api.g_varchar2_table(19) := '496E740D0A7D3B0D0A0D0A66756E6374696F6E207375626D697441734E756D62657228297B0D0A202020200D0A2020200D0A202020200D0A202020207661722078203D20646F63756D656E742E717565727953656C6563746F72416C6C2827696E707574';
wwv_flow_api.g_varchar2_table(20) := '5B637572726669656C645D27293B0D0A202020200D0A2020202076617220693B0D0A202020200D0A20202020666F72202869203D20303B2069203C20782E6C656E6774683B20692B2B29207B0D0A20202020202020200D0A202020202020202076617220';
wwv_flow_api.g_varchar2_table(21) := '705F76616C7565203D20646F63756D656E742E676574456C656D656E744279496428785B695D2E6E616D65292E67657441747472696275746528226E616D6522293B0D0A2020202020202020202020200D0A2020202020202020766172206D7953747269';
wwv_flow_api.g_varchar2_table(22) := '6E67203D20617065782E6974656D28705F76616C7565292E67657456616C756528293B0D0A09092020202020200D0A20202020202020207661722079203D206D79537472696E672E7265706C616365282F5C442F672C2727293B0D0A0909090D0A202020';
wwv_flow_api.g_varchar2_table(23) := '2020202020617065782E6974656D28705F76616C7565292E73657456616C75652879293B0D0A20202020202020200D0A20202020202020207D3B0D0A2020200D0A7D3B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(6964287118495032117)
,p_plugin_id=>wwv_flow_api.id(6964284037523032092)
,p_file_name=>'currencyFormat.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
