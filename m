Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39344 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab3HTRGL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2013 13:06:11 -0400
In-Reply-To: <52138297.9020908@samsung.com>
References: <1376658684-3267-1-git-send-email-j.anaszewski@samsung.com> <5210ADC3.6090704@kernel.org> <521230CB.20801@samsung.com> <52126D3B.4010401@kernel.org> <52138297.9020908@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH/RFC v4 0/3] gp2ap020a00f ambient light/proximity sensor
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 20 Aug 2013 17:09:32 +0100
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>,
	s.nawrocki@samsung.com
Message-ID: <54d98ce2-780d-4100-9f0a-0f5cf81bab2d@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Jacek Anaszewski <j.anaszewski@samsung.com> wrote:
>On 08/19/2013 09:08 PM, Jonathan Cameron wrote:
>
>>>>>     - I am still encountering "module in use" message when I am
>trying
>>>>>       to execute rmmod on a driver module after generic_buffer
>application
>>>>>       has been launched at least once. This is not specific only
>to my
>>>>>       implementation but also for lps331ap driver (the only one of
>the
>>>>>       remaining IIO drivers supporting triggers I am able to test
>>>>>       currently).
>>>> Umm.. I'm unsure, but it 'might' be something to do with the
>interrupt issues
>>>> that are firing the above warning (though I doubt it as the
>lps331ap isn't
>>>> suffering from that bug - as it currently stands in tree).
>>>> Check that all the sysfs entries are as one would expect (no
>trigger attached
>>>> or buffered enabled etc).  Might be a bug in generic_buffer but I
>haven't
>>>> personally seen it do this.
>>>
>>> Fixing the warning didn't fix this problem. I've checked sysfs
>entries
>>> - the buffer is not enabled, no trigger is attached. I don't know if
>>> this is correct, but when I build build my driver as a module I get
>>> also the module industrialio-triggered-buffer.ko built, which has to
>>> be loaded prior to the driver module.
>> That provides the triggered_buffer utility functions. When those are
>used
>> it needs to be there.
>>
>> Unfortunately this isn't something I can chase down without the
>hardware.
>> It works fine in the iio_dummy driver.  Could you perhaps just build
>that
>> and check that works fine with a sysfs-trigger?  Would act to
>indicate
>> if there is something causing the issue in this driver that we
>haven't spotted
>> or something nasty is going on in the core.
>
>I've managed to discover what is going on. The bad symptom is in the
>information returned by lsmod. Before launching generic_buffer
>application the "Used by" column for the driver module is 0.
>After the application finishes it is 0x7fffffff.
>I figured out that the problem is in the function
>iio_trigger_write_current (industrialio-trigger.c:371).
>
>If I comment lines:
>
>if (oldtrig && indio_dev->trig != oldtrig)
>	iio_trigger_put(oldtrig);
>
>the issue ceases to appear. It seems that module_put is called too many
>times.
Thanks. Will look into this... 
>
>Thanks,
>Jacek
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
