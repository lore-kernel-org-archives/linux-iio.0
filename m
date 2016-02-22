Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-245.synserver.de ([212.40.185.245]:1242 "EHLO
	smtp-out-244.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751374AbcBWM3X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2016 07:29:23 -0500
Subject: Re: iio_simple_dummy_buffer_dma
To: John Syne <john3909@gmail.com>
References: <C78F84F2-A2D5-40B2-9291-F27FA95C8F52@gmail.com>
 <8CFE0549-CA65-4163-917D-5BF55DCC0E4A@gmail.com>
 <56CAF486.4060505@metafoo.de>
 <5343A235-F2C0-46B0-A0E1-853F3BC5F27D@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56CB4602.6060809@metafoo.de>
Date: Mon, 22 Feb 2016 18:31:46 +0100
MIME-Version: 1.0
In-Reply-To: <5343A235-F2C0-46B0-A0E1-853F3BC5F27D@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/22/2016 06:25 PM, John Syne wrote:
> Hi Lars,
> 
> It seems like there are other config selections that are selecting KFIFO so it seems to be enabled always. I can enable DMA buffer, but I will see how to disable KFIFO. When I get this working, should I see a waveform in IIO Oscilloscope?

Hi,

There is one for the dummy buffer.

IIO_SIMPLE_DUMMY_BUFFER_DMA needs to be set and
IIO_SIMPLE_DUMMY_BUFFER_KFIFO needs to be unset.

- Lars


> 
> Regards,
> John
> 
> 
> 
> 
>> On Feb 22, 2016, at 3:44 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>> On 02/22/2016 05:51 AM, John Syne wrote:
>>> BTW, I seem to remember that Lars removed iio_simple_dummy_buffer_dma.c in his V3 patch so this won’t be in the IIO repo, but I don’t know how to test the IIO DMA framework without this file.
>>>
>>
>> Hi,
>>
>> The patch was dropped for now to avoid conflicts with other ongoing work on
>> the dummy driver. The patch will come back in a slightly overhauled version
>> soonish.
>>
>> As for your problem, make sure that you have the part of the patch which
>> updates things so you can choose in Kconfig whether you want to use the DMA
>> buffer or the KFIFO buffer. And then select the DMA buffer in your .config.
>>
>> - Lars
>>
>>
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
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

