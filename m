Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078852;
	b=fg2xdUuZRF9oPkNZuZhdaoJ7y4N0XqA0m+c2+cWjpOMy0fKwvw6b1p7CMhLby1lyw3XC
	 bq5j0bmnwHs4Cx04cni1R7vpjLsBj4lAK5DyFUO1CuSBPJMfGUuaf3+kJSRQSd0A+XMDS
	 FETnQR52PnndNvHZOlXx6HJEoM/ON/ByncvYRdU/+9haDe4PepxDmVu2QWSIKCDR7L2Nj
	 nW4j10MRU6/CqBvdE3PcvNKs/lsAvhbKsFXXI6oJy6XeFhH4kw0aKdbAiJOO9C5LTibge
	 gw3mFfhqZi1Dd04+hWbnZ0TU7h6cM9CSebxPBQuoAa054C+h8XODf883ByBmcYoadaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078852;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=zLSvn6HKvnd44EqpYtsf0FVG1UPD5pBu1Gkyu1XKFNQ=;
	b=SQh4rMDQQN9f07DaMsGs7RH7+6j4GHCuUpt0/+7iDxm8sJV3mvrUkR6nqXTAiTRPPS7Q
	 QBZ/14K2jDC+Q/b11wI83PZ62EMsfOLNyaOBwsjbZhcYza0Vxv2/tWX2qPt1VLsOUFz2b
	 SpkqYV8KHWDz1gnOC7jwpuh9Kzrvi8XHytLMIQIynid0qGw5+Ysy6J1ZNQgCM6O9nM/be
	 woZmvT9ILfDo8QwFKGzJXVC5AePw/53Uc2Z9AjRSF0tmhyCbWvlYSY9+n6tBfV2kE7FTn
	 JfCrHiG7CxHQ4igd8nB20JowTKzLer1DAaO3/KE9qSpSKErri7wsWxF0hI5HL1p+K1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iRaFRE62;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76145606A320;
	Thu, 19 Nov 2026 09:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76145606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iRaFRE62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795078851; x=1826614851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TcqI0Nf/DOxlqyCBmb9i1TLpqnTwTuPTH4WKnE5MmV8=;
  b=iRaFRE62qAWE6fHbHAOpZtuf1+xJofOcbN+sNhKiWP37dmTR5NgbK5Up
   548cbEWjvq0BZDXRqtvJUKoU2LUdW2MoyN+E9YLMzwFv81njV+4ra7F2s
   PfOtLsWEzPTZpBDcWLRukdAamUwikw4Y16K3Ga3BA0NqveXqMfgxuCKgp
   8L2i4h8xkkGjWXmyu1otskmuxDHxM42TapdFFc7XnQRCynN+DurF3txaM
   KC1wmYFqVIxRylVvCVu+2mq+dII26UNnUC1sSOZPPNhvDomkjhYHyGLsd
   LiighPu/hM9XZe7LrAYIbQAYIhLOo4C4cS2mVQKnjCBn1aQ18oR2RYMip
   g==;
X-CSE-ConnectionGUID: LxC5SniFRsmXVroFXT3zoA==
X-CSE-MsgGUID: p3yWC9sES/SQKU7UNP419w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3948490"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3948490"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:00:40 -0800
X-CSE-ConnectionGUID: wS0CWJ4oQQuwtlvpIMiMLw==
X-CSE-MsgGUID: SjoUSKAsTHy2fHnD+dlK/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10370775"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:00:23 -0800
Date: Thu, 19 Nov 2026 11:00:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Salih Erim <salih.erim@amd.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: rohm-bd79112: Support ROHM BD79111
Message-ID: <av66oui-2Pk1XOIi@ashevche-desk.local>
References: <cover.1795009599.git.mazziesaccount@gmail.com>
 <ab74e547e892ccabb763a06e8231e8ed44f4fefb.1795009599.git.mazziesaccount@gmail.com>
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
In-Reply-To: <ab74e547e892ccabb763a06e8231e8ed44f4fefb.1795009599.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 04:19:35PM +0200, Matti Vaittinen wrote:
> 
> ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
> where pins can be configured to be either used as GPIO or ADC inputs.
> ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
> sources.
> 
> The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
> for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
> promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
> the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
> clock.
> 
> NOTE: In order to achieve those speeds one needs to use more optimized
> protocol compared to the one implemented in this driver. This driver
> retrieves samples using two 16-bit SPI transactions. The first
> transaction writes the channel to be sampled, and ignores data on MISO.
> Then the next 16-bit transaction carries the data.
> 
> Achieving maximum sample-rate would require the driver to interpret the
> MISO data of each 16-bit transaction so, that when the
> channel-to-be-sampled was sent in transaction N, the data is read at
> transaction N+1 - which also already configures the channel to be
> sampled for transaction N+2. Supporting this would require the
> channel-to-be-read for the future read to be known when the current
> channel data is retrieved. For raw-reads this is not possible and for
> buffered reads it would make things a bit hairy.
> 
> So, here we aim for simplicity instead of the peak performance.

...

>  config ROHM_BD79112
> -	tristate "Rohm BD79112 ADC driver"
> +	tristate "ROHM BD79112 and BD79111 ADC/GPIO driver"

So, as Jonathan mentioned this should be rather relaxed, so we don't update it
each time the new HW is got supported. Also in a new style we want a bit of an
order by having this, text in top comment, and MODULE_DESCRIPTION() to be the
same (or very similar, like with or without word 'driver').

>  	depends on SPI && GPIOLIB
>  	select REGMAP_SPI
>  	select IIO_ADC_HELPER
>  	help
> -	  Say yes here to build support for the ROHM BD79112 ADC. The
> -	  ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. Analog inputs
> -	  can also be used for GPIO.
> +	  Say yes here to build support for the ROHM BD79112 and BD79111
> +	  ADCs. Both of the ICs are 12-bit SAR ADCs. The ROHM BD79112 has
> +	  32-channels, the BD79111 has 16. Analog inputs can also be used
> +	  for GPIO.

Yeah, and here the style is to have something like a list

	  Say yes here to build support for the following ROHM SAR ADCs:
	  - BD7911 (12-bit, 16 channels)
	  - BD7912 (12-bit, 32 channels)

	  Analog inputs can also be used for GPIO.

(feel free to amend, it's just an example).

...

> +static int bd79112_disable_gpios(struct bd79112_data *data)
> +{
> +	unsigned int i;
> +	int ret;

> +	for (i = 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {

	for (unsigned int i = 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {

> +		ret = regmap_write(data->map, BD79112_FIRST_GPIO_EN_REG + i, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

> +/* The BD79111 only has the registers for pins 0 - 15 */
> +static int bd79111_disable_gpios(struct bd79112_data *data)
> +{
> +	static const unsigned int regs[] = {
> +		BD79112_REG_GPI_EN_A8_A15, BD79112_REG_GPI_EN_A0_A7,
> +		BD79112_REG_GPO_EN_A8_A15, BD79112_REG_GPO_EN_A0_A7,
> +	};
> +	unsigned int i;
> +	int ret;

> +	for (i = 0; i < ARRAY_SIZE(regs); i++) {

	for (unsigned int i = 0; i < ARRAY_SIZE(regs); i++) {

> +		ret = regmap_write(data->map, regs[i], 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

>  	data = iio_priv(iio_dev);
> +	data->cd = spi_get_device_match_data(spi);
> +	if (!data->cd)
> +		return -ENODEV;

-ENODATA

...

> +	data->gc.ngpio = data->cd->num_channels;
> +	data->gc.label = devm_kasprintf(dev, GFP_KERNEL, "%s-gpio",
> +					data->cd->name);

I would use a single line.

> +	if (!data->gc.label)
> +		return -ENOMEM;

...

>  static const struct of_device_id bd79112_of_match[] = {
> -	{ .compatible = "rohm,bd79112" },
> +	{ .compatible = "rohm,bd79111", .data = &bd79111_chip_data },
> +	{ .compatible = "rohm,bd79112", .data = &bd79112_chip_data },
>  	{ }
>  };

So, this can be split to two patches:
- introduction of chip_info
- adding a new HW.

-- 
With Best Regards,
Andy Shevchenko


