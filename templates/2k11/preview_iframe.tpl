<!doctype html>
<!--[if lt IE 7 ]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="{$lang}"> <![endif]-->
<!--[if IE 7 ]>    <html class="no-js lt-ie9 lt-ie8" lang="{$lang}"> <![endif]-->
<!--[if IE 8 ]>    <html class="no-js lt-ie9" lang="{$lang}"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="{$lang}"> <!--<![endif]-->
<head>
    <meta charset="{$head_charset}">
    <title>{$CONST.SERENDIPITY_ADMIN_SUITE}</title>
    <meta name="generator" content="Serendipity v.{$serendipityVersion}">
    <meta name="viewport" content="width=device-width, initial-scale=1">
{if $template_option.webfonts == 'droid'}
    <link  rel="stylesheet" href="//fonts.googleapis.com/css?family=Droid+Sans:400,700">
{elseif $template_option.webfonts == 'ptsans'}
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=PT+Sans:400,400italic,700,700italic">
{elseif $template_option.webfonts == 'osans'}
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:400,400italic,700,700italic">
{elseif $template_option.webfonts == 'cabin'}
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Cabin:400,400italic,700,700italic">
{elseif $template_option.webfonts == 'ubuntu'}
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Ubuntu:400,400italic,700,700italic">
{elseif $template_option.webfonts == 'dserif'}
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Droid+Serif:400,400italic,700,700italic">
{/if}
{if $head_link_stylesheet_frontend}
    <link rel="stylesheet" href="{$head_link_stylesheet_frontend}">
{else}
    <link rel="stylesheet" href="{$serendipityHTTPPath}{$serendipityRewritePrefix}serendipity.css">
{/if}
    <script src="{serendipity_getFile file="js/modernizr-2.7.1.min.js" frontend=true}"></script>
{serendipity_hookPlugin hook="backend_header" hookAll="true"}
    <script>
        window.onload = function() {ldelim}
            parent.document.getElementById('serendipity_iframe').style.height = document.querySelector('html').offsetHeight + 'px';
            parent.document.getElementById('serendipity_iframe').scrolling    = 'no';
            parent.document.getElementById('serendipity_iframe').style.border = 0;
        {rdelim}
    </script>
</head>
<body{if $template_option.webfonts != 'none'} class="{$template_option.webfonts}"{/if}>
<div id="page" class="clearfix container">
    <div class="clearfix col2r">
        <main id="content"{if $template_option.imgstyle != 'none'} class="{$template_option.imgstyle}"{/if}>
        {if $mode == 'preview'}
            <div class="clearfix">
        {elseif $mode == 'save'}
            <div class="clearfix">
            <div style="float: left; height: 75px"></div>
            {$updertHooks}
            {if isset($res) and $res}
                <div class="serendipity_msg_important">{$CONST.ERROR}: <b>{$res}</b></div>
            {else}
                {if isset($lastSavedEntry) and $lastSavedEntry}
                    <script type="text/javascript">$(document).ready(function() {
                                                        parent.document.forms['serendipityEntry']['serendipity[id]'].value = "{$lastSavedEntry}";
                    });
                    </script>
                {/if}
                <span class="msg_success"><span class="icon-ok-circled" aria-hidden="true"></span> {$CONST.ENTRY_SAVED}</span>
                <a href="{$entrylink}" target="_blank">{$CONST.VIEW}</a>
            {/if}
        {/if}
        {if isset($preview)}
            {$preview}
        {/if}
        </div>
        </main>
    </div>
</div>
</body>
</html>