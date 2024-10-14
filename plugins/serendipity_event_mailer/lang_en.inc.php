<?php

/**
 *  @version
 *  @author Translator Name <yourmail@example.com>
 *  EN-Revision: Revision of lang_en.inc.php
 */

@define('PLUGIN_EVENT_MAILER_NAME', 'Send entries via E-Mail');
@define('PLUGIN_EVENT_MAILER_DESC', 'Let you send a newly created entry via E-Mail to a specific address');
@define('PLUGIN_EVENT_MAILER_RECIPIENT', 'Mail recipient');
@define('PLUGIN_EVENT_MAILER_RECIPIENTDESC', 'E-Mail address you want to send the entries to (suggested: a mailing list)');
@define('PLUGIN_EVENT_MAILER_LINK', 'Mail link to article?');
@define('PLUGIN_EVENT_MAILER_LINKDESC', 'Include a link to the article in the mail.');
@define('PLUGIN_EVENT_MAILER_STRIPTAGS', 'Remove HTML?');
@define('PLUGIN_EVENT_MAILER_STRIPTAGSDESC', 'Remove HTML-Tags from the mail.');
@define('PLUGIN_EVENT_MAILER_CONVERTP', 'Convert HTML-paragraphs to newlines?');
@define('PLUGIN_EVENT_MAILER_CONVERTPDESC', 'Adds a newline after each HTML paragraph. This is very useful if you enable HTML removing, so that your paragraphs can be kept if not manually entered.');
@define('PLUGIN_EVENT_MAILER_RECIPIENTS', 'Mail recipient (seperate multiple recipients with a space)');
@define('PLUGIN_EVENT_MAILER_NOTSENDDECISION', 'This entry was not sent via E-Mail because you decided to not send it.');
@define('PLUGIN_EVENT_MAILER_SENDING', 'Sending');
@define('PLUGIN_EVENT_MAILER_ISTOSENDIT', 'Send this entry via E-Mail');
@define('PLUGIN_EVENT_MAILER_SENDTOALL', 'Send to all authors');
@define('PLUGIN_EVENT_MAILER_KEEPSTRIPTAGS', 'Keep images and hyperlinks when removing html?');
@define('PLUGIN_EVENT_MAILER_KEEPSTRIPTAGSDESC', 'Only applies when removing HTML-tags from the mail. If enabled, images and hyperlinks will be put inside the text, when disabled those placeholders will also be removed.');
@define('PLUGIN_EVENT_MAILER_FORCESEND', 'Forces sending an E-Mail on save');
@define('PLUGIN_EVENT_MAILER_FORCESEND_DESC', 'By default, E-Mails are only sent when publishing an entry for the first time');
@define('PLUGIN_EVENT_MAILER_MAILTEXT', 'Optional custom text to prepend to the E-Mail (like a greeting or explaining why this entry is being mailed)');
