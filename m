Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59038 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbbGELla (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 07:41:30 -0400
Message-ID: <559917E7.1000801@kernel.org>
Date: Sun, 05 Jul 2015 12:41:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com,
	christoph.muellner@theobroma-systems.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 2/9] iio: mma8452: add support for MMA8453Q accelerometer
 chip
References: <1436018110-3903-1-git-send-email-martink@posteo.de> <1436018110-3903-3-git-send-email-martink@posteo.de>
In-Reply-To: <1436018110-3903-3-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/07/15 14:55, Martin Kepplinger wrote:
> This adds support for the 10 bit version if Freescale's accelerometers
> of this series. The datasheet is available at Freescale's website:
> 
> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA8453Q.pdf
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Couple of minor bits inline.
> ---
>  drivers/iio/accel/Kconfig   |  6 +++---
>  drivers/iio/accel/mma8452.c | 41 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 00e7bcb..91fab16 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -87,13 +87,13 @@ config KXSD9
>  	  will be called kxsd9.
>  
>  config MMA8452
> -	tristate "Freescale MMA8452Q Accelerometer Driver"
> +	tristate "Freescale MMA8452 Accelerometer Driver"
Why the rename in the above menu item?  Usual trick here
if the message is getting too long is to add 'and similar.' then
ensure all supported parts are as you have, clearly mentioned in the help.
>  	depends on I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to build support for the Freescale MMA8452Q 3-axis
> -	  accelerometer.
> +	  Say yes here to build support for the following Freescale 3-axis
> +	  accelerometers: MMA8452Q, MMA8453Q.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mma8452.
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index b2ebfcb..209b0d7 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1,5 +1,8 @@
>  /*
> - * mma8452.c - Support for Freescale MMA8452Q 3-axis 12-bit accelerometer
> + * mma8452.c - Support for following Freescale 3-axis accelerometers:
> + *
> + *	MMA8452Q
> + *	MMA8453Q
>   *
>   * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   *
> @@ -27,7 +30,7 @@
>  
>  #define DRIVER_NAME "mma8452"
>  #define MMA8452_STATUS 0x00
> -#define MMA8452_OUT_X 0x01 /* MSB first, 12-bit  */
> +#define MMA8452_OUT_X 0x01 /* MSB first, 10 or 12-bit  */
>  #define MMA8452_OUT_Y 0x03
>  #define MMA8452_OUT_Z 0x05
>  #define MMA8452_INT_SRC 0x0c
> @@ -74,6 +77,7 @@
>  #define MMA8452_INT_TRANS	BIT(5)
>  
>  #define MMA8452_DEVICE_ID 0x2a
> +#define MMA8453_DEVICE_ID 0x3a
>  
>  struct mma8452_data {
>  	struct i2c_client *client;
> @@ -718,8 +722,16 @@ static const struct iio_chan_spec mma8452_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +static const struct iio_chan_spec mma8453_channels[] = {
> +	MMA8452_CHANNEL(X, 0, 10),
> +	MMA8452_CHANNEL(Y, 1, 10),
> +	MMA8452_CHANNEL(Z, 2, 10),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
>  enum {
>  	mma8452,
> +	mma8453,
>  };
>  
>  /*
> @@ -747,7 +759,24 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
>  		.ev_count = MMA8452_TRANSIENT_COUNT,
>  	},
> +	[mma8453] = {
> +		.chip_id = MMA8453_DEVICE_ID,
> +		.channels = mma8453_channels,
> +		.num_channels = ARRAY_SIZE(mma8453_channels),
> +		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
> +		.ev_cfg = MMA8452_TRANSIENT_CFG,
> +		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> +		.ev_cfg_chan_shift = 1,
> +		.ev_src = MMA8452_TRANSIENT_SRC,
> +		.ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE,
> +		.ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE,
> +		.ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE,
> +		.ev_ths = MMA8452_TRANSIENT_THS,
> +		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
> +		.ev_count = MMA8452_TRANSIENT_COUNT,
> +	},
>  };
> +
>  static struct attribute *mma8452_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> @@ -866,6 +895,7 @@ static int mma8452_reset(struct i2c_client *client)
>  
>  static const struct of_device_id mma8452_dt_ids[] = {
>  	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
> +	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
>  	{ }
>  };
>  
> @@ -880,7 +910,8 @@ static int mma8452_probe(struct i2c_client *client,
>  	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
>  	if (ret < 0)
>  		return ret;
> -	if (ret != MMA8452_DEVICE_ID)
> +
> +	if (ret != MMA8452_DEVICE_ID && ret != MMA8453_DEVICE_ID)
>  		return -ENODEV;
Change this to a switch now as it'll only get uglier as more parts are
added.
>  
>  	match = of_match_device(mma8452_dt_ids, &client->dev);
> @@ -898,6 +929,9 @@ static int mma8452_probe(struct i2c_client *client,
>  	data->chip_info = match->data;
>  	mutex_init(&data->lock);
>  
> +	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
> +		match->compatible, data->chip_info->chip_id);
> +
This bit should probably have been in the previous patch, though as
it's trivial, who really cares ;)  Does explain the chip_id
unused element in the previous patch.  Best bet may be to move it back
to that patch now and solve both issues.
>  	i2c_set_clientdata(client, indio_dev);
>  	indio_dev->info = &mma8452_info;
>  	indio_dev->name = DRIVER_NAME;
> @@ -1024,6 +1058,7 @@ static SIMPLE_DEV_PM_OPS(mma8452_pm_ops, mma8452_suspend, mma8452_resume);
>  
>  static const struct i2c_device_id mma8452_id[] = {
>  	{ "mma8452", mma8452 },
> +	{ "mma8453", mma8453 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mma8452_id);
> 

