Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH 1/2] iio: st_sensors: switch to a threaded interrupt
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <1462805775-7723-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>, Denis Ciocca <denis.ciocca@st.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <c747fbdf-5fcb-d8e3-e0d7-a815af1d291d@intel.com>
Date: Mon, 9 May 2016 20:44:38 +0300
MIME-Version: 1.0
In-Reply-To: <1462805775-7723-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 05/09/2016 05:56 PM, Linus Walleij wrote:
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
> 
> Additionally: if the active scanmask is not set for the
> sensor no IRQs should be enabled and we need to bail out
> with IRQ_NONE. This can happen if spurious IRQs fire when
> installing the threaded interrupt handler.
> 
> Tested with hard interrupt triggers on LIS331DL, then also
> tested with hrtimers on the same sensor by creating a 75Hz
> HRTimer and using it to poll the sensor.
> 
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Crestez Dan Leonard <cdleonard@gmail.com>
> Reported-by: Crestez Dan Leonard <cdleonard@gmail.com>
> Fixes: 97865fe41322 ("iio: st_sensors: verify interrupt event to status")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v4->v5:
> - Move the setting of hw_irq_enabled to before the register
>   write to enable interrupts so we avoid a race where this
>   variable could be read in its previous state.
> - NOTE: this patch is a regression fix and can be applied
>   without 2/2.
> - Leonard can you verify that this patch fixes your issue
>   with HRTimer-triggered reads and provide your Tested-by?

Tested-by: Crestez Dan Leonard <leonard.crestez@intel.com>

> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +	/* If we do timetamping here, do it before reading the values */
> +	if (sdata->hw_irq_trigger)
> +		timestamp = sdata->hw_timestamp;
> +	else
> +		timestamp = iio_get_time_ns();

This ignores pf->timestamp so passing iio_pollfunc_store_time no longer
has any effect, right? I think this is actually a good thing. When using
software triggers it is best to get the timestamp as close to the actual
read as possible. Relying on iio_pollfunc_store_time would just add the
noisy delay between hrtimer interrupts and process context to iio
timestamps.

But it would now make sense to pass NULL instead of
iio_pollfunc_store_time to all the iio_triggered_buffer_setup calls in
st_sensors, right?

It's also a bit strange that the buffer irq_handler is no longer called.
Maybe this needs validate_device in trigger_ops?

> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +	/*
> +	 * If this trigger is backed by a hardware interrupt and we have a
> +	 * status register, check if this IRQ came from us
> +	 */
> +	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
> +		u8 status;
> +
> +		ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> +			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
> +			   &status);
> +		if (ret < 0) {
> +			dev_err(sdata->dev, "could not read channel status\n");
> +			goto out_poll;
> +		}
> +
> +		/*
> +		 * If this was not caused by any channels on this sensor,
> +		 * return IRQ_NONE
> +		 */
> +		if (!indio_dev->active_scan_mask)
> +			return IRQ_NONE;
> +		if (!(status & (u8)indio_dev->active_scan_mask[0]))
> +			return IRQ_NONE;

It's not clear that this belongs here. The check is not related to
sdata->sensor_settings->drdy_irq.addr_stat_drdy. It could be done before
checking the status register or even in the hardirq handler.

It seems to me that placing this check here would result in a bunch of
useless bus transactions.

-- 
Regards,
Leonard
