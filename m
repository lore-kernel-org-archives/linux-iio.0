Return-Path: <joe@perches.com>
Message-ID: <1393193717.11020.12.camel@joe-AO722>
Subject: Re: [RFCv2 5/5] mfd: twl4030-madc: Move driver to drivers/iio/adc
From: Joe Perches <joe@perches.com>
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, Marek Belisko <marek@goldelico.com>,
 Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant
 Likely <grant.likely@linaro.org>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-iio@vger.kernel.org
Date: Sun, 23 Feb 2014 14:15:17 -0800
In-Reply-To: <1393193271-16717-6-git-send-email-sre@debian.org>
References: <20140223220140.GA1258@earth.universe>
	 <1393193271-16717-1-git-send-email-sre@debian.org>
	 <1393193271-16717-6-git-send-email-sre@debian.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2014-02-23 at 23:07 +0100, Sebastian Reichel wrote:
> This is a driver for an A/D converter, which belongs into
> drivers/iio/adc.

Please use git format-patch -M

> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
[]
> +static int twl4030_madc_read(struct iio_dev *iio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int *val, int *val2, long mask)
> +{
[]
> +	req.do_avg = !!(mask & IIO_CHAN_INFO_AVERAGE_RAW);

It looks like do_avg should be bool not u16
