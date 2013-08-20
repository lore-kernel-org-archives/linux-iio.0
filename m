Return-Path: <j.anaszewski@samsung.com>
Message-id: <52138297.9020908@samsung.com>
Date: Tue, 20 Aug 2013 16:52:07 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, linux-iio@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, s.nawrocki@samsung.com
Subject: Re: [PATCH/RFC v4 0/3] gp2ap020a00f ambient light/proximity sensor
References: <1376658684-3267-1-git-send-email-j.anaszewski@samsung.com>
 <5210ADC3.6090704@kernel.org> <521230CB.20801@samsung.com>
 <52126D3B.4010401@kernel.org>
In-reply-to: <52126D3B.4010401@kernel.org>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/19/2013 09:08 PM, Jonathan Cameron wrote:

>>>>     - I am still encountering "module in use" message when I am trying
>>>>       to execute rmmod on a driver module after generic_buffer application
>>>>       has been launched at least once. This is not specific only to my
>>>>       implementation but also for lps331ap driver (the only one of the
>>>>       remaining IIO drivers supporting triggers I am able to test
>>>>       currently).
>>> Umm.. I'm unsure, but it 'might' be something to do with the interrupt issues
>>> that are firing the above warning (though I doubt it as the lps331ap isn't
>>> suffering from that bug - as it currently stands in tree).
>>> Check that all the sysfs entries are as one would expect (no trigger attached
>>> or buffered enabled etc).  Might be a bug in generic_buffer but I haven't
>>> personally seen it do this.
>>
>> Fixing the warning didn't fix this problem. I've checked sysfs entries
>> - the buffer is not enabled, no trigger is attached. I don't know if
>> this is correct, but when I build build my driver as a module I get
>> also the module industrialio-triggered-buffer.ko built, which has to
>> be loaded prior to the driver module.
> That provides the triggered_buffer utility functions. When those are used
> it needs to be there.
>
> Unfortunately this isn't something I can chase down without the hardware.
> It works fine in the iio_dummy driver.  Could you perhaps just build that
> and check that works fine with a sysfs-trigger?  Would act to indicate
> if there is something causing the issue in this driver that we haven't spotted
> or something nasty is going on in the core.

I've managed to discover what is going on. The bad symptom is in the
information returned by lsmod. Before launching generic_buffer
application the "Used by" column for the driver module is 0.
After the application finishes it is 0x7fffffff.
I figured out that the problem is in the function
iio_trigger_write_current (industrialio-trigger.c:371).

If I comment lines:

if (oldtrig && indio_dev->trig != oldtrig)
	iio_trigger_put(oldtrig);

the issue ceases to appear. It seems that module_put is called too many
times.

Thanks,
Jacek
