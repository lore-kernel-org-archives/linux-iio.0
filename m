Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:54951 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab0EWKCh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2010 06:02:37 -0400
Message-ID: <4BF8FDD4.6020104@cam.ac.uk>
Date: Sun, 23 May 2010 11:05:08 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] staging:iio: kill off spurious semicolons
References: <1274598630-12160-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1274598630-12160-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/23/10 08:10, Mike Frysinger wrote:
> A bunch of IIO files contain spurious semicolons after function
> definitions and case statements and if statements.  Guess people
> really like this thing, but kill them anyways so they'll stop
> spreading via copy & paste with new drivers.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Combination of my bad coding style a while ago and never getting
round to cleaning up.  A number of these are in a series of clean
up patches I haven't sent out yet, but you found more than me, so
I'll merge my changes on top of this.

Thanks,

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/accel/lis3l02dq.h    |   19 ++++++++++++-------
>  drivers/staging/iio/accel/sca3000.h      |   14 +++++++++-----
>  drivers/staging/iio/accel/sca3000_core.c |   14 +++++++-------
>  drivers/staging/iio/adc/max1363.h        |   14 ++++++++------
>  drivers/staging/iio/adc/max1363_core.c   |    4 ++--
>  drivers/staging/iio/adc/max1363_ring.c   |    4 ++--
>  6 files changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
> index e76a979..0ffa0bb 100644
> --- a/drivers/staging/iio/accel/lis3l02dq.h
> +++ b/drivers/staging/iio/accel/lis3l02dq.h
> @@ -199,11 +199,13 @@ int lis3l02dq_initialize_ring(struct iio_ring_buffer *ring);
>  void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring);
>  #else /* CONFIG_IIO_RING_BUFFER */
>  
> -static inline void lis3l02dq_remove_trigger(struct iio_dev *indio_dev) {};
> +static inline void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
> +{
> +}
>  static inline int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
>  {
>  	return 0;
> -};
> +}
>  
>  static inline ssize_t
>  lis3l02dq_read_accel_from_ring(struct device *dev,
> @@ -211,18 +213,21 @@ lis3l02dq_read_accel_from_ring(struct device *dev,
>  			       char *buf)
>  {
>  	return 0;
> -};
> +}
>  
>  static int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
>  {
>  	return 0;
> -};
> +}
>  static inline void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
> -{};
> +{
> +}
>  static inline int lis3l02dq_initialize_ring(struct iio_ring_buffer *ring)
>  {
>  	return 0;
> -};
> -static inline void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring) {};
> +}
> +static inline void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring)
> +{
> +}
>  #endif /* CONFIG_IIO_RING_BUFFER */
>  #endif /* SPI_LIS3L02DQ_H_ */
> diff --git a/drivers/staging/iio/accel/sca3000.h b/drivers/staging/iio/accel/sca3000.h
> index e532199..09d9470 100644
> --- a/drivers/staging/iio/accel/sca3000.h
> +++ b/drivers/staging/iio/accel/sca3000.h
> @@ -242,7 +242,7 @@ static inline int sca3000_11bit_convert(uint8_t msb, uint8_t lsb)
>  	val |= (val & (1 << 12)) ? 0xE000 : 0;
>  
>  	return val;
> -};
> +}
>  
>  static inline int sca3000_13bit_convert(uint8_t msb, uint8_t lsb)
>  {
> @@ -253,7 +253,7 @@ static inline int sca3000_13bit_convert(uint8_t msb, uint8_t lsb)
>  	val |= (val & (1 << 12)) ? 0xE000 : 0;
>  
>  	return val;
> -};
> +}
>  
>  
>  #ifdef CONFIG_IIO_RING_BUFFER
> @@ -286,15 +286,19 @@ void sca3000_unconfigure_ring(struct iio_dev *indio_dev);
>  void sca3000_ring_int_process(u8 val, struct iio_ring_buffer *ring);
>  
>  #else
> -static inline void sca3000_register_ring_funcs(struct iio_dev *indio_dev) {};
> +static inline void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
> +{
> +}
>  
>  static inline
>  int sca3000_register_ring_access_and_init(struct iio_dev *indio_dev)
>  {
>  	return 0;
> -};
> +}
>  
> -static inline void sca3000_ring_int_process(u8 val, void *ring) {};
> +static inline void sca3000_ring_int_process(u8 val, void *ring)
> +{
> +}
>  
>  #endif
>  
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index d4f82c3..b78b6b6 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -387,7 +387,7 @@ sca3000_show_available_measurement_modes(struct device *dev,
>  	case SCA3000_OP_MODE_BYPASS:
>  		len += sprintf(buf + len, ", 1 - bypass mode");
>  		break;
> -	};
> +	}
>  	switch (st->info->option_mode_2) {
>  	case SCA3000_OP_MODE_WIDE:
>  		len += sprintf(buf + len, ", 2 - wide mode");
> @@ -433,7 +433,7 @@ sca3000_show_measurement_mode(struct device *dev,
>  		case SCA3000_OP_MODE_BYPASS:
>  			len += sprintf(buf + len, "1 - bypass mode\n");
>  			break;
> -		};
> +		}
>  		break;
>  	case SCA3000_MEAS_MODE_OP_2:
>  		switch (st->info->option_mode_2) {
> @@ -442,7 +442,7 @@ sca3000_show_measurement_mode(struct device *dev,
>  			break;
>  		}
>  		break;
> -	};
> +	}
>  
>  error_ret:
>  	mutex_unlock(&st->lock);
> @@ -559,7 +559,7 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
>  			       st->info->option_mode_2_freq/2,
>  			       st->info->option_mode_2_freq/4);
>  		break;
> -	};
> +	}
>  	kfree(rx);
>  	return len;
>  error_ret:
> @@ -590,7 +590,7 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
>  	case SCA3000_MEAS_MODE_OP_2:
>  		*base_freq = info->option_mode_2_freq;
>  		break;
> -	};
> +	}
>  	kfree(rx);
>  error_ret:
>  	return ret;
> @@ -627,8 +627,8 @@ static ssize_t sca3000_read_frequency(struct device *dev,
>  		case 0x02:
>  			len = sprintf(buf, "%d\n", base_freq/4);
>  			break;
> -	};
> -			kfree(rx);
> +	}
> +	kfree(rx);
>  	return len;
>  error_ret_mut:
>  	mutex_unlock(&st->lock);
> diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
> index 72cf367..6da468b 100644
> --- a/drivers/staging/iio/adc/max1363.h
> +++ b/drivers/staging/iio/adc/max1363.h
> @@ -147,7 +147,7 @@ enum max1363_channels {
>  	max1363_in1min0, max1363_in3min2,
>  	max1363_in5min4, max1363_in7min6,
>  	max1363_in9min8, max1363_in11min10,
> -	};
> +};
>  
>  /* This must be maintained along side the max1363_mode_table in max1363_core */
>  enum max1363_modes {
> @@ -237,25 +237,27 @@ void max1363_uninitialize_ring(struct iio_ring_buffer *ring);
>  
>  static inline void max1363_uninitialize_ring(struct iio_ring_buffer *ring)
>  {
> -};
> +}
>  
>  static inline int max1363_initialize_ring(struct iio_ring_buffer *ring)
>  {
>  	return 0;
> -};
> +}
>  
>  int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
>  {
>  	return -EINVAL;
> -};
> +}
>  
>  
>  static inline int
>  max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  {
>  	return 0;
> -};
> +}
>  
> -static inline void max1363_ring_cleanup(struct iio_dev *indio_dev) {};
> +static inline void max1363_ring_cleanup(struct iio_dev *indio_dev)
> +{
> +}
>  #endif /* CONFIG_MAX1363_RING_BUFFER */
>  #endif /* _MAX1363_H_ */
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
> index 20e2674..cb5b572 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -148,7 +148,7 @@ const struct max1363_mode
>  			      mask))
>  				return &max1363_mode_table[ci->mode_list[i]];
>  	return NULL;
> -};
> +}
>  
>  static ssize_t max1363_show_precision(struct device *dev,
>  				struct device_attribute *attr,
> @@ -935,7 +935,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
>  		if (!strcmp(max1363_chip_info_tbl[i].name, id->name)) {
>  			st->chip_info = &max1363_chip_info_tbl[i];
>  			break;
> -		};
> +		}
>  	/* Unsupported chip */
>  	if (!st->chip_info) {
>  		dev_err(&client->dev, "%s is not supported\n", id->name);
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
> index 56688dc..a49b3d7 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -262,9 +262,9 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
>  void max1363_uninitialize_ring(struct iio_ring_buffer *ring)
>  {
>  	iio_ring_buffer_unregister(ring);
> -};
> +}
>  
>  int max1363_initialize_ring(struct iio_ring_buffer *ring)
>  {
>  	return iio_ring_buffer_register(ring, 0);
> -};
> +}

