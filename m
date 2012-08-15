Return-Path: <lars@metafoo.de>
Message-ID: <502B62AC.2030801@metafoo.de>
Date: Wed, 15 Aug 2012 10:49:48 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: "Kim, Milo" <Milo.Kim@ti.com>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "sameo@linux.intel.com" <sameo@linux.intel.com>
Subject: Re: [PATCH v2] iio: adc: add new lp8788 adc driver
References: <A874F61F95741C4A9BA573A70FE3998F41EEF1F7@DQHE02.ent.ti.com>
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F41EEF1F7@DQHE02.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/10/2012 09:06 AM, Kim, Milo wrote:
> [...]
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = result;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = adc_const[id] * ((result * 1000 + 500) / 1000);

This looks wrong. The IIO_CHAN_INFO_SCALE attribute is the factor by which
IIO_CHAN_INFO_RAW needs to be multiplied to get the value in the proper unit,
which is specified in the IIO ABI spec. E.g. milli volts for voltages.

What you return here seems to be the IIO_CHAN_INFO_PROCESSED attribute. Which
basically is raw * scale.

> +		*val2 = 0;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		break;
> +	}
> +
> +err:
> +	return -EINVAL;
> +}
> +
> [...]
> +}
> +
> +static struct iio_chan_spec lp8788_adc_channels[] = {

const

> +	[LPADC_VBATT_5P5] = LP8788_CHAN(VBATT_5P5, IIO_VOLTAGE),
> +	[LPADC_VIN_CHG]   = LP8788_CHAN(VIN_CHG, IIO_VOLTAGE),
> +	[LPADC_IBATT]     = LP8788_CHAN(IBATT, IIO_CURRENT),
> +	[LPADC_IC_TEMP]   = LP8788_CHAN(IC_TEMP, IIO_TEMP),
> +	[LPADC_VBATT_6P0] = LP8788_CHAN(VBATT_6P0, IIO_VOLTAGE),
> +	[LPADC_VBATT_5P0] = LP8788_CHAN(VBATT_5P0, IIO_VOLTAGE),
> +	[LPADC_ADC1]      = LP8788_CHAN(ADC1, IIO_VOLTAGE),
> +	[LPADC_ADC2]      = LP8788_CHAN(ADC2, IIO_VOLTAGE),
> +	[LPADC_VDD]       = LP8788_CHAN(VDD, IIO_VOLTAGE),
> +	[LPADC_VCOIN]     = LP8788_CHAN(VCOIN, IIO_VOLTAGE),
> +	[LPADC_VDD_LDO]   = LP8788_CHAN(VDD_LDO, IIO_VOLTAGE),
> +	[LPADC_ADC3]      = LP8788_CHAN(ADC3, IIO_VOLTAGE),
> +	[LPADC_ADC4]      = LP8788_CHAN(ADC4, IIO_VOLTAGE),
> +};
> +
