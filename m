Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45062 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbaHYQCf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 12:02:35 -0400
Message-ID: <53FB5E18.9060206@kernel.org>
Date: Mon, 25 Aug 2014 17:02:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sricharan Chalasani <sricharan.chalasani@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: help regarding Hardware Triggers in IIO ADC Driver
References: <CABLc4a_LCCD9xzMSyg3AyKw4bM3Cj2ek7oGCptRrJWF9LC-kZA@mail.gmail.com>	<53F65FD6.1080709@kernel.org> <CABLc4a8M=XEH7sH2eC4gL1mkzinBBRpJA=pxMZYSn2zN-KOZGw@mail.gmail.com>
In-Reply-To: <CABLc4a8M=XEH7sH2eC4gL1mkzinBBRpJA=pxMZYSn2zN-KOZGw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/08/14 09:08, Sricharan Chalasani wrote:
> Hi Jonathan and all,
> 
> I am really thankful to you for your quick responses. It really helps
> me a lot to quckly understand how IIO works. Many thanks in advance
> again.
> 
> This is in continuation to my previous email and your valuable
> response, I have decided to use IIO RTC Trigger as a trigger provider
> and write my own Generic ADC driver. Before start writing my own
> Generic Driver, may I request your help to better understand how a
> Trigger really works.
> 
> As an experiment, I will make use of IIO RTC Trigger
> (staging/iio/trigger) as Trigger provider to Trigger Simple Dummy IIO
> Driver (staging/iio).
> 
> Assuming that I have 2 channels on my ADC. Following is my basic
> understanding of how an RTC Trigger works.
> 
> (After loading both IIO RTC Trigger driver and Simple Dummy IIO Driver)
> 
> Set up periodic RTC trigger frequency
> 
> #echo 1000 > /sys/devices/trigger0/frequency
> 
> Set up the channels in use
> 
> # echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage0_en
> # echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage1_en
> 
> Set up the trigger we want to use (it must be the name of one of the
> triggers present in iio/devices) (assuming that the rtc trigger name -
> my_rtc_trig0)
> 
> # echo "my_rtc_trig0" > /sys/bus/iio/devices/iio:device0/trigger/current_trigger
> 
> Set up the buffer length (Maximum number of data kept in the buffer,
> if we reach this number, the older data will be dropped)
> 
> # echo 100 > /sys/bus/iio/devices/iio:device0/buffer/length
> 
> Enable the capture
> 
> # echo 1 > /sys/bus/iio/devices/iio:device0/buffer/enable
> 
> With the above configuration, I understand that whenever the RTC
> Periodic Interrupt is generated, the periodic RTC interrupt handler
> (ISR) in-turn invokes my Simple Dummy Trigger Handler
> (iio_simple_dummy_trigger_h). My Simple dummy trigger handler is
> invoked (iio_simple_dummy_trigger_h) periodically with the help of RTC
> periodic interrupt. I will copy data corresponding to all the enabled
> channels (fake data in this case) to ring buffer from the function
> iio_simple_dummy_trigger_h periodically.
A small point - it's a fifo not a ring buffer, but otherwise fine
(used to be a ring buffer, but no one really cared about that so
we switched over the a fifo using the kfifo infrastructure.)
> 
> Please correct me if my understanding of how a periodic RTC Trigger
> really Triggers an IIO device to copy data to ring buffer
> periodically, is wrong ......
All correct as far as I can see.

J
> 
> 
> Thanks in advance,
> 
> Sricharan.
> 
> 
> 
> 
> 
> 
> 
> On Fri, Aug 22, 2014 at 2:38 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 20/08/14 19:19, Sricharan Chalasani wrote:
>>> Hi Mr. Jonathan,
>> Hi Sricharan,
>>
>> It is almost always best to address questions like this to the relevant mailing list
>> (find that out from MAINTAINERS in the root of the kernel source tree).  In this
>> case linux-iio.  If nothing else, others on there tend to respond faster than I do
>> and it is useful to have discussions such as this available in the archives to
>> refer to later.
>>>
>>> My name is Sricharan. I am from Pune, South India. I know it is not correct to directly write to you. But I request you
>>> to please help me in this regard.
>>>
>>> I tried a lot to undersatand whether my following approach really satisfy the principles of IIO Subsystem, but feel like
>>> I am missing something in properly understanding my Subsystem properly.
>>>
>>> In the existing IIO drivers (linux-3.16), my understanding is that Hardware Triggers are just used to copy sampled data
>>> from the ADC to the Kernel buffer. I think none of the hardware triggers are really configuring ADC to Start the analog
>>> to digital conversion.
>> Actually quite a few hardware triggers can be used in this fashion, though often in the case
>> of Data Ready type interrupts they can be used to trigger 'other' devices.
>> Also we have a number of standalone triggers. The most relevant are still to be
>> found in drivers/staging/iio/triggers (rtc and blackfin timers triggers).  They
>> are there because we actually intend to drop them once we have a better means of
>> configuring the high resolution timer based trigger that has been posted to the
>> lists a few times.  The jitter on that trigger is actually very low reducing the
>> point of using hardware counters and now high resolution timers are nearly always
>> available.
>>>
>>> I have a Hardware Counter on my Board. I am planning to configure my Counter overflow interrupt as an IIO Hardware
>>> Trigger.
>> This is pretty much a periodic rtc interrupt (note these are now all emulated via high
>> res timers in the rtc system but they used to do it exactly the way you describe!)
>>
>>> In my IIO ADC driver probe function I am planning to start my Counter for the first time. Once the counter
>>> overflow interrupted is generated, inside the counter ISR, I am planning to configure ADC to start analog to digital
>>> conversion on all the channels (4 of them), one sample on each channel and once the Conversion is completed, I am
>>> planning to copy the Sampled data to Kernel buffer associated with the Trigger.
>> This is fine and is how pretty much all the buffer supporting drivers that don't
>> supply a trigger (no fixed internal sampling rate typically) do it.
>> A simple example would be something like drivers/iio/max1363 though in that conversions
>> are clocked directly from the i2c bus so 'appear' instantaneous.
>>
>> If you have an interrupt to indicate the end of the conversion, then the normal trick is
>> to use a completion to basically sleep the trigger handler (which is in a thread) until
>> the data is ready.  Lots of drivers do this as well.
>>
>>>
>>> I will program the Counter again and wait for interrupt and repeat the steps above. I am planning to continue this
>>> approach indefinitely.
>> Hmm.  If you actually have to reprogram the counter rather than it being periodic you 'might'
>> have a small amount of drift if you are not careful...
>>>
>>> Does this approach satisfy the principles of IIO Subsystem ? Am I missing anything here in understanding the IIO
>>> Subsystem properly ?
>> This is fine.  Note however that what you describe is best implemented as two drivers.
>> One is a generic adc driver which uses the trigger and the second is a trigger provider.
>>
>> J
>>>
>>> Thanks in advance,
>>>
>>> Sricharan,
>>> Pune (India).
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
