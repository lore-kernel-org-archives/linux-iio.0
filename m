Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55931 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758369AbcEFLbz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 6 May 2016 07:31:55 -0400
Subject: Re: [PATCH v2] iio: st_sensors: switch to a threaded interrupt
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <1462524763-24566-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <8cfaa99f-f46e-722a-a96f-9e465f6d9558@intel.com>
Date: Fri, 6 May 2016 14:32:01 +0300
MIME-Version: 1.0
In-Reply-To: <1462524763-24566-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/2016 11:52 AM, Linus Walleij wrote:
> commit 98ad8b41f58dff6b30713d7f09ae3834b8df7ded
> ("iio: st_sensors: verify interrupt event to status") caused
> a regression when reading ST sensors from a HRTimer trigger
> rather than the intrinsic interrupts: the HRTimer may
> trigger faster than the sensor provides new values, and
> as the check against new values available as a cause of
> the interrupt trigger was done in the poll function,
> this would bail out of the HRTimer interrupt with
> IRQ_NONE.
> 
> So clearly we need to only check the new values available
> from the proper interrupt handler and not from the poll
> function, which should rather just read the raw values
> from the registers, put them into the buffer and be happy.
> 
> ---
> ChangeLog v1->v2:
> - v1 was missing timestamps since nothing ever stamped them.
>   Restore the timestamps by simply using
>   iio_trigger_generic_data_rdy_poll()
>   as the top half of the threaded interrupt handler.
> 
iio_trigger_generic_data_rdy_poll always returns IRQ_HANDLED. This means
that the threaded handler is never called.

I think the correct solution would be to call the buffer's hardirq
handler from the trigger's hardirq and the buffer's threaded handler
from the trigger's threaded handler, right? I don't know how to do this
properly with iio. Having "iio_poll_func" create an irq is very strange.

Perhaps the easiest solution would be to call st_sensors_buffer_*
directly from st_sensors_trigger_* and add a validate_sensor() function
to check that this trigger is not used with some other device.

>  		/*
>  		 * If this was not caused by any channels on this sensor,
>  		 * return IRQ_NONE
>  		 */
> +		if (!indio_dev->active_scan_mask)
> +			return IRQ_NONE;

This seems odd. I'm not sure it's even possible for active_scan_mask to
be NULL, maybe you wanted to check if the mask is all-zero instead? Can
this really happen?

And if you're going to do such a check you should do it before reading
the status anyway to avoid the pointless read. It's worth minimizing bus
operations.

-- 
Regards,
Leonard
