Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59519 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab2IFVVv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Sep 2012 17:21:51 -0400
Message-ID: <504913ED.5040901@kernel.org>
Date: Thu, 06 Sep 2012 22:21:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Drop timestamp parameter from buffer store_to callback
References: <5045ED39.5030408@jic23.retrosnub.co.uk> <1346762330-20360-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1346762330-20360-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/04/2012 01:38 PM, Lars-Peter Clausen wrote:
> Drop timestamp parameter from buffer store_to callback and subsequently from
> iio_push_to_buffer. The timestamp parameter is unused and it seems likely that
> it will stay unused in the future, so it should be safe to remove it.

Fine by me. I'll add the hid sensor driver that crossed with this patch
separately for the first patch, but will have to just drop it in this one.
Hope you don't mind!

I'll post the proposed version in a mo.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/adc/ad7266.c                        |    2 +-
>  drivers/iio/adc/ad_sigma_delta.c                |    2 +-
>  drivers/iio/adc/at91_adc.c                      |    2 +-
>  drivers/iio/industrialio-buffer.c               |    5 ++---
>  drivers/iio/kfifo_buf.c                         |    3 +--
>  drivers/iio/light/adjd_s311.c                   |    2 +-
>  drivers/staging/iio/accel/adis16201_ring.c      |    2 +-
>  drivers/staging/iio/accel/adis16203_ring.c      |    2 +-
>  drivers/staging/iio/accel/adis16204_ring.c      |    2 +-
>  drivers/staging/iio/accel/adis16209_ring.c      |    2 +-
>  drivers/staging/iio/accel/adis16240_ring.c      |    2 +-
>  drivers/staging/iio/accel/lis3l02dq_ring.c      |    2 +-
>  drivers/staging/iio/adc/ad7298_ring.c           |    2 +-
>  drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
>  drivers/staging/iio/adc/ad7606_ring.c           |    2 +-
>  drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
>  drivers/staging/iio/adc/ad799x_ring.c           |    2 +-
>  drivers/staging/iio/adc/max1363_ring.c          |    2 +-
>  drivers/staging/iio/adc/mxs-lradc.c             |    2 +-
>  drivers/staging/iio/gyro/adis16260_ring.c       |    2 +-
>  drivers/staging/iio/iio_simple_dummy_buffer.c   |    2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
>  drivers/staging/iio/imu/adis16400_ring.c        |    2 +-
>  drivers/staging/iio/meter/ade7758_ring.c        |    2 +-
>  drivers/staging/iio/ring_sw.c                   |    7 +++----
>  include/linux/iio/buffer.h                      |    6 ++----
>  26 files changed, 30 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 5c3f1ba..b11f214 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -99,7 +99,7 @@ static irqreturn_t ad7266_trigger_handler(int irq, void *p)
>  	if (ret == 0) {
>  		if (indio_dev->scan_timestamp)
>  			((s64 *)st->data)[1] = pf->timestamp;
> -		iio_push_to_buffer(buffer, (u8 *)st->data, pf->timestamp);
> +		iio_push_to_buffer(buffer, (u8 *)st->data);
>  	}
>  
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index ae847c5..67baa13 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -391,7 +391,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  		break;
>  	}
>  
> -	iio_push_to_buffer(indio_dev->buffer, (uint8_t *)data, pf->timestamp);
> +	iio_push_to_buffer(indio_dev->buffer, (uint8_t *)data);
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  	sigma_delta->irq_dis = false;
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index c1e4690..bc10091 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -82,7 +82,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  		*timestamp = pf->timestamp;
>  	}
>  
> -	buffer->access->store_to(buffer, (u8 *)st->buffer, pf->timestamp);
> +	buffer->access->store_to(buffer, (u8 *)st->buffer);
>  
>  	iio_trigger_notify_done(idev->trig);
>  	st->irq_enabled = true;
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 774891c..d4ad374 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -682,12 +682,11 @@ static unsigned char *iio_demux(struct iio_buffer *buffer,
>  	return buffer->demux_bounce;
>  }
>  
> -int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
> -		       s64 timestamp)
> +int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data)
>  {
>  	unsigned char *dataout = iio_demux(buffer, data);
>  
> -	return buffer->access->store_to(buffer, dataout, timestamp);
> +	return buffer->access->store_to(buffer, dataout);
>  }
>  EXPORT_SYMBOL_GPL(iio_push_to_buffer);
>  
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index 63da424..5bc5c86 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -95,8 +95,7 @@ static int iio_set_length_kfifo(struct iio_buffer *r, int length)
>  }
>  
>  static int iio_store_to_kfifo(struct iio_buffer *r,
> -			      u8 *data,
> -			      s64 timestamp)
> +			      u8 *data)
>  {
>  	int ret;
>  	struct iio_kfifo *kf = iio_to_kfifo(r);
> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> index 9a99f43..164b62b 100644
> --- a/drivers/iio/light/adjd_s311.c
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -187,7 +187,7 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
>  			= time_ns;
> -	iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
> +	iio_push_to_buffer(buffer, (u8 *)data->buffer);
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
> index 884dcf8..97c09f0 100644
> --- a/drivers/staging/iio/accel/adis16201_ring.c
> +++ b/drivers/staging/iio/accel/adis16201_ring.c
> @@ -82,7 +82,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
>  
> -	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
> +	iio_push_to_buffer(indio_dev->buffer, (u8 *)data);
>  
>  	kfree(data);
>  done:
> diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
> index a7ff804..7507e1a 100644
> --- a/drivers/staging/iio/accel/adis16203_ring.c
> +++ b/drivers/staging/iio/accel/adis16203_ring.c
> @@ -81,7 +81,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
>  
> -	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
> +	iio_push_to_buffer(indio_dev->buffer, (u8 *)data);
>  
>  	kfree(data);
>  done:
> diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
> index 16e36e3..4c976be 100644
> --- a/drivers/staging/iio/accel/adis16204_ring.c
> +++ b/drivers/staging/iio/accel/adis16204_ring.c
> @@ -78,7 +78,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
>  
> -	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
> +	iio_push_to_buffer(indio_dev->buffer, (u8 *)data);
>  
>  	kfree(data);
>  done:
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
> index 5cfeff4..f939e29 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -78,7 +78,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
>  
> -	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
> +	iio_push_to_buffer(indio_dev->buffer, (u8 *)data);
>  
>  	kfree(data);
>  done:
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
> index d5ec43e..caff8e2 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -76,7 +76,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
>  
> -	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
> +	iio_push_to_buffer(indio_dev->buffer, (u8 *)data);
>  
>  	kfree(data);
>  done:
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index 9332762..247605c 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -152,7 +152,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
>  			= pf->timestamp;
> -	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
> +	iio_push_to_buffer(indio_dev->buffer, (u8 *)data);
>  
>  	kfree(data);
>  done:
> diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
> index 9fce404..c2906a8 100644
> --- a/drivers/staging/iio/adc/ad7298_ring.c
> +++ b/drivers/staging/iio/adc/ad7298_ring.c
> @@ -93,7 +93,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  						 indio_dev->masklength); i++)
>  		buf[i] = be16_to_cpu(st->rx_buf[i]);
>  
> -	iio_push_to_buffer(indio_dev->buffer, (u8 *)buf, time_ns);
> +	iio_push_to_buffer(indio_dev->buffer, (u8 *)buf);
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
> index 3741ac6..940681f 100644
> --- a/drivers/staging/iio/adc/ad7476_ring.c
> +++ b/drivers/staging/iio/adc/ad7476_ring.c
> @@ -44,7 +44,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
>  			&time_ns, sizeof(time_ns));
>  
> -	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
> +	iio_push_to_buffer(indio_dev->buffer, rxbuf);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	kfree(rxbuf);
> diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
> index f4b009e..ba04d0f 100644
> --- a/drivers/staging/iio/adc/ad7606_ring.c
> +++ b/drivers/staging/iio/adc/ad7606_ring.c
> @@ -83,7 +83,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
>  	if (indio_dev->scan_timestamp)
>  		*((s64 *)(buf + indio_dev->scan_bytes - sizeof(s64))) = time_ns;
>  
> -	iio_push_to_buffer(indio_dev->buffer, buf, time_ns);
> +	iio_push_to_buffer(indio_dev->buffer, buf);
>  done:
>  	gpio_set_value(st->pdata->gpio_convst, 0);
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
> index a4ff493..b39923b 100644
> --- a/drivers/staging/iio/adc/ad7887_ring.c
> +++ b/drivers/staging/iio/adc/ad7887_ring.c
> @@ -95,7 +95,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
>  		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
>  		       &time_ns, sizeof(time_ns));
>  
> -	iio_push_to_buffer(indio_dev->buffer, buf, time_ns);
> +	iio_push_to_buffer(indio_dev->buffer, buf);
>  done:
>  	kfree(buf);
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
> index 84275c3..86026d9 100644
> --- a/drivers/staging/iio/adc/ad799x_ring.c
> +++ b/drivers/staging/iio/adc/ad799x_ring.c
> @@ -77,7 +77,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
>  		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
>  			&time_ns, sizeof(time_ns));
>  
> -	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
> +	iio_push_to_buffer(indio_dev->buffer, rxbuf);
>  done:
>  	kfree(rxbuf);
>  out:
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
> index 774ae1b..5f74f3b 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -80,7 +80,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  
>  	if (indio_dev->scan_timestamp)
>  		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
> -	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
> +	iio_push_to_buffer(indio_dev->buffer, rxbuf);
>  
>  done_free:
>  	kfree(rxbuf);
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index ae549e5..ca7c1fa 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -256,7 +256,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
>  		*timestamp = pf->timestamp;
>  	}
>  
> -	iio_push_to_buffer(buffer, (u8 *)lradc->buffer, pf->timestamp);
> +	iio_push_to_buffer(buffer, (u8 *)lradc->buffer);
>  
>  	iio_trigger_notify_done(iio->trig);
>  
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
> index e6e2345..e294cb4 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -81,7 +81,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
>  
> -	iio_push_to_buffer(indio_dev->buffer, (u8 *)data, pf->timestamp);
> +	iio_push_to_buffer(indio_dev->buffer, (u8 *)data);
>  
>  	kfree(data);
>  done:
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index e080213..1fd3809 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -87,7 +87,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
>  			= iio_get_time_ns();
> -	iio_push_to_buffer(buffer, (u8 *)data, pf->timestamp);
> +	iio_push_to_buffer(buffer, (u8 *)data);
>  
>  	kfree(data);
>  
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 39a9be8..de21d47 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -678,7 +678,7 @@ static void ad5933_work(struct work_struct *work)
>  			buf[0] = be16_to_cpu(buf[0]);
>  		}
>  		/* save datum to the ring */
> -		iio_push_to_buffer(ring, (u8 *)buf, iio_get_time_ns());
> +		iio_push_to_buffer(ring, (u8 *)buf);
>  	} else {
>  		/* no data available - try again later */
>  		schedule_delayed_work(&st->work, st->poll_time_jiffies);
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
> index 6b71788..260bdd1 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -150,7 +150,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
>  	/* Guaranteed to be aligned with 8 byte boundary */
>  	if (ring->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
> -	iio_push_to_buffer(ring, (u8 *) data, pf->timestamp);
> +	iio_push_to_buffer(ring, (u8 *) data);
>  
>  done:
>  	kfree(data);
> diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
> index 23c107a..9e49bac 100644
> --- a/drivers/staging/iio/meter/ade7758_ring.c
> +++ b/drivers/staging/iio/meter/ade7758_ring.c
> @@ -73,7 +73,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		dat64[1] = pf->timestamp;
>  
> -	iio_push_to_buffer(indio_dev->buffer, (u8 *)dat64, pf->timestamp);
> +	iio_push_to_buffer(indio_dev->buffer, (u8 *)dat64);
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
> index f61c8fd..3a45f9a 100644
> --- a/drivers/staging/iio/ring_sw.c
> +++ b/drivers/staging/iio/ring_sw.c
> @@ -65,7 +65,7 @@ static inline void __iio_free_sw_ring_buffer(struct iio_sw_ring_buffer *ring)
>  /* Lock always held if their is a chance this may be called */
>  /* Only one of these per ring may run concurrently - enforced by drivers */
>  static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
> -				unsigned char *data, s64 timestamp)
> +				unsigned char *data)
>  {
>  	int ret = 0;
>  	unsigned char *temp_ptr, *change_test_ptr;
> @@ -256,11 +256,10 @@ error_ret:
>  }
>  
>  static int iio_store_to_sw_rb(struct iio_buffer *r,
> -			      u8 *data,
> -			      s64 timestamp)
> +			      u8 *data)
>  {
>  	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
> -	return iio_store_to_sw_ring(ring, data, timestamp);
> +	return iio_store_to_sw_ring(ring, data);
>  }
>  
>  static int iio_request_update_sw_rb(struct iio_buffer *r)
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 8ba516f..c629b3a 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -36,7 +36,7 @@ struct iio_buffer;
>   * any of them not existing.
>   **/
>  struct iio_buffer_access_funcs {
> -	int (*store_to)(struct iio_buffer *buffer, u8 *data, s64 timestamp);
> +	int (*store_to)(struct iio_buffer *buffer, u8 *data);
>  	int (*read_first_n)(struct iio_buffer *buffer,
>  			    size_t n,
>  			    char __user *buf);
> @@ -118,10 +118,8 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
>   * iio_push_to_buffer() - push to a registered buffer.
>   * @buffer:		IIO buffer structure for device
>   * @data:		the data to push to the buffer
> - * @timestamp:		timestamp to associate with the data
>   */
> -int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
> -		       s64 timestamp);
> +int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data);
>  
>  int iio_update_demux(struct iio_dev *indio_dev);
>  
> 
