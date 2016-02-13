Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58902 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbcBMOTP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Feb 2016 09:19:15 -0500
Subject: Re: [RFC PATCH v1 3/3] iio: make drivers use new timestamping clock
 API
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1455184829.git.gregor.boirie@parrot.com>
 <9bebbc3bdb3e22ebe28fa1c3b00cef199c54cbf6.1455184829.git.gregor.boirie@parrot.com>
Cc: lars@metafoo.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56BF3B61.1020004@kernel.org>
Date: Sat, 13 Feb 2016 14:19:13 +0000
MIME-Version: 1.0
In-Reply-To: <9bebbc3bdb3e22ebe28fa1c3b00cef199c54cbf6.1455184829.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/16 10:04, Gregor Boirie wrote:
> Update IIO drivers to pass IIO device as argument to iio_get_time_ns() and
> iio_get_time_res().
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Clearly you need to be careful to ensure we can build the drivers
when only patch one is applied. I'd be tempted to just merge this
into patch one.  Even more fun with patch 2 vs this.
You could work some nasty macro magic, or go through a double name
change, but given the nature of the patches, perhaps leave them as
is for review and I'll splice them into a single patch at time of
application - uggly but simple ;)

Otherwise looks fine to me.

Jonathan
> ---
>  drivers/iio/accel/bma180.c                        |  2 +-
>  drivers/iio/accel/bmc150-accel-core.c             |  4 +--
>  drivers/iio/accel/kxcjk-1013.c                    |  2 +-
>  drivers/iio/accel/mma7455_core.c                  |  3 ++-
>  drivers/iio/accel/mma8452.c                       |  4 +--
>  drivers/iio/accel/mma9551.c                       |  2 +-
>  drivers/iio/accel/mma9553.c                       |  2 +-
>  drivers/iio/adc/ad7291.c                          |  2 +-
>  drivers/iio/adc/ad7298.c                          |  2 +-
>  drivers/iio/adc/ad7476.c                          |  2 +-
>  drivers/iio/adc/ad7887.c                          |  2 +-
>  drivers/iio/adc/ad7923.c                          |  2 +-
>  drivers/iio/adc/ad799x.c                          |  4 +--
>  drivers/iio/adc/cc10001_adc.c                     |  2 +-
>  drivers/iio/adc/hi8435.c                          |  2 +-
>  drivers/iio/adc/ina2xx-adc.c                      |  6 ++---
>  drivers/iio/adc/max1363.c                         |  5 ++--
>  drivers/iio/adc/vf610_adc.c                       |  3 ++-
>  drivers/iio/adc/xilinx-xadc-events.c              |  4 +--
>  drivers/iio/chemical/atlas-ph-sensor.c            |  2 +-
>  drivers/iio/dac/ad5421.c                          |  6 ++---
>  drivers/iio/dac/ad5504.c                          |  2 +-
>  drivers/iio/dummy/iio_simple_dummy_buffer.c       |  3 ++-
>  drivers/iio/dummy/iio_simple_dummy_events.c       |  2 +-
>  drivers/iio/gyro/bmg160_core.c                    | 30 +++++++++++------------
>  drivers/iio/humidity/dht11.c                      | 16 ++++++------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c        |  2 +-
>  drivers/iio/light/acpi-als.c                      |  2 +-
>  drivers/iio/light/adjd_s311.c                     |  2 +-
>  drivers/iio/light/apds9300.c                      |  2 +-
>  drivers/iio/light/apds9960.c                      |  4 +--
>  drivers/iio/light/cm36651.c                       |  2 +-
>  drivers/iio/light/gp2ap020a00f.c                  |  8 +++---
>  drivers/iio/light/isl29125.c                      |  2 +-
>  drivers/iio/light/lm3533-als.c                    |  2 +-
>  drivers/iio/light/ltr501.c                        |  7 +++---
>  drivers/iio/light/opt3001.c                       |  4 +--
>  drivers/iio/light/stk3310.c                       |  2 +-
>  drivers/iio/light/tcs3414.c                       |  2 +-
>  drivers/iio/light/tcs3472.c                       |  2 +-
>  drivers/iio/light/tsl2563.c                       |  2 +-
>  drivers/iio/light/us5182d.c                       |  2 +-
>  drivers/iio/magnetometer/mag3110.c                |  2 +-
>  drivers/iio/pressure/mpl3115.c                    |  2 +-
>  drivers/iio/pressure/ms5611_core.c                |  3 ++-
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c |  2 +-
>  drivers/iio/proximity/sx9500.c                    |  4 +--
>  drivers/staging/iio/accel/lis3l02dq_core.c        |  2 +-
>  drivers/staging/iio/accel/sca3000_core.c          |  2 +-
>  drivers/staging/iio/adc/ad7280a.c                 |  8 +++---
>  drivers/staging/iio/adc/ad7606_ring.c             |  2 +-
>  drivers/staging/iio/adc/ad7816.c                  |  3 ++-
>  drivers/staging/iio/addac/adt7316.c               |  4 +--
>  drivers/staging/iio/cdc/ad7150.c                  |  2 +-
>  drivers/staging/iio/light/tsl2x7x_core.c          |  2 +-
>  drivers/staging/iio/magnetometer/hmc5843_core.c   |  2 +-
>  56 files changed, 106 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index f04b884..d5f842b 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -654,7 +654,7 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bma180_data *data = iio_priv(indio_dev);
> -	int64_t time_ns = iio_get_time_ns();
> +	int64_t time_ns = iio_get_time_ns(indio_dev);
>  	int bit, ret, i = 0;
>  
>  	mutex_lock(&data->mutex);
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index c73331f7..0529461 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -892,7 +892,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>  	 */
>  	if (!irq) {
>  		data->old_timestamp = data->timestamp;
> -		data->timestamp = iio_get_time_ns();
> +		data->timestamp = iio_get_time_ns(indio_dev);
>  	}
>  
>  	/*
> @@ -1295,7 +1295,7 @@ static irqreturn_t bmc150_accel_irq_handler(int irq, void *private)
>  	int i;
>  
>  	data->old_timestamp = data->timestamp;
> -	data->timestamp = iio_get_time_ns();
> +	data->timestamp = iio_get_time_ns(indio_dev);
>  
>  	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
>  		if (data->triggers[i].enabled) {
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index edec1d0..36539a2 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1131,7 +1131,7 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct kxcjk1013_data *data = iio_priv(indio_dev);
>  
> -	data->timestamp = iio_get_time_ns();
> +	data->timestamp = iio_get_time_ns(indio_dev);
>  
>  	if (data->dready_trigger_on)
>  		iio_trigger_poll(data->dready_trig);
> diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
> index c633cc2..44a65b7 100644
> --- a/drivers/iio/accel/mma7455_core.c
> +++ b/drivers/iio/accel/mma7455_core.c
> @@ -97,7 +97,8 @@ static irqreturn_t mma7455_trigger_handler(int irq, void *p)
>  	if (ret)
>  		goto done;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7f4994f..6d6019b 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -718,7 +718,7 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	s64 ts = iio_get_time_ns();
> +	s64 ts = iio_get_time_ns(indio_dev);
>  	int src;
>  
>  	src = i2c_smbus_read_byte_data(data->client, data->chip_info->ev_src);
> @@ -798,7 +798,7 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
>  		goto done;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> -					   iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index d899a4d..bf27044 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -391,7 +391,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
>  	iio_push_event(indio_dev,
>  		       IIO_MOD_EVENT_CODE(IIO_INCLI, 0, (mma_axis + 1),
>  					  IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING),
> -		       iio_get_time_ns());
> +		       iio_get_time_ns(indio_dev));
>  
>  out:
>  	mutex_unlock(&data->mutex);
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index fa7d362..55b4868 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1002,7 +1002,7 @@ static irqreturn_t mma9553_irq_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct mma9553_data *data = iio_priv(indio_dev);
>  
> -	data->timestamp = iio_get_time_ns();
> +	data->timestamp = iio_get_time_ns(indio_dev);
>  	/*
>  	 * Since we only configure the interrupt pin when an
>  	 * event is enabled, we are sure we have at least
> diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
> index c0eabf1..0376309 100644
> --- a/drivers/iio/adc/ad7291.c
> +++ b/drivers/iio/adc/ad7291.c
> @@ -115,7 +115,7 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
>  	u16 t_status, v_status;
>  	u16 command;
>  	int i;
> -	s64 timestamp = iio_get_time_ns();
> +	s64 timestamp = iio_get_time_ns(indio_dev);
>  
>  	if (ad7291_i2c_read(chip, AD7291_T_ALERT_STATUS, &t_status))
>  		return IRQ_HANDLED;
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index 62bb8f7..5dd0742 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -163,7 +163,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  		goto done;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> -		iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index be85c2a..6a14985 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -70,7 +70,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  		goto done;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> -		iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 2d3c397..361fae0 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -122,7 +122,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
>  		goto done;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> -		iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 45e29cc..2a82b9e 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -181,7 +181,7 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
>  		goto done;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> -		iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 01d7158..ec9dccb 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -212,7 +212,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
>  		goto out;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> -			iio_get_time_ns());
> +			iio_get_time_ns(indio_dev));
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> @@ -508,7 +508,7 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
>  							    (i >> 1),
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_FALLING),
> -				       iio_get_time_ns());
> +				       iio_get_time_ns(indio_dev));
>  	}
>  
>  done:
> diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
> index 8254f52..91636c0 100644
> --- a/drivers/iio/adc/cc10001_adc.c
> +++ b/drivers/iio/adc/cc10001_adc.c
> @@ -186,7 +186,7 @@ done:
>  
>  	if (!sample_invalid)
>  		iio_push_to_buffers_with_timestamp(indio_dev, data,
> -						   iio_get_time_ns());
> +						   iio_get_time_ns(indio_dev));
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index c73c6c6..c62bdb0 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -400,7 +400,7 @@ static void hi8435_iio_push_event(struct iio_dev *idev, unsigned int val)
>  			iio_push_event(idev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>  						    IIO_EV_TYPE_THRESH, dir),
> -				       iio_get_time_ns());
> +				       iio_get_time_ns(idev));
>  		}
>  	}
>  
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index d803e50..b5c9304 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -442,7 +442,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  	s64 time_a, time_b;
>  	unsigned int alert;
>  
> -	time_a = iio_get_time_ns();
> +	time_a = iio_get_time_ns(indio_dev);
>  
>  	/*
>  	 * Because the timer thread and the chip conversion clock
> @@ -483,7 +483,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  		data[i++] = val;
>  	}
>  
> -	time_b = iio_get_time_ns();
> +	time_b = iio_get_time_ns(indio_dev);
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev,
>  					   (unsigned int *)data, time_a);
> @@ -537,7 +537,7 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
>  	trace_printk("Expected work period: %u us\n", sampling_us);
>  	trace_printk("Async readout mode: %d\n", chip->allow_async_readout);
>  
> -	chip->prev_ns = iio_get_time_ns();
> +	chip->prev_ns = iio_get_time_ns(indio_dev);
>  
>  	chip->task = kthread_run(ina2xx_capture_thread, (void *)indio_dev,
>  				 "%s:%d-%uus", indio_dev->name, indio_dev->id,
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 929508e..e1f5420 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -788,7 +788,7 @@ static irqreturn_t max1363_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct max1363_state *st = iio_priv(indio_dev);
> -	s64 timestamp = iio_get_time_ns();
> +	s64 timestamp = iio_get_time_ns(indio_dev);
>  	unsigned long mask, loc;
>  	u8 rx;
>  	u8 tx[2] = { st->setupbyte,
> @@ -1506,7 +1506,8 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  	if (b_sent < 0)
>  		goto done_free;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, rxbuf, iio_get_time_ns());
> +	iio_push_to_buffers_with_timestamp(indio_dev, rxbuf,
> +		iio_get_time_ns(indio_dev));
>  
>  done_free:
>  	kfree(rxbuf);
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index b10f629..33f80a9 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -594,7 +594,8 @@ static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
>  		if (iio_buffer_enabled(indio_dev)) {
>  			info->buffer[0] = info->value;
>  			iio_push_to_buffers_with_timestamp(indio_dev,
> -					info->buffer, iio_get_time_ns());
> +					info->buffer,
> +					iio_get_time_ns(indio_dev));
>  			iio_trigger_notify_done(indio_dev->trig);
>  		} else
>  			complete(&info->completion);
> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
> index edcf3aa..6d5c2a6 100644
> --- a/drivers/iio/adc/xilinx-xadc-events.c
> +++ b/drivers/iio/adc/xilinx-xadc-events.c
> @@ -46,7 +46,7 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
>  		iio_push_event(indio_dev,
>  			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
>  				IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
> -			iio_get_time_ns());
> +			iio_get_time_ns(indio_dev));
>  	} else {
>  		/*
>  		 * For other channels we don't know whether it is a upper or
> @@ -56,7 +56,7 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
>  		iio_push_event(indio_dev,
>  			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
>  				IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> -			iio_get_time_ns());
> +			iio_get_time_ns(indio_dev));
>  	}
>  }
>  
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index 06cd49c..d83b6d3 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -185,7 +185,7 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
>  
>  	if (ret > 0)
>  		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -				iio_get_time_ns());
> +				iio_get_time_ns(indio_dev));
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
> index 968712b..559061a 100644
> --- a/drivers/iio/dac/ad5421.c
> +++ b/drivers/iio/dac/ad5421.c
> @@ -242,7 +242,7 @@ static irqreturn_t ad5421_fault_handler(int irq, void *data)
>  					0,
>  					IIO_EV_TYPE_THRESH,
>  					IIO_EV_DIR_RISING),
> -			iio_get_time_ns());
> +			iio_get_time_ns(indio_dev));
>  		}
>  
>  		if (events & AD5421_FAULT_UNDER_CURRENT) {
> @@ -251,7 +251,7 @@ static irqreturn_t ad5421_fault_handler(int irq, void *data)
>  					0,
>  					IIO_EV_TYPE_THRESH,
>  					IIO_EV_DIR_FALLING),
> -				iio_get_time_ns());
> +				iio_get_time_ns(indio_dev));
>  		}
>  
>  		if (events & AD5421_FAULT_TEMP_OVER_140) {
> @@ -260,7 +260,7 @@ static irqreturn_t ad5421_fault_handler(int irq, void *data)
>  					0,
>  					IIO_EV_TYPE_MAG,
>  					IIO_EV_DIR_RISING),
> -				iio_get_time_ns());
> +				iio_get_time_ns(indio_dev));
>  		}
>  
>  		old_fault = fault;
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index 4e4c20d..41dbe20 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -223,7 +223,7 @@ static irqreturn_t ad5504_event_handler(int irq, void *private)
>  					    0,
>  					    IIO_EV_TYPE_THRESH,
>  					    IIO_EV_DIR_RISING),
> -		       iio_get_time_ns());
> +		       iio_get_time_ns((struct iio_dev*) private));
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index cf44a6f..4535b7e 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -85,7 +85,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  		}
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data, iio_get_time_ns());
> +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +		iio_get_time_ns(indio_dev));
>  
>  	kfree(data);
>  
> diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
> index 6eb600f..ed63ffd 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_events.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_events.c
> @@ -158,7 +158,7 @@ static irqreturn_t iio_simple_dummy_get_timestamp(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct iio_dummy_state *st = iio_priv(indio_dev);
>  
> -	st->event_timestamp = iio_get_time_ns();
> +	st->event_timestamp = iio_get_time_ns(indio_dev);
>  	return IRQ_WAKE_THREAD;
>  }
>  
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index bbce3b0..54d1c74 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -884,25 +884,25 @@ static irqreturn_t bmg160_event_handler(int irq, void *private)
>  
>  	if (val & BMG160_ANY_MOTION_BIT_X)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
> -							0,
> -							IIO_MOD_X,
> -							IIO_EV_TYPE_ROC,
> -							dir),
> -							iio_get_time_ns());
> +		                                             0,
> +		                                             IIO_MOD_X,
> +		                                             IIO_EV_TYPE_ROC,
> +		                                             dir),
> +		               iio_get_time_ns(indio_dev));
>  	if (val & BMG160_ANY_MOTION_BIT_Y)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
> -							0,
> -							IIO_MOD_Y,
> -							IIO_EV_TYPE_ROC,
> -							dir),
> -							iio_get_time_ns());
> +		                                        0,
> +		                                        IIO_MOD_Y,
> +		                                        IIO_EV_TYPE_ROC,
> +		                                        dir),
> +		               iio_get_time_ns(indio_dev));
>  	if (val & BMG160_ANY_MOTION_BIT_Z)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
> -							0,
> -							IIO_MOD_Z,
> -							IIO_EV_TYPE_ROC,
> -							dir),
> -							iio_get_time_ns());
> +		                                        0,
> +		                                        IIO_MOD_Z,
> +		                                        IIO_EV_TYPE_ROC,
> +		                                        dir),
> +		               iio_get_time_ns(indio_dev));
>  
>  ack_intr_status:
>  	if (!data->dready_trigger_on) {
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 96185f8..8dbad4e 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -110,7 +110,8 @@ static unsigned char dht11_decode_byte(char *bits)
>  	return ret;
>  }
>  
> -static int dht11_decode(struct dht11 *dht11, int offset)
> +static int dht11_decode(const struct iio_dev* iio_dev, struct dht11 *dht11,
> +		int offset)
>  {
>  	int i, t;
>  	char bits[DHT11_BITS_PER_READ];
> @@ -133,7 +134,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
>  	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
>  		return -EIO;
>  
> -	dht11->timestamp = ktime_get_real_ns();
> +	dht11->timestamp = iio_get_time_ns(iio_dev);
>  	if (hum_int < 20) {  /* DHT22 */
>  		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
>  					((temp_int & 0x80) ? -100 : 100);
> @@ -161,7 +162,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
>  
>  	/* TODO: Consider making the handler safe for IRQ sharing */
>  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
> -		dht11->edges[dht11->num_edges].ts = ktime_get_real_ns();
> +		dht11->edges[dht11->num_edges].ts = iio_get_time_ns(iio);
>  		dht11->edges[dht11->num_edges++].value =
>  						gpio_get_value(dht11->gpio);
>  
> @@ -180,8 +181,9 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  	int ret, timeres, offset;
>  
>  	mutex_lock(&dht11->lock);
> -	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) {
> -		timeres = ktime_get_resolution_ns();
> +	if (dht11->timestamp + DHT11_DATA_VALID_TIME <
> +	    iio_get_time_ns(iio_dev)) {
> +		timeres = iio_get_time_res(iio_dev);
>  		if (timeres > DHT11_MIN_TIMERES) {
>  			dev_err(dht11->dev, "timeresolution %dns too low\n",
>  				timeres);
> @@ -231,7 +233,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  		offset = DHT11_EDGES_PREAMBLE +
>  				dht11->num_edges - DHT11_EDGES_PER_READ;
>  		for (; offset >= 0; --offset) {
> -			ret = dht11_decode(dht11, offset);
> +			ret = dht11_decode(iio_dev, dht11, offset);
>  			if (!ret)
>  				break;
>  		}
> @@ -302,7 +304,7 @@ static int dht11_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	dht11->timestamp = ktime_get_real_ns() - DHT11_DATA_VALID_TIME - 1;
> +	dht11->timestamp = iio_get_time_ns(iio) - DHT11_DATA_VALID_TIME - 1;
>  	dht11->num_edges = -1;
>  
>  	platform_set_drvdata(pdev, iio);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index ba27e27..5c026a3 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -107,7 +107,7 @@ irqreturn_t inv_mpu6050_irq_handler(int irq, void *p)
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  	s64 timestamp;
>  
> -	timestamp = iio_get_time_ns();
> +	timestamp = iio_get_time_ns(indio_dev);
>  	kfifo_in_spinlocked(&st->timestamps, &timestamp, 1,
>  				&st->time_stamp_lock);
>  
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 60537ec..560757e 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -116,7 +116,7 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
>  	struct iio_dev *indio_dev = acpi_driver_data(device);
>  	struct acpi_als *als = iio_priv(indio_dev);
>  	s32 *buffer = als->evt_buffer;
> -	s64 time_ns = iio_get_time_ns();
> +	s64 time_ns = iio_get_time_ns(indio_dev);
>  	s32 val;
>  	int ret;
>  
> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> index 09ad5f1..0113fc8 100644
> --- a/drivers/iio/light/adjd_s311.c
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -118,7 +118,7 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct adjd_s311_data *data = iio_priv(indio_dev);
> -	s64 time_ns = iio_get_time_ns();
> +	s64 time_ns = iio_get_time_ns(indio_dev);
>  	int i, j = 0;
>  
>  	int ret = adjd_s311_req_data(indio_dev);
> diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
> index e1b9fa5..649b26f 100644
> --- a/drivers/iio/light/apds9300.c
> +++ b/drivers/iio/light/apds9300.c
> @@ -396,7 +396,7 @@ static irqreturn_t apds9300_interrupt_handler(int irq, void *private)
>  		       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
>  					    IIO_EV_TYPE_THRESH,
>  					    IIO_EV_DIR_EITHER),
> -		       iio_get_time_ns());
> +		       iio_get_time_ns(dev_info));
>  
>  	apds9300_clear_intr(data);
>  
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index f6a07dc..42ef6cf 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -801,7 +801,7 @@ static irqreturn_t apds9960_interrupt_handler(int irq, void *private)
>  			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_EITHER),
> -			       iio_get_time_ns());
> +			       iio_get_time_ns(indio_dev));
>  		regmap_write(data->regmap, APDS9960_REG_CICLEAR, 1);
>  	}
>  
> @@ -810,7 +810,7 @@ static irqreturn_t apds9960_interrupt_handler(int irq, void *private)
>  			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_EITHER),
> -			       iio_get_time_ns());
> +			       iio_get_time_ns(indio_dev));
>  		regmap_write(data->regmap, APDS9960_REG_PICLEAR, 1);
>  	}
>  
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index c8d7b5e..9d66e89 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -268,7 +268,7 @@ static irqreturn_t cm36651_irq_handler(int irq, void *data)
>  				CM36651_CMD_READ_RAW_PROXIMITY,
>  				IIO_EV_TYPE_THRESH, ev_dir);
>  
> -	iio_push_event(indio_dev, ev_code, iio_get_time_ns());
> +	iio_push_event(indio_dev, ev_code, iio_get_time_ns(indio_dev));
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 6d41086..f558a2b 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -851,7 +851,7 @@ static irqreturn_t gp2ap020a00f_prox_sensing_handler(int irq, void *data)
>  				    GP2AP020A00F_SCAN_MODE_PROXIMITY,
>  				    IIO_EV_TYPE_ROC,
>  				    IIO_EV_DIR_RISING),
> -			       iio_get_time_ns());
> +			       iio_get_time_ns(indio_dev));
>  		} else {
>  			iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(
> @@ -859,7 +859,7 @@ static irqreturn_t gp2ap020a00f_prox_sensing_handler(int irq, void *data)
>  				    GP2AP020A00F_SCAN_MODE_PROXIMITY,
>  				    IIO_EV_TYPE_ROC,
>  				    IIO_EV_DIR_FALLING),
> -			       iio_get_time_ns());
> +			       iio_get_time_ns(indio_dev));
>  		}
>  	}
>  
> @@ -925,7 +925,7 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
>  					    IIO_MOD_LIGHT_CLEAR,
>  					    IIO_EV_TYPE_THRESH,
>  					    IIO_EV_DIR_RISING),
> -				       iio_get_time_ns());
> +				       iio_get_time_ns(indio_dev));
>  		}
>  
>  		if (test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV, &priv->flags)) {
> @@ -939,7 +939,7 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
>  					    IIO_MOD_LIGHT_CLEAR,
>  					    IIO_EV_TYPE_THRESH,
>  					    IIO_EV_DIR_FALLING),
> -				       iio_get_time_ns());
> +				       iio_get_time_ns(indio_dev));
>  		}
>  	}
>  
> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> index e2945a2..67ccc5e 100644
> --- a/drivers/iio/light/isl29125.c
> +++ b/drivers/iio/light/isl29125.c
> @@ -189,7 +189,7 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -		iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index e56937c..f409c20 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -267,7 +267,7 @@ static irqreturn_t lm3533_als_isr(int irq, void *dev_id)
>  					    0,
>  					    IIO_EV_TYPE_THRESH,
>  					    IIO_EV_DIR_EITHER),
> -		       iio_get_time_ns());
> +		       iio_get_time_ns(indio_dev));
>  out:
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 809a961..041c7d7 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1256,7 +1256,8 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>  		buf[j++] = psdata & LTR501_PS_DATA_MASK;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> @@ -1282,14 +1283,14 @@ static irqreturn_t ltr501_interrupt_handler(int irq, void *private)
>  			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_EITHER),
> -			       iio_get_time_ns());
> +			       iio_get_time_ns(indio_dev));
>  
>  	if (status & LTR501_STATUS_PS_INTR)
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_EITHER),
> -			       iio_get_time_ns());
> +			       iio_get_time_ns(indio_dev));
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index b776c8e..78c9b3a 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -713,13 +713,13 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
>  					IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
>  							IIO_EV_TYPE_THRESH,
>  							IIO_EV_DIR_RISING),
> -					iio_get_time_ns());
> +					iio_get_time_ns(iio));
>  		if (ret & OPT3001_CONFIGURATION_FL)
>  			iio_push_event(iio,
>  					IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
>  							IIO_EV_TYPE_THRESH,
>  							IIO_EV_DIR_FALLING),
> -					iio_get_time_ns());
> +					iio_get_time_ns(iio));
>  	} else if (ret & OPT3001_CONFIGURATION_CRF) {
>  		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
>  		if (ret < 0) {
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 42d334b..b48641d 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -529,7 +529,7 @@ static irqreturn_t stk3310_irq_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct stk3310_data *data = iio_priv(indio_dev);
>  
> -	data->timestamp = iio_get_time_ns();
> +	data->timestamp = iio_get_time_ns(indio_dev);
>  
>  	return IRQ_WAKE_THREAD;
>  }
> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> index f90f8c5..936e764 100644
> --- a/drivers/iio/light/tcs3414.c
> +++ b/drivers/iio/light/tcs3414.c
> @@ -217,7 +217,7 @@ static irqreturn_t tcs3414_trigger_handler(int irq, void *p)
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -		iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 1b530bf..95519a3 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -204,7 +204,7 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -		iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index 12731d6..27dbfdd 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -630,7 +630,7 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
>  					    0,
>  					    IIO_EV_TYPE_THRESH,
>  					    IIO_EV_DIR_EITHER),
> -		       iio_get_time_ns());
> +		       iio_get_time_ns(dev_info));
>  
>  	/* clear the interrupt and push the event */
>  	i2c_smbus_write_byte(chip->client, TSL2563_CMD | TSL2563_CLEARINT);
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 45bc2f7..20c40f7 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -833,7 +833,7 @@ static irqreturn_t us5182d_irq_thread_handler(int irq, void *private)
>  	dir = ret & US5182D_CFG0_PROX ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
>  	ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1, IIO_EV_TYPE_THRESH, dir);
>  
> -	iio_push_event(indio_dev, ev, iio_get_time_ns());
> +	iio_push_event(indio_dev, ev, iio_get_time_ns(indio_dev));
>  
>  	ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0,
>  					ret & ~US5182D_CFG0_PX_IRQ);
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index 261d517..f2be4a0 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -261,7 +261,7 @@ static irqreturn_t mag3110_trigger_handler(int irq, void *p)
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> -		iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 01b2e0b..6392d7b 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -171,7 +171,7 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
>  	mutex_unlock(&data->lock);
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> -		iio_get_time_ns());
> +		iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index c7885f0c..5e6f537 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -190,7 +190,8 @@ static irqreturn_t ms5611_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto err;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +		iio_get_time_ns(indio_dev));
>  
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 93e29fb..53895eb 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -244,7 +244,7 @@ static irqreturn_t lidar_trigger_handler(int irq, void *private)
>  	ret = lidar_get_measurement(data, data->buffer);
>  	if (!ret) {
>  		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -						   iio_get_time_ns());
> +						   iio_get_time_ns(indio_dev));
>  	} else if (ret != -EINVAL) {
>  		dev_err(&data->client->dev, "cannot read LIDAR measurement");
>  	}
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 66cd09a..1d74b3a 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -492,7 +492,7 @@ static void sx9500_push_events(struct iio_dev *indio_dev)
>  		dir = new_prox ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
>  		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
>  					  IIO_EV_TYPE_THRESH, dir);
> -		iio_push_event(indio_dev, ev, iio_get_time_ns());
> +		iio_push_event(indio_dev, ev, iio_get_time_ns(indio_dev));
>  		data->prox_stat[chan] = new_prox;
>  	}
>  }
> @@ -669,7 +669,7 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -					   iio_get_time_ns());
> +					   iio_get_time_ns(indio_dev));
>  
>  out:
>  	mutex_unlock(&data->mutex);
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
> index 7939ae6..868789a 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -451,7 +451,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	u8 t;
>  
> -	s64 timestamp = iio_get_time_ns();
> +	s64 timestamp = iio_get_time_ns(indio_dev);
>  
>  	lis3l02dq_spi_read_reg_8(indio_dev,
>  				 LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index 02e930c..327b9e0 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -775,7 +775,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret, val;
> -	s64 last_timestamp = iio_get_time_ns();
> +	s64 last_timestamp = iio_get_time_ns(indio_dev);
>  
>  	/*
>  	 * Could lead if badly timed to an extra read of status reg,
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index f45ebed..c5b5dd6 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -705,7 +705,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  							IIO_EV_DIR_RISING,
>  							IIO_EV_TYPE_THRESH,
>  							0, 0, 0),
> -					       iio_get_time_ns());
> +					       iio_get_time_ns(indio_dev));
>  			else if (((channels[i] >> 11) & 0xFFF) <=
>  				st->cell_threshlow)
>  				iio_push_event(indio_dev,
> @@ -715,7 +715,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  							IIO_EV_DIR_FALLING,
>  							IIO_EV_TYPE_THRESH,
>  							0, 0, 0),
> -					       iio_get_time_ns());
> +					       iio_get_time_ns(indio_dev));
>  		} else {
>  			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
>  				iio_push_event(indio_dev,
> @@ -724,7 +724,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  							0,
>  							IIO_EV_TYPE_THRESH,
>  							IIO_EV_DIR_RISING),
> -					       iio_get_time_ns());
> +					       iio_get_time_ns(indio_dev));
>  			else if (((channels[i] >> 11) & 0xFFF) <=
>  				st->aux_threshlow)
>  				iio_push_event(indio_dev,
> @@ -733,7 +733,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  							0,
>  							IIO_EV_TYPE_THRESH,
>  							IIO_EV_DIR_FALLING),
> -					       iio_get_time_ns());
> +					       iio_get_time_ns(indio_dev));
>  		}
>  	}
>  
> diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
> index a6f8eb1..d5823c2 100644
> --- a/drivers/staging/iio/adc/ad7606_ring.c
> +++ b/drivers/staging/iio/adc/ad7606_ring.c
> @@ -77,7 +77,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
>  			goto done;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns(indio_dev));
>  done:
>  	gpio_set_value(st->pdata->gpio_convst, 0);
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 2226051..9f24334 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -253,7 +253,8 @@ static const struct attribute_group ad7816_attribute_group = {
>  
>  static irqreturn_t ad7816_event_handler(int irq, void *private)
>  {
> -	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI, iio_get_time_ns());
> +	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
> +		iio_get_time_ns((struct iio_dev*) private));
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 3adc451..f4ea954 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1755,7 +1755,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  		if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
>  			stat1 &= 0x1F;
>  
> -		time = iio_get_time_ns();
> +		time = iio_get_time_ns(indio_dev);
>  		if (stat1 & BIT(0))
>  			iio_push_event(indio_dev,
>  				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> @@ -1807,7 +1807,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  							    0,
>  							    IIO_EV_TYPE_THRESH,
>  							    IIO_EV_DIR_RISING),
> -				       iio_get_time_ns());
> +				       iio_get_time_ns(indio_dev));
>  	}
>  
>  	return IRQ_HANDLED;
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index f6b9a10..5578a07 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -493,7 +493,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
>  	u8 int_status;
> -	s64 timestamp = iio_get_time_ns();
> +	s64 timestamp = iio_get_time_ns(indio_dev);
>  	int ret;
>  
>  	ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index 5b1c165..4ff425d 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -1524,7 +1524,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	s64 timestamp = iio_get_time_ns();
> +	s64 timestamp = iio_get_time_ns(indio_dev);
>  	int ret;
>  	u8 value;
>  
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
> index 9489799..f125953 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
> @@ -436,7 +436,7 @@ static irqreturn_t hmc5843_trigger_handler(int irq, void *p)
>  		goto done;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -					   iio_get_time_ns());
> +					   iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> 

