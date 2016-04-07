Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:55118 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755300AbcDGT7G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 Apr 2016 15:59:06 -0400
Date: Thu, 7 Apr 2016 21:59:04 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 5/5] max44000: Initial triggered buffer support
In-Reply-To: <dc82c7c28df002717a2668708cc96732a0856fac.1460045763.git.leonard.crestez@intel.com>
Message-ID: <alpine.DEB.2.02.1604072152010.26969@pmeerw.net>
References: <cover.1460045763.git.leonard.crestez@intel.com> <dc82c7c28df002717a2668708cc96732a0856fac.1460045763.git.leonard.crestez@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


comments below

> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  drivers/iio/light/max44000.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index e479c53..7b1f8bc 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -19,6 +19,9 @@
>  #include <linux/util_macros.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/acpi.h>
>  
>  #define MAX44000_DRV_NAME		"max44000"
> @@ -123,24 +126,41 @@ static const char max44000_scale_avail_str[] =
>  	"0.5 "
>  	 "4";
>  
> +#define MAX44000_SCAN_INDEX_ALS 0
> +#define MAX44000_SCAN_INDEX_PRX 1
> +
>  static const struct iio_chan_spec max44000_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
>  					    BIT(IIO_CHAN_INFO_INT_TIME),
> +		.scan_index = MAX44000_SCAN_INDEX_ALS,
> +		.scan_type = {
> +			.sign		= 'u',
> +			.realbits	= 14,
> +			.storagebits	= 16,
> +		}
>  	},
>  	{
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = MAX44000_SCAN_INDEX_PRX,
> +		.scan_type = {
> +			.sign		= 'u',
> +			.realbits	= 8,
> +			.storagebits	= 8,

code would get simpler if storagebits = 16

> +		}
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  	{
>  		.type = IIO_CURRENT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE),
>  		.extend_name = "led",
>  		.output = 1,
> +		.scan_index = -1,
>  	},
>  };
>  
> @@ -456,6 +476,42 @@ static int max44000_force_write_defaults(struct max44000_data *data)
>  	return 0;
>  }
>  
> +static irqreturn_t max44000_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct max44000_data *data = iio_priv(indio_dev);
> +	u16 buf[indio_dev->scan_bytes / 2];
> +	u8 *pos = (u8 *)buf;

int i = 0;

> +	unsigned int regval;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	if (*indio_dev->active_scan_mask & (1 << MAX44000_SCAN_INDEX_ALS)) {

BIT(MAX44000_SCAN_INDEX_ALS)

> +		ret = max44000_read_alsval(data);
> +		if (ret < 0)
> +			goto out_unlock;
> +		*((u16 *)pos) = ret;

buf[i++] = ret;

> +		pos += 2;
> +	}
> +	if (*indio_dev->active_scan_mask & (1 << MAX44000_SCAN_INDEX_PRX)) {
> +		ret = regmap_read(data->regmap, MAX44000_REG_PRX_DATA, &regval);
> +		if (ret < 0)
> +			goto out_unlock;
buf[i++] = retval;

> +		*pos = regval;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());

moving iio_push_to_buffers_with_timestamp() before mutex_unlock() would 
allow simpler code (not sure if it's worth)

> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +
> +out_unlock:
> +	mutex_unlock(&data->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
>  static int max44000_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -513,6 +569,12 @@ static int max44000_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL, max44000_trigger_handler, NULL);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +		return ret;
> +	}
> +
>  	return iio_device_register(indio_dev);

no devm_ possible anymore :-)

>  }
>  
> @@ -521,6 +583,7 @@ static int max44000_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	return 0;
>  }
>  
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
