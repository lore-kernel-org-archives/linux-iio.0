Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52619 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbcL3Sem (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 13:34:42 -0500
Subject: Re: Problems with using IIO buffers
To: Matthias Klumpp <matthias@tenstral.net>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <CAKNHny-B-tyZ3GszV-DLxRKzhhCuqELUc6MsiPs=76GYghO58g@mail.gmail.com>
 <alpine.DEB.2.02.1612201144140.4422@pmeerw.net>
 <CAKNHny_yV-FV9smGfrX2wR-T7M5uCk9WWG4xNGBMXrAuwVy2ZA@mail.gmail.com>
 <alpine.DEB.2.02.1612201720550.9386@pmeerw.net>
 <CAKNHny9M4uQvk_Xg1f0JL5Ob=PzUBFi8=0G1XVwqdkhR1f4P=g@mail.gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fa3259c5-d76b-bc93-e517-054ef249a861@kernel.org>
Date: Fri, 30 Dec 2016 18:34:41 +0000
MIME-Version: 1.0
In-Reply-To: <CAKNHny9M4uQvk_Xg1f0JL5Ob=PzUBFi8=0G1XVwqdkhR1f4P=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/12/16 16:49, Matthias Klumpp wrote:
> 2016-12-20 17:30 GMT+01:00 Peter Meerwald-Stadler <pmeerw@pmeerw.net>:
>> [...]
>>
>> this is what I use (Ubuntu, Linux 4.4) and it works; maybe the trigger
>> name you use is incorrect?
>>
>> modprobe iio_trig_sysfs
>> modprobe iio_dummy (make sure CONFIG_IIO_SIMPLE_DUMMY_BUFFER is #defined)
>> cd /sys/bus/iio/devices/iio_sysfs_trigger
>> echo 123 > add_trigger
>> cd /sys/bus/iio/devices/trigger0
>> cat name # should give sysfstrig123
>> cd /sys/bus/iio/devices/iio:device0
>> echo sysfstrig123 > trigger/current_trigger
>> echo 1 > scan_elements/in_voltage0_en
>> echo 1 > buffer/enable
> 
> This works now, I think I messed up setting the trigger last time
> (selected the wrong name, stupid...).
> I now trigger the trigger via `echo 1 > trigger0/trigger_now` and try
> to read data from the character device via
> `iio_readdev /dev/iio:device0`, with the same result as described in
> the first post - refilling the buffer doesn't work and I run into a
> timeout.
> When trying this with my driver, I see that the data polling function
> is not called, and when (using the dummy driver) trying to get data
> from the /dev/iio:device0 device without using iio_readdev, I also get
> no result.
> 
> Clearly, it feels like I am missing something obvious here...

Just to check.

Triggering is per 'scan'. It's perhaps closer to the trigger on a camera
that than on an oscilloscope if that helps.

Are you firing the trigger multiple times?

It sounds like you are refilling the buffer in your driver so possibly
we are looking at different problems in the two cases?

Perhaps post an RFC of your driver for us to take a look at?

Let us know if you got this sorted. I've been rather snowed under and
out of touch for the last few weeks!

Jonathan

> 
> Regards,
>     Matthias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

