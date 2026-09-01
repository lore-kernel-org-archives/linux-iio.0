Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2735E92B;
	Tue,  1 Sep 2026 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250345; cv=none; b=pdGneP2QqhQD5h2/WAtcG++0/RfCsQ/VEihP0d0aWCznCRXXS8lKpfC3qsHDBMqHFI4xOfvSD0s1Mq8tuq5uGBVPBfLNc1r4e3UJjkAtqEnLc5bBZv1SKI78praOFnYB0abRHQZY8cJYeZIhz2pCDWuX5ne/W3gHHhi+vSshi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250345; c=relaxed/simple;
	bh=iNhWQfYq0TqTFxIw2Kpv0c6+V2bz0vFlRgZmYm5pLHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcSu2PGU+rpATRZiPq4b0kgw9dSmp8zmjx2BxgOvy5ryRUEwSdkCbl1PKPtisGAsEgYLEeXSGQCsFaovg1c8JhtayLS4f+5WD6VDRTSm7cJm6wET1KuX4CT+jAM1/yABUwO+7NlaxmE4F1dXoxiCSeb3l1gfS1HIMA/UiaTCm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrcPISnz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrcPISnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788250343; x=1819786343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iNhWQfYq0TqTFxIw2Kpv0c6+V2bz0vFlRgZmYm5pLHU=;
  b=jrcPISnzoJK9hBKBIpF7iVHqRpNz6lzFZ/vI7Nq53VbD4rWdDeY50vcZ
   msmTgvot7NQ1SwaV719MdN4fBUQAPEYAOzrPa2xhQIDyA3OXqpVAFPJGQ
   cxABSW7XqiUfJYq6unfGOVM8dMAHOpIWe/d4iaPm/lSyJiEpiEnjhigdd
   AZAt1pRHklqC+3p0zNbu6KkjVkiSTgD6YBEs0kNtBFxt0t/A9VapTsgEI
   p94Q9ghuhzQE+Fzjc56gfSc80jQHfN4T/9NJUPSQ+ErYIGqL8jLRbblFv
   gkujOhV+b6jTqOq7pIDMuxvQu3T9hppaGb2P03npPDA5xBiLaioqPz1ru
   A==;
X-CSE-ConnectionGUID: urty41aiRwOAeFxqwqNR0Q==
X-CSE-MsgGUID: xAZHVaX8RwO6gdeOukJNgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99006216"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99006216"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:12:22 -0700
X-CSE-ConnectionGUID: tYRDxU/kQmufUkEqP30lyA==
X-CSE-MsgGUID: jAeKmRCDSe6m4U3T4lT3Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="265781422"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:12:12 -0700
Date: Tue, 1 Sep 2026 11:12:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, gregkh@linuxfoundation.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org, marcelo.schmitt1@gmail.com,
	danascape@gmail.com
Subject: Re: [PATCH 1/3] iio: accel: adis16201: merge adis16203 support from
 staging
Message-ID: <apaI2vkeBhyx1pQd@ashevche-desk.local>
References: <20260831184201.34416-1-shehryar.amd@gmail.com>
 <20260831184201.34416-2-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831184201.34416-2-shehryar.amd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 11:41:59PM +0500, Shehryar Ahmad wrote:
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

"GENMASK():s are..." ?

> unchanged

Missing period.

...

Yes, it's a good change, but please split it to 3+ patches. See below.

...

> - * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
> + * Analog Devices ADIS16201 Inclinometer/Accelerometer and ADIS16203 Inclinometer Driver

This needs to be written in the more generic form. Also the same text should be
in MODULE_DESCRIPTION() and in the Summary of the Kconfig help text (which is
missing to update). This will be part of the patch that adds the new HW.

...

>   * Copyright 2010 Analog Devices Inc.

This probably needs to be merged as well. I haven't checked the actual lines in
the other driver, though.

...

> -#define ADIS16201_STARTUP_DELAY_MS			220
> -#define ADIS16201_FLASH_CNT				0x00
> +#define ADIS16201_STARTUP_DELAY_MS			        220
> +#define ADIS16201_FLASH_CNT					        0x00
>  
>  /* Data Output Register Information */
> -#define ADIS16201_SUPPLY_OUT_REG			0x02
> -#define ADIS16201_XACCL_OUT_REG				0x04
> -#define ADIS16201_YACCL_OUT_REG				0x06
> -#define ADIS16201_AUX_ADC_REG				0x08
> -#define ADIS16201_TEMP_OUT_REG				0x0A
> -#define ADIS16201_XINCL_OUT_REG				0x0C
> -#define ADIS16201_YINCL_OUT_REG				0x0E
> +#define ADIS16201_SUPPLY_OUT_REG					0x02
> +#define ADIS16201_XACCL_OUT_REG				        0x04
> +#define ADIS16201_YACCL_OUT_REG				        0x06
> +#define ADIS16201_AUX_ADC_REG				        0x08
> +#define ADIS16201_TEMP_OUT_REG				        0x0A
> +#define ADIS16201_INCL_OUT_REG		                0x0C
> +#define ADIS16201_YINCL_OUT_REG				        0x0E
>  
>  /* Calibration Register Definition */
> -#define ADIS16201_XACCL_OFFS_REG			0x10
> -#define ADIS16201_YACCL_OFFS_REG			0x12
> -#define ADIS16201_XACCL_SCALE_REG			0x14
> -#define ADIS16201_YACCL_SCALE_REG			0x16
> -#define ADIS16201_XINCL_OFFS_REG			0x18
> -#define ADIS16201_YINCL_OFFS_REG			0x1A
> -#define ADIS16201_XINCL_SCALE_REG			0x1C
> -#define ADIS16201_YINCL_SCALE_REG			0x1E
> +#define ADIS16201_XACCL_OFFS_REG			        0x10
> +#define ADIS16201_YACCL_OFFS_REG			        0x12
> +#define ADIS16201_XACCL_SCALE_REG			        0x14
> +#define ADIS16201_YACCL_SCALE_REG			        0x16
> +#define ADIS16201_INCL_OFFS_REG			            0x18
> +#define ADIS16201_YINCL_OFFS_REG			        0x1A
> +#define ADIS16201_XINCL_SCALE_REG			        0x1C
> +#define ADIS16201_YINCL_SCALE_REG			        0x1E
>  
>  /* Alarm Register Definition */
> -#define ADIS16201_ALM_MAG1_REG				0x20
> -#define ADIS16201_ALM_MAG2_REG				0x22
> -#define ADIS16201_ALM_SMPL1_REG				0x24
> -#define ADIS16201_ALM_SMPL2_REG				0x26
> -#define ADIS16201_ALM_CTRL_REG				0x28
> -
> -#define ADIS16201_AUX_DAC_REG				0x30
> -#define ADIS16201_GPIO_CTRL_REG				0x32
> -#define ADIS16201_SMPL_PRD_REG				0x36
> +#define ADIS16201_ALM_MAG1_REG				        0x20
> +#define ADIS16201_ALM_MAG2_REG				        0x22
> +#define ADIS16201_ALM_SMPL1_REG				        0x24
> +#define ADIS16201_ALM_SMPL2_REG				        0x26
> +#define ADIS16201_ALM_CTRL_REG				        0x28
> +
> +#define ADIS16201_AUX_DAC_REG						0x30
> +#define ADIS16201_GPIO_CTRL_REG						0x32
> +#define ADIS16201_SMPL_PRD_REG						0x36
> +
>  /* Operation, filter configuration */
> -#define ADIS16201_AVG_CNT_REG				0x38
> -#define ADIS16201_SLP_CNT_REG				0x3A
> +#define ADIS16201_AVG_CNT_REG				        0x38
> +#define ADIS16201_SLP_CNT_REG				        0x3A

Make indentation changes either separate or do not touch these lines at all,
it's very hard to check if there were any real changes (in the offsets
and/or names).

...

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

Why do you need to reshuffle the enum? This needs a good justification and
explanation why it's not a problem for the existing support.

...

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

Keep trailing commas in non-termination entries (yes, while it looks like
the end of the list, strictly speaking it's not). Same for the rest of the
similar cases.

> +};

...

> +struct differ_info {
> +	u16 write_mask_incli;
> +	unsigned int incli_scale_val2;
> +	unsigned int read_bits_incli;
> +	const struct iio_chan_spec *arr_chans;
> +	u16 diag_stat_mask;
> +	unsigned int num_chans;

Always run `pahole` when do some data type changes or introduction. This one
may have unneeded gaps.

> +};

...

> +static const struct differ_info adis16201_diff = {
> +	.write_mask_incli = GENMASK(8, 0),
> +	.incli_scale_val2 = 100000,

Would it make sense to use multipliers from units.h or elsewhere?

> +	.read_bits_incli = 9,
> +	.arr_chans = adis16201_channels,
> +	.diag_stat_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),

Make the BIT() indented in the same way, I recommend to have

	.diag_stat_mask =
		BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |

> +	.num_chans = ARRAY_SIZE(adis16201_channels)
> +};

...

> +static const struct differ_info adis16203_diff = {

Same comments as per above.

> +};

...

> +static int adis16201_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,

> +			       int val,
> +			       int val2,
> +			       long mask)

There is room for all three on the one line.

> +{
> +	struct adis16201_state *st = iio_priv(indio_dev);
> +	int m;

Why signed?

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

Apply mask to the valu directly in the switch case, drop 'm'.

With

	struct adis *adis = ...;

and the above suggestion this becomes

	return adis_write_reg_16(adis, adis16201_addresses[chan->scan_index], val);

> +}

...

>  static int adis16201_read_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
> -			      int *val, int *val2,
> -			      long mask)
> +			      int *val,
> +			      int *val2, long mask)

This is stray change. Why?!

>  {

...

> +		case IIO_INCLI:
> +			*val = 0;
> +			*val2 = st->info->incli_scale_val2;
> +			return IIO_VAL_INT_PLUS_MICRO;


> -		case IIO_INCLI:
> -			*val = 0;
> -			*val2 = 100000;
> -			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;

Same Q.

...

Now, looking at the above I see an additional preparatory patch, id est
the new data type (struct adis16201_state) that wraps existing one. In
the following changes you may extend it as required.

...

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

Ah, this code is moved up and being modified. So, split this to a few patches:

- move this function up (no changes, explain why you will need it up)
- modify as I suggested above (apply mast directly to the value)
- add your changes in the final (big) patch

...

>  	struct iio_dev *indio_dev;
> -	struct adis *st;
> +	struct adis16201_state *st;
> +	struct adis_data data = adis16201_data;
>  	int ret;

> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(struct adis16201_state));

Why?!

>  	if (!indio_dev)
>  		return -ENOMEM;

...

> +	st->info = spi_get_device_match_data(spi);

This should be checked against NULL and ENODATA to be returned otherwise.

Also switching to chip_info should go separately.

...

>  	indio_dev->name = spi->dev.driver->name;

This needs to be part of the chip_info structure.

...

> +static const struct of_device_id adis16201_of_match[] = {
> +	{ .compatible = "adi,adis16201", .data = &adis16201_diff },
> +	{ .compatible = "adi,adis16203", .data = &adis16203_diff },
> +	{ }
> +};

Missing MODULE_DEVICE_TABLE() (IIRC the macro name). Also this needs to be
added in a separate patch.

...

>  static struct spi_driver adis16201_driver = {
>  	.driver = {
> -		.name = "adis16201",
> +		.name = "adis16201_adis16203",
> +		.of_match_table = adis16201_of_match,
>  	},
>  	.probe = adis16201_probe,
>  };
>  module_spi_driver(adis16201_driver);

...

>  MODULE_ALIAS("spi:adis16201");
> +MODULE_ALIAS("spi:adis16203");

No, make proper SPI ID table to be present instead (in a separate patch)

...

Overall I counted something like 7 patches this one has to be split into.

-- 
With Best Regards,
Andy Shevchenko


