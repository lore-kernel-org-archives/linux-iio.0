Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:35484 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbbGaQn7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 31 Jul 2015 12:43:59 -0400
Date: Fri, 31 Jul 2015 18:43:57 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Teodora Baluta <teodora.baluta@intel.com>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: mxc4005: add triggered buffer mode for
 mxc4005
In-Reply-To: <1438356340-13306-3-git-send-email-teodora.baluta@intel.com>
Message-ID: <alpine.DEB.2.02.1507311834190.12658@pmeerw.net>
References: <1438356340-13306-1-git-send-email-teodora.baluta@intel.com> <1438356340-13306-3-git-send-email-teodora.baluta@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 31 Jul 2015, Teodora Baluta wrote:

> This patch adds support for buffered readings for the 3-axis
> accelerometer mxc4005.

some comments below
 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
> ---
>  drivers/iio/accel/Kconfig   |  2 ++
>  drivers/iio/accel/mxc4005.c | 75 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 73 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 7f534a3..e8d135e 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -140,6 +140,8 @@ config MMA9553
>  config MXC4005
>  	tristate "Memsic MXC4005XC 3-Axis Accelerometer Driver"
>  	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	select REGMAP_I2C
>  	help
>  	  Say yes here to build support for the Memsic MXC4005XC 3-axis
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index 0f0410c..114c14d 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -19,6 +19,9 @@
>  #include <linux/acpi.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  #define MXC4005_DRV_NAME		"mxc4005"
>  #define MXC4005_REGMAP_NAME		"mxc4005_regmap"
> @@ -54,6 +57,7 @@ struct mxc4005_data {
>  	struct i2c_client *client;
>  	struct mutex mutex;
>  	struct regmap *regmap;
> +	s16 buffer[8];

be16 buffer[3]; ?!

>  };
>  
>  /*
> @@ -125,6 +129,20 @@ static const struct regmap_config mxc4005_regmap_config = {
>  	.writeable_reg = mxc4005_is_writeable_reg,
>  };
>  
> +static int mxc4005_read_xyz(struct mxc4005_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, MXC4005_REG_XOUT_UPPER,
> +			       (u8 *) data->buffer, sizeof(data->buffer));

sizeof(data->buffer) == sizeof(s16) * 8 == 16 bytes, but actually the 
sensor data is just 6 bytes!?

> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "failed to read axes\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mxc4005_read_axis(struct mxc4005_data *data,
>  			     int axis)
>  {
> @@ -190,6 +208,7 @@ static int mxc4005_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct mxc4005_data *data = iio_priv(indio_dev);
> +	int axis = chan->scan_index;

why?
BTW w.r.t the initial patch: chan->address could store the register 
address directly, so MXC4005_AXIS_TO_REG() could be dropped

>  	int ret;
>  
>  	switch (mask) {
> @@ -200,12 +219,13 @@ static int mxc4005_read_raw(struct iio_dev *indio_dev,
>  				return -EBUSY;
>  
>  			mutex_lock(&data->mutex);
> -			ret = mxc4005_read_axis(data, chan->address);
> +			ret = mxc4005_read_axis(data, axis);
>  			mutex_unlock(&data->mutex);
>  			if (ret < 0)
>  				return ret;
>  			ret = be16_to_cpu(ret);
> -			*val = sign_extend32(ret >> 4, 11);
> +			*val = sign_extend32(ret >> chan->scan_type.shift,
> +					     chan->scan_type.realbits - 1);
>  			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
> @@ -259,17 +279,47 @@ static const struct iio_info mxc4005_info = {
>  	.type = IIO_ACCEL,					\
>  	.modified = 1,						\
>  	.channel2 = IIO_MOD_##_axis,				\
> -	.address = AXIS_##_axis,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.scan_index = AXIS_##_axis,				\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 12,					\
> +		.storagebits = 16,				\
> +		.shift = 4,					\
> +		.endianness = IIO_BE,				\
> +	},							\
>  }
>  
>  static const struct iio_chan_spec mxc4005_channels[] = {
>  	MXC4005_CHANNEL(X),
>  	MXC4005_CHANNEL(Y),
>  	MXC4005_CHANNEL(Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +static irqreturn_t mxc4005_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mxc4005_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = mxc4005_read_xyz(data);

this always reads all channels, what if only one channel is enabled by the 
user? use available_scan_masks...

> +	mutex_unlock(&data->mutex);
> +	if (ret < 0)
> +		goto err;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +					   iio_get_time_ns());
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int mxc4005_chip_init(struct mxc4005_data *data)
>  {
>  	int ret;
> @@ -324,14 +374,29 @@ static int mxc4005_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &mxc4005_info;
>  
> +	ret = iio_triggered_buffer_setup(indio_dev,
> +					 &iio_pollfunc_store_time,
> +					 mxc4005_trigger_handler,
> +					 NULL);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"failed to setup iio triggered buffer\n");
> +		return ret;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
>  			"unable to register iio device %d\n", ret);
> -		return ret;
> +		goto err_buffer_cleanup;
>  	}
>  
>  	return 0;
> +
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	return ret;
>  }
>  
>  static int mxc4005_remove(struct i2c_client *client)
> @@ -340,6 +405,8 @@ static int mxc4005_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
>  	return 0;
>  }
>  
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
