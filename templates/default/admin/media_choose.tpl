<html>
    <head>
        <title>{$CONST.SERENDIPITY_ADMIN_SUITE}: {$CONST.SELECT_FILE}</title>
        <meta http-equiv="Content-Type" content="text/html; charset={$CONST.LANG_CHARSET}" />
        {if $media.css}<link rel="stylesheet" type="text/css" href="{$media.css}" />{/if}
        {if $media.css_tree}<link rel="stylesheet" type="text/css" href="{$media.css_tree}" />{/if}
        {if $media.css_imgedit}<link rel="stylesheet" type="text/css" href="{$media.css_imgedit}" />{/if}

        {if $media.is_imgedit}
        <style type="text/css">
        #outer {
            left: {$imgedit.zoombox_padding}px;
        }

        #overlay {
            clip: rect({$imgedit.overlay_clip_top} {$imgedit.overlay_clip_right} {$imgedit.overlay_clip_bottom} {$imgedit.overlay_clip_left});
        }

        #harea {
            left: {$imgedit.zoombox_x}px;
            top: {$imgedit.zoombox_y}px;
            visibility: {$imgedit.harea_visibility};
        }

        #varea {
            left: {$imgedit.zoombox_x}px;
            top: {$imgedit.zoombox_y}px;
            visibility: {$imgedit.varea_visibility};
        }

        #zoom {
            width: {$imgedit.zoombox_width}px;
        }

        #scaletext {
            visibility: {$imgedit.scale_visibility};
        }

        #outer {
            width: {$imgedit.img_width}px;
            height: {$imgedit.img_height}px;
            border: 1px solid red;
            position: relative;
            display: block;
        }
        </style>
        <script type="text/javascript" src="{serendipity_getFile file='dragdrop.js'}" ></script>
        <script type="text/javascript" src="{serendipity_getFile file='imgedit.js'}" ></script>
        {/if}

        <script type="text/javascript" src="{serendipity_getFile file='YahooUI/treeview/YAHOO.js'}"></script>
        <script type="text/javascript" src="{serendipity_getFile file='YahooUI/treeview/treeview.js'}"></script>

        <script src="{serendipity_getFile file='admin/header_spawn.js'}"></script>

        {serendipity_hookPlugin hook="backend_header" hookAll="true"}


        <script type="text/javascript">
            var media_token_url = '{$media.token_url}';
            var media_rename = '{$CONST.ENTER_NEW_NAME}';

        {if $media.only_path}
            if (parent.frames && parent.frames['tree']) {
                parent.frames['tree'].document.getElementById('newdirlink').href =
                    parent.frames['tree'].basenewdirurl +
                    "{$media.only_path|@escape}"
            }
        {/if}
    </script>

    </head>
{if $media.frameset}
    <frameset id="media_frame" cols="20%,*">
        <frame id="media_frame_tree" frameborder="0" name="tree" scrolling="auto" src="{$serendipityHTTPPath}serendipity_admin_image_selector.php?{$media.GET_STRING}&amp;serendipity[step]=tree" />
        <frame id="media_frame_main" frameborder="0" name="media" src="{$serendipityHTTPPath}serendipity_admin_image_selector.php?{$media.GET_STRING}&amp;serendipity[step]=default" />
    </frameset>
    </html>
{else}
<body id="{$media.body_id}">

<div class="serendipityAdminContent">
{if $media.case == 'external'}

    <!-- EXTERNAL MEDIA START -->
    {if $media.is_created OR $media.is_deleted}
    <script type="text/javascript">
    if (parent.frames['tree']) {
        parent.frames['tree'].location.href  = parent.frames['tree'].location.href;
        parent.frames['media'].location.href = '{$serendipityHTTPPath}serendipity_admin_image_selector.php?serendipity[step]=default&serendipity[only_path]={$media.new_dir}';
    }
    </script>
    {/if}
    {$media.external}

    {if $media.is_imgedit}
    {$IMGEDIT}
    {/if}

    <!-- EXTERNAL MEDIA END -->

{elseif $media.case == 'default'}

    <!-- MEDIA MANAGER START -->
    <h1>{$CONST.SELECT_FILE}</h1>
    <h2>{$CONST.CLICK_FILE_TO_INSERT}</h2>
    <br />
    {$media.external}
    {$MEDIA_LIST}
    <!-- MEDIA MANAGER END -->

{elseif $media.case == 'choose'}

    {if $perm_denied}
        {$CONST.PERM_DENIED}
    {else}

    <!-- MEDIA SELECTION START -->
    {$media.external}
    <div>
    {if $media.file.is_image}
        {serendipity_hookPlugin hook="frontend_image_selector" data=$media.file hookAll=true}
        <img align="right" src="{$media.file.imgsrc}" />
        <h1>{$CONST.YOU_CHOSE|@sprintf:$media.file.realname}</h1>
        <p>
            <form action="#" method="GET" id="imageForm" name="serendipity[selForm]" onsubmit="serendipity_imageSelector_done()">
                <div>
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_hiddenfields' data=$media.file}
                    <input type="hidden" name="imgThumbWidth"  value="{$media.file.thumbWidth}" />
                    <input type="hidden" name="imgThumbHeight" value="{$media.file.thumbHeight}" />
                    <input type="hidden" name="imgWidth"  value="{$media.file.dimensions_width}" />
                    <input type="hidden" name="imgHeight" value="{$media.file.dimensions_height}" />
                    <input type="hidden" name="imgID" value="{$media.imgID}" />
                    <input type="hidden" name="baseURL" value="{$serendipityBaseURL}" />
                    <input type="hidden" name="indexFile" value="{$serendipityIndexFile}" />
                    <input type="hidden" name="imgName"   value="{$media.file.full_file}" />
                    <input type="hidden" name="thumbName" value="{$media.file.show_thumb}" />
                    <input type="hidden" name="hotlink" value="{$media.file.hotlink}" />
                    {if $media.htmltarget}
                    <input type="hidden" name="serendipity[htmltarget]" value="{$media.htmltarget|@escape}" />
                    {/if}
                    {if $media.filename_only}
                    <input type="hidden" name="serendipity[filename_only]" value="{$media.filename_only|@escape}" />
                    {/if}

                    {if $media.file.fast_select}
                    <script type="text/javascript">
                        {serendipity_hookPlugin hookAll=true hook='frontend_image_add_filenameonly' data=$media.file}
                        serendipity_imageSelector_done('{$media.textarea|@escape}');
                    </script>
                    {else}
                    <b>{$CONST.IMAGE_SIZE}:</b>
                    <br />
                    <input class="input_radio" id="radio_link_no" type="radio"  name="serendipity[linkThumbnail]" value="no" {'linkThumbnail'|@ifRemember:'no':true} /><label for="radio_link_no">{$CONST.I_WANT_THUMB}</label><br />
                    <input class="input_radio" id="radio_link_yes" type="radio" name="serendipity[linkThumbnail]" value="yes" {'linkThumbnail'|@ifRemember:'yes'} /><label for="radio_link_yes">{$CONST.I_WANT_BIG_IMAGE}</label><br />
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_imagesize' data=$media.file}
                    <br />

                    {if NOT $media.filename_only}
                    <b>{$CONST.IMAGE_ALIGNMENT}:</b>
                    <br />

                    <input class="input_radio" type="radio" name="serendipity[align]" {'align'|@ifRemember:''}           value="" />     <img src="{serendipity_getFile file='img/img_align_top.png'}"   vspace="5" /><br />
                    <input class="input_radio" type="radio" name="serendipity[align]" {'align'|@ifRemember:'left':true}  value="left" /> <img src="{serendipity_getFile file='img/img_align_left.png'}"  vspace="5" /><br />
                    <input class="input_radio" type="radio" name="serendipity[align]" {'align'|@ifRemember:'right'}      value="right" /><img src="{serendipity_getFile file='img/img_align_right.png'}" vspace="5" /><br />
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_imagealign' data=$media.file}
                    <br />

                    <b>{$CONST.IMAGE_AS_A_LINK}:</b>
                    <br />

                    <input class="input_radio" type="radio" id="radio_islink_no" type="radio" name="serendipity[isLink]" value="no" {'isLink'|@ifRemember:'no':true} /><label for="radio_islink_no"> {$CONST.I_WANT_NO_LINK}</label><br />
                    <input class="input_radio" type="radio" id="radio_islink_yes"  type="radio" name="serendipity[isLink]" value="yes"  {'isLink'|@ifRemember:'yes'} /><label for="radio_islink_yes"> {$CONST.I_WANT_IT_TO_LINK}</label>
                    {if $media.file.hotlink}

                    <input class="input_textbox" type="text"  name="serendipity[url]" size="30" value="{$media.file.path}" /><br />
                    {else}
                        {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_link_url' data=$media.file.links}
                        <input class="input_textbox" type="text"  name="serendipity[url]" size="30" value="{$media.file.links.imagelinkurl}" /><br />
                    {/if}

                    <label for="select_image_target">{$CONST.MEDIA_TARGET}</label>
                        <select name="serendipity[target]" id="select_image_target">
                            <option value="none"   {'target'|@ifRemember:'none':false:'selected'}>{$CONST.NONE}</option>
                            <option value="js"     {'target'|@ifRemember:'js':false:'selected'}>{$CONST.MEDIA_TARGET_JS}</option>
                            <option value="plugin" {'target'|@ifRemember:'plugin':false:'selected'}>{$CONST.MEDIA_ENTRY}</option>
                            <option value="_blank" {'target'|@ifRemember:'_blank':false:'selected'}>{$CONST.MEDIA_TARGET_BLANK}</option>
                        </select>
                    <br />

                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_imagelink2' data=$media.file}
                    <br />

                    <b>{$CONST.COMMENT}:</b>
                    <br />
                    <textarea id="serendipity_imagecomment" name="serendipity[imagecomment]" rows="5" cols="40">{$media.file.props.base_property.COMMENT1|@escape}</textarea>
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_imagecomment' data=$media.file}
                    <br />

                    <b>{$CONST.MEDIA_ALT}:</b>
                    <br />
                    <input size="30" class="input_textbox" type="text" id="serendipity_alt" name="serendipity[alt]" value="{$media.file.props.base_property.ALT|@escape}" /></textarea>
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_alt' data=$media.file}
                    <br />

                    <b>{$CONST.MEDIA_TITLE}:</b>
                    <br />
                    <input size="30" class="input_textbox" type="text" id="serendipity_title" name="serendipity[title]" value="{$media.file.props.base_property.TITLE|@escape}" /></textarea>
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_title' data=$media.file}
                    <br />
                    {/if}

                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_more' data=$media.file}
                    <input class="serendipityPrettyButton input_button" type="button" value="{$CONST.BACK}" onclick="history.go(-1);" />
                    <input class="serendipityPrettyButton input_button" type="button" value="{$CONST.DONE}" onclick="rememberMediaOptions(); {$media.file.origfinishJSFunction}" />
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_submit' data=$media.file}
                {/if}
            </div>
        </form>
    </p>
    {else}
        {if $media.filename_only}
        <script type="text/javascript">
            {serendipity_hookPlugin hookAll=true hook='frontend_image_add_filenameonly' data=$media}
            if (parent.self.opener == undefined) {
                // in iframes, there is no opener, and the magnific popup is wrapped
                parent.self = window.parent.parent.$.magnificPopup;
                parent.self.opener = window.parent.parent;
            }
            parent.self.opener.serendipity.serendipity_imageSelector_addToElement('{$media.file.full_file|escape}', '{$media.htmltarget|escape}');
            parent.self.close();
        </script>
        {else}
        <script type="text/javascript">
            block = '<a href="{$media.file.full_file}" title="{$media.file.realname|@escape}" target="_blank">{$media.file.realname|@escape}</a>';
            {serendipity_hookPlugin hookAll=true hook='frontend_image_add_unknown' data=$media}
            if (parent.self.opener == undefined) {
                // in iframes, there is no opener, and the magnific popup is wrapped
                parent.self = window.parent.parent.$.magnificPopup;
                parent.self.opener = window.parent.parent;
            }
            if (parent.self.opener.editorref) {
                parent.self.opener.editorref.surroundHTML(block, '');
            } else {
                parent.self.opener.serendipity.serendipity_imageSelector_addToBody(block, '{$media.textarea}');
            }
            parent.self.close();
        </script>
        {/if}
    {/if}
    {/if}
{elseif $media.case == 'tree'}
    <div id="content">
        <form name="mainForm" action="javscript:;">
            <div class="newsItem">
                <div id="expandcontractdiv">
                    <a href="javascript:treeToggleAll()">{$CONST.TOGGLE_ALL}</a>
                </div>
                <div id="treeDiv1"></div>
            </div>
        </form>
    </div>

    <div id="footerContainer">
        <div id="footer">
            <p><a id="newdirlink" target="media" class="serendipityPrettyButton input_button" href="{$serendipityHTTPPath}serendipity_admin_image_selector.php?serendipity[step]=directoryCreate">{$CONST.WORD_NEW}</a></p>
            <p><a id="managedirlink" target="media" class="serendipityPrettyButton input_button" href="{$serendipityHTTPPath}serendipity_admin_image_selector.php?serendipity[step]=default&amp;serendipity[adminModule]=images&amp;serendipity[adminAction]=directorySelect">{$CONST.MANAGE_DIRECTORIES}</a></p>
        </div>
    </div>

    <script type="text/javascript">
        var tree;
        var nodes = new Array();
        var nodeIndex;
        var coreNode      = '';
        var last_path     = '';
        var last_node     = new Array();
        var baseurl       = '{$serendipityHTTPPath}serendipity_admin_image_selector.php?{$media.GET_STRING}&amp;serendipity[step]=default&amp;serendipity[only_path]=';
        var basenewdirurl = '{$serendipityHTTPPath}serendipity_admin_image_selector.php?{$media.GET_STRING}&amp;serendipity[step]=directoryCreate&amp;serendipity[only_path]=';

        function treeInit() {
            tree = new YAHOO.widget.TreeView("treeDiv1");
            tree.onExpand = function(node) {
                document.getElementById('newdirlink').href = basenewdirurl + node.data.relpath;
            };

            coreNode          = new YAHOO.widget.TextNode("{$CONST.MEDIA}", tree.getRoot(), false);
            coreNode.href     = baseurl;
            coreNode.target   = 'media';
            coreNode.expanded = true;
        {foreach from=$media.paths item="item" key="id"}
            mydir = { id: "{$id}", label: "{$item.name}", target : "media", href: baseurl + "{$item.relpath}", relpath: "{$item.relpath}" };
        {if $item.depth == 1}
            tmpNode = new YAHOO.widget.TextNode(mydir, coreNode, false);
        {else}
            if (last_node[{$item.depth}-1]) {
                tmpNode = new YAHOO.widget.TextNode(mydir, last_node[{$item.depth} - 1], false);
            } else {
                tmpNode = new YAHOO.widget.TextNode(mydir, coreNode, false);
            }
        {/if}
            last_node[{$item.depth}] = tmpNode;
        {/foreach}
            tree.draw();
        }

        addLoadEvent(treeInit);
    </script>
{/if}

    </div>
</body>
</html>
{/if}
