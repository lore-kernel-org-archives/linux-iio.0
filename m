Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9500 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbcFUQro (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Jun 2016 12:47:44 -0400
Subject: Re: [PATCH v7] iio: st_sensors: harden interrupt handling
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <1466429146-11652-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Crestez Dan Leonard <cdleonard@gmail.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <069994ef-467e-f403-a248-a9fa9a87891e@intel.com>
Date: Tue, 21 Jun 2016 19:47:26 +0300
MIME-Version: 1.0
In-Reply-To: <1466429146-11652-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/20/2016 04:25 PM, Linus Walleij wrote:
> Leonard Crestez observed the following phenomenon: when using
> hard interrupt triggers (the DRDY line coming out of an ST
> sensor) sometimes a new value would arrive while reading the
> previous value, due to latencies in the system.
> 
> We discovered that the ST hardware as far as can be observed
> is designed for level interrupts: the DRDY line will be held
> asserted as long as there are new values coming. The interrupt
> handler should be re-entered until we're out of values to
> handle from the sensor.
> 
> If interrupts were handled as occurring on the edges (usually
> low-to-high) new values could appear and the line be held
> asserted after that, and these values would be missed, the
> interrupt handler would also lock up as new data was
> available, but as no new edges occurs on the DRDY signal,
> nothing happens: the edge detector only detects edges.
> 
> To counter this, do the following:
> 
> - Accept interrupt lines to be flagged as level interrupts
>   using IRQF_TRIGGER_HIGH and IRQF_TRIGGER_LOW. If the line
>   is marked like this (in the device tree node or ACPI
>   table or similar) it will be utilized as a level IRQ.
>   We mark the line with IRQF_ONESHOT and mask the IRQ
>   while processing a sample, then the top half will be
>   entered again if new values are available.
> 
> - If no interrupt type is indicated from the DT/ACPI,
>   choose IRQF_TRIGGER_HIGH so the above goes into action.
> 
> - If we are flagged as using edge interrupts with
>   IRQF_TRIGGER_RISING or IRQF_TRIGGER_FALLING: remove
>   IRQF_ONESHOT so that the interrupt line is not
>   masked while running the thread part of the interrupt.
>   This way we will never miss an interrupt, then introduce
>   a loop that polls the data ready registers repeatedly
>   until no new samples are available, then exit the
>   interrupt handler. This way we know no new values are
>   available when the interrupt handler exits and
>   new (edge) interrupts will be triggered when data arrives.
>   Take some extra care to update the timestamp in the poll
>   loop if this happens. The timestamp will not be 100%
>   perfect, but it will at least be closer to the actual
>   events. Usually the extra poll loop will handle the new
>   samples, but once in a blue moon, we get a new IRQ
>   while exiting the loop, before returning from the
>   thread IRQ bottom half with IRQ_HANDLED. On these rare
>   occasions, the removal of IRQF_ONESHOT means the
>   interrupt will immediately fire again.
> 
> Tested successfully on the LIS331DL and L3G4200D by setting
> sampling frequency to 400Hz/800Hz and stressing the system:
> extra reads in the threaded interrupt handler occurs.

I tested and it seems to work great with level irqs on minnowboard.

However I still think that looping "up to 10 times" is not really a fix,
it just hides the problem. If you spin waiting for new data then you
should spin forever or until buffer is disabled some way. I think it's
better to add this patch without the loop counter.

I think the right solution would be to ensure that when the sampling
frequency is too high the timer-based trigger "transforms" into a
thread-based busy loop. For example maybe the driver could call some
sort of iio_trigger_should_stop() function which also does "schedule()"
as appropriate.

-- 
Regards,
Leonard
