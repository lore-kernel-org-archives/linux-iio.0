Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <20121124052707.GA17392@roeck-us.net> <50B09EDC.4020200@kernel.org> <20130116054918.GA7056@roeck-us.net> <50F667C9.6000106@jic23.retrosnub.co.uk> <20130117204549.GB22045@roeck-us.net>
In-Reply-To: <20130117204549.GB22045@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----PRP77NSC6KHQ3QFZY5KVYDSKLYDXV8"
Subject: Re: MAX1363 IIO driver questions
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 17 Jan 2013 21:03:58 +0000
To: Guenter Roeck <linux@roeck-us.net>
CC: Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org,Jean Delvare <khali@linux-fr.org>,lm-sensors@lm-sensors.org
Message-ID: <8649d873-66ef-4b0f-a22d-8480e5aa1ead@email.android.com>
List-ID: <linux-iio@vger.kernel.org>

------PRP77NSC6KHQ3QFZY5KVYDSKLYDXV8
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit


Good point. New use case for us so suggestions on how to do the association cleanly would be most welcome. Is there anything similar out there? We could add a per iio device sysfs interface to add additional mappings but it is a little uggly...

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

Guenter Roeck <linux@roeck-us.net> wrote:

On Wed, Jan 16, 2013 at 08:41:45AM +0000, Jonathan Cameron wrote:
> On 16/01/13 05:49, Guenter Roeck wrote:
> >On Sat, Nov 24, 2012 at 10:18:04AM +0000, Jonathan Cameron wrote:
> >>On 11/24/2012 05:27 AM, Guenter Roeck wrote:
> >>>Hi all,
> >>Hi Guenter,
> >>>
> >>>What would it take to move the MAX1363 driver out of staging ?
> >>>
> >>Nothing given it is already out of staging in linux-next (though only has been
> >>for about a week)
> >>
> >>>Background is that I need a hardware monitoring driver for MAX1139, and would
> >>>like to avoid using a driver from staging if possible (after all, it might
> >>>go away anytime). Another option would be to submit a hwmon driver for it,
> >>>but that doesn't seem to be the best approach.
> >>
> >>The hwmon driver client driver for iio devices is still in staging, but mainly
> >>because I haven't had a chance to take a last look at it before posting it to
> >>the hmwon list. IIRC you were more or less happy with what went into staging
> >>in the first place, so hopefully not too much left to do.
> >>
> >Jonathan,
> >
> >can you educate me how to actually use iio_hwmon ? I get it loaded,
> >which registers the platform driver, but I have no idea how to instantiate it.
> >
> http://marc.info/?l=linux-iio&m=132933525705497&w=2
> 
> [PATCH 6/6] stargate2: example of map configuration for iio to hwmon
> example.
> 
Hi Jonathan,

In other words, I can not test it on a PC unless I write a driver to
instantiate it. Not too helpful :(. It means that iio drivers can not
be used / instantiated for hardware monitoring on PCs.

Thanks,
Guenter


------PRP77NSC6KHQ3QFZY5KVYDSKLYDXV8
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body><br>
Good point.  New use case for us so suggestions on how to do the association cleanly would be most welcome.  Is there anything similar out there? We could add a per iio device sysfs interface to add additional mappings but it is a little uggly...<br>
<br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.<br><br><div class="gmail_quote">Guenter Roeck &lt;linux@roeck-us.net&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style="white-space: pre-wrap; word-wrap:break-word; font-family: monospace">On Wed, Jan 16, 2013 at 08:41:45AM +0000, Jonathan Cameron wrote:<br />&gt; On 16/01/13 05:49, Guenter Roeck wrote:<br />&gt; &gt;On Sat, Nov 24, 2012 at 10:18:04AM +0000, Jonathan Cameron wrote:<br />&gt; &gt;&gt;On 11/24/2012 05:27 AM, Guenter Roeck wrote:<br />&gt; &gt;&gt;&gt;Hi all,<br />&gt; &gt;&gt;Hi Guenter,<br />&gt; &gt;&gt;&gt;<br />&gt; &gt;&gt;&gt;What would it take to move the MAX1363 driver out of staging ?<br />&gt; &gt;&gt;&gt;<br />&gt; &gt;&gt;Nothing given it is already out of staging in linux-next (though only has been<br />&gt; &gt;&gt;for about a week)<br />&gt; &gt;&gt;<br />&gt; &gt;&gt;&gt;Background is that I need a hardware monitoring driver for MAX1139, and would<br />&gt; &gt;&gt;&gt;like to avoid using a driver from staging if possible (after all, it might<br />&gt; &gt;&gt;&gt;go away anytime). Another option would be to submit a hwmon driver for it,<br />&gt;
&gt;&gt;&gt;but that doesn't seem to be the best approach.<br />&gt; &gt;&gt;<br />&gt; &gt;&gt;The hwmon driver client driver for iio devices is still in staging, but mainly<br />&gt; &gt;&gt;because I haven't had a chance to take a last look at it before posting it to<br />&gt; &gt;&gt;the hmwon list.  IIRC you were more or less happy with what went into staging<br />&gt; &gt;&gt;in the first place, so hopefully not too much left to do.<br />&gt; &gt;&gt;<br />&gt; &gt;Jonathan,<br />&gt; &gt;<br />&gt; &gt;can you educate me how to actually use iio_hwmon ? I get it loaded,<br />&gt; &gt;which registers the platform driver, but I have no idea how to instantiate it.<br />&gt; &gt;<br />&gt; <a href="http://marc.info/?l=linux-iio&amp;m=132933525705497&amp;w=2">http://marc.info/?l=linux-iio&amp;m=132933525705497&amp;w=2</a><br />&gt; <br />&gt; [PATCH 6/6] stargate2: example of map configuration for iio to hwmon<br />&gt; example.<br />&gt; <br />Hi Jonathan,<br /><br />In oth
 er
words, I can not test it on a PC unless I write a driver to<br />instantiate it. Not too helpful :(. It means that iio drivers can not<br />be used / instantiated for hardware monitoring on PCs.<br /><br />Thanks,<br />Guenter<br /></pre></blockquote></div></body></html>
------PRP77NSC6KHQ3QFZY5KVYDSKLYDXV8--
