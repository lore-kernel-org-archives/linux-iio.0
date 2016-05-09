Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37362 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbcEIV06 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 May 2016 17:26:58 -0400
In-Reply-To: <d76ecc9c-a6a9-59c9-afd9-8f0ae9eb0dff@intel.com>
References: <1462805775-7723-1-git-send-email-linus.walleij@linaro.org> <1462805775-7723-2-git-send-email-linus.walleij@linaro.org> <d76ecc9c-a6a9-59c9-afd9-8f0ae9eb0dff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/2] iio: st_sensors: read surplus samples in trigger
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 09 May 2016 22:26:51 +0100
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Message-ID: <3CDC61F5-716E-4400-82FF-CC9E89358088@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 9 May 2016 19:36:23 BST, Crestez Dan Leonard <leonard.crestez@intel.com> wrote:
>On 05/09/2016 05:56 PM, Linus Walleij wrote:
>> Leonard Crestez observed the following phenomenon: when using
>> hard interrupt triggers (the DRDY line coming out of an ST
>> sensor) sometimes a new value would arrive while reading the
>> previous value, due to latencies in the system.
>> 
>> As the interrupts from the ST sensors are a pulse, intended
>> to be read by an edge-triggered interrupt line (such as a
>> GPIO) one edge (transition from low-to-high or high-to-low)
>> will be missed while processing the current values.
>> 
>> If this happens, the state machine that triggers interrupts on
>> the DRDY line will lock waiting for the current value to be
>> read out and not fire any more interrupts. That means that
>> when we exit the interrupt handler, even though new values are
>> available from the sensor, no new interrupt will be triggered.
>> 
>> To counter this, do two things:
>> 
>> - Remove IRQF_ONESHOT so that the interrupt line is not
>>   masked while running the thread part of the interrupt.
>>   This way we will never miss an interrupt.
>> 
>> - Introduce a loop that polls the data ready
>>   registers repeatedly until no new samples are available,
>>   then exits the interrupt handler. This way we know no new
>>   values are available when the interrupt handler exits and
>>   new interrupts will be triggered when data arrives.
>>   Take some extra care to update the timestamp for the poll
>>   function if this happens. The timestamp will not be 100%
>>   perfect, but it will at least be closer to the actual
>>   events.
>> 
>> Usually the extra poll loop will handle the new samples,
>> but once in a blue moon, we get a new IRQ while exiting
>> the loop, before returning from the thread IRQ bottom half
>> with IRQ_HANDLED. On these rare occasions, the removal of
>> IRQF_ONESHOT means the interrupt will immediately fire
>> again.
>
>I also tested this and it no longer stops printing samples. Your
>explanation also looks good to me.
>
>An infinite loop in the threaded interrupt handler looks odd. Are you
>sure this is allowed? I do my tests in qemu with an usb adapter and if
>I
>run with -smp 1 it seems to be impossible to stop the irq thread.

Definitely not allowed....

Long term we need a way to throttle or fault out after first few loops.

Right now this improves situation even if we just let it happen say 10 times to ride
our slight delays...

I ideally want to fire up my board and hammer this as well, plus read it very 
carefully to see if this really closes all potential races...


J
>
>More specifically stopping the irq thread means something like:
>	echo 0 > /sys/bus/iio/devices/iio:device0/buffer/enable
>or
>	echo 10 > /sys/bus/iio/devices/iio:device0/sampling_frequency
>This seems to lockup waiting for the i2c adapter lock (but only with a
>single CPU). Perhaps because the trigger thread only sleeps while
>waiting for the i2c bus, which happens to be done while holding the i2c
>adapter lock?
>
>The simplest way to reproduce is to configure high frequency and run
>generic_buffer with a -c 100 argument. After printing 100 samples it
>will attempt to disable the buffer (by writing 0 to buffer/enable) but
>hang inside i2c.
>
>This issue might be specific to my test setup so not very interesting.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
