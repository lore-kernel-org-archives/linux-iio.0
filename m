Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36337 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcDLFTk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2016 01:19:40 -0400
Received: by mail-io0-f169.google.com with SMTP id u185so14333318iod.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2016 22:19:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <570A6743.4090003@kernel.org>
References: <CADO9-pckFN67QpCHs3Z-vLqH9-6zrdUazgth3Xd=Q++=V8Zkyg@mail.gmail.com>
 <570A6743.4090003@kernel.org>
From: Yong Li <sdliyong@gmail.com>
Date: Tue, 12 Apr 2016 13:19:20 +0800
Message-ID: <CADO9-pdh-RuJn-sv1JmVFtVSOqULU9XCtA5GeeRJVL=VaciKOA@mail.gmail.com>
Subject: Re: How to use GPIO pin as the trigger for IIO devices?
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks Jonathan for your mail!

2016-04-10 22:46 GMT+08:00 Jonathan Cameron <jic23@kernel.org>:
> On 07/04/16 04:51, Yong Li wrote:
>>  am testing an IIO gyro sensor using kernel 4.4, currently I can use
>> the sysfs trigger as a trigger, I can read the data from
>> /dev/iio:deviceX after "echo 1 > trigger_now".
>>
>>
>> I want to use a gpio pin for the data trigger. For example, when the
>> GPIO pin 62 is low, the data will be ready.
>>
>>
>> How to connect/setup the gpio with the IIO triggers, how can I use the
>> iio_trig_interrupt.ko? I found there is new triggers in the
>> /sys/bus/iio/devices after I loaded the iio_trig_interrupt.ko.
> Hi Yong,
>
> Unfortunately a means of identifying that a given IRQ (GPIO or otherwise)
> is to be used as an iio_trigger is needed.  At the moment, that driver
> only supports getting this from an IORESOURCE_IRQ in a board file.
>
> There was a recent thread on device tree bindings for these;
> http://marc.info/?l=linux-iio&m=145621588017248&w=2
>
> It got a little non obvious from the point of view of what the bindings
> should look like and buried under other work.
>
> Still the patches there will probably get you going.
>
> Jonathan
>
>>
>> Thanks,
>> Yong
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
