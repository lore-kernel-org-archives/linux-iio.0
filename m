Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH 2/2] iio: st_sensors: read surplus samples in trigger
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <1462805775-7723-1-git-send-email-linus.walleij@linaro.org>
 <1462805775-7723-2-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>, Denis Ciocca <denis.ciocca@st.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <d76ecc9c-a6a9-59c9-afd9-8f0ae9eb0dff@intel.com>
Date: Mon, 9 May 2016 21:36:23 +0300
MIME-Version: 1.0
In-Reply-To: <1462805775-7723-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 05/09/2016 05:56 PM, Linus Walleij wrote:
> Leonard Crestez observed the following phenomenon: when using
> hard interrupt triggers (the DRDY line coming out of an ST
> sensor) sometimes a new value would arrive while reading the
> previous value, due to latencies in the system.
> 
> As the interrupts from the ST sensors are a pulse, intended
> to be read by an edge-triggered interrupt line (such as a
> GPIO) one edge (transition from low-to-high or high-to-low)
> will be missed while processing the current values.
> 
> If this happens, the state machine that triggers interrupts on
> the DRDY line will lock waiting for the current value to be
> read out and not fire any more interrupts. That means that
> when we exit the interrupt handler, even though new values are
> available from the sensor, no new interrupt will be triggered.
> 
> To counter this, do two things:
> 
> - Remove IRQF_ONESHOT so that the interrupt line is not
>   masked while running the thread part of the interrupt.
>   This way we will never miss an interrupt.
> 
> - Introduce a loop that polls the data ready
>   registers repeatedly until no new samples are available,
>   then exits the interrupt handler. This way we know no new
>   values are available when the interrupt handler exits and
>   new interrupts will be triggered when data arrives.
>   Take some extra care to update the timestamp for the poll
>   function if this happens. The timestamp will not be 100%
>   perfect, but it will at least be closer to the actual
>   events.
> 
> Usually the extra poll loop will handle the new samples,
> but once in a blue moon, we get a new IRQ while exiting
> the loop, before returning from the thread IRQ bottom half
> with IRQ_HANDLED. On these rare occasions, the removal of
> IRQF_ONESHOT means the interrupt will immediately fire
> again.

I also tested this and it no longer stops printing samples. Your
explanation also looks good to me.

An infinite loop in the threaded interrupt handler looks odd. Are you
sure this is allowed? I do my tests in qemu with an usb adapter and if I
run with -smp 1 it seems to be impossible to stop the irq thread.

More specifically stopping the irq thread means something like:
	echo 0 > /sys/bus/iio/devices/iio:device0/buffer/enable
or
	echo 10 > /sys/bus/iio/devices/iio:device0/sampling_frequency
This seems to lockup waiting for the i2c adapter lock (but only with a
single CPU). Perhaps because the trigger thread only sleeps while
waiting for the i2c bus, which happens to be done while holding the i2c
adapter lock?

The simplest way to reproduce is to configure high frequency and run
generic_buffer with a -c 100 argument. After printing 100 samples it
will attempt to disable the buffer (by writing 0 to buffer/enable) but
hang inside i2c.

This issue might be specific to my test setup so not very interesting.

-- 
Regards,
Leonard
