Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:48045 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751919AbdEEJkO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 May 2017 05:40:14 -0400
Date: Fri, 5 May 2017 12:40:09 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and ADC128S102
Message-ID: <20170505094009.GP2697@lahna.fi.intel.com>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 05, 2017 at 08:31:32AM +0200, Jan Kiszka wrote:
> +static int adc108s102_probe(struct spi_device *spi)
> +{
> +	struct adc108s102_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	if (ACPI_COMPANION(&spi->dev)) {
> +		st->reg = NULL;
> +		ret = device_property_read_u32(&spi->dev, "va-millivolt",
> +					    &st->va_millivolt);

Please try to avoid things like this for now. You can just hard code the
voltage now and we can think how to solve this in ACPI if there will be
an actual user needing anything else than the voltage you are using on
your board.

> +		if (ret < 0) {
> +			dev_err(&spi->dev,
> +				"Missing va-millivolt device property\n");
> +			return -ENODEV;
> +		}
> +	} else {
> +		st->reg = devm_regulator_get(&spi->dev, "vref");
> +		if (IS_ERR(st->reg))
> +			return PTR_ERR(st->reg);

This should be an optional regulator and in case of ACPI you just don't
have it.

> +
> +		ret = regulator_enable(st->reg);
> +		if (ret < 0) {
> +			dev_err(&spi->dev, "Cannot enable vref regulator\n");
> +			return ret;
> +		}
> +	}
