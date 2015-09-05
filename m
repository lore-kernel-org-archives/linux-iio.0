Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41751 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbIEQ4R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 12:56:17 -0400
Subject: Re: [PATCH 2/6] iio: mma8452: add support for MMA8453Q accelerometer
 chip
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
References: <1441107913-4112-1-git-send-email-martink@posteo.de>
 <1441107913-4112-3-git-send-email-martink@posteo.de>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55EB1EAE.6010508@kernel.org>
Date: Sat, 5 Sep 2015 17:56:14 +0100
MIME-Version: 1.0
In-Reply-To: <1441107913-4112-3-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/15 12:45, Martin Kepplinger wrote:
> This adds support for the 10 bit version if Freescale's accelerometers
> of this series. The datasheet is available at Freescale's website:
> 
> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA8453Q.pdf
> 
> It creates a devicetree bindings file to document the new functionality
> and removes the driver from the trivial-devices list.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Another nice patch.  My only comment is that it might be worth adding
a cross reference in the bindings docs to the interrupt docs.

I'll probably take it as is after letting it sit for a little longer, but
if you are rerolling for another reason that would be a nice addition.

Jonathan
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    |  1 -
>  .../devicetree/bindings/iio/accel/mma8452.txt      | 22 +++++++++++++
>  drivers/iio/accel/Kconfig                          |  6 ++--
>  drivers/iio/accel/mma8452.c                        | 37 ++++++++++++++++++++--
>  4 files changed, 59 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index d77d412..a50e56d 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -54,7 +54,6 @@ epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
>  fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
>  fsl,mc13892		MC13892: Power Management Integrated Circuit (PMIC) for i.MX35/51
>  fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
> -fsl,mma8452		MMA8452Q: 3-axis 12-bit / 8-bit Digital Accelerometer
>  fsl,mpr121		MPR121: Proximity Capacitive Touch Sensor Controller
>  fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
>  gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> new file mode 100644
> index 0000000..c3bc272
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> @@ -0,0 +1,22 @@
> +Freescale MMA8452Q or MMA8453Q triaxial accelerometer
> +
> +Required properties:
> +
> +  - compatible: should contain one of
> +    * "fsl,mma8452"
> +    * "fsl,mma8453"
> +  - reg: the I2C address of the chip
> +
> +Optional properties:
> +
> +  - interrupt-parent: should be the phandle for the interrupt controller
> +  - interrupts: interrupt mapping for GPIO IRQ
Only comment here is that usual convention is to cross reference the
interrupt docs as their are lots of weird corner cases that we don't
have to care about documenting for every device.
> +
> +Example:
> +
> +	mma8453fc@1d {
> +		compatible = "fsl,mma8453";
> +		reg = <0x1d>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <5 0>;
> +	};
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index a59047d..e4075a0 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -100,13 +100,13 @@ config KXCJK1013
>  	  be called kxcjk-1013.
>  
>  config MMA8452
> -	tristate "Freescale MMA8452Q Accelerometer Driver"
> +	tristate "Freescale MMA8452Q and similar Accelerometers Driver"
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
> index f28428fa..7b2ab17 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1,5 +1,8 @@
>  /*
> - * mma8452.c - Support for Freescale MMA8452Q 3-axis 12-bit accelerometer
> + * mma8452.c - Support for following Freescale 3-axis accelerometers:
> + *
> + * MMA8452Q (12 bit)
> + * MMA8453Q (10 bit)
>   *
>   * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   *
> @@ -26,7 +29,7 @@
>  
>  #define MMA8452_STATUS				0x00
>  #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
> -#define MMA8452_OUT_X				0x01 /* MSB first, 12-bit  */
> +#define MMA8452_OUT_X				0x01 /* MSB first */
>  #define MMA8452_OUT_Y				0x03
>  #define MMA8452_OUT_Z				0x05
>  #define MMA8452_INT_SRC				0x0c
> @@ -69,6 +72,7 @@
>  #define  MMA8452_INT_TRANS			BIT(5)
>  
>  #define  MMA8452_DEVICE_ID			0x2a
> +#define  MMA8453_DEVICE_ID			0x3a
>  
>  struct mma8452_data {
>  	struct i2c_client *client;
> @@ -768,8 +772,16 @@ static const struct iio_chan_spec mma8452_channels[] = {
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
>  static const struct mma_chip_info mma_chip_info_table[] = {
> @@ -796,6 +808,22 @@ static const struct mma_chip_info mma_chip_info_table[] = {
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
>  
>  static struct attribute *mma8452_attributes[] = {
> @@ -917,6 +945,7 @@ static int mma8452_reset(struct i2c_client *client)
>  
>  static const struct of_device_id mma8452_dt_ids[] = {
>  	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
> +	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
> @@ -932,7 +961,8 @@ static int mma8452_probe(struct i2c_client *client,
>  	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
>  	if (ret < 0)
>  		return ret;
> -	if (ret != MMA8452_DEVICE_ID)
> +
> +	if (ret != MMA8452_DEVICE_ID && ret != MMA8453_DEVICE_ID)
>  		return -ENODEV;
>  
>  	match = of_match_device(mma8452_dt_ids, &client->dev);
> @@ -1079,6 +1109,7 @@ static SIMPLE_DEV_PM_OPS(mma8452_pm_ops, mma8452_suspend, mma8452_resume);
>  
>  static const struct i2c_device_id mma8452_id[] = {
>  	{ "mma8452", mma8452 },
> +	{ "mma8453", mma8453 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mma8452_id);
> 

