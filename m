Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59098 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbbGELr2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 07:47:28 -0400
Message-ID: <5599194E.5020207@kernel.org>
Date: Sun, 05 Jul 2015 12:47:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com,
	christoph.muellner@theobroma-systems.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 4/9] iio: mma8452: add support for MMA8652FC and MMA8653FC
 accelerometers
References: <1436018110-3903-1-git-send-email-martink@posteo.de> <1436018110-3903-5-git-send-email-martink@posteo.de>
In-Reply-To: <1436018110-3903-5-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/07/15 14:55, Martin Kepplinger wrote:
> MMA8652FC and MMA8653FC don't provide the transient interrupt source, so
> the motion interrupt source is used by providing a new iio_chan_spec
> definition, so that other supported devices are not affected by this.
> 
> Datasheets for the newly supported devices are available at Freescale's
> website:
> 
> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA8652FC.pdf
> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA8653FC.pdf
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Only really one comment which is a follow through from an earlier suggestion.

Looking good.
> ---
>  drivers/iio/accel/Kconfig   |  2 +-
>  drivers/iio/accel/mma8452.c | 79 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 91fab16..684c8b5 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -93,7 +93,7 @@ config MMA8452
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the following Freescale 3-axis
> -	  accelerometers: MMA8452Q, MMA8453Q.
> +	  accelerometers: MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mma8452.
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 0498b6e..ccce925 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -3,6 +3,8 @@
>   *
>   *	MMA8452Q
>   *	MMA8453Q
> + *	MMA8652FC
> + *	MMA8653FC
>   *
>   * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   *
> @@ -88,6 +90,8 @@
>  
>  #define MMA8452_DEVICE_ID 0x2a
>  #define MMA8453_DEVICE_ID 0x3a
> +#define MMA8652_DEVICE_ID 0x4a
> +#define MMA8653_DEVICE_ID 0x5a
>  
>  struct mma8452_data {
>  	struct i2c_client *client;
> @@ -740,6 +744,26 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
>  }
>  
> +#define MMA8652_CHANNEL(axis, idx, bits) { \
> +	.type = IIO_ACCEL, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_##axis, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +		BIT(IIO_CHAN_INFO_CALIBBIAS), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +		BIT(IIO_CHAN_INFO_SCALE), \
> +	.scan_index = idx, \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = (bits), \
> +		.storagebits = 16, \
> +		.shift = 16 - (bits), \
> +		.endianness = IIO_BE, \
> +	}, \
> +	.event_spec = mma8452_motion_event, \
> +	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
> +}
> +
>  static const struct iio_chan_spec mma8452_channels[] = {
>  	MMA8452_CHANNEL(X, 0, 12),
>  	MMA8452_CHANNEL(Y, 1, 12),
> @@ -754,9 +778,25 @@ static const struct iio_chan_spec mma8453_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +static const struct iio_chan_spec mma8652_channels[] = {
> +	MMA8652_CHANNEL(X, 0, 12),
> +	MMA8652_CHANNEL(Y, 1, 12),
> +	MMA8652_CHANNEL(Z, 2, 12),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const struct iio_chan_spec mma8653_channels[] = {
> +	MMA8652_CHANNEL(X, 0, 10),
> +	MMA8652_CHANNEL(Y, 1, 10),
> +	MMA8652_CHANNEL(Z, 2, 10),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
>  enum {
>  	mma8452,
>  	mma8453,
> +	mma8652,
> +	mma8653,
>  };
>  
>  /*
> @@ -800,6 +840,38 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
>  		.ev_count = MMA8452_TRANSIENT_COUNT,
>  	},
> +	[mma8652] = {
> +		.chip_id = MMA8652_DEVICE_ID,
> +		.channels = mma8652_channels,
> +		.num_channels = ARRAY_SIZE(mma8652_channels),
> +		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
> +		.ev_cfg = MMA8452_FF_MT_CFG,
> +		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
> +		.ev_cfg_chan_shift = 3,
> +		.ev_src = MMA8452_FF_MT_SRC,
> +		.ev_src_xe = MMA8452_FF_MT_SRC_XHE,
> +		.ev_src_ye = MMA8452_FF_MT_SRC_YHE,
> +		.ev_src_ze = MMA8452_FF_MT_SRC_ZHE,
> +		.ev_ths = MMA8452_FF_MT_THS,
> +		.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
> +		.ev_count = MMA8452_FF_MT_COUNT,
> +	},
> +	[mma8653] = {
> +		.chip_id = MMA8653_DEVICE_ID,
> +		.channels = mma8653_channels,
> +		.num_channels = ARRAY_SIZE(mma8653_channels),
> +		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
> +		.ev_cfg = MMA8452_FF_MT_CFG,
> +		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
> +		.ev_cfg_chan_shift = 3,
> +		.ev_src = MMA8452_FF_MT_SRC,
> +		.ev_src_xe = MMA8452_FF_MT_SRC_XHE,
> +		.ev_src_ye = MMA8452_FF_MT_SRC_YHE,
> +		.ev_src_ze = MMA8452_FF_MT_SRC_ZHE,
> +		.ev_ths = MMA8452_FF_MT_THS,
> +		.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
> +		.ev_count = MMA8452_FF_MT_COUNT,
> +	},
>  };
>  
>  static struct attribute *mma8452_attributes[] = {
> @@ -921,6 +993,8 @@ static int mma8452_reset(struct i2c_client *client)
>  static const struct of_device_id mma8452_dt_ids[] = {
>  	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
>  	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
> +	{ .compatible = "fsl,mma8652", .data = &mma_chip_info_table[mma8652] },
> +	{ .compatible = "fsl,mma8653", .data = &mma_chip_info_table[mma8653] },
>  	{ }
>  };
>  
> @@ -936,7 +1010,8 @@ static int mma8452_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret != MMA8452_DEVICE_ID && ret != MMA8453_DEVICE_ID)
> +	if (ret != MMA8452_DEVICE_ID && ret != MMA8453_DEVICE_ID &&
> +	    ret != MMA8652_DEVICE_ID && ret != MMA8653_DEVICE_ID)
And now the advantages of a switch become apparent ;)
switch (ret) {
       case MMA8452_DEVICE_ID:
       case MMA8453_DEVICE_ID:
       ..
       break;
       default:
	  return -ENODEV;

Also, you should really be verifying that not only is it a supported
part, but that it is the one that our board configuration is telling us
is there.

>  		return -ENODEV;
>  
>  	match = of_match_device(mma8452_dt_ids, &client->dev);
> @@ -1086,6 +1161,8 @@ static SIMPLE_DEV_PM_OPS(mma8452_pm_ops, mma8452_suspend, mma8452_resume);
>  static const struct i2c_device_id mma8452_id[] = {
>  	{ "mma8452", mma8452 },
>  	{ "mma8453", mma8453 },
> +	{ "mma8652", mma8652 },
> +	{ "mma8653", mma8653 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mma8452_id);
> 

