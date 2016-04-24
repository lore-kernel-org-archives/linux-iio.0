Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35166 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbcDXJYj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Apr 2016 05:24:39 -0400
Subject: Re: [PATCH v3 5/5] max44000: Initial triggered buffer support
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1460989642.git.leonard.crestez@intel.com>
 <d809963f51912bd9d879030ec113e15becf313d6.1460989642.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1af170c5-ae57-4919-ccef-a8512222c74b@kernel.org>
Date: Sun, 24 Apr 2016 10:24:37 +0100
MIME-Version: 1.0
In-Reply-To: <d809963f51912bd9d879030ec113e15becf313d6.1460989642.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/04/16 15:31, Crestez Dan Leonard wrote:
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/light/max44000.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index c58bb78..b83d47d 100644
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
> @@ -125,24 +128,41 @@ static const char max44000_scale_avail_str[] =
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
> +			.storagebits	= 16,
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
> @@ -467,6 +487,41 @@ static const struct regmap_config max44000_regmap_config = {
>  	.cache_type	= REGCACHE_RBTREE,
>  };
>  
> +static irqreturn_t max44000_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct max44000_data *data = iio_priv(indio_dev);
> +	u16 buf[8]; /* 2x u16 + padding + 8 bytes timestamp */
> +	int index = 0;
> +	unsigned int regval;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	if (test_bit(MAX44000_SCAN_INDEX_ALS, indio_dev->active_scan_mask)) {
> +		ret = max44000_read_alsval(data);
> +		if (ret < 0)
> +			goto out_unlock;
> +		buf[index++] = ret;
> +	}
> +	if (test_bit(MAX44000_SCAN_INDEX_PRX, indio_dev->active_scan_mask)) {
> +		ret = regmap_read(data->regmap, MAX44000_REG_PRX_DATA, &regval);
> +		if (ret < 0)
> +			goto out_unlock;
> +		buf[index] = regval;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
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
> @@ -532,6 +587,12 @@ static int max44000_probe(struct i2c_client *client,
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
>  }
>  
> @@ -540,6 +601,7 @@ static int max44000_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  
>  	return 0;
>  }
> 

