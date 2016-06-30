Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43041 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbcF3TNv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 15:13:51 -0400
Subject: Re: [PATCH v5 2/2] iio:core: timestamping clock selection support
To: maitysanchayan@gmail.com, Gregor Boirie <gregor.boirie@parrot.com>
References: <cover.1457546125.git.gregor.boirie@parrot.com>
 <193ad007f4156d653705d826dfd4f4987a40d2d1.1457546125.git.gregor.boirie@parrot.com>
 <20160310070654.GA12128@Sanchayan-Arch.toradex.int>
Cc: Stefan Agner <stefan@agner.ch>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <906fb406-2e63-d0b1-706c-6d2e290c2641@kernel.org>
Date: Thu, 30 Jun 2016 20:13:16 +0100
MIME-Version: 1.0
In-Reply-To: <20160310070654.GA12128@Sanchayan-Arch.toradex.int>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/16 07:06, maitysanchayan@gmail.com wrote:
> Hello Gregor,
> 
> On 16-03-09 19:05:49, Gregor Boirie wrote:
>> Adds a new per-device sysfs attribute "current_timestamp_clock" to allow
>> userspace to select a particular POSIX clock for buffered samples and
>> events timestamping.
>>
>> Following clocks, as listed in clock_gettime(2), are supported:
>> CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW,
>> CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME and
>> CLOCK_TAI.
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied with the obvious updates to new drivers to the togreg
branch of iio.git.  Sorry this one took so long. I thought I'd
applied it ages ago!

Thanks,

Jonathan
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio           |   7 +
>>  Documentation/DocBook/iio.tmpl                    |   2 +-
>>  drivers/iio/accel/bma180.c                        |   2 +-
>>  drivers/iio/accel/bmc150-accel-core.c             |   4 +-
>>  drivers/iio/accel/kxcjk-1013.c                    |   2 +-
>>  drivers/iio/accel/mma7455_core.c                  |   3 +-
>>  drivers/iio/accel/mma8452.c                       |   4 +-
>>  drivers/iio/accel/mma9551.c                       |   2 +-
>>  drivers/iio/accel/mma9553.c                       |   2 +-
>>  drivers/iio/adc/ad7291.c                          |   2 +-
>>  drivers/iio/adc/ad7298.c                          |   2 +-
>>  drivers/iio/adc/ad7476.c                          |   2 +-
>>  drivers/iio/adc/ad7887.c                          |   2 +-
>>  drivers/iio/adc/ad7923.c                          |   2 +-
>>  drivers/iio/adc/ad799x.c                          |   4 +-
>>  drivers/iio/adc/cc10001_adc.c                     |   2 +-
>>  drivers/iio/adc/hi8435.c                          |   2 +-
>>  drivers/iio/adc/ina2xx-adc.c                      |   6 +-
>>  drivers/iio/adc/max1363.c                         |   5 +-
>>  drivers/iio/adc/ti-ads1015.c                      |   3 +-
>>  drivers/iio/adc/vf610_adc.c                       |   3 +-
> 
> Thanks for implementing this.
> 
> For what it's worth, I tested this on Colibri Vybrid VF61 for a while and
> all seems to work fine.
> 
> So with the testing for vf610_adc driver
> 
> Acked-by: Sanchayan Maity <maitysanchayan@gmail.com>
> 
> Regards,
> Sanchayan.
> 
>>  drivers/iio/adc/xilinx-xadc-events.c              |   4 +-
>>  drivers/iio/chemical/atlas-ph-sensor.c            |   2 +-
>>  drivers/iio/dac/ad5421.c                          |   6 +-
>>  drivers/iio/dac/ad5504.c                          |   2 +-
>>  drivers/iio/dummy/iio_simple_dummy_buffer.c       |   3 +-
>>  drivers/iio/dummy/iio_simple_dummy_events.c       |   2 +-
>>  drivers/iio/gyro/bmg160_core.c                    |  30 ++--
>>  drivers/iio/iio_core.h                            |   3 +
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c        |   2 +-
>>  drivers/iio/industrialio-core.c                   | 179 +++++++++++++++++++++-
>>  drivers/iio/industrialio-event.c                  |  19 ++-
>>  drivers/iio/industrialio-trigger.c                |   2 +-
>>  drivers/iio/light/acpi-als.c                      |   2 +-
>>  drivers/iio/light/adjd_s311.c                     |   2 +-
>>  drivers/iio/light/apds9300.c                      |   2 +-
>>  drivers/iio/light/apds9960.c                      |   4 +-
>>  drivers/iio/light/cm36651.c                       |   2 +-
>>  drivers/iio/light/gp2ap020a00f.c                  |   8 +-
>>  drivers/iio/light/isl29125.c                      |   2 +-
>>  drivers/iio/light/lm3533-als.c                    |   2 +-
>>  drivers/iio/light/ltr501.c                        |   7 +-
>>  dr>  drivers/iio/light/stk3310.c                       |   2 +-
>>  drivers/iio/light/tcs3414.c                       |   2 +-
>>  drivers/iio/light/tcs3472.c                       |   2 +-
>>  drivers/iio/light/tsl2563.c                       |   2 +-
>>  drivers/iio/light/us5182d.c                       |   2 +-
>>  drivers/iio/magnetometer/hmc5843_core.c           |   2 +-
>>  drivers/iio/magnetometer/mag3110.c                |   2 +-
>>  drivers/iio/pressure/mpl3115.c                    |   2 +-
>>  drivers/iio/pressure/ms5611_core.c                |   3 +-
>>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c |   2 +-
>>  drivers/iio/proximity/sx9500.c                    |   4 +-
>>  drivers/staging/iio/accel/lis3l02dq_core.c        |   2 +-
>>  drivers/staging/iio/accel/sca3000_core.c          |   2 +-
>>  drivers/staging/iio/adc/ad7280a.c                 |   8 +-
>>  drivers/staging/iio/adc/ad7606_ring.c             |   3 +-
>>  drivers/staging/iio/adc/ad7816.c                  |   3 +-
>>  drivers/staging/iio/addac/adt7316.c               |   4 +-
>>  drivers/staging/iio/cdc/ad7150.c                  |   2 +-
>>  drivers/staging/iio/light/tsl2x7x_core.c          |   2 +-
>>  include/linux/iio/iio.h                           |  22 ++-
>>  63 files changed, 317 insertions(+), 108 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 3c66248..c374b21 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -32,6 +32,13 @@ Description:
>>  		Description of the physical chip / device for device X.
>>  		Typically a part number.
>>  
>> +What:		/sys/bus/iio/devices/iio:deviceX/timestamp_clock
>> +KernelVersion:	4.5
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		String identifying current posix clock used to timestamp
>> +		buffered samples and events for device X.
>> +
>>  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
>>  What:		/sys/bus/iio/devices/iio:deviceX/buffer/sampling_frequency
>>  What:		/sys/bus/iio/devices/triggerX/sampling_frequency
>> diff --git a/Documentation/DocBook/iio.tmpl b/Documentation/DocBook/iio.tmpl
>> index f525bf5..e2ab6a1 100644
>> --- a/Documentation/DocBook/iio.tmpl
>> +++ b/Documentation/DocBook/iio.tmpl
>> @@ -594,7 +594,7 @@
>>  
>>      irqreturn_t sensor_iio_pollfunc(int irq, void *p)
>>      {
>> -        pf->timestamp = iio_get_time_ns();
>> +        pf->timestamp = iio_get_time_ns((struct indio_dev *)p);
>>          return IRQ_WAKE_THREAD;
>>      }
>>  
>> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
>> index f04b884..e3f88ba 100644
>> --- a/drivers/iio/accel/bma180.c
>> +++ b/drivers/iio/accel/bma180.c
>> @@ -654,7 +654,7 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
>>  	struct iio_poll_func *pf = p;
>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>  	struct bma180_data *data = iio_priv(indio_dev);
>> -	int64_t time_ns = iio_get_time_ns();
>> +	s64 time_ns = iio_get_time_ns(indio_dev);
>>  	int bit, ret, i = 0;
>>  
>>  	mutex_lock(&data->mutex);
>> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
>> index c73331f7..0529461 100644
>> --- a/drivers/iio/accel/bmc150-accel-core.c
>> +++ b/drivers/iio/accel/bmc150-accel-core.c
>> @@ -892,7 +892,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>>  	 */
>>  	if (!irq) {
>>  		data->old_timestamp = data->timestamp;
>> -		data->timestamp = iio_get_time_ns();
>> +		data->timestamp = iio_get_time_ns(indio_dev);
>>  	}
>>  
>>  	/*
>> @@ -1295,7 +1295,7 @@ static irqreturn_t bmc150_accel_irq_handler(int irq, void *private)
>>  	int i;
>>  
>>  	data->old_timestamp = data->timestamp;
>> -	data->timestamp = iio_get_time_ns();
>> +	data->timestamp = iio_get_time_ns(indio_dev);
>>  
>>  	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
>>  		if (data->triggers[i].enabled) {
>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>> index edec1d0..36539a2 100644
>> --- a/drivers/iio/accel/kxcjk-1013.c
>> +++ b/drivers/iio/accel/kxcjk-1013.c
>> @@ -1131,7 +1131,7 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
>>  	struct iio_dev *indio_dev = private;
>>  	struct kxcjk1013_data *data = iio_priv(indio_dev);
>>  
>> -	data->timestamp = iio_get_time_ns();
>> +	data->timestamp = iio_get_time_ns(indio_dev);
>>  
>>  	if (data->dready_trigger_on)
>>  		iio_trigger_poll(data->dready_trig);
>> diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
>> index c633cc2..91e2c04 100644
>> --- a/drivers/iio/accel/mma7455_core.c
>> +++ b/drivers/iio/accel/mma7455_core.c
>> @@ -97,7 +97,8 @@ static irqreturn_t mma7455_trigger_handler(int irq, void *p)
>>  	if (ret)
>>  		goto done;
>>  
>> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
>> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
>> +					   iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 5ca0d16..b9ca5ad 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -783,7 +783,7 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>>  static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
>>  {
>>  	struct mma8452_data *data = iio_priv(indio_dev);
>> -	s64 ts = iio_get_time_ns();
>> +	s64 ts = iio_get_time_ns(indio_dev);
>>  	int src;
>>  
>>  	src = i2c_smbus_read_byte_data(data->client, data->chip_info->ev_src);
>> @@ -863,7 +863,7 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
>>  		goto done;
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>> -					   iio_get_time_ns());
>> +					   iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
>> index d899a4d..bf27044 100644
>> --- a/drivers/iio/accel/mma9551.c
>> +++ b/drivers/iio/accel/mma9551.c
>> @@ -391,7 +391,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
>>  	iio_push_event(indio_dev,
>>  		       IIO_MOD_EVENT_CODE(IIO_INCLI, 0, (mma_axis + 1),
>>  					  IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING),
>> -		       iio_get_time_ns());
>> +		       iio_get_time_ns(indio_dev));
>>  
>>  out:
>>  	mutex_unlock(&data->mutex);
>> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
>> index fa7d362..55b4868 100644
>> --- a/drivers/iio/accel/mma9553.c
>> +++ b/drivers/iio/accel/mma9553.c
>> @@ -1002,7 +1002,7 @@ static irqreturn_t mma9553_irq_handler(int irq, void *private)
>>  	struct iio_dev *indio_dev = private;
>>  	struct mma9553_data *data = iio_priv(indio_dev);
>>  
>> -	data->timestamp = iio_get_time_ns();
>> +	data->timestamp = iio_get_time_ns(indio_dev);
>>  	/*
>>  	 * Since we only configure the interrupt pin when an
>>  	 * event is enabled, we are sure we have at least
>> diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
>> index c0eabf1..0376309 100644
>> --- a/drivers/iio/adc/ad7291.c
>> +++ b/drivers/iio/adc/ad7291.c
>> @@ -115,7 +115,7 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
>>  	u16 t_status, v_status;
>>  	u16 command;
>>  	int i;
>> -	s64 timestamp = iio_get_time_ns();
>> +	s64 timestamp = iio_get_time_ns(indio_dev);
>>  
>>  	if (ad7291_i2c_read(chip, AD7291_T_ALERT_STATUS, &t_status))
>>  		return IRQ_HANDLED;
>> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
>> index 62bb8f7..5dd0742 100644
>> --- a/drivers/iio/adc/ad7298.c
>> +++ b/drivers/iio/adc/ad7298.c
>> @@ -163,7 +163,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>>  		goto done;
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
>> -		iio_get_time_ns());
>> +		iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
>> index be85c2a..6a14985 100644
>> --- a/drivers/iio/adc/ad7476.c
>> +++ b/drivers/iio/adc/ad7476.c
>> @@ -70,7 +70,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>>  		goto done;
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
>> -		iio_get_time_ns());
>> +		iio_get_time_ns(indio_dev));
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>>  
>> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
>> index 2d3c397..361fae0 100644
>> --- a/drivers/iio/adc/ad7887.c
>> +++ b/drivers/iio/adc/ad7887.c
>> @@ -122,7 +122,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
>>  		goto done;
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
>> -		iio_get_time_ns());
>> +		iio_get_time_ns(indio_dev));
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>>  
>> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
>> index 45e29cc..2a82b9e 100644
>> --- a/drivers/iio/adc/ad7923.c
>> +++ b/drivers/iio/adc/ad7923.c
>> @@ -181,7 +181,7 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
>>  		goto done;
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
>> -		iio_get_time_ns());
>> +		iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
>> index 01d7158..ec9dccb 100644
>> --- a/drivers/iio/adc/ad799x.c
>> +++ b/drivers/iio/adc/ad799x.c
>> @@ -212,7 +212,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
>>  		goto out;
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
>> -			iio_get_time_ns());
>> +			iio_get_time_ns(indio_dev));
>>  out:
>>  	iio_trigger_notify_done(indio_dev->trig);
>>  
>> @@ -508,7 +508,7 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
>>  							    (i >> 1),
>>  							    IIO_EV_TYPE_THRESH,
>>  							    IIO_EV_DIR_FALLING),
>> -				       iio_get_time_ns());
>> +				       iio_get_time_ns(indio_dev));
>>  	}
>>  
>>  done:
>> diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
>> index 8254f52..91636c0 100644
>> --- a/drivers/iio/adc/cc10001_adc.c
>> +++ b/drivers/iio/adc/cc10001_adc.c
>> @@ -186,7 +186,7 @@ done:
>>  
>>  	if (!sample_invalid)
>>  		iio_push_to_buffers_with_timestamp(indio_dev, data,
>> -						   iio_get_time_ns());
>> +						   iio_get_time_ns(indio_dev));
>>  	iio_trigger_notify_done(indio_dev->trig);
>>  
>>  	return IRQ_HANDLED;
>> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
>> index c73c6c6..c62bdb0 100644
>> --- a/drivers/iio/adc/hi8435.c
>> +++ b/drivers/iio/adc/hi8435.c
>> @@ -400,7 +400,7 @@ static void hi8435_iio_push_event(struct iio_dev *idev, unsigned int val)
>>  			iio_push_event(idev,
>>  				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>>  						    IIO_EV_TYPE_THRESH, dir),
>> -				       iio_get_time_ns());
>> +				       iio_get_time_ns(idev));
>>  		}
>>  	}
>>  
>> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
>> index 65909d5..ee1baf0 100644
>> --- a/drivers/iio/adc/ina2xx-adc.c
>> +++ b/drivers/iio/adc/ina2xx-adc.c
>> @@ -443,7 +443,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>>  	s64 time_a, time_b;
>>  	unsigned int alert;
>>  
>> -	time_a = iio_get_time_ns();
>> +	time_a = iio_get_time_ns(indio_dev);
>>  
>>  	/*
>>  	 * Because the timer thread and the chip conversion clock
>> @@ -482,7 +482,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>>  		data[i++] = val;
>>  	}
>>  
>> -	time_b = iio_get_time_ns();
>> +	time_b = iio_get_time_ns(indio_dev);
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev,
>>  					   (unsigned int *)data, time_a);
>> @@ -532,7 +532,7 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
>>  	dev_dbg(&indio_dev->dev, "Async readout mode: %d\n",
>>  		chip->allow_async_readout);
>>  
>> -	chip->prev_ns = iio_get_time_ns();
>> +	chip->prev_ns = iio_get_time_ns(indio_dev);
>>  
>>  	chip->task = kthread_run(ina2xx_capture_thread, (void *)indio_dev,
>>  				 "%s:%d-%uus", indio_dev->name, indio_dev->id,
>> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
>> index 929508e..0a4682b 100644
>> --- a/drivers/iio/adc/max1363.c
>> +++ b/drivers/iio/adc/max1363.c
>> @@ -788,7 +788,7 @@ static irqreturn_t max1363_event_handler(int irq, void *private)
>>  {
>>  	struct iio_dev *indio_dev = private;
>>  	struct max1363_state *st = iio_priv(indio_dev);
>> -	s64 timestamp = iio_get_time_ns();
>> +	s64 timestamp = iio_get_time_ns(indio_dev);
>>  	unsigned long mask, loc;
>>  	u8 rx;
>>  	u8 tx[2] = { st->setupbyte,
>> @@ -1506,7 +1506,8 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>>  	if (b_sent < 0)
>>  		goto done_free;
>>  
>> -	iio_push_to_buffers_with_timestamp(indio_dev, rxbuf, iio_get_time_ns());
>> +	iio_push_to_buffers_with_timestamp(indio_dev, rxbuf,
>> +					   iio_get_time_ns(indio_dev));
>>  
>>  done_free:
>>  	kfree(rxbuf);
>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>> index 73cbf0b..b5f3eb9 100644
>> --- a/drivers/iio/adc/ti-ads1015.c
>> +++ b/drivers/iio/adc/ti-ads1015.c
>> @@ -225,7 +225,8 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
>>  	buf[0] = res;
>>  	mutex_unlock(&data->lock);
>>  
>> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
>> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
>> +					   iio_get_time_ns(indio_dev));
>>  
>>  err:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
>> index b10f629..33f80a9 100644
>> --- a/drivers/iio/adc/vf610_adc.c
>> +++ b/drivers/iio/adc/vf610_adc.c
>> @@ -594,7 +594,8 @@ static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
>>  		if (iio_buffer_enabled(indio_dev)) {
>>  			info->buffer[0] = info->value;
>>  			iio_push_to_buffers_with_timestamp(indio_dev,
>> -					info->buffer, iio_get_time_ns());
>> +					info->buffer,
>> +					iio_get_time_ns(indio_dev));
>>  			iio_trigger_notify_done(indio_dev->trig);
>>  		} else
>>  			complete(&info->completion);
>> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
>> index edcf3aa..6d5c2a6 100644
>> --- a/drivers/iio/adc/xilinx-xadc-events.c
>> +++ b/drivers/iio/adc/xilinx-xadc-events.c
>> @@ -46,7 +46,7 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
>>  		iio_push_event(indio_dev,
>>  			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
>>  				IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
>> -			iio_get_time_ns());
>> +			iio_get_time_ns(indio_dev));
>>  	} else {
>>  		/*
>>  		 * For other channels we don't know whether it is a upper or
>> @@ -56,7 +56,7 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
>>  		iio_push_event(indio_dev,
>>  			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
>>  				IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
>> -			iio_get_time_ns());
>> +			iio_get_time_ns(indio_dev));
>>  	}
>>  }
>>  
>> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
>> index 62b37cd..be37e24 100644
>> --- a/drivers/iio/chemical/atlas-ph-sensor.c
>> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
>> @@ -183,7 +183,7 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
>>  
>>  	if (!ret)
>>  		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> -				iio_get_time_ns());
>> +				iio_get_time_ns(indio_dev));
>>  
>>  	iio_trigger_notify_done(indio_dev->trig);
>>  
>> diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
>> index 968712b..559061a 100644
>> --- a/drivers/iio/dac/ad5421.c
>> +++ b/drivers/iio/dac/ad5421.c
>> @@ -242,7 +242,7 @@ static irqreturn_t ad5421_fault_handler(int irq, void *data)
>>  					0,
>>  					IIO_EV_TYPE_THRESH,
>>  					IIO_EV_DIR_RISING),
>> -			iio_get_time_ns());
>> +			iio_get_time_ns(indio_dev));
>>  		}
>>  
>>  		if (events & AD5421_FAULT_UNDER_CURRENT) {
>> @@ -251,7 +251,7 @@ static irqreturn_t ad5421_fault_handler(int irq, void *data)
>>  					0,
>>  					IIO_EV_TYPE_THRESH,
>>  					IIO_EV_DIR_FALLING),
>> -				iio_get_time_ns());
>> +				iio_get_time_ns(indio_dev));
>>  		}
>>  
>>  		if (events & AD5421_FAULT_TEMP_OVER_140) {
>> @@ -260,7 +260,7 @@ static irqreturn_t ad5421_fault_handler(int irq, void *data)
>>  					0,
>>  					IIO_EV_TYPE_MAG,
>>  					IIO_EV_DIR_RISING),
>> -				iio_get_time_ns());
>> +				iio_get_time_ns(indio_dev));
>>  		}
>>  
>>  		old_fault = fault;
>> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
>> index 4e4c20d..788b3d6 100644
>> --- a/drivers/iio/dac/ad5504.c
>> +++ b/drivers/iio/dac/ad5504.c
>> @@ -223,7 +223,7 @@ static irqreturn_t ad5504_event_handler(int irq, void *private)
>>  					    0,
>>  					    IIO_EV_TYPE_THRESH,
>>  					    IIO_EV_DIR_RISING),
>> -		       iio_get_time_ns());
>> +		       iio_get_time_ns((struct iio_dev *)private));
>>  
>>  	return IRQ_HANDLED;
>>  }
>> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
>> index cf44a6f..b383892 100644
>> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
>> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
>> @@ -85,7 +85,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>>  		}
>>  	}
>>  
>> -	iio_push_to_buffers_with_timestamp(indio_dev, data, iio_get_time_ns());
>> +	iio_push_to_buffers_with_timestamp(indio_dev, data,
>> +					   iio_get_time_ns(indio_dev));
>>  
>>  	kfree(data);
>>  
>> diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
>> index 6eb600f..ed63ffd 100644
>> --- a/drivers/iio/dummy/iio_simple_dummy_events.c
>> +++ b/drivers/iio/dummy/iio_simple_dummy_events.c
>> @@ -158,7 +158,7 @@ static irqreturn_t iio_simple_dummy_get_timestamp(int irq, void *private)
>>  	struct iio_dev *indio_dev = private;
>>  	struct iio_dummy_state *st = iio_priv(indio_dev);
>>  
>> -	st->event_timestamp = iio_get_time_ns();
>> +	st->event_timestamp = iio_get_time_ns(indio_dev);
>>  	return IRQ_WAKE_THREAD;
>>  }
>>  
>> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
>> index bbce3b0..4cefcc0 100644
>> --- a/drivers/iio/gyro/bmg160_core.c
>> +++ b/drivers/iio/gyro/bmg160_core.c
>> @@ -884,25 +884,25 @@ static irqreturn_t bmg160_event_handler(int irq, void *private)
>>  
>>  	if (val & BMG160_ANY_MOTION_BIT_X)
>>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
>> -							0,
>> -							IIO_MOD_X,
>> -							IIO_EV_TYPE_ROC,
>> -							dir),
>> -							iio_get_time_ns());
>> +							     0,
>> +							     IIO_MOD_X,
>> +							     IIO_EV_TYPE_ROC,
>> +							     dir),
>> +			       iio_get_time_ns(indio_dev));
>>  	if (val & BMG160_ANY_MOTION_BIT_Y)
>>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
>> -							0,
>> -							IIO_MOD_Y,
>> -							IIO_EV_TYPE_ROC,
>> -							dir),
>> -							iio_get_time_ns());
>> +							     0,
>> +							     IIO_MOD_Y,
>> +							     IIO_EV_TYPE_ROC,
>> +							     dir),
>> +			       iio_get_time_ns(indio_dev));
>>  	if (val & BMG160_ANY_MOTION_BIT_Z)
>>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
>> -							0,
>> -							IIO_MOD_Z,
>> -							IIO_EV_TYPE_ROC,
>> -							dir),
>> -							iio_get_time_ns());
>> +							     0,
>> +							     IIO_MOD_Z,
>> +							     IIO_EV_TYPE_ROC,
>> +							     dir),
>> +			       iio_get_time_ns(indio_dev));
>>  
>>  ack_intr_status:
>>  	if (!data->dready_trigger_on) {
>> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
>> index 3598835..4c45488 100644
>> --- a/drivers/iio/iio_core.h
>> +++ b/drivers/iio/iio_core.h
>> @@ -79,4 +79,7 @@ void iio_device_unregister_eventset(struct iio_dev *indio_dev);
>>  void iio_device_wakeup_eventset(struct iio_dev *indio_dev);
>>  int iio_event_getfd(struct iio_dev *indio_dev);
>>  
>> +struct iio_event_interface;
>> +bool iio_event_enabled(const struct iio_event_interface *ev_int);
>> +
>>  #endif
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> index d070062..3a9f3ea 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> @@ -107,7 +107,7 @@ irqreturn_t inv_mpu6050_irq_handler(int irq, void *p)
>>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>  	s64 timestamp;
>>  
>> -	timestamp = iio_get_time_ns();
>> +	timestamp = iio_get_time_ns(indio_dev);
>>  	kfifo_in_spinlocked(&st->timestamps, &timestamp, 1,
>>  			    &st->time_stamp_lock);
>>  
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 70cb7eb..dbaf56b 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -174,6 +174,86 @@ ssize_t iio_read_const_attr(struct device *dev,
>>  }
>>  EXPORT_SYMBOL(iio_read_const_attr);
>>  
>> +static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
>> +{
>> +	int ret;
>> +	const struct iio_event_interface *ev_int = indio_dev->event_interface;
>> +
>> +	ret = mutex_lock_interruptible(&indio_dev->mlock);
>> +	if (ret)
>> +		return ret;
>> +	if ((ev_int && iio_event_enabled(ev_int)) ||
>> +	    iio_buffer_enabled(indio_dev)) {
>> +		mutex_unlock(&indio_dev->mlock);
>> +		return -EBUSY;
>> +	}
>> +	indio_dev->clock_id = clock_id;
>> +	mutex_unlock(&indio_dev->mlock);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * iio_get_time_ns() - utility function to get a time stamp for events etc
>> + * @indio_dev: device
>> + */
>> +s64 iio_get_time_ns(const struct iio_dev *indio_dev)
>> +{
>> +	struct timespec tp;
>> +
>> +	switch (iio_device_get_clock(indio_dev)) {
>> +	case CLOCK_REALTIME:
>> +		ktime_get_real_ts(&tp);
>> +		break;
>> +	case CLOCK_MONOTONIC:
>> +		ktime_get_ts(&tp);
>> +		break;
>> +	case CLOCK_MONOTONIC_RAW:
>> +		getrawmonotonic(&tp);
>> +		break;
>> +	case CLOCK_REALTIME_COARSE:
>> +		tp = current_kernel_time();
>> +		break;
>> +	case CLOCK_MONOTONIC_COARSE:
>> +		tp = get_monotonic_coarse();
>> +		break;
>> +	case CLOCK_BOOTTIME:
>> +		get_monotonic_boottime(&tp);
>> +		break;
>> +	case CLOCK_TAI:
>> +		timekeeping_clocktai(&tp);
>> +		break;
>> +	default:
>> +		BUG();
>> +	}
>> +
>> +	return timespec_to_ns(&tp);
>> +}
>> +EXPORT_SYMBOL(iio_get_time_ns);
>> +
>> +/**
>> + * iio_get_time_res() - utility function to get time stamp clock resolution in
>> + *                      nano seconds.
>> + * @indio_dev: device
>> + */
>> +unsigned int iio_get_time_res(const struct iio_dev *indio_dev)
>> +{
>> +	switch (iio_device_get_clock(indio_dev)) {
>> +	case CLOCK_REALTIME:
>> +	case CLOCK_MONOTONIC:
>> +	case CLOCK_MONOTONIC_RAW:
>> +	case CLOCK_BOOTTIME:
>> +	case CLOCK_TAI:
>> +		return hrtimer_resolution;
>> +	case CLOCK_REALTIME_COARSE:
>> +	case CLOCK_MONOTONIC_COARSE:
>> +		return LOW_RES_NSEC;
>> +	default:
>> +		BUG();
>> +	}
>> +}
>> +EXPORT_SYMBOL(iio_get_time_res);
>> +
>>  static int __init iio_init(void)
>>  {
>>  	int ret;
>> @@ -904,11 +984,91 @@ static ssize_t iio_show_dev_name(struct device *dev,
>>  
>>  static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
>>  
>> +static ssize_t iio_show_timestamp_clock(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	const struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	const clockid_t clk = iio_device_get_clock(indio_dev);
>> +	const char *name;
>> +	ssize_t sz;
>> +
>> +	switch (clk) {
>> +	case CLOCK_REALTIME:
>> +		name = "realtime\n";
>> +		sz = sizeof("realtime\n");
>> +		break;
>> +	case CLOCK_MONOTONIC:
>> +		name = "monotonic\n";
>> +		sz = sizeof("monotonic\n");
>> +		break;
>> +	case CLOCK_MONOTONIC_RAW:
>> +		name = "monotonic_raw\n";
>> +		sz = sizeof("monotonic_raw\n");
>> +		break;
>> +	case CLOCK_REALTIME_COARSE:
>> +		name = "realtime_coarse\n";
>> +		sz = sizeof("realtime_coarse\n");
>> +		break;
>> +	case CLOCK_MONOTONIC_COARSE:
>> +		name = "monotonic_coarse\n";
>> +		sz = sizeof("monotonic_coarse\n");
>> +		break;
>> +	case CLOCK_BOOTTIME:
>> +		name = "boottime\n";
>> +		sz = sizeof("boottime\n");
>> +		break;
>> +	case CLOCK_TAI:
>> +		name = "tai\n";
>> +		sz = sizeof("tai\n");
>> +		break;
>> +	default:
>> +		BUG();
>> +	}
>> +
>> +	memcpy(buf, name, sz);
>> +	return sz;
>> +}
>> +
>> +static ssize_t iio_store_timestamp_clock(struct device *dev,
>> +					 struct device_attribute *attr,
>> +					 const char *buf, size_t len)
>> +{
>> +	clockid_t clk;
>> +	int ret;
>> +
>> +	if (sysfs_streq(buf, "realtime"))
>> +		clk = CLOCK_REALTIME;
>> +	else if (sysfs_streq(buf, "monotonic"))
>> +		clk = CLOCK_MONOTONIC;
>> +	else if (sysfs_streq(buf, "monotonic_raw"))
>> +		clk = CLOCK_MONOTONIC_RAW;
>> +	else if (sysfs_streq(buf, "realtime_coarse"))
>> +		clk = CLOCK_REALTIME_COARSE;
>> +	else if (sysfs_streq(buf, "monotonic_coarse"))
>> +		clk = CLOCK_MONOTONIC_COARSE;
>> +	else if (sysfs_streq(buf, "boottime"))
>> +		clk = CLOCK_BOOTTIME;
>> +	else if (sysfs_streq(buf, "tai"))
>> +		clk = CLOCK_TAI;
>> +	else
>> +		return -EINVAL;
>> +
>> +	ret = iio_device_set_clock(dev_to_iio_dev(dev), clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
>> +		   iio_show_timestamp_clock, iio_store_timestamp_clock);
>> +
>>  static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>>  {
>>  	int i, ret = 0, attrcount, attrn, attrcount_orig = 0;
>>  	struct iio_dev_attr *p;
>> -	struct attribute **attr;
>> +	struct attribute **attr, *clk = NULL;
>>  
>>  	/* First count elements in any existing group */
>>  	if (indio_dev->info->attrs) {
>> @@ -923,16 +1083,25 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>>  	 */
>>  	if (indio_dev->channels)
>>  		for (i = 0; i < indio_dev->num_channels; i++) {
>> -			ret = iio_device_add_channel_sysfs(indio_dev,
>> -							   &indio_dev
>> -							   ->channels[i]);
>> +			const struct iio_chan_spec *chan =
>> +				&indio_dev->channels[i];
>> +
>> +			if (chan->type == IIO_TIMESTAMP)
>> +				clk = &dev_attr_current_timestamp_clock.attr;
>> +
>> +			ret = iio_device_add_channel_sysfs(indio_dev, chan);
>>  			if (ret < 0)
>>  				goto error_clear_attrs;
>>  			attrcount += ret;
>>  		}
>>  
>> +	if (indio_dev->event_interface)
>> +		clk = &dev_attr_current_timestamp_clock.attr;
>> +
>>  	if (indio_dev->name)
>>  		attrcount++;
>> +	if (clk)
>> +		attrcount++;
>>  
>>  	indio_dev->chan_attr_group.attrs = kcalloc(attrcount + 1,
>>  						   sizeof(indio_dev->chan_attr_group.attrs[0]),
>> @@ -953,6 +1122,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>>  		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
>>  	if (indio_dev->name)
>>  		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
>> +	if (clk)
>> +		indio_dev->chan_attr_group.attrs[attrn++] = clk;
>>  
>>  	indio_dev->groups[indio_dev->groupcounter++] =
>>  		&indio_dev->chan_attr_group;
>> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
>> index cae332b..0ebfc92 100644
>> --- a/drivers/iio/industrialio-event.c
>> +++ b/drivers/iio/industrialio-event.c
>> @@ -44,6 +44,11 @@ struct iio_event_interface {
>>  	struct mutex		read_lock;
>>  };
>>  
>> +bool iio_event_enabled(const struct iio_event_interface *ev_int)
>> +{
>> +	return !!test_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>> +}
>> +
>>  /**
>>   * iio_push_event() - try to add event to the list for userspace reading
>>   * @indio_dev:		IIO device structure
>> @@ -60,7 +65,7 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>>  	int copied;
>>  
>>  	/* Does anyone care? */
>> -	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
>> +	if (iio_event_enabled(ev_int)) {
>>  
>>  		ev.id = ev_code;
>>  		ev.timestamp = timestamp;
>> @@ -180,8 +185,14 @@ int iio_event_getfd(struct iio_dev *indio_dev)
>>  	if (ev_int == NULL)
>>  		return -ENODEV;
>>  
>> -	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags))
>> -		return -EBUSY;
>> +	fd = mutex_lock_interruptible(&indio_dev->mlock);
>> +	if (fd)
>> +		return fd;
>> +
>> +	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
>> +		fd = -EBUSY;
>> +		goto unlock;
>> +	}
>>  
>>  	iio_device_get(indio_dev);
>>  
>> @@ -194,6 +205,8 @@ int iio_event_getfd(struct iio_dev *indio_dev)
>>  		kfifo_reset_out(&ev_int->det_events);
>>  	}
>>  
>> +unlock:
>> +	mutex_unlock(&indio_dev->mlock);
>>  	return fd;
>>  }
>>  
>> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
>> index ae2806a..cf93717 100644
>> --- a/drivers/iio/industrialio-trigger.c
>> +++ b/drivers/iio/industrialio-trigger.c
>> @@ -251,7 +251,7 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
>>  irqreturn_t iio_pollfunc_store_time(int irq, void *p)
>>  {
>>  	struct iio_poll_func *pf = p;
>> -	pf->timestamp = iio_get_time_ns();
>> +	pf->timestamp = iio_get_time_ns(pf->indio_dev);
>>  	return IRQ_WAKE_THREAD;
>>  }
>>  EXPORT_SYMBOL(iio_pollfunc_store_time);
>> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
>> index 53201d9..f0b47c5 100644
>> --- a/drivers/iio/light/acpi-als.c
>> +++ b/drivers/iio/light/acpi-als.c
>> @@ -118,7 +118,7 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
>>  	struct iio_dev *indio_dev = acpi_driver_data(device);
>>  	struct acpi_als *als = iio_priv(indio_dev);
>>  	s32 *buffer = als->evt_buffer;
>> -	s64 time_ns = iio_get_time_ns();
>> +	s64 time_ns = iio_get_time_ns(indio_dev);
>>  	s32 val;
>>  	int ret;
>>  
>> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
>> index 09ad5f1..0113fc8 100644
>> --- a/drivers/iio/light/adjd_s311.c
>> +++ b/drivers/iio/light/adjd_s311.c
>> @@ -118,7 +118,7 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>>  	struct iio_poll_func *pf = p;
>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>  	struct adjd_s311_data *data = iio_priv(indio_dev);
>> -	s64 time_ns = iio_get_time_ns();
>> +	s64 time_ns = iio_get_time_ns(indio_dev);
>>  	int i, j = 0;
>>  
>>  	int ret = adjd_s311_req_data(indio_dev);
>> diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
>> index e1b9fa5..649b26f 100644
>> --- a/drivers/iio/light/apds9300.c
>> +++ b/drivers/iio/light/apds9300.c
>> @@ -396,7 +396,7 @@ static irqreturn_t apds9300_interrupt_handler(int irq, void *private)
>>  		       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
>>  					    IIO_EV_TYPE_THRESH,
>>  					    IIO_EV_DIR_EITHER),
>> -		       iio_get_time_ns());
>> +		       iio_get_time_ns(dev_info));
>>  
>>  	apds9300_clear_intr(data);
>>  
>> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
>> index f6a07dc..42ef6cf 100644
>> --- a/drivers/iio/light/apds9960.c
>> +++ b/drivers/iio/light/apds9960.c
>> @@ -801,7 +801,7 @@ static irqreturn_t apds9960_interrupt_handler(int irq, void *private)
>>  			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
>>  						    IIO_EV_TYPE_THRESH,
>>  						    IIO_EV_DIR_EITHER),
>> -			       iio_get_time_ns());
>> +			       iio_get_time_ns(indio_dev));
>>  		regmap_write(data->regmap, APDS9960_REG_CICLEAR, 1);
>>  	}
>>  
>> @@ -810,7 +810,7 @@ static irqreturn_t apds9960_interrupt_handler(int irq, void *private)
>>  			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
>>  						    IIO_EV_TYPE_THRESH,
>>  						    IIO_EV_DIR_EITHER),
>> -			       iio_get_time_ns());
>> +			       iio_get_time_ns(indio_dev));
>>  		regmap_write(data->regmap, APDS9960_REG_PICLEAR, 1);
>>  	}
>>  
>> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
>> index c8d7b5e..9d66e89 100644
>> --- a/drivers/iio/light/cm36651.c
>> +++ b/drivers/iio/light/cm36651.c
>> @@ -268,7 +268,7 @@ static irqreturn_t cm36651_irq_handler(int irq, void *data)
>>  				CM36651_CMD_READ_RAW_PROXIMITY,
>>  				IIO_EV_TYPE_THRESH, ev_dir);
>>  
>> -	iio_push_event(indio_dev, ev_code, iio_get_time_ns());
>> +	iio_push_event(indio_dev, ev_code, iio_get_time_ns(indio_dev));
>>  
>>  	return IRQ_HANDLED;
>>  }
>> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
>> index 6d41086..f558a2b 100644
>> --- a/drivers/iio/light/gp2ap020a00f.c
>> +++ b/drivers/iio/light/gp2ap020a00f.c
>> @@ -851,7 +851,7 @@ static irqreturn_t gp2ap020a00f_prox_sensing_handler(int irq, void *data)
>>  				    GP2AP020A00F_SCAN_MODE_PROXIMITY,
>>  				    IIO_EV_TYPE_ROC,
>>  				    IIO_EV_DIR_RISING),
>> -			       iio_get_time_ns());
>> +			       iio_get_time_ns(indio_dev));
>>  		} else {
>>  			iio_push_event(indio_dev,
>>  			       IIO_UNMOD_EVENT_CODE(
>> @@ -859,7 +859,7 @@ static irqreturn_t gp2ap020a00f_prox_sensing_handler(int irq, void *data)
>>  				    GP2AP020A00F_SCAN_MODE_PROXIMITY,
>>  				    IIO_EV_TYPE_ROC,
>>  				    IIO_EV_DIR_FALLING),
>> -			       iio_get_time_ns());
>> +			       iio_get_time_ns(indio_dev));
>>  		}
>>  	}
>>  
>> @@ -925,7 +925,7 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
>>  					    IIO_MOD_LIGHT_CLEAR,
>>  					    IIO_EV_TYPE_THRESH,
>>  					    IIO_EV_DIR_RISING),
>> -				       iio_get_time_ns());
>> +				       iio_get_time_ns(indio_dev));
>>  		}
>>  
>>  		if (test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV, &priv->flags)) {
>> @@ -939,7 +939,7 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
>>  					    IIO_MOD_LIGHT_CLEAR,
>>  					    IIO_EV_TYPE_THRESH,
>>  					    IIO_EV_DIR_FALLING),
>> -				       iio_get_time_ns());
>> +				       iio_get_time_ns(indio_dev));
>>  		}
>>  	}
>>  
>> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
>> index e2945a2..67ccc5e 100644
>> --- a/drivers/iio/light/isl29125.c
>> +++ b/drivers/iio/light/isl29125.c
>> @@ -189,7 +189,7 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
>>  	}
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> -		iio_get_time_ns());
>> +		iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
>> index e56937c..f409c20 100644
>> --- a/drivers/iio/light/lm3533-als.c
>> +++ b/drivers/iio/light/lm3533-als.c
>> @@ -267,7 +267,7 @@ static irqreturn_t lm3533_als_isr(int irq, void *dev_id)
>>  					    0,
>>  					    IIO_EV_TYPE_THRESH,
>>  					    IIO_EV_DIR_EITHER),
>> -		       iio_get_time_ns());
>> +		       iio_get_time_ns(indio_dev));
>>  out:
>>  	return IRQ_HANDLED;
>>  }
>> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>> index 6bf89d8..3afc53a 100644
>> --- a/drivers/iio/light/ltr501.c
>> +++ b/drivers/iio/light/ltr501.c
>> @@ -1256,7 +1256,8 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>>  		buf[j++] = psdata & LTR501_PS_DATA_MASK;
>>  	}
>>  
>> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
>> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
>> +					   iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> @@ -1282,14 +1283,14 @@ static irqreturn_t ltr501_interrupt_handler(int irq, void *private)
>>  			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
>>  						    IIO_EV_TYPE_THRESH,
>>  						    IIO_EV_DIR_EITHER),
>> -			       iio_get_time_ns());
>> +			       iio_get_time_ns(indio_dev));
>>  
>>  	if (status & LTR501_STATUS_PS_INTR)
>>  		iio_push_event(indio_dev,
>>  			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
>>  						    IIO_EV_TYPE_THRESH,
>>  						    IIO_EV_DIR_EITHER),
>> -			       iio_get_time_ns());
>> +			       iio_get_time_ns(indio_dev));
>>  
>>  	return IRQ_HANDLED;
>>  }
>> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
>> index b776c8e..78c9b3a 100644
>> --- a/drivers/iio/light/opt3001.c
>> +++ b/drivers/iio/light/opt3001.c
>> @@ -713,13 +713,13 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
>>  					IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
>>  							IIO_EV_TYPE_THRESH,
>>  							IIO_EV_DIR_RISING),
>> -					iio_get_time_ns());
>> +					iio_get_time_ns(iio));
>>  		if (ret & OPT3001_CONFIGURATION_FL)
>>  			iio_push_event(iio,
>>  					IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
>>  							IIO_EV_TYPE_THRESH,
>>  							IIO_EV_DIR_FALLING),
>> -					iio_get_time_ns());
>> +					iio_get_time_ns(iio));
>>  	} else if (ret & OPT3001_CONFIGURATION_CRF) {
>>  		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
>>  		if (ret < 0) {
>> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
>> index 42d334b..b48641d 100644
>> --- a/drivers/iio/light/stk3310.c
>> +++ b/drivers/iio/light/stk3310.c
>> @@ -529,7 +529,7 @@ static irqreturn_t stk3310_irq_handler(int irq, void *private)
>>  	struct iio_dev *indio_dev = private;
>>  	struct stk3310_data *data = iio_priv(indio_dev);
>>  
>> -	data->timestamp = iio_get_time_ns();
>> +	data->timestamp = iio_get_time_ns(indio_dev);
>>  
>>  	return IRQ_WAKE_THREAD;
>>  }
>> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
>> index f90f8c5..936e764 100644
>> --- a/drivers/iio/light/tcs3414.c
>> +++ b/drivers/iio/light/tcs3414.c
>> @@ -217,7 +217,7 @@ static irqreturn_t tcs3414_trigger_handler(int irq, void *p)
>>  	}
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> -		iio_get_time_ns());
>> +		iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
>> index 1b530bf..95519a3 100644
>> --- a/drivers/iio/light/tcs3472.c
>> +++ b/drivers/iio/light/tcs3472.c
>> @@ -204,7 +204,7 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
>>  	}
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> -		iio_get_time_ns());
>> +		iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
>> index 12731d6..27dbfdd 100644
>> --- a/drivers/iio/light/tsl2563.c
>> +++ b/drivers/iio/light/tsl2563.c
>> @@ -630,7 +630,7 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
>>  					    0,
>>  					    IIO_EV_TYPE_THRESH,
>>  					    IIO_EV_DIR_EITHER),
>> -		       iio_get_time_ns());
>> +		       iio_get_time_ns(dev_info));
>>  
>>  	/* clear the interrupt and push the event */
>>  	i2c_smbus_write_byte(chip->client, TSL2563_CMD | TSL2563_CLEARINT);
>> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
>> index 45bc2f7..20c40f7 100644
>> --- a/drivers/iio/light/us5182d.c
>> +++ b/drivers/iio/light/us5182d.c
>> @@ -833,7 +833,7 @@ static irqreturn_t us5182d_irq_thread_handler(int irq, void *private)
>>  	dir = ret & US5182D_CFG0_PROX ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
>>  	ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1, IIO_EV_TYPE_THRESH, dir);
>>  
>> -	iio_push_event(indio_dev, ev, iio_get_time_ns());
>> +	iio_push_event(indio_dev, ev, iio_get_time_ns(indio_dev));
>>  
>>  	ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0,
>>  					ret & ~US5182D_CFG0_PX_IRQ);
>> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
>> index 77882b4..ba3e2a3 100644
>> --- a/drivers/iio/magnetometer/hmc5843_core.c
>> +++ b/drivers/iio/magnetometer/hmc5843_core.c
>> @@ -451,7 +451,7 @@ static irqreturn_t hmc5843_trigger_handler(int irq, void *p)
>>  		goto done;
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> -					   iio_get_time_ns());
>> +					   iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
>> index 261d517..f2be4a0 100644
>> --- a/drivers/iio/magnetometer/mag3110.c
>> +++ b/drivers/iio/magnetometer/mag3110.c
>> @@ -261,7 +261,7 @@ static irqreturn_t mag3110_trigger_handler(int irq, void *p)
>>  	}
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>> -		iio_get_time_ns());
>> +		iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
>> index 01b2e0b..6392d7b 100644
>> --- a/drivers/iio/pressure/mpl3115.c
>> +++ b/drivers/iio/pressure/mpl3115.c
>> @@ -171,7 +171,7 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
>>  	mutex_unlock(&data->lock);
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>> -		iio_get_time_ns());
>> +		iio_get_time_ns(indio_dev));
>>  
>>  done:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
>> index 37dbc04..8bc178b 100644
>> --- a/drivers/iio/pressure/ms5611_core.c
>> +++ b/drivers/iio/pressure/ms5611_core.c
>> @@ -224,7 +224,8 @@ static irqreturn_t ms5611_trigger_handler(int irq, void *p)
>>  	if (ret < 0)
>>  		goto err;
>>  
>> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
>> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
>> +					   iio_get_time_ns(indio_dev));
>>  
>>  err:
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> index 4f502386..b216220 100644
>> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> @@ -244,7 +244,7 @@ static irqreturn_t lidar_trigger_handler(int irq, void *private)
>>  	ret = lidar_get_measurement(data, data->buffer);
>>  	if (!ret) {
>>  		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> -						   iio_get_time_ns());
>> +						   iio_get_time_ns(indio_dev));
>>  	} else if (ret != -EINVAL) {
>>  		dev_err(&data->client->dev, "cannot read LIDAR measurement");
>>  	}
>> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
>> index 66cd09a..1d74b3a 100644
>> --- a/drivers/iio/proximity/sx9500.c
>> +++ b/drivers/iio/proximity/sx9500.c
>> @@ -492,7 +492,7 @@ static void sx9500_push_events(struct iio_dev *indio_dev)
>>  		dir = new_prox ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
>>  		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
>>  					  IIO_EV_TYPE_THRESH, dir);
>> -		iio_push_event(indio_dev, ev, iio_get_time_ns());
>> +		iio_push_event(indio_dev, ev, iio_get_time_ns(indio_dev));
>>  		data->prox_stat[chan] = new_prox;
>>  	}
>>  }
>> @@ -669,7 +669,7 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
>>  	}
>>  
>>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> -					   iio_get_time_ns());
>> +					   iio_get_time_ns(indio_dev));
>>  
>>  out:
>>  	mutex_unlock(&data->mutex);
>> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
>> index 7a6fed3..5c3410a 100644
>> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
>> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
>> @@ -451,7 +451,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>>  	struct iio_dev *indio_dev = private;
>>  	u8 t;
>>  
>> -	s64 timestamp = iio_get_time_ns();
>> +	s64 timestamp = iio_get_time_ns(indio_dev);
>>  
>>  	lis3l02dq_spi_read_reg_8(indio_dev,
>>  				 LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
>> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
>> index a8f533a..cff7e4a 100644
>> --- a/drivers/staging/iio/accel/sca3000_core.c
>> +++ b/drivers/staging/iio/accel/sca3000_core.c
>> @@ -774,7 +774,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
>>  	struct iio_dev *indio_dev = private;
>>  	struct sca3000_state *st = iio_priv(indio_dev);
>>  	int ret, val;
>> -	s64 last_timestamp = iio_get_time_ns();
>> +	s64 last_timestamp = iio_get_time_ns(indio_dev);
>>  
>>  	/*
>>  	 * Could lead if badly timed to an extra read of status reg,
>> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
>> index 62e5eca..69fa4eb 100644
>> --- a/drivers/staging/iio/adc/ad7280a.c
>> +++ b/drivers/staging/iio/adc/ad7280a.c
>> @@ -705,7 +705,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>>  							IIO_EV_DIR_RISING,
>>  							IIO_EV_TYPE_THRESH,
>>  							0, 0, 0),
>> -					       iio_get_time_ns());
>> +					       iio_get_time_ns(indio_dev));
>>  			else if (((channels[i] >> 11) & 0xFFF) <=
>>  				st->cell_threshlow)
>>  				iio_push_event(indio_dev,
>> @@ -715,7 +715,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>>  							IIO_EV_DIR_FALLING,
>>  							IIO_EV_TYPE_THRESH,
>>  							0, 0, 0),
>> -					       iio_get_time_ns());
>> +					       iio_get_time_ns(indio_dev));
>>  		} else {
>>  			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
>>  				iio_push_event(indio_dev,
>> @@ -724,7 +724,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>>  							0,
>>  							IIO_EV_TYPE_THRESH,
>>  							IIO_EV_DIR_RISING),
>> -					       iio_get_time_ns());
>> +					       iio_get_time_ns(indio_dev));
>>  			else if (((channels[i] >> 11) & 0xFFF) <=
>>  				st->aux_threshlow)
>>  				iio_push_event(indio_dev,
>> @@ -733,7 +733,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>>  							0,
>>  							IIO_EV_TYPE_THRESH,
>>  							IIO_EV_DIR_FALLING),
>> -					       iio_get_time_ns());
>> +					       iio_get_time_ns(indio_dev));
>>  		}
>>  	}
>>  
>> diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
>> index a6f8eb1..0572df9 100644
>> --- a/drivers/staging/iio/adc/ad7606_ring.c
>> +++ b/drivers/staging/iio/adc/ad7606_ring.c
>> @@ -77,7 +77,8 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
>>  			goto done;
>>  	}
>>  
>> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
>> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
>> +					   iio_get_time_ns(indio_dev));
>>  done:
>>  	gpio_set_value(st->pdata->gpio_convst, 0);
>>  	iio_trigger_notify_done(indio_dev->trig);
>> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
>> index ac3735c..5e8115b 100644
>> --- a/drivers/staging/iio/adc/ad7816.c
>> +++ b/drivers/staging/iio/adc/ad7816.c
>> @@ -253,7 +253,8 @@ static const struct attribute_group ad7816_attribute_group = {
>>  
>>  static irqreturn_t ad7816_event_handler(int irq, void *private)
>>  {
>> -	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI, iio_get_time_ns());
>> +	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
>> +		       iio_get_time_ns((struct iio_dev *)private));
>>  	return IRQ_HANDLED;
>>  }
>>  
>> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
>> index 3adc451..f4ea954 100644
>> --- a/drivers/staging/iio/addac/adt7316.c
>> +++ b/drivers/staging/iio/addac/adt7316.c
>> @@ -1755,7 +1755,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>>  		if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
>>  			stat1 &= 0x1F;
>>  
>> -		time = iio_get_time_ns();
>> +		time = iio_get_time_ns(indio_dev);
>>  		if (stat1 & BIT(0))
>>  			iio_push_event(indio_dev,
>>  				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
>> @@ -1807,7 +1807,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>>  							    0,
>>  							    IIO_EV_TYPE_THRESH,
>>  							    IIO_EV_DIR_RISING),
>> -				       iio_get_time_ns());
>> +				       iio_get_time_ns(indio_dev));
>>  	}
>>  
>>  	return IRQ_HANDLED;
>> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
>> index f6b9a10..5578a07 100644
>> --- a/drivers/staging/iio/cdc/ad7150.c
>> +++ b/drivers/staging/iio/cdc/ad7150.c
>> @@ -493,7 +493,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
>>  	struct iio_dev *indio_dev = private;
>>  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
>>  	u8 int_status;
>> -	s64 timestamp = iio_get_time_ns();
>> +	s64 timestamp = iio_get_time_ns(indio_dev);
>>  	int ret;
>>  
>>  	ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
>> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
>> index 2a62718..d35b503 100644
>> --- a/drivers/staging/iio/light/tsl2x7x_core.c
>> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
>> @@ -1524,7 +1524,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>>  {
>>  	struct iio_dev *indio_dev = private;
>>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>> -	s64 timestamp = iio_get_time_ns();
>> +	s64 timestamp = iio_get_time_ns(indio_dev);
>>  	int ret;
>>  	u8 value;
>>  
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index b2b1677..8b1db3a 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -281,13 +281,8 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
>>  		},							\
>>  }
>>  
>> -/**
>> - * iio_get_time_ns() - utility function to get a time stamp for events etc
>> - **/
>> -static inline s64 iio_get_time_ns(void)
>> -{
>> -	return ktime_get_real_ns();
>> -}
>> +s64 iio_get_time_ns(const struct iio_dev *indio_dev);
>> +unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
>>  
>>  /* Device operating modes */
>>  #define INDIO_DIRECT_MODE		0x01
>> @@ -466,6 +461,7 @@ struct iio_buffer_setup_ops {
>>   * @chan_attr_group:	[INTERN] group for all attrs in base directory
>>   * @name:		[DRIVER] name of the device.
>>   * @info:		[DRIVER] callbacks and constant info from driver
>> + * @clock_id:		[INTERN] timestamping clock posix identifier
>>   * @info_exist_lock:	[INTERN] lock to prevent use during removal
>>   * @setup_ops:		[DRIVER] callbacks to call before and after buffer
>>   *			enable/disable
>> @@ -506,6 +502,7 @@ struct iio_dev {
>>  	struct attribute_group		chan_attr_group;
>>  	const char			*name;
>>  	const struct iio_info		*info;
>> +	clockid_t			clock_id;
>>  	struct mutex			info_exist_lock;
>>  	const struct iio_buffer_setup_ops	*setup_ops;
>>  	struct cdev			chrdev;
>> @@ -532,7 +529,7 @@ extern struct bus_type iio_bus_type;
>>  
>>  /**
>>   * iio_device_put() - reference counted deallocation of struct device
>> - * @indio_dev: 		IIO device structure containing the device
>> + * @indio_dev: IIO device structure containing the device
>>   **/
>>  static inline void iio_device_put(struct iio_dev *indio_dev)
>>  {
>> @@ -541,6 +538,15 @@ static inline void iio_device_put(struct iio_dev *indio_dev)
>>  }
>>  
>>  /**
>> + * iio_device_get_clock() - Retrieve current timestamping clock for the device
>> + * @indio_dev: IIO device structure containing the device
>> + */
>> +static inline clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
>> +{
>> +	return indio_dev->clock_id;
>> +}
>> +
>> +/**
>>   * dev_to_iio_dev() - Get IIO device struct from a device struct
>>   * @dev: 		The device embedded in the IIO device
>>   *
>> -- 
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

