Return-Path: <lars@metafoo.de>
Message-ID: <5028FD24.1010307@metafoo.de>
Date: Mon, 13 Aug 2012 15:12:04 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 drivers@analog.com
Subject: Re: [PATCH 22/22] staging:iio:adc: Add AD7791 driver
References: <1344616596-8026-1-git-send-email-lars@metafoo.de> <1344616596-8026-22-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-22-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/10/2012 06:36 PM, Lars-Peter Clausen wrote:
> This patch adds support for the Analog Devices AD7787, AD7788, AD7789, AD7790
> and AD7791 Sigma Delta Analog-to-Digital converters.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> [...]
> +	case IIO_CHAN_INFO_SCALE:
> +		/* The monitor channel uses an internal reference. */
> +		if (chan->address == AD7791_CH_AVDD_MONITOR) {
> +			scale_nv = 5850000000ULL;
> +		} else {
> +			int voltage_uv;
> +
> +			voltage_uv = regulator_get_voltage(st->reg);
> +			if (voltage_uv < 0)
> +				return voltage_uv;
> +			scale_nv = voltage_uv * 1000;
> +		}
> +		if (unipolar)
> +			scale_nv >>= chan->scan_type.realbits;
> +		else
> +			scale_nv >>= chan->scan_type.realbits - 1;
> +		*val2 = do_div(scale_nv, 1000000);
> +		*val = scale_nv;
> +

Just noticed that the scale is off by a factor of 1000. It reports volts
while we want milli volts.

> +		return IIO_VAL_INT_PLUS_NANO;
> +	}
