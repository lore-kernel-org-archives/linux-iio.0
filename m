Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46336 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbcFZKor (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 06:44:47 -0400
Subject: Re: [PATCH v8] iio: st_sensors: harden interrupt handling
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
References: <1466583905-13199-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cb094a04-00c1-489c-96b7-4e93708be808@kernel.org>
Date: Sun, 26 Jun 2016 11:44:45 +0100
MIME-Version: 1.0
In-Reply-To: <1466583905-13199-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/06/16 09:25, Linus Walleij wrote:
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
This element is the tricky one. Previous default was (incorrectly)
IRQF_RISING so any boards relying on that will be broken.

The problem here will be ancient boards with either wrong
device tree bindings or none at all.  See stargate2.c

Clearly I can fix that one, but we still may get nasty
surprises elsewhere.  Also fixing that will mean adding
platform data which we haven't previously had...

Is it that painful to stick to a rising default?

Jonathan

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
> 
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Tested-by: Crestez Dan Leonard <cdleonard@gmail.com>
> Reported-by: Crestez Dan Leonard <cdleonard@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v7->v8:
> - Remove the 10 times iteration loop: instead allow the thread
>   to turn into a polling loop when there is always new data
>   available.
> - To stop the thread from going into an eternal loop: make it
>   respect sdata->hw_irq_enabled: if the interrupt is disabled,
>   we bail out of the loop.
> ChangeLog v6->v7:
> - Incorporate Leonards handling of level interrupts into
>   the code. If we have level IRQs: use them.
> - Default to level interrupt handling.
> - If we only have edge interrupts: enable the polling loop.
> - Leonard it would be awesome if you could test this patch,
>   maybe both with level and edge irqs on your system? I
>   could only test the edges.
> ChangeLog v5->v6:
> - Add a loop counter to the threaded value poll function: let's
>   just loop here for at maximum 10 loops before we exit and
>   let the thread re-trigger if more interrupts arrived.
> ChangeLog v4->v5:
> - Remove the IRQF_ONESHOT flag from the interrupt: this makes
>   it possible to trigger the top half of the interrupt even
>   though the bottom half is processing an earlier interrupt.
>   This makes it possible to gracefully handle interrupts that
>   come in during sensor reading.
> - Add better descriptive comments.
> ChangeLog v3->v4:
> - Include this patch with the threaded interrupt fix patch.
>   Adapte the same patch numbering system.
> 
> If this works I suggest it be applied to mainline as a fix on
> top of the threading patch version 3, so we handle this annoying
> lockup bug.
> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c  |   7 +-
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 158 +++++++++++++++------
>  include/linux/iio/common/st_sensors.h              |   2 +
>  3 files changed, 119 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index f1693dbebb8a..f6873919f188 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -59,7 +59,12 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	s64 timestamp;
>  
> -	/* If we do timetamping here, do it before reading the values */
> +	/*
> +	 * If we do timetamping here, do it before reading the values, because
> +	 * once we've read the values, new interrupts can occur (when using
> +	 * the hardware trigger) and the hw_timestamp may get updated.
> +	 * By storing it in a local variable first, we are safe.
> +	 */
>  	if (sdata->hw_irq_trigger)
>  		timestamp = sdata->hw_timestamp;
>  	else
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 296e4ff19ae8..88a7805eda7a 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -18,6 +18,50 @@
>  #include "st_sensors_core.h"
>  
>  /**
> + * st_sensors_new_samples_available() - check if more samples came in
> + * returns:
> + * 0 - no new samples available
> + * 1 - new samples available
> + * negative - error or unknown
> + */
> +static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
> +					    struct st_sensor_data *sdata)
> +{
> +	u8 status;
> +	int ret;
> +
> +	/* How would I know if I can't check it? */
> +	if (!sdata->sensor_settings->drdy_irq.addr_stat_drdy)
> +		return -EINVAL;
> +
> +	/* No scan mask, no interrupt */
> +	if (!indio_dev->active_scan_mask)
> +		return 0;
> +
> +	ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> +			sdata->sensor_settings->drdy_irq.addr_stat_drdy,
> +			&status);
> +	if (ret < 0) {
> +		dev_err(sdata->dev,
> +			"error checking samples available\n");
> +		return ret;
> +	}
> +	/*
> +	 * the lower bits of .active_scan_mask[0] is directly mapped
> +	 * to the channels on the sensor: either bit 0 for
> +	 * one-dimensional sensors, or e.g. x,y,z for accelerometers,
> +	 * gyroscopes or magnetometers. No sensor use more than 3
> +	 * channels, so cut the other status bits here.
> +	 */
> +	status &= 0x07;
> +
> +	if (status & (u8)indio_dev->active_scan_mask[0])
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/**
>   * st_sensors_irq_handler() - top half of the IRQ-based triggers
>   * @irq: irq number
>   * @p: private handler data
> @@ -43,44 +87,43 @@ irqreturn_t st_sensors_irq_thread(int irq, void *p)
>  	struct iio_trigger *trig = p;
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -	int ret;
>  
>  	/*
>  	 * If this trigger is backed by a hardware interrupt and we have a
> -	 * status register, check if this IRQ came from us
> +	 * status register, check if this IRQ came from us. Notice that
> +	 * we will process also if st_sensors_new_samples_available()
> +	 * returns negative: if we can't check status, then poll
> +	 * unconditionally.
>  	 */
> -	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
> -		u8 status;
> -
> -		ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> -			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
> -			   &status);
> -		if (ret < 0) {
> -			dev_err(sdata->dev, "could not read channel status\n");
> -			goto out_poll;
> -		}
> -		/*
> -		 * the lower bits of .active_scan_mask[0] is directly mapped
> -		 * to the channels on the sensor: either bit 0 for
> -		 * one-dimensional sensors, or e.g. x,y,z for accelerometers,
> -		 * gyroscopes or magnetometers. No sensor use more than 3
> -		 * channels, so cut the other status bits here.
> -		 */
> -		status &= 0x07;
> +	if (sdata->hw_irq_trigger &&
> +	    st_sensors_new_samples_available(indio_dev, sdata)) {
> +		iio_trigger_poll_chained(p);
> +	} else {
> +		dev_dbg(sdata->dev, "spurious IRQ\n");
> +		return IRQ_NONE;
> +	}
>  
> -		/*
> -		 * If this was not caused by any channels on this sensor,
> -		 * return IRQ_NONE
> -		 */
> -		if (!indio_dev->active_scan_mask)
> -			return IRQ_NONE;
> -		if (!(status & (u8)indio_dev->active_scan_mask[0]))
> -			return IRQ_NONE;
> +	/*
> +	 * If we have proper level IRQs the handler will be re-entered if
> +	 * the line is still active, so return here and come back in through
> +	 * the top half if need be.
> +	 */
> +	if (!sdata->edge_irq)
> +		return IRQ_HANDLED;
> +
> +	/*
> +	 * If we are using egde IRQs, new samples arrived while processing
> +	 * the IRQ and those may be missed unless we pick them here, so poll
> +	 * again. If the sensor delivery frequency is very high, this thread
> +	 * turns into a polled loop handler.
> +	 */
> +	while (sdata->hw_irq_trigger &&
> +	       st_sensors_new_samples_available(indio_dev, sdata)) {
> +		dev_dbg(sdata->dev, "more samples came in during polling\n");
> +		sdata->hw_timestamp = iio_get_time_ns();
> +		iio_trigger_poll_chained(p);
>  	}
>  
> -out_poll:
> -	/* It's our IRQ: proceed to handle the register polling */
> -	iio_trigger_poll_chained(p);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -107,13 +150,18 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	 * If the IRQ is triggered on falling edge, we need to mark the
>  	 * interrupt as active low, if the hardware supports this.
>  	 */
> -	if (irq_trig == IRQF_TRIGGER_FALLING) {
> +	switch(irq_trig) {
> +	case IRQF_TRIGGER_FALLING:
> +	case IRQF_TRIGGER_LOW:
>  		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
>  			dev_err(&indio_dev->dev,
> -				"falling edge specified for IRQ but hardware "
> -				"only support rising edge, will request "
> -				"rising edge\n");
> -			irq_trig = IRQF_TRIGGER_RISING;
> +				"falling/low specified for IRQ "
> +				"but hardware only support rising/high: "
> +				"will request rising/high\n");
> +			if (irq_trig == IRQF_TRIGGER_FALLING)
> +				irq_trig = IRQF_TRIGGER_RISING;
> +			if (irq_trig == IRQF_TRIGGER_LOW)
> +				irq_trig = IRQF_TRIGGER_HIGH;
>  		} else {
>  			/* Set up INT active low i.e. falling edge */
>  			err = st_sensors_write_data_with_mask(indio_dev,
> @@ -122,20 +170,39 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  			if (err < 0)
>  				goto iio_trigger_free;
>  			dev_info(&indio_dev->dev,
> -				 "interrupts on the falling edge\n");
> +				 "interrupts on the falling edge or "
> +				 "active low level\n");
>  		}
> -	} else if (irq_trig == IRQF_TRIGGER_RISING) {
> +		break;
> +	case IRQF_TRIGGER_RISING:
>  		dev_info(&indio_dev->dev,
>  			 "interrupts on the rising edge\n");
> -
> -	} else {
> +		break;
> +	case IRQF_TRIGGER_HIGH:
> +		dev_info(&indio_dev->dev,
> +			 "interrupts active high level\n");
> +		break;
> +	default:
> +		/* This is the most preferred mode, if possible */
>  		dev_err(&indio_dev->dev,
> -		"unsupported IRQ trigger specified (%lx), only "
> -			"rising and falling edges supported, enforce "
> -			"rising edge\n", irq_trig);
> -		irq_trig = IRQF_TRIGGER_RISING;
> +			"unsupported IRQ trigger specified (%lx), enforce "
> +			"active high\n", irq_trig);
> +		irq_trig = IRQF_TRIGGER_HIGH;
>  	}
>  
> +	/* Tell the interrupt handler that we're dealing with edges */
> +	if (irq_trig == IRQF_TRIGGER_FALLING ||
> +	    irq_trig == IRQF_TRIGGER_RISING)
> +		sdata->edge_irq = true;
> +	else
> +		/*
> +		 * If we're not using edges (i.e. level interrupts) we
> +		 * just mask off the IRQ, handle one interrupt, then
> +		 * if the line is still low, we return to the
> +		 * interrupt handler top half again and start over.
> +		 */
> +		irq_trig |= IRQF_ONESHOT;
> +
>  	/*
>  	 * If the interrupt pin is Open Drain, by definition this
>  	 * means that the interrupt line may be shared with other
> @@ -148,9 +215,6 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	    sdata->sensor_settings->drdy_irq.addr_stat_drdy)
>  		irq_trig |= IRQF_SHARED;
>  
> -	/* Let's create an interrupt thread masking the hard IRQ here */
> -	irq_trig |= IRQF_ONESHOT;
> -
>  	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
>  			st_sensors_irq_handler,
>  			st_sensors_irq_thread,
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 99403b19092f..c9efe0f809e5 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -223,6 +223,7 @@ struct st_sensor_settings {
>   * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
>   * @tf: Transfer function structure used by I/O operations.
>   * @tb: Transfer buffers and mutex used by I/O operations.
> + * @edge_irq: the IRQ triggers on edges and need special handling.
>   * @hw_irq_trigger: if we're using the hardware interrupt on the sensor.
>   * @hw_timestamp: Latest timestamp from the interrupt handler, when in use.
>   */
> @@ -250,6 +251,7 @@ struct st_sensor_data {
>  	const struct st_sensor_transfer_function *tf;
>  	struct st_sensor_transfer_buffer tb;
>  
> +	bool edge_irq;
>  	bool hw_irq_trigger;
>  	s64 hw_timestamp;
>  };
> 

