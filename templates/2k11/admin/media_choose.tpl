{if isset($perm_denied) and $perm_denied}
    <span class="msg_error"><span class="icon-attention-circled" aria-hidden="true"></span> {$CONST.PERM_DENIED}</span>
{else}
    {if isset($medias) and $medias}
        <script>
            var blockSkip = false;
            var block = '';

            {serendipity_hookPlugin hookAll=true hook='frontend_image_add_prepend' addData="galleryListing"}
            if (!blockSkip) {
                block = '<ul class="s9y_gallery plainList">';
            }

            {foreach $medias as $media}
                {* generate the images of the gallery with their markup *}
                {serendipity_hookPlugin hookAll=true hook='frontend_image_add_unknown' data=$media addData="galleryListing"}
                if (blockSkip) {
                    // Plugins can emit this variable and also assign their own "block" variable, which will override the s9y default
                } else {
                    block += '<li class="s9y_gallery_item"><a class="serendipity_image_link" href="{$media.file.links.imagelinkurl}"><!-- s9ymdb:{$media.file.id} --><img class="s9y_gallery_image" src="{$media.file.full_thumbHTTP|escape}" alt=""></a></li>';
                }
            {/foreach}

            blockSkip = false;
            {serendipity_hookPlugin hookAll=true hook='frontend_image_add_append' addData="galleryListing"}
            if (!blockSkip) {
                block += '</ul>';
            }

            if (parent.self.opener == undefined) {
                // in iframes, there is no opener, and the magnific popup is wrapped
                parent.self = window.parent.parent.$.magnificPopup;
                parent.self.opener = window.parent.parent;
            }
            if (parent.self.opener.editorref) {
                parent.self.opener.editorref.surroundHTML(block, '');
            } else {
                parent.self.opener.serendipity.serendipity_imageSelector_addToBody(block, '{$textarea}');
            }
            parent.self.close();
        </script>
    {else}
         <!-- MEDIA SELECTION START -->
        {if isset($media.external)}
            {$media.external}
        {/if}

        <div class="clearfix">
        {if $media.file.is_image}
            {serendipity_hookPlugin hook="frontend_image_selector" data=$media.file hookAll=true}
            <h1>{$CONST.YOU_CHOSE|sprintf:$media.file.realname}</h1>

            <img src="{$media.file.imgsrc}" alt="">

            <form id="imageForm" name="serendipity[selForm]" action="#" method="GET">
                {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_hiddenfields' data=$media.file}
                <input name="imgThumbWidth" type="hidden" value="{$media.file.thumbWidth}">
                <input name="imgThumbHeight" type="hidden" value="{$media.file.thumbHeight}">
                <input name="imgWidth" type="hidden" value="{$media.file.dimensions_width}">
                <input name="imgHeight" type="hidden" value="{$media.file.dimensions_height}">
                <input name="imgID" type="hidden" value="{$media.file.id}">
                <input name="baseURL" type="hidden" value="{$serendipityBaseURL}">
                <input name="indexFile" type="hidden" value="{$serendipityIndexFile}">
                <input name="imgName" type="hidden" value="{$media.file.full_file}">
                <input name="thumbName" type="hidden" value="{$media.file.show_thumb}">
                <input name="hotlink" type="hidden" value="{$media.file.hotlink}">
            {if $media.htmltarget}
                <input name="serendipity[htmltarget]" type="hidden" value="{$media.htmltarget|escape}">
            {/if}
            {if $media.filename_only}
                <input name="serendipity[filename_only]" type="hidden" value="{$media.filename_only|escape}">
            {/if}
            {if isset($media.file.fast_select) and $media.file.fast_select}
                <script>
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_add_filenameonly' data=$media.file}
                    serendipity.serendipity_imageSelector_done('{$media.textarea|escape}');
                </script>
            {else}
                <fieldset id="image_size">
                    <span class="wrap_legend"><legend>{$CONST.IMAGE_SIZE}</legend></span>

                    <div class="clearfix">
                        <div class="form_radio">
                            <input id="radio_link_no" name="serendipity[linkThumbnail]" type="radio" value="no" {'linkThumbnail'|ifRemember:'no':true}>
                            <label for="radio_link_no">{$CONST.I_WANT_THUMB}</label>
                        </div>

                        <div class="form_radio">
                            <input id="radio_link_yes" name="serendipity[linkThumbnail]" type="radio" value="yes" {'linkThumbnail'|ifRemember:'yes'}>
                            <label for="radio_link_yes">{$CONST.I_WANT_BIG_IMAGE}</label>
                        </div>
                    </div>
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_imagesize' data=$media.file}
                </fieldset>
                {if NOT $media.filename_only}
                <fieldset id="image_alignment">
                    <span class="wrap_legend"><legend>{$CONST.IMAGE_ALIGNMENT}</legend></span>

                    <div class="clearfix">
                        <div class="form_radio">
                            <input id="image_align_top" name="serendipity[align]" {'align'|ifRemember:''} type="radio" value="">
                            <label for="image_align_top"><img src="{serendipity_getFile file='img/img_align_top.png'}" alt="{$CONST.ALIGN_TOP}"></label>
                        </div>

                        <div class="form_radio">
                            <input id="image_align_left" name="serendipity[align]" {'align'|ifRemember:'left':true} type="radio" value="left">
                            <label for="image_align_left"><img src="{serendipity_getFile file='img/img_align_left.png'}" alt="{$CONST.ALIGN_LEFT}"></label>
                        </div>

                        <div class="form_radio">
                            <input id="image_align_right" name="serendipity[align]" {'align'|ifRemember:'right'} type="radio" value="right">
                            <label for="image_align_right"><img src="{serendipity_getFile file='img/img_align_right.png'}" alt="{$CONST.ALIGN_RIGHT}"></label>
                        </div>
                    </div>
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_imagealign' data=$media.file}
                </fieldset>

                <fieldset id="image_as_link">
                    <span class="wrap_legend"><legend>{$CONST.IMAGE_AS_A_LINK}</legend></span>

                    <div class="clearfix">
                        <div class="form_radio">
                            <input id="radio_islink_no" name="serendipity[isLink]" type="radio" value="no" {'isLink'|ifRemember:'no':true}>
                            <label for="radio_islink_no">{$CONST.I_WANT_NO_LINK}</label>
                        </div>

                        <div class="form_radio">
                            <input id="radio_islink_yes" name="serendipity[isLink]" type="radio" value="yes" {'isLink'|ifRemember:'yes'}>
                            <label for="radio_islink_yes">{$CONST.I_WANT_IT_TO_LINK}</label>

                            <div class="form_field">
                            {* Could use input[type=url], but does that handle local URLs as well? Hm. *}
                                <label for="media_file_path" class="visuallyhidden">{$CONST.FILTER_DIRECTORY}</label>
                            {if $media.file.hotlink}
                                <input id="media_file_path" name="serendipity[url]" type="text" value="{$media.file.path}">
                            {else}
                                {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_link_url' data=$media.file.links}
                                <input id="media_file_path" name="serendipity[url]" type="text" value="{$media.file.links.imagelinkurl}">
                            {/if}
                            </div>
                        </div>
                    </div>

                    <div class="form_select">
                        <select id="select_image_target" name="serendipity[target]">
                            <option value="none"   {'target'|ifRemember:'none':false:'selected'}>{$CONST.NONE}</option>
                            <option value="js"     {'target'|ifRemember:'js':false:'selected'}>{$CONST.MEDIA_TARGET_JS}</option>
                            <option value="plugin" {'target'|ifRemember:'plugin':false:'selected'}>{$CONST.MEDIA_ENTRY}</option>
                            <option value="_blank" {'target'|ifRemember:'_blank':false:'selected'}>{$CONST.MEDIA_TARGET_BLANK}</option>
                        </select>
                        {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_imagelink2' data=$media.file}
                        <label for="select_image_target">{$CONST.MEDIA_TARGET}</label>
                    </div>
                </fieldset>

                <div id="image_comment" class="form_area">
                    <label for="serendipity_imagecomment">{$CONST.COMMENT}</label>
                    <textarea id="serendipity_imagecomment" name="serendipity[imagecomment]" rows="5">{if isset($media.file.props.base_property.COMMENT1)}{$media.file.props.base_property.COMMENT1|escape|escape}{/if}</textarea>
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_imagecomment' data=$media.file}
                </div>

                <div id="image_alttext" class="form_field">
                    <label for="serendipity_alt">{$CONST.MEDIA_ALT}</label>
                    <input id="serendipity_alt" name="serendipity[alt]" type="text" value="{if isset($media.file.props.base_property.ALT)}{$media.file.props.base_property.ALT|escape}{/if}">
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_alt' data=$media.file}
                </div>

                <div id="image_title" class="form_field">
                    <label for="serendipity_title">{$CONST.MEDIA_TITLE}</label>
                    <input id="serendipity_title" name="serendipity[title]" type="text" value="{if isset($media.file.props.base_property.TITLE)}{$media.file.props.base_property.TITLE|escape}{/if}">
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_title' data=$media.file}
                </div>
                {/if}
                {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_more' data=$media.file}
                <div class="form_buttons">
                    <input class="go_back" type="button" value="{$CONST.BACK}">
                    <input type="button" value="{$CONST.DONE}" onclick="serendipity.rememberMediaOptions(); {$media.file.origfinishJSFunction}">
                    {serendipity_hookPlugin hookAll=true hook='frontend_image_selector_submit' data=$media.file}
                </div>
            {/if}{* else fast_select end *}
            </form>
        {else}{* if $media.file.is_image end *}
            {if $media.filename_only}
            <script>
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
                {if $media.file.mediatype == 'video'}
                    <script>
                        block = '<video src="{$media.file.full_file}" controls><!-- s9ymdb:{$media.file.id} --><a class="block_level opens_window" href="{$media.file.full_file}" title="{$media.file.realname|escape}">{$media.file.realname|escape}</a></video>';
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

                {else}
                    <script>
                        block = '<a class="block_level opens_window" href="{$media.file.full_file}" title="{$media.file.realname|escape}"><!-- s9ymdb:{$media.file.id} -->{$media.file.realname|escape}</a>';
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
        {/if}{* if $media.file.is_image is something else end *}
        </div>
    {/if}
{/if}{* if $perm_denied else end *}
