Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CF3C2D;
	Sat,  5 Sep 2026 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566707; cv=none; b=g5s8vjoAr4ZYrH2sjQ4WSYlB1oHBdxSynQ+xZcPM3AXyfsKW72rudM/ctFHycQwdaTWyMc5XRBrKLhCK34XfolOX4aESUSqhWu4jefU/ooqyshF1RdwGugpK2JZixKYHmOxsqDOo2BENNNj3vvfwemRsS91O+66ljsC08X+IN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566707; c=relaxed/simple;
	bh=N2N96tizgI40KQsD7Az5BDHGwUqcbNBrcU9kLVo0zxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKvE1m0yia5fm4TI8ntuSF3dJE+JowtS3VwsDVEDXeddZ2pFycwMU5MORLOFwJxAE60TtY/vfxsXCKUAIIkOic6g6IgeOxsj5TdWoxRbb05P5jqqRoVhoSu23ziGqi84xruSsE8xAOYOTBrPCBnrfm0fVbdbF7sGs7+/3eiMXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjOoeMQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjOoeMQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232C11F00A3E;
	Sat,  5 Sep 2026 00:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566705;
	bh=7hu+mgRkBuIo6Ezvpol8qB9iQwPz9CHFbnwU1M/c01w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DjOoeMQfvTtlDf9Q2YfWHSKNm7iFaoxxPVC1+ZK2h5LOtJMLB6XYwWw8CCs4xLG36
	 HsQkB3GNwJMzKsjCD7Q63bPWYrc1UgW5YoAsMdxSjgtsFhDtYSNlywm0Ku5p0kOEA3
	 AF8rQGIIVCCGnbKBG+Z/oM1gUw1UCw60e35+pBug8dqbqZZdmgeQadUW/ukUm8QzoQ
	 GGgr2X4AgaayKazQUIzBYn4tmYdjleWRdkdWO6WJMpsn9rtpaDVAh6BFX31JjO+t9C
	 9LzSPbZkP3lYZrOOI1w9AveGZsIwBkuVueVJLmouFESDMc9LEpdEVJ13mFmEsp7zge
	 Tnyk7C94C/C4g==
Date: Sat, 5 Sep 2026 01:04:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, devicetree@vger.kernel.org,
 marcelo.schmitt1@gmail.com, danascape@gmail.com
Subject: Re: [PATCH 1/3] iio: accel: adis16201: merge adis16203 support from
 staging
Message-ID: <20260905010458.3a2c1f44@jic23-huawei>
In-Reply-To: <20260831184201.34416-2-shehryar.amd@gmail.com>
References: <20260831184201.34416-1-shehryar.amd@gmail.com>
	<20260831184201.34416-2-shehryar.amd@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 23:41:59 +0500
Shehryar Ahmad <shehryar.amd@gmail.com> wrote:

> Merge the ADIS16203 360 degree inclinometer driver from staging to
> mainline ADIS16201 driver. Register addresses and external SPI interface
> are identical between both. Some things that differ like write mask, and
> calibbias bit width are handled by per chip struct differ_info, handled
> by of_device_id match data in probe, following the same pattern used in
> adis16475 which selects per-chip data directly via of_device_id.data and
> spi_get_device_match_data(), adis16480 does similar but via a different
> mechanism (index into an array via the SPI ID table).
> 
> Channels arrays are kept separate to avoid dropping const and kmemdup
> would be extra failure point if memory allocation fails and is memory
> inefficient.
> 
> GENMASK is still same instead of range check to keep adis16201 behaviour
> unchanged
> 
> Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
Hi Shehryar,

I suspect I repeated quite a bit of what Andy raised, but various comments
inline.  Spend some time on minimizing the diff and splitting this up
into a series of patches. Each of the following could be multiple
patches.

First tidy ups etc / introduction of device id tables etc.
Second real changes to enable multi parts, but no new parts yet.
Third add the new device support with any stuff unique to that device.

> ---
>  drivers/iio/accel/adis16201.c | 289 ++++++++++++++++++++--------------
>  1 file changed, 174 insertions(+), 115 deletions(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index ba0f97944..ee8efeed2 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
> + * Analog Devices ADIS16201 Inclinometer/Accelerometer and ADIS16203 Inclinometer Driver

Break this into one line per part. Ends up a lot less churn heavy if we add
more in future.

>   *
>   * Copyright 2010 Analog Devices Inc.
>   */
> @@ -13,93 +13,187 @@
>  #include <linux/iio/iio.h>
...

>  
>  /* System Command Register Definition */
> -#define ADIS16201_GLOB_CMD_REG				0x3E
> -#define  ADIS16201_GLOB_CMD_SW_RESET			BIT(7)
> -#define  ADIS16201_GLOB_CMD_FACTORY_RESET		BIT(1)
> +#define ADIS16201_GLOB_CMD_REG				        0x3E
> +#define ADIS16201_GLOB_CMD_SW_RESET			        BIT(7)
> +#define ADIS16203_GLOB_CMD_CLEAR_STAT               BIT(4)
> +#define ADIS16201_GLOB_CMD_FACTORY_RESET		    BIT(1)
>  
> -#define ADIS16201_ERROR_ACTIVE				BIT(14)
> +#define ADIS16201_ERROR_ACTIVE				        BIT(14)

You need a very good reason to change existing driver white space in
register definitions.  Particularly as what you have is worse as it
removes the clear separation between register address and field masks that
those extra little bits of white space where givving.

>  
>  enum adis16201_scan {
> -	ADIS16201_SCAN_ACC_X,
> -	ADIS16201_SCAN_ACC_Y,
> -	ADIS16201_SCAN_INCLI_X,
> -	ADIS16201_SCAN_INCLI_Y,
>  	ADIS16201_SCAN_SUPPLY,
> -	ADIS16201_SCAN_AUX_ADC,
>  	ADIS16201_SCAN_TEMP,
> +	ADIS16201_SCAN_AUX_ADC,
> +	ADIS16201_SCAN_INCLI,
> +	ADIS16201_SCAN_INCLI_Y,
> +	ADIS16201_SCAN_ACC_X,
> +	ADIS16201_SCAN_ACC_Y,
>  };
>  
>  static const u8 adis16201_addresses[] = {
>  	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
>  	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
> -	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI] = ADIS16201_INCL_OFFS_REG,
>  	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
>  };
>  
> +static const struct iio_chan_spec adis16201_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY,
> +	0, 12),
> +	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
> +		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
> +		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16201_INCL_OUT_REG, ADIS16201_SCAN_INCLI,
> +	BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> +	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
> +		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> +	IIO_CHAN_SOFT_TIMESTAMP(7)
> +};
> +
> +static const struct iio_chan_spec adis16203_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
> +	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16201_INCL_OUT_REG, ADIS16201_SCAN_INCLI,
> +		BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
> +	IIO_CHAN_SOFT_TIMESTAMP(4)
> +};
> +
> +struct differ_info {

adis16201_chip_info or something like that. differ_info is not
a naming convention we use in other drivers and is not immediately
obvious to me.  Each instance is data about a chip, not the difference
in anything.


> +	u16 write_mask_incli;
> +	unsigned int incli_scale_val2;
> +	unsigned int read_bits_incli;
> +	const struct iio_chan_spec *arr_chans;
> +	u16 diag_stat_mask;
> +	unsigned int num_chans;
> +};
> +
> +static const struct differ_info adis16201_diff = {
> +	.write_mask_incli = GENMASK(8, 0),
> +	.incli_scale_val2 = 100000,
> +	.read_bits_incli = 9,
> +	.arr_chans = adis16201_channels,
> +	.diag_stat_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
> +	.num_chans = ARRAY_SIZE(adis16201_channels)
> +};
> +
> +static const struct differ_info adis16203_diff = {
> +	.write_mask_incli = GENMASK(13, 0),
> +	.incli_scale_val2 = 25000,
> +	.read_bits_incli = 14,
> +	.arr_chans = adis16203_channels,
> +	.diag_stat_mask = BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
> +	.num_chans = ARRAY_SIZE(adis16203_channels)
> +};
I'd be tempted to shift all this stuff down to where the chan_spec
array originally was. Should give you a more readable diff.
Only the structure definitions should need to be up here, not the
instances.

> +
> +struct adis16201_state {
> +	struct adis adis;
> +	const struct differ_info *info;
> +};
> +
> +static int adis16201_write_raw(struct iio_dev *indio_dev,

If this needs to move, do it in a patch that has a description of why.
Also rewrap parameters to have similar ones on same line if that
line ends up fairly short.

> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask)
> +{
> +	struct adis16201_state *st = iio_priv(indio_dev);
> +	int m;
> +
> +	if (mask != IIO_CHAN_INFO_CALIBBIAS)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_ACCEL:
> +		m = GENMASK(11, 0);
> +		break;
> +	case IIO_INCLI:
> +		m = st->info->write_mask_incli;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return adis_write_reg_16(&st->adis, adis16201_addresses[chan->scan_index],
> +				 val & m);
> +}
> +
>  static int adis16201_read_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
> -			      int *val, int *val2,
> -			      long mask)
> +			      int *val,
> +			      int *val2, long mask)
>  {
> -	struct adis *st = iio_priv(indio_dev);
> +	struct adis16201_state *st = iio_priv(indio_dev);
>  	int ret;
>  	int bits;
>  	u8 addr;
> @@ -126,6 +220,11 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  			*val = -470;
>  			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		case IIO_INCLI:
> +			*val = 0;
> +			*val2 = st->info->incli_scale_val2;
> +			return IIO_VAL_INT_PLUS_MICRO;

Keep the ordering the same. No obvious reason to move it and it will
make the diff more obvious.

>  		case IIO_ACCEL:
>  			/*
>  			 * IIO base unit for sensitivity of accelerometer
> @@ -135,10 +234,6 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  			*val = 0;
>  			*val2 = IIO_G_TO_M_S_2(462400);
>  			return IIO_VAL_INT_PLUS_NANO;
> -		case IIO_INCLI:
> -			*val = 0;
> -			*val2 = 100000;
> -			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -157,13 +252,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  			bits = 12;
>  			break;
>  		case IIO_INCLI:
> -			bits = 9;
> +			bits = st->info->read_bits_incli;
>  			break;
>  		default:
>  			return -EINVAL;
>  		}
>  		addr = adis16201_addresses[chan->scan_index];
> -		ret = adis_read_reg_16(st, addr, &val16);
> +		ret = adis_read_reg_16(&st->adis, addr, &val16);
>  		if (ret)
>  			return ret;
>  
> @@ -174,49 +269,6 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -static int adis16201_write_raw(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       int val,
> -			       int val2,
> -			       long mask)
> -{
> -	struct adis *st = iio_priv(indio_dev);
> -	int m;
> -
> -	if (mask != IIO_CHAN_INFO_CALIBBIAS)
> -		return -EINVAL;
> -
> -	switch (chan->type) {
> -	case IIO_ACCEL:
> -		m = GENMASK(11, 0);
> -		break;
> -	case IIO_INCLI:
> -		m = GENMASK(8, 0);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return adis_write_reg_16(st, adis16201_addresses[chan->scan_index],
> -				 val & m);
> -}
> -
> -static const struct iio_chan_spec adis16201_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0,
> -			 12),
> -	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
> -	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> -	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> -	IIO_CHAN_SOFT_TIMESTAMP(7)
> -};
> -

See above. I think all this code movement can be easily avoided
but maybe I'm missing something.  If it does need moving, separate
patch that makes it clear why.

>  static const struct iio_info adis16201_info = {
>  	.read_raw = adis16201_read_raw,
>  	.write_raw = adis16201_write_raw,
> @@ -224,6 +276,7 @@ static const struct iio_info adis16201_info = {
>  };
>  
>  static const char * const adis16201_status_error_msgs[] = {
> +	[ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",

Bring this in only in the patch (after split) that adds adis16203 support.

>  	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
>  	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
>  	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> @@ -248,56 +301,62 @@ static const struct adis_data adis16201_data = {
>  	.timeouts = &adis16201_timeouts,
>  
>  	.status_error_msgs = adis16201_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
>  };
>  
>  static int adis16201_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> -	struct adis *st;
> +	struct adis16201_state *st;
> +	struct adis_data data = adis16201_data;
Pull the initialization down here rather than copying the const copy
above. Even better do it where you know the remaining value.

	data = (struct adis_data) {
		.whatever =,
	};

>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(struct adis16201_state));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +	st->info = spi_get_device_match_data(spi);

Annoyingly there are baths where that fails because the user is forcing
binding to a part without a matching firmware description so check for NULL and
fail probe if you get it.

>  
>  	indio_dev->name = spi->dev.driver->name;
>  	indio_dev->info = &adis16201_info;
> -
> -	indio_dev->channels = adis16201_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> +	indio_dev->channels = st->info->arr_chans;
> +	indio_dev->num_channels = st->info->num_chans;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> +	data.status_error_mask = st->info->diag_stat_mask;

This is where the adis = bit above belongs.

> +	ret = adis_init(&st->adis, indio_dev, spi, &data);
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
>  	if (ret)
>  		return ret;
>  
> -	ret = __adis_initial_startup(st);
> +	ret = __adis_initial_startup(&st->adis);
>  	if (ret)
>  		return ret;
>  
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
> +static const struct of_device_id adis16201_of_match[] = {
> +	{ .compatible = "adi,adis16201", .data = &adis16201_diff },
> +	{ .compatible = "adi,adis16203", .data = &adis16203_diff },
> +	{ }
> +};
> +
>  static struct spi_driver adis16201_driver = {
>  	.driver = {
> -		.name = "adis16201",
> +		.name = "adis16201_adis16203",
> +		.of_match_table = adis16201_of_match,

Add an of table in a separate patch - including the MODULE_DEVICE_TABLE() stuff
mentioned below.


>  	},
>  	.probe = adis16201_probe,
>  };
>  module_spi_driver(adis16201_driver);
>  
>  MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
> +MODULE_DESCRIPTION("Analog Devices ADIS16201 Inclinometer/Accelerometer and ADIS16203 Inclinometer Driver");

We normally just add 'and similar' for cases like this.   Once there are two
parts the chances of a third become too high to have an ever extending description.
Do that as part of a refactor only patch. As Andy mentioned, this needs
breaking up into no op changes with no new support (in appropriate
sized parts) then introduction of new stuff such as the adis16203 support.

>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("spi:adis16201");
> +MODULE_ALIAS("spi:adis16203");

I'm not sure why we need any explicit MODULE_ALIAS() in here in the first
places vs MODULE_DEVICE_TABLE() calls for the two tables.

Make that change as a precursor patch having verified it should generate the same
effective module alias for the parts already supported (I don't care about the
one you are bringing out of staging - though it should work anyway).

>  MODULE_IMPORT_NS("IIO_ADISLIB");

