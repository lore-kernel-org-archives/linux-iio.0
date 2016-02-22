Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33835 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbcBVHnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Feb 2016 02:43:52 -0500
Received: by mail-pa0-f52.google.com with SMTP id fy10so86801802pac.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Feb 2016 23:43:52 -0800 (PST)
Received: from [10.100.116.101] (ip174-68-100-216.sd.sd.cox.net. [174.68.100.216])
        by smtp.gmail.com with ESMTPSA id xu1sm34586088pab.31.2016.02.21.23.43.51
        for <linux-iio@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Feb 2016 23:43:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: iio_simple_dummy_buffer_dma
From: John Syne <john3909@gmail.com>
In-Reply-To: <01799BDD-FEC7-4A8C-9CDE-FCF6940E8F25@gmail.com>
Date: Sun, 21 Feb 2016 23:43:50 -0800
Message-Id: <3D719580-A43E-4BBC-9DD1-E0849944BD17@gmail.com>
References: <C78F84F2-A2D5-40B2-9291-F27FA95C8F52@gmail.com> <8CFE0549-CA65-4163-917D-5BF55DCC0E4A@gmail.com> <AD4F55AE-891A-4334-9E75-49153C7CD93E@gmail.com> <01799BDD-FEC7-4A8C-9CDE-FCF6940E8F25@gmail.com>
To: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I apologize for the noise. I was right the first time. It is iio_simple_dummy_buffer_dma.c that isn’t getting called, but I guess that should be done in the iio_simple_dummy.c probe function. Is that correct?

Regards,
John




> On Feb 21, 2016, at 11:34 PM, John Syne <john3909@gmail.com> wrote:
> 
> Sorry, that should be “iio_simple_dummy_configure_buffer” isn’t called.
> 
> Regards,
> John
> 
> 
> 
> 
>> On Feb 21, 2016, at 8:57 PM, John Syne <john3909@gmail.com> wrote:
>> 
>> Seems like “iio_simple_dummy_configure_buffer_dma" never gets called and that is why the demo doesn’t work.
>> 
>> Regards,
>> John
>> 
>> 
>> 
>> 
>>> On Feb 21, 2016, at 8:51 PM, John Syne <john3909@gmail.com> wrote:
>>> 
>>> BTW, I seem to remember that Lars removed iio_simple_dummy_buffer_dma.c in his V3 patch so this won’t be in the IIO repo, but I don’t know how to test the IIO DMA framework without this file.
>>> 
>>> Regards,
>>> John
>>> 
>>> 
>>> 
>>> 
>>>> On Feb 21, 2016, at 8:41 PM, John Syne <john3909@gmail.com> wrote:
>>>> 
>>>> Hi,
>>>> 
>>>> I am interested in using the IIO DMA framework and tried to use your dummy driver. 
>>>> 
>>>> I attempting to get the iio_dummy working with dma and seem to be having sum difficulty.
>>>> 
>>>> Here is what I have done so far:
>>>> 
>>>> I’m working on a BeagleBoneBlack running a 4.1 Linux Kernel. I have back ported the latest IIO code from git://git.kernel.org/pub/scm/linux/kernel/git/jic23
>>>> 
>>>> As a test I tried ti_am335x_adc.ko and enabled in_voltage0_en and then enabled the buffer. Reading from /dev/iio:device0 provided the waveform of the signal generator I had connected to ADC0 on the board. I was even able to run iiod and then connected IIO Oscilloscope which showed the same waveform. I did get a message WARNING: High-speed mode not enabled, but I guess there is no mmap in the driver and that is probably the issue.
>>>> 
>>>> In linux config, I have enabled the following:
>>>> CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>>>> CONFIG_IIO_SIMPLE_DUMMY_BUFFER
>>>> CONFIG_IIO_SIMPLE_DUMMY_BUFFER_DMA
>>>> CONFIG_IIO_BUFFER_CB
>>>> CONFIG_IIO_BUFFER_DMA
>>>> CONFIG_IIO_BUFFER_DMAENGINE
>>>> CONFIG_IIO_KFIFO_BUF
>>>> CONFIG_IIO_TRIGGERED_BUFFER
>>>> CONFIG_IIO_TRIGGER
>>>> CONFIG_IIO_CONSUMERS_PER_TRIGGER 2
>>>> 
>>>> When I "modprobe iio_dummy”, the following modules are loaded:
>>>> 
>>>> industrialio
>>>> industrialio_buffer_dma
>>>> iio_dummy
>>>> kfifo_buf
>>>> iio_dummy_evgen
>>>> 
>>>> I then modprobe iio_trig_sysfs which gives me /sys/bus/iio/device/iio_sysfs_trigger. To create a trigger I did:
>>>> 
>>>>> echo 1 > /sys/bus/iio/device/iio_sysfs_trigger/add_trigger
>>>>> cat name /sys/bus/iio/device/trigger0/name
>>>>> sysfstrig1
>>>>> echo sysfstrig1 > /sys/bus/iio/device/iio:device0/trigger/current_trigger
>>>> 
>>>> Now to enable a measurement:
>>>> 
>>>>> echo 1 > /sys/bus/iio/device/iio:device0/scan_elements/in_voltage0_en
>>>> 
>>>> Finally to enable the buffer:
>>>> 
>>>>> echo 1 /sys/bus/iio/device/iio:device0/buffer/enable
>>>> 
>>>> When I read "/dev/iio:device0" I get nothing. Connecting IIO Oscilloscope I get the following error message:
>>>> 
>>>> WARNING: High-speed mode not enabled
>>>> ERROR: Reading from device failed: -110
>>>> Client Exited
>>>> 
>>>> In iio_simple_dummy_buffer_dma.c, I see iio_dummy_dma_source which generates a rect, sine, tri and saw waveforms. Not sure what I need to do to get these waveforms to generate. Is this demo functional?
>>>> 
>>>> 
>>>> Regards,
>>>> John
>>>> 
>>>> 
>>>> 
>>>> 
>>> 
>> 
> 

