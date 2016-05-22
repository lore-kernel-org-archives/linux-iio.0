Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52455 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbcEVT7H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 15:59:07 -0400
Subject: Re: [PATCH 1/2 v7] iio: st_sensors: switch to a threaded interrupt
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
References: <1463856196-26894-1-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3b75075d-cc7a-415c-e056-38af31e37539@kernel.org>
Date: Sun, 22 May 2016 20:59:04 +0100
MIME-Version: 1.0
In-Reply-To: <1463856196-26894-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/05/16 19:43, Linus Walleij wrote:
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
> Reported-by: Crestez Dan Leonard <cdleonard@gmail.com>
> Tested-by: Crestez Dan Leonard <cdleonard@gmail.com>
> Fixes: 97865fe41322 ("iio: st_sensors: verify interrupt event to status")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
I've tested this as well now.  Will let it sit for a few more days
as it won't make any difference until rc1 is out and may give
Denis / Giuseppe a chance to check it as well.

Works nicely.

Jonathan
> ---
> ChangeLog v6->v7:
> - Cut the higher bits of the status word explicitly and do not
>   assume it to be masked by the .active_scan_mask[0].
> - NOTE: this patch is a regression fix and can be applied
>   without 2/2. Hopefully this can go into v4.7-rc:s now.
> ChangeLog v5->v6:
> - Set the triggered buffer top half IRQ handler to NULL in all
>   subdrivers (accelerometer, gyro, magnetometer, pressure) as
>   we now use the iio_trigger_poll_chained() call.
> - Add st_sensors_validate_device() to the intrinsic triggers
>   and set as .validate_deice() for all subdrivers. Its purpose
>   is to check that the trigger is indeed provided by this
>   device before we use it.
> ChangeLog v4->v5:
> - Move the setting of hw_irq_enabled to before the register
>   write to enable interrupts so we avoid a race where this
>   variable could be read in its previous state.
> ChangeLog v3->v4:
> - v3 would not timestamp properly when using a HRTimer to read
>   values from the sensors. This is now fixed.
> - Add a flag to the sensor data indicating whether the hardware
>   interrupt trigger is in use. If this is the case, we use that
>   timestamp. If the hardware trigger is not in use, we just let
>   the poll function read the current time before proceeding to
>   grab the values from the sensor.
> - Move interrupt top/bottom halves to st_sensors_trigger.c so the
>   interrupt code is kept together and easier to understand in
>   context.
> ChangeLog v2->v3:
> - v2 was a total disaster, as iio_trigger_generic_data_rdy_poll()
>   would just call the old bottom half and return IRQ_HANDLED.
>   handle the timestamp locally in the sensor data and restore
>   the usage of the local interrupt thread.
> - I think it works now.
> ChangeLog v1->v2:
> - v1 was missing timestamps since nothing ever stamped them.
>   Restore the timestamps by simply using
>   iio_trigger_generic_data_rdy_poll()
>   as the top half of the threaded interrupt handler.
> ---
>  drivers/iio/accel/st_accel_buffer.c                |  2 +-
>  drivers/iio/accel/st_accel_core.c                  |  1 +
>  drivers/iio/common/st_sensors/st_sensors_buffer.c  | 25 ++----
>  drivers/iio/common/st_sensors/st_sensors_core.c    |  3 +
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 88 +++++++++++++++++++++-
>  drivers/iio/gyro/st_gyro_buffer.c                  |  2 +-
>  drivers/iio/gyro/st_gyro_core.c                    |  1 +
>  drivers/iio/magnetometer/st_magn_buffer.c          |  2 +-
>  drivers/iio/magnetometer/st_magn_core.c            |  1 +
>  drivers/iio/pressure/st_pressure_buffer.c          |  2 +-
>  drivers/iio/pressure/st_pressure_core.c            |  1 +
>  include/linux/iio/common/st_sensors.h              |  9 ++-
>  12 files changed, 111 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> index a1e642ee13d6..7fddc137e91e 100644
> --- a/drivers/iio/accel/st_accel_buffer.c
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -91,7 +91,7 @@ static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
>  
>  int st_accel_allocate_ring(struct iio_dev *indio_dev)
>  {
> -	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +	return iio_triggered_buffer_setup(indio_dev, NULL,
>  		&st_sensors_trigger_handler, &st_accel_buffer_setup_ops);
>  }
>  
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index f06f4329db5b..1d9291116556 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -649,6 +649,7 @@ static const struct iio_info accel_info = {
>  static const struct iio_trigger_ops st_accel_trigger_ops = {
>  	.owner = THIS_MODULE,
>  	.set_trigger_state = ST_ACCEL_TRIGGER_SET_STATE,
> +	.validate_device = st_sensors_validate_device,
>  };
>  #define ST_ACCEL_TRIGGER_OPS (&st_accel_trigger_ops)
>  #else
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index c55898543a47..f1693dbebb8a 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -57,31 +57,20 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	s64 timestamp;
>  
> -	/* If we have a status register, check if this IRQ came from us */
> -	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
> -		u8 status;
> -
> -		len = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> -			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
> -			   &status);
> -		if (len < 0)
> -			dev_err(sdata->dev, "could not read channel status\n");
> -
> -		/*
> -		 * If this was not caused by any channels on this sensor,
> -		 * return IRQ_NONE
> -		 */
> -		if (!(status & (u8)indio_dev->active_scan_mask[0]))
> -			return IRQ_NONE;
> -	}
> +	/* If we do timetamping here, do it before reading the values */
> +	if (sdata->hw_irq_trigger)
> +		timestamp = sdata->hw_timestamp;
> +	else
> +		timestamp = iio_get_time_ns();
>  
>  	len = st_sensors_get_buffer_element(indio_dev, sdata->buffer_data);
>  	if (len < 0)
>  		goto st_sensors_get_buffer_element_error;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, sdata->buffer_data,
> -		pf->timestamp);
> +					   timestamp);
>  
>  st_sensors_get_buffer_element_error:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index dffe00692169..928ee68fcc5f 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -424,6 +424,9 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
>  	else
>  		drdy_mask = sdata->sensor_settings->drdy_irq.mask_int2;
>  
> +	/* Flag to the poll function that the hardware trigger is in use */
> +	sdata->hw_irq_trigger = enable;
> +
>  	/* Enable/Disable the interrupt generator for data ready. */
>  	err = st_sensors_write_data_with_mask(indio_dev,
>  					sdata->sensor_settings->drdy_irq.addr,
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index da72279fcf99..1f59bcc0f143 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -17,6 +17,73 @@
>  #include <linux/iio/common/st_sensors.h>
>  #include "st_sensors_core.h"
>  
> +/**
> + * st_sensors_irq_handler() - top half of the IRQ-based triggers
> + * @irq: irq number
> + * @p: private handler data
> + */
> +irqreturn_t st_sensors_irq_handler(int irq, void *p)
> +{
> +	struct iio_trigger *trig = p;
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	/* Get the time stamp as close in time as possible */
> +	sdata->hw_timestamp = iio_get_time_ns();
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +/**
> + * st_sensors_irq_thread() - bottom half of the IRQ-based triggers
> + * @irq: irq number
> + * @p: private handler data
> + */
> +irqreturn_t st_sensors_irq_thread(int irq, void *p)
> +{
> +	struct iio_trigger *trig = p;
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	int ret;
> +
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
> +		/*
> +		 * the lower bits of .active_scan_mask[0] is directly mapped
> +		 * to the channels on the sensor: either bit 0 for
> +		 * one-dimensional sensors, or e.g. x,y,z for accelerometers,
> +		 * gyroscopes or magnetometers. No sensor use more than 3
> +		 * channels, so cut the other status bits here.
> +		 */
> +		status &= 0x07;
> +
> +		/*
> +		 * If this was not caused by any channels on this sensor,
> +		 * return IRQ_NONE
> +		 */
> +		if (!indio_dev->active_scan_mask)
> +			return IRQ_NONE;
> +		if (!(status & (u8)indio_dev->active_scan_mask[0]))
> +			return IRQ_NONE;
> +	}
> +
> +out_poll:
> +	/* It's our IRQ: proceed to handle the register polling */
> +	iio_trigger_poll_chained(p);
> +	return IRQ_HANDLED;
> +}
> +
>  int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  				const struct iio_trigger_ops *trigger_ops)
>  {
> @@ -77,9 +144,12 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	    sdata->sensor_settings->drdy_irq.addr_stat_drdy)
>  		irq_trig |= IRQF_SHARED;
>  
> -	err = request_threaded_irq(irq,
> -			iio_trigger_generic_data_rdy_poll,
> -			NULL,
> +	/* Let's create an interrupt thread masking the hard IRQ here */
> +	irq_trig |= IRQF_ONESHOT;
> +
> +	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
> +			st_sensors_irq_handler,
> +			st_sensors_irq_thread,
>  			irq_trig,
>  			sdata->trig->name,
>  			sdata->trig);
> @@ -119,6 +189,18 @@ void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL(st_sensors_deallocate_trigger);
>  
> +int st_sensors_validate_device(struct iio_trigger *trig,
> +			       struct iio_dev *indio_dev)
> +{
> +	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
> +
> +	if (indio != indio_dev)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(st_sensors_validate_device);
> +
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics ST-sensors trigger");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
> index d67b17b6a7aa..a5377044e42f 100644
> --- a/drivers/iio/gyro/st_gyro_buffer.c
> +++ b/drivers/iio/gyro/st_gyro_buffer.c
> @@ -91,7 +91,7 @@ static const struct iio_buffer_setup_ops st_gyro_buffer_setup_ops = {
>  
>  int st_gyro_allocate_ring(struct iio_dev *indio_dev)
>  {
> -	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +	return iio_triggered_buffer_setup(indio_dev, NULL,
>  		&st_sensors_trigger_handler, &st_gyro_buffer_setup_ops);
>  }
>  
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index be9057e89dc3..242a3e3c88e4 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -408,6 +408,7 @@ static const struct iio_info gyro_info = {
>  static const struct iio_trigger_ops st_gyro_trigger_ops = {
>  	.owner = THIS_MODULE,
>  	.set_trigger_state = ST_GYRO_TRIGGER_SET_STATE,
> +	.validate_device = st_sensors_validate_device,
>  };
>  #define ST_GYRO_TRIGGER_OPS (&st_gyro_trigger_ops)
>  #else
> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
> index ecd3bd0a9769..0a9e8fadfa9d 100644
> --- a/drivers/iio/magnetometer/st_magn_buffer.c
> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> @@ -82,7 +82,7 @@ static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
>  
>  int st_magn_allocate_ring(struct iio_dev *indio_dev)
>  {
> -	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +	return iio_triggered_buffer_setup(indio_dev, NULL,
>  		&st_sensors_trigger_handler, &st_magn_buffer_setup_ops);
>  }
>  
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 62036d2a9956..8250fc322c56 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -572,6 +572,7 @@ static const struct iio_info magn_info = {
>  static const struct iio_trigger_ops st_magn_trigger_ops = {
>  	.owner = THIS_MODULE,
>  	.set_trigger_state = ST_MAGN_TRIGGER_SET_STATE,
> +	.validate_device = st_sensors_validate_device,
>  };
>  #define ST_MAGN_TRIGGER_OPS (&st_magn_trigger_ops)
>  #else
> diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
> index 2ff53f222352..99468d0a64e7 100644
> --- a/drivers/iio/pressure/st_pressure_buffer.c
> +++ b/drivers/iio/pressure/st_pressure_buffer.c
> @@ -82,7 +82,7 @@ static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
>  
>  int st_press_allocate_ring(struct iio_dev *indio_dev)
>  {
> -	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +	return iio_triggered_buffer_setup(indio_dev, NULL,
>  		&st_sensors_trigger_handler, &st_press_buffer_setup_ops);
>  }
>  
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 9e9b72a8f18f..b48285739246 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -425,6 +425,7 @@ static const struct iio_info press_info = {
>  static const struct iio_trigger_ops st_press_trigger_ops = {
>  	.owner = THIS_MODULE,
>  	.set_trigger_state = ST_PRESS_TRIGGER_SET_STATE,
> +	.validate_device = st_sensors_validate_device,
>  };
>  #define ST_PRESS_TRIGGER_OPS (&st_press_trigger_ops)
>  #else
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index d029ffac0d69..99403b19092f 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -223,6 +223,8 @@ struct st_sensor_settings {
>   * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
>   * @tf: Transfer function structure used by I/O operations.
>   * @tb: Transfer buffers and mutex used by I/O operations.
> + * @hw_irq_trigger: if we're using the hardware interrupt on the sensor.
> + * @hw_timestamp: Latest timestamp from the interrupt handler, when in use.
>   */
>  struct st_sensor_data {
>  	struct device *dev;
> @@ -247,6 +249,9 @@ struct st_sensor_data {
>  
>  	const struct st_sensor_transfer_function *tf;
>  	struct st_sensor_transfer_buffer tb;
> +
> +	bool hw_irq_trigger;
> +	s64 hw_timestamp;
>  };
>  
>  #ifdef CONFIG_IIO_BUFFER
> @@ -260,7 +265,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  				const struct iio_trigger_ops *trigger_ops);
>  
>  void st_sensors_deallocate_trigger(struct iio_dev *indio_dev);
> -
> +int st_sensors_validate_device(struct iio_trigger *trig,
> +			       struct iio_dev *indio_dev);
>  #else
>  static inline int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  				const struct iio_trigger_ops *trigger_ops)
> @@ -271,6 +277,7 @@ static inline void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
>  {
>  	return;
>  }
> +#define st_sensors_validate_device NULL
>  #endif
>  
>  int st_sensors_init_sensor(struct iio_dev *indio_dev,
> 

