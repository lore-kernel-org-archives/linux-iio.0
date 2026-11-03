Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702843;
	b=rjQo9DDLV76SIaDDQMlXT9fuWG5+q5nJrxK/2LKF66Vnc7ph/wkFoP3Bc+T9dHP9Chif
	 fRGFqsRlMrAPfcAwsnpLxS/LaABI28GR2poPMQErXvSgw/cEJ+cShNFctakDIrSsAvxF2
	 +MikhkPWXMvA0N403b20gvCt/o/h3ghGLs+hG8AK7DanD6Ajd5qMwNbL2sIN2I9ubTxHy
	 yAEoOr/MzCYZB0yCBWAg8whHk46VgVE+vqnsGxjXT221+NyMVLuNR/N1znN0IUNfwHzv0
	 HDqs1VXzgYVIL/nFOlPXQnBVpVsKAtdZE6o7JTFpVDSOxSFzrvBni1jJ+V0EL7kFvxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702843;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=SkUcxZ1t63MePeSMW2Wu2q33BJB/cbn4zP9hnNeC3Q4=;
	b=RBzO9z6VYCnocVu7viS4IpkPIBz+0iNkKabeYoMmWcqRilap3+7fI2g7itpnCCinvDl5
	 +2TR5F0i0nchT8f3IQFbUFcdMOhcVTxh5baOnfKmJ7+eBUHVBAt8pPmAFFih3ojNiFUfR
	 1O6ku4KAYcS3tAeGrazVJeXOkNukXSbSw/XB2A8/EUquuo30m++rycKCs0QzgLrDBI0Bs
	 xZ/kLuym9ytm+/W61RSp/UXRt48H+D+y3WDxM6D3AUtxRhfe8LsTWEqVk1GXWgoaVwJ9Z
	 DFdiJbjpRDCr8Eo658UC7hLn/gSbCCQRnE9/FHbxEZNjKWu4g5FrXL77ubRLGS3g8/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="cT/Z/88J";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E7606F7F5;
	Tue,  3 Nov 2026 10:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 300E7606F7F5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cT/Z/88J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793702842; x=1825238842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oyoUK38FkkANBumPrhhkNVYPQ3RbXsytpYkdsY/NfX8=;
  b=cT/Z/88Jzcha2+5aMDhnJ0caE00hwijNwzOpMwBkKobGi4lBIgZBLvay
   UCfPh94338eiK+EPq1KRzF4n+VNlCfXYO4jhogUeyFONbhpenXCML+Xvo
   PT0Q6e4WlytuaC6A7ISfaPM/0oYROPSCFUa/dqYNrGMo0z7jhejEn6QBz
   FUfktbRrssbixtWY2ZYw/UC8wnXkZJQC6yw2qqXcGA26vDayaRMkozQNH
   Xyea35XXCJfIenuHNKRvyS1LniiE11doEtStZPchWi1oy5N6+EjHdV5rj
   y6YUXcgDq3x8SYi6S28KAJ5oB1Uf3UNMSp5wMDZd732dh0+RKtILhV7oJ
   g==;
X-CSE-ConnectionGUID: VyzEIqYbSKq3Rw2JUzAm/A==
X-CSE-MsgGUID: n/hJQqoPQECAgPTWJu4KpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2301022"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2301022"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:47:21 -0800
X-CSE-ConnectionGUID: pwN/pBCzQ9+D0Ol6T40Xcw==
X-CSE-MsgGUID: WffITHA7QsGtfFS1Mex6tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8179559"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:47:17 -0800
Date: Tue, 3 Nov 2026 12:47:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <aum7smuAHnSSb69e@ashevche-desk.local>
References: <20261102201155.10948-1-olivier@mgcrea.io>
 <20261102201155.10948-3-olivier@mgcrea.io>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102201155.10948-3-olivier@mgcrea.io>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 09:11:55PM +0100, Olivier Louvignes wrote:
> The X1600's SAR ADC has four auxiliary channels, each with its own start
> bit, interrupt flag and 12-bit result, and none of the touchscreen or
> battery engines of the JZ47xx ADCs that ingenic-adc drives. Add a small
> driver that exposes the four channels as voltages against the 3.3 V
> reference.
> 
> The registers are in chapter 19 of the X1600 programming manual. The
> ADC clock divider is even, as the manual has it (an odd value divides
> by one less); the vendor kernel writes the divider minus one, which
> gives a slightly faster clock than it asks for.
> 
> Tested on a HiBy R1, whose play/pause and volume keys sit on channel 0
> behind adc-keys: all three read and report correctly.

A few nit-picks below, otherwise feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +static int x1600_adc_read_raw_channel(struct x1600_adc *adc, unsigned int ch, int *val)
> +{
> +	unsigned int bank, shift;
> +	int ret = 0;
> +	u32 enable, data;

Keep reversed xmas tree order, also split assignment.

	unsigned int bank, shift;
	u32 enable, data;
	int ret;


> +	guard(mutex)(&adc->lock);
> +
> +	reinit_completion(&adc->done);
> +	x1600_adc_write(adc, X1600_ADC_REG_STATUS, BIT(ch));
> +	enable = x1600_adc_read(adc, X1600_ADC_REG_ENABLE);
> +	x1600_adc_write(adc, X1600_ADC_REG_ENABLE, enable | BIT(ch));

> +	if (!wait_for_completion_timeout(&adc->done,
> +					 msecs_to_jiffies(X1600_ADC_TIMEOUT_MS)))
> +		ret = -ETIMEDOUT;

#define _TIMEOUT		msecs_to_jiffies(...plain number...)

	if (wait_for_completion_timeout(&adc->done, X1600_ADC_TIMEOUT))
		ret = 0;
	else
		ret = -ETIMEDOUT;

> +	enable = x1600_adc_read(adc, X1600_ADC_REG_ENABLE);
> +	x1600_adc_write(adc, X1600_ADC_REG_ENABLE, enable & ~BIT(ch));
> +	if (ret)
> +		return ret;
> +
> +	/* Two results to a data register, the even channel's in the low half. */
> +	bank = ch / 2;
> +	shift = ch % 2;
> +	data = x1600_adc_read(adc, X1600_ADC_REG_DATA(bank));
> +	*val = field_get(X1600_ADC_DATA_MASK(shift), data);

+ blank line.

> +	return 0;
> +}

...

> +static int x1600_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *iio_dev;
> +	struct x1600_adc *adc;
> +	unsigned long rate;
> +	u32 div, reg;
> +	int irq, ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(iio_dev);
> +	init_completion(&adc->done);
> +	ret = devm_mutex_init(dev, &adc->lock);
> +	if (ret)
> +		return ret;
> +
> +	adc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->base))
> +		return PTR_ERR(adc->base);
> +
> +	adc->clk = devm_clk_get_enabled(dev, NULL);

Can we have clocks always be named? Otherwise if any new dual-clock HW appear
here, the code will be disrupted.

> +	if (IS_ERR(adc->clk))
> +		return dev_err_probe(dev, PTR_ERR(adc->clk), "Unable to get clock\n");
> +
> +	/* Powered down, interrupts masked and cleared, as the vendor does. */
> +	x1600_adc_write(adc, X1600_ADC_REG_ENABLE, X1600_ADC_ENABLE_POWER_DOWN);
> +	x1600_adc_write(adc, X1600_ADC_REG_CTRL, X1600_ADC_CHANNELS_MASK);
> +	x1600_adc_write(adc, X1600_ADC_REG_STATUS, X1600_ADC_CHANNELS_MASK);

> +	rate = clamp(clk_get_rate(adc->clk), 2UL * X1600_ADC_CLK_RATE_HZ,
> +		     254UL * X1600_ADC_CLK_RATE_HZ);

I would put it as

	rate = clamp(clk_get_rate(adc->clk),
		     2UL * X1600_ADC_CLK_RATE_HZ, 254UL * X1600_ADC_CLK_RATE_HZ);

for the sake of the logical split (and yes, 81 characters in this case is okay).

> +	div = round_up(DIV_ROUND_UP(rate, X1600_ADC_CLK_RATE_HZ), 2);
> +	/* US and MS at their reset values: single conversions don't use them. */
> +	x1600_adc_write(adc, X1600_ADC_REG_CLKDIV,
> +			FIELD_PREP(X1600_ADC_CLKDIV_CLKDIV, div) |
> +			FIELD_PREP(X1600_ADC_CLKDIV_US, 16) |
> +			FIELD_PREP(X1600_ADC_CLKDIV_MS, 4));
> +	reg = x1600_adc_read(adc, X1600_ADC_REG_STABLE) & ~X1600_ADC_STABLE_TIME;
> +	x1600_adc_write(adc, X1600_ADC_REG_STABLE,
> +			reg | FIELD_PREP(X1600_ADC_STABLE_TIME, 1));
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, x1600_adc_irq, 0, dev_name(dev), adc);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Left powered up: a typical use, such as buttons read through adc-keys,
> +	 * polls every few tens of milliseconds, and powering up takes 2 ms.
> +	 */
> +	x1600_adc_write(adc, X1600_ADC_REG_ENABLE, 0);
> +	fsleep(2 * USEC_PER_MSEC);
> +	x1600_adc_write(adc, X1600_ADC_REG_CTRL, 0);
> +
> +	ret = devm_add_action_or_reset(dev, x1600_adc_power_down, adc);
> +	if (ret)
> +		return ret;
> +
> +	iio_dev->name = "x1600-adc";
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->channels = x1600_adc_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(x1600_adc_channels);
> +	iio_dev->info = &x1600_adc_info;
> +
> +	return devm_iio_device_register(dev, iio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


