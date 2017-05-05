Return-Path: <SRS0=bPqk=4L=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1493978058.30052.26.camel@linux.intel.com>
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and
 ADC128S102
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Sascha Weisenberger
 <sascha.weisenberger@siemens.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>,  Rob Herring <robh@kernel.org>
Date: Fri, 05 May 2017 12:54:18 +0300
In-Reply-To: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2017-05-05 at 08:31 +0200, Jan Kiszka wrote:
> This is an upstream port of an IIO driver for the TI ADC108S102 and
> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
> included.
> 
> Due to the lack of regulators under ACPI, we need a special device
> property to define the voltage provide to the VA pin of the ADC
> ("va-millivolt"). For DT usage, the regulator "vref-supply" is
> requested. Note that DT usage has not been tested.

+1 to what Mika commented on this and just some additional information.

Other than that looks pretty good.

> Changes in v3:
>  - Reworked reference voltage handling, splitting up the different
> ACPI
>    case from DT usage. This also means that the "va-millivolt"
>    (formerly and incorrectly called "ext-vin-microvolt") becomes
>    ACPI-only

Just to be clean, there is *no* such thing as *XYZ-only* device
properties. The idea behind them is to provide resource provider
agnostic API to read properties.

> +			if (st->reg)
> +				*val = regulator_get_voltage(st->reg) 
> / 1000;
> +			else
> +				*val = st->va_millivolt;
> +

Another way is to not just hard code the value, but create a fixed
voltage regulator out of it. In this case you will have one way to get
its value.

> +		st->reg = devm_regulator_get(&spi->dev, "vref");

It should be _optional like I mentioned in one of previous review.

> +	if (!IS_ERR(st->reg))

This is redundant

> +		regulator_disable(st->reg);

> +	if (!IS_ERR(st->reg))

Ditto.

> +		regulator_disable(st->reg);


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
