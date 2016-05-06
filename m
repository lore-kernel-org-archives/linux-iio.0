Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33924 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758463AbcEFSIZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 6 May 2016 14:08:25 -0400
Subject: Re: [PATCH v3] iio: st_sensors: switch to a threaded interrupt
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <1462535191-21131-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <dc142147-fffe-19ad-5c74-239ab85040b7@intel.com>
Date: Fri, 6 May 2016 21:08:20 +0300
MIME-Version: 1.0
In-Reply-To: <1462535191-21131-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/2016 02:46 PM, Linus Walleij wrote:
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
> To achieve this: switch the ST Sensors over to using a true
> threaded interrupt handler.
> 
> In the interrupt thread, check if new values are available,
> else yield to the (potential) next device on the same
> interrupt line to check the registers. If the interrupt
> was ours, proceed to poll the values.
> 
> Instead of relying on iio_trigger_generic_data_rdy_poll() as
> a top half to wake up the thread that polls the sensor for
> new data, have the thread call iio_trigger_poll_chained()
> after determining that is is the proper source of the
> interrupt. This is modelled on drivers/iio/accel/mma8452.c
> which is already using a properly threaded interrupt handler.
> 
> In order to get the same precision in timestamps as
> previously, where samples would be timestamped in the
> poll function pf->timestamp when calling
> iio_trigger_generic_data_rdy_poll() we introduce a
> local timestamp in the sensor data, set it in the top half
> (fastpath) of the interrupt handler and provide that to the
> core when calling iio_push_to_buffers_with_timestamp().

This doesn't work correctly with software timers. sdata->timestamp won't
update because st_sensors_irq_handler doesn't get called in this mode.

Easiest fix would be to set pollfunc->timestamp in
st_sensors_irq_handler. But I don't really know how this is supposed to
work.

-- 
Regards,
Leonard
