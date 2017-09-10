Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbdIJQPU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 12:15:20 -0400
Date: Sun, 10 Sep 2017 17:15:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: adc: mcp320x: Add support for mcp3550/1/3
Message-ID: <20170910171514.714abfdd@archlinux>
In-Reply-To: <77df087e5d4a8954b3a7e019372884b877583558.1504807204.git.lukas@wunner.de>
References: <cover.1504807204.git.lukas@wunner.de>
        <77df087e5d4a8954b3a7e019372884b877583558.1504807204.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 9 Sep 2017 20:32:41 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> These ADCs are marketed as single-channel 22 bit delta-sigma ADCs, but
> in reality their resolution is 21 bit with an overrange or underrange
> of 12% beyond Vref.  In other words, "full scale" means +/- 2^20.
> 
> This driver does not explicitly signal back to the user when an
> overrange or underrange occurs, but the user can detect it by comparing
> the raw value to +/- 2^20 (or the scaled value to Vref).
> 
> The chips feature an extended temperature range and high accuracy,
> low noise characteristics, but their conversion times are slow with
> up to 80 ms +/- 2% (on the MCP3550-50).
> 
> Hence, unlike the other ADCs supported by the driver, conversion does
> not take place in realtime upon lowering CS.  Instead, CS is asserted
> for 8 usec to start the conversion.  After waiting for the duration of
> the conversion, the result can be fetched.  While waiting, control of
> the bus is ceased so it may be used by a different device.
> 
> After the result has been fetched and 10 us have passed, the chip goes
> into shutdown and an additional power-up delay of 144 clock periods is
> then required to wake the analog circuitry upon the next conversion
> (footnote below table 4-1, page 16 in the spec).
> 
> Optionally, the chips can be used in so-called "continuous conversion
> mode":  Conversions then take place continuously and the last result may
> be fetched at any time without observing a delay.  The mode is enabled
> by permanently driving CS low, e.g. by wiring it to ground.  The driver
> only supports "single conversion mode" for now but should be adaptable
> to "continuous conversion mode" with moderate effort.
> 
> The chips clock out a 3 byte word, unlike the other ADCs supported by
> the driver which all have a lower resolution than 16 bit and thus make
> do with 2 bytes.  Calculate the word length on probe by rounding up the
> resolution to full bytes.  Crucially, if the clock idles low, the
> transfer is preceded by a useless Data Ready bit which increases its
> length from 24 bit to 25 bit = 4 bytes (section 5.5 in the spec).
> Autosense this based on the SPI slave's configuration.
> 
> Cc: Mathias Duckeck <m.duckeck@kunbus.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Excellent.  Applied to the togreg branch of iio.git and pushed out as
testing.

Thanks,

Jonathan

> ---
> Changes since v1:
> - Move kerneldoc to separate patch. (Jonathan)
> 
> - Move support for continuous conversion mode to separate patch
>   which is marked informational / not for merging. (Rob, Jonathan)
> 
> - Rework calculation of raw value in patch [5/6]:  Instead of
>   byte-wise mangling, convert the big endian value clocked out
>   by the chip to host byte order and mangle the resulting 32-bit
>   value.  Reduces the amount of code and improves readability as
>   the bit numbers referenced in the code comment and datasheet
>   are used verbatim in the code.
> 
> - Use switch/case-statement instead of if-clause when applying
>   chip-specific quirks in mcp320x_probe(). (Jonathan)
> 
> - Expand code comment explaining the two consecutive conversions
>   in mcp320x_probe(). (Jonathan)
> 
>  drivers/iio/adc/Kconfig   |   5 +-
>  drivers/iio/adc/mcp320x.c | 120 ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 118 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 57625653fcb6..84dd04621650 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -475,12 +475,13 @@ config	MAX9611
>  	  called max9611.
>  
>  config MCP320X
> -	tristate "Microchip Technology MCP3x01/02/04/08"
> +	tristate "Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3"
>  	depends on SPI
>  	help
>  	  Say yes here to build support for Microchip Technology's
>  	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204,
> -	  MCP3208 or MCP3301 analog to digital converter.
> +	  MCP3208, MCP3301, MCP3550, MCP3551 and MCP3553 analog to digital
> +	  converters.
>  
>  	  This driver can also be built as a module. If so, the module will be
>  	  called mcp320x.
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 32859188d653..a04856d8afdb 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -19,6 +19,11 @@
>   * ------------
>   * 13 bit converter
>   * MCP3301
> + * ------------
> + * 22 bit converter
> + * MCP3550
> + * MCP3551
> + * MCP3553
>   *
>   * Datasheet can be found here:
>   * http://ww1.microchip.com/downloads/en/DeviceDoc/21293C.pdf  mcp3001
> @@ -28,6 +33,7 @@
>   * http://ww1.microchip.com/downloads/en/DeviceDoc/21034D.pdf  mcp3202
>   * http://ww1.microchip.com/downloads/en/DeviceDoc/21298c.pdf  mcp3204/08
>   * http://ww1.microchip.com/downloads/en/DeviceDoc/21700E.pdf  mcp3301
> + * http://ww1.microchip.com/downloads/en/DeviceDoc/21950D.pdf  mcp3550/1/3
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -51,12 +57,17 @@ enum {
>  	mcp3204,
>  	mcp3208,
>  	mcp3301,
> +	mcp3550_50,
> +	mcp3550_60,
> +	mcp3551,
> +	mcp3553,
>  };
>  
>  struct mcp320x_chip_info {
>  	const struct iio_chan_spec *channels;
>  	unsigned int num_channels;
>  	unsigned int resolution;
> +	unsigned int conv_time; /* usec */
>  };
>  
>  /**
> @@ -64,6 +75,8 @@ struct mcp320x_chip_info {
>   * @spi: SPI slave (parent of the IIO device)
>   * @msg: SPI message to select a channel and receive a value from the ADC
>   * @transfer: SPI transfers used by @msg
> + * @start_conv_msg: SPI message to start a conversion by briefly asserting CS
> + * @start_conv_transfer: SPI transfer used by @start_conv_msg
>   * @reg: regulator generating Vref
>   * @lock: protects read sequences
>   * @chip_info: ADC properties
> @@ -74,13 +87,15 @@ struct mcp320x {
>  	struct spi_device *spi;
>  	struct spi_message msg;
>  	struct spi_transfer transfer[2];
> +	struct spi_message start_conv_msg;
> +	struct spi_transfer start_conv_transfer;
>  
>  	struct regulator *reg;
>  	struct mutex lock;
>  	const struct mcp320x_chip_info *chip_info;
>  
>  	u8 tx_buf ____cacheline_aligned;
> -	u8 rx_buf[2];
> +	u8 rx_buf[4];
>  };
>  
>  static int mcp320x_channel_to_tx_data(int device_index,
> @@ -109,6 +124,15 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>  {
>  	int ret;
>  
> +	if (adc->chip_info->conv_time) {
> +		ret = spi_sync(adc->spi, &adc->start_conv_msg);
> +		if (ret < 0)
> +			return ret;
> +
> +		usleep_range(adc->chip_info->conv_time,
> +			     adc->chip_info->conv_time + 100);
> +	}
> +
>  	memset(&adc->rx_buf, 0, sizeof(adc->rx_buf));
>  	if (adc->chip_info->num_channels > 1)
>  		adc->tx_buf = mcp320x_channel_to_tx_data(device_index, channel,
> @@ -139,6 +163,31 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>  		*val = sign_extend32((adc->rx_buf[0] & 0x1f) << 8
>  				    | adc->rx_buf[1], 12);
>  		return 0;
> +	case mcp3550_50:
> +	case mcp3550_60:
> +	case mcp3551:
> +	case mcp3553: {
> +		u32 raw = be32_to_cpup((u32 *)adc->rx_buf);
> +
> +		if (!(adc->spi->mode & SPI_CPOL))
> +			raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
> +
> +		/*
> +		 * If the input is within -vref and vref, bit 21 is the sign.
> +		 * Up to 12% overrange or underrange are allowed, in which case
> +		 * bit 23 is the sign and bit 0 to 21 is the value.
> +		 */
> +		raw >>= 8;
> +		if (raw & BIT(22) && raw & BIT(23))
> +			return -EIO; /* cannot have overrange AND underrange */
> +		else if (raw & BIT(22))
> +			raw &= ~BIT(22); /* overrange */
> +		else if (raw & BIT(23) || raw & BIT(21))
> +			raw |= GENMASK(31, 22); /* underrange or negative */
> +
> +		*val = (s32)raw;
> +		return 0;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -297,6 +346,31 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
>  		.num_channels = ARRAY_SIZE(mcp3201_channels),
>  		.resolution = 13
>  	},
> +	[mcp3550_50] = {
> +		.channels = mcp3201_channels,
> +		.num_channels = ARRAY_SIZE(mcp3201_channels),
> +		.resolution = 21,
> +		/* 2% max deviation + 144 clock periods to exit shutdown */
> +		.conv_time = 80000 * 1.02 + 144000 / 102.4,
> +	},
> +	[mcp3550_60] = {
> +		.channels = mcp3201_channels,
> +		.num_channels = ARRAY_SIZE(mcp3201_channels),
> +		.resolution = 21,
> +		.conv_time = 66670 * 1.02 + 144000 / 122.88,
> +	},
> +	[mcp3551] = {
> +		.channels = mcp3201_channels,
> +		.num_channels = ARRAY_SIZE(mcp3201_channels),
> +		.resolution = 21,
> +		.conv_time = 73100 * 1.02 + 144000 / 112.64,
> +	},
> +	[mcp3553] = {
> +		.channels = mcp3201_channels,
> +		.num_channels = ARRAY_SIZE(mcp3201_channels),
> +		.resolution = 21,
> +		.conv_time = 16670 * 1.02 + 144000 / 122.88,
> +	},
>  };
>  
>  static int mcp320x_probe(struct spi_device *spi)
> @@ -304,7 +378,7 @@ static int mcp320x_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	struct mcp320x *adc;
>  	const struct mcp320x_chip_info *chip_info;
> -	int ret;
> +	int ret, device_index;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
>  	if (!indio_dev)
> @@ -320,7 +394,8 @@ static int mcp320x_probe(struct spi_device *spi)
>  	indio_dev->info = &mcp320x_info;
>  	spi_set_drvdata(spi, indio_dev);
>  
> -	chip_info = &mcp320x_chip_infos[spi_get_device_id(spi)->driver_data];
> +	device_index = spi_get_device_id(spi)->driver_data;
> +	chip_info = &mcp320x_chip_infos[device_index];
>  	indio_dev->channels = chip_info->channels;
>  	indio_dev->num_channels = chip_info->num_channels;
>  
> @@ -329,7 +404,8 @@ static int mcp320x_probe(struct spi_device *spi)
>  	adc->transfer[0].tx_buf = &adc->tx_buf;
>  	adc->transfer[0].len = sizeof(adc->tx_buf);
>  	adc->transfer[1].rx_buf = adc->rx_buf;
> -	adc->transfer[1].len = sizeof(adc->rx_buf);
> +	adc->transfer[1].len = DIV_ROUND_UP(chip_info->resolution, 8);
> +
>  	if (chip_info->num_channels == 1)
>  		/* single-channel converters are rx only (no MOSI pin) */
>  		spi_message_init_with_transfers(&adc->msg,
> @@ -338,6 +414,32 @@ static int mcp320x_probe(struct spi_device *spi)
>  		spi_message_init_with_transfers(&adc->msg, adc->transfer,
>  						ARRAY_SIZE(adc->transfer));
>  
> +	switch (device_index) {
> +	case mcp3550_50:
> +	case mcp3550_60:
> +	case mcp3551:
> +	case mcp3553:
> +		/* rx len increases from 24 to 25 bit in SPI mode 0,0 */
> +		if (!(spi->mode & SPI_CPOL))
> +			adc->transfer[1].len++;
> +
> +		/* conversions are started by asserting CS pin for 8 usec */
> +		adc->start_conv_transfer.delay_usecs = 8;
> +		spi_message_init_with_transfers(&adc->start_conv_msg,
> +						&adc->start_conv_transfer, 1);
> +
> +		/*
> +		 * If CS was previously kept low (continuous conversion mode)
> +		 * and then changed to high, the chip is in shutdown.
> +		 * Sometimes it fails to wake from shutdown and clocks out
> +		 * only 0xffffff.  The magic sequence of performing two
> +		 * conversions without delay between them resets the chip
> +		 * and ensures all subsequent conversions succeed.
> +		 */
> +		mcp320x_adc_conversion(adc, 0, 1, device_index, &ret);
> +		mcp320x_adc_conversion(adc, 0, 1, device_index, &ret);
> +	}
> +
>  	adc->reg = devm_regulator_get(&spi->dev, "vref");
>  	if (IS_ERR(adc->reg))
>  		return PTR_ERR(adc->reg);
> @@ -392,6 +494,10 @@ static const struct of_device_id mcp320x_dt_ids[] = {
>  	{ .compatible = "microchip,mcp3204" },
>  	{ .compatible = "microchip,mcp3208" },
>  	{ .compatible = "microchip,mcp3301" },
> +	{ .compatible = "microchip,mcp3550-50" },
> +	{ .compatible = "microchip,mcp3550-60" },
> +	{ .compatible = "microchip,mcp3551" },
> +	{ .compatible = "microchip,mcp3553" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
> @@ -407,6 +513,10 @@ static const struct spi_device_id mcp320x_id[] = {
>  	{ "mcp3204", mcp3204 },
>  	{ "mcp3208", mcp3208 },
>  	{ "mcp3301", mcp3301 },
> +	{ "mcp3550-50", mcp3550_50 },
> +	{ "mcp3550-60", mcp3550_60 },
> +	{ "mcp3551", mcp3551 },
> +	{ "mcp3553", mcp3553 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, mcp320x_id);
> @@ -423,5 +533,5 @@ static struct spi_driver mcp320x_driver = {
>  module_spi_driver(mcp320x_driver);
>  
>  MODULE_AUTHOR("Oskar Andero <oskar.andero@gmail.com>");
> -MODULE_DESCRIPTION("Microchip Technology MCP3x01/02/04/08");
> +MODULE_DESCRIPTION("Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3");
>  MODULE_LICENSE("GPL v2");

