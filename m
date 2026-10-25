Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960466;
	b=OYe72mp94iaqX3x6QgzU/giAiCTPv9itLxW9Zh47Y+62bQ6/0iQMxRQjyet9kLSiN5ID
	 vyWNQVEkyAv+dkyRTEDbv5uNOVlk8AKwKKztzuuiAuRg+dmmyvD1DEQ4q5gDgYET5Xq/7
	 pKor/MoOJ0n94MVCdETsjCROsWtNB4+OMlw2+cF9JEe82UV1soMIDjaUNOQ/Kx20BDfGe
	 W5Ol5dw4q/JnoZXkZEFbGqgXqvi6+IKZpu4gfc65TzOe9Mc39gDMIr53qlZxWoD1t0F+f
	 +0JoeajLFhdEeEZoAV4wGWQrEd/sqIFUAc/buTUuzC4LtMaZSJ+V+8oJfumYIeQnV0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960466;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=SerfV/Y7Wh+AGRntag+tZ7aJlrVfjkCeYTwFVXmDajI=;
	b=jHw1/uqiO+DJ8S75Rlmv4d4fnZGRYuUSlPV1IrhOsScc7S2J1LACpoc47qLP+qtwtr+1
	 NWMUqPSVyTy5eTLUJY1Q2iD14maF2rZHTxI7RJLkXkLcEdZkh8ZL83dqlc0FgxpihZUN3
	 FxQ71lS0S/ajcdYI6a+feqoS+pGhuKs0h9UpiZkDHZHi91xiqmVznHTb1HmE8OTX7F7sH
	 bxtR57YXG338qPpUHwvqRTUADtoyUMJtrZsqlhIfH1d8KA0N22pGNrambLJc92happvQk
	 Q6fgBI13wScZA7dnUcQGxSAdcbvKDitu09Z/MvlJoprOWU81JuGGkJt+UP6yaUxHEoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OTKm3kTp;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A6B606A31A;
	Sun, 25 Oct 2026 20:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OTKm3kTp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792960464; x=1824496464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mg6YTG/YvJ24ApaEm7t/+8C8l8zv4nUM13VOLy4x8R4=;
  b=OTKm3kTpcwEF+7zuk+6vRH0n7a3ADiBHYl8uNo4gpQ8H4U261aDx7oev
   MCF73G9nYpI6cZYnKSyvm7IsuSMjxOJ9thLYLZirmxW87PWUr0t8MgqNC
   1ZyvChzxA8v1l33Tc51aTmMYtpAjA9RGyVp9iNan3Xnm3exeba6/QI8dK
   Swy26rhTPVmXtlmSjzEj69EKpOiCpA40G4kxIbzK44dF+oIKb7aAzUct/
   RZwsQ/VRnnT2zTa0fzGIZZv6Aktfvr96qdoExycYfDcFPS14TFuG/Ov6f
   Rw1cymk/2IsZleOuWEakHBZQ8ntj0q6+mV5FkY7h0CJpvO+/gXFADG0PX
   w==;
X-CSE-ConnectionGUID: PGuK82JTRjuamPYh5zrf4Q==
X-CSE-MsgGUID: dBOF0LMYTcq83929fIQ3bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1662665"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1662665"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:34:23 -0700
X-CSE-ConnectionGUID: nUa3Tpr0RGKMqIqVElpsaw==
X-CSE-MsgGUID: P4z4O7j4RxO4iO9gfX8lrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4480432"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:34:20 -0700
Date: Sun, 25 Oct 2026 22:34:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: adc: ti-ads1298: add ADS1299 support
Message-ID: <at5nycDs6ImZV8X5@ashevche-desk.local>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
 <20261024231335.280955-7-stephanbrrs8@gmail.com>
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
In-Reply-To: <20261024231335.280955-7-stephanbrrs8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 08:13:35PM -0300, Stephan Costa Barros wrote:
> The ADS1299, ADS1299-6 and ADS1299-4 are 8, 6 and 4-channel, 24-bit
> biopotential ADCs for EEG. They share the register map, the commands
> and the data format of the ADS129x, and differ in:
> 
> - the PGA gains, 1, 2, 4, 6, 8, 12 and 24;
> - the data rates, f_CLK / 2^(7 + DR) with no HR bit, from 16 kSPS to
>   250 SPS, and the oversampling ratio, 64 * 2^DR;
> - the internal reference, a fixed 4.5 V, and the reserved bits 6:5 of
>   CONFIG3;
> - the ID register, which holds the channel count in bits 1:0;
> - the register map, which ends at CONFIG4;
> - the inputs, which are shorted out of reset.
> 
> Add the chip info for the ADS1299, and connect the inputs of every
> channel at init, which changes nothing on the ADS129x, whose inputs are
> already connected out of reset. The channel count is read from the ID
> register, so ti,ads1299 also serves the ADS1299-4 and ADS1299-6 through
> their fallback.
> 
> For both families, enable the DVDD supply when the device tree gives
> one, and hold PWDN asserted, like RESET, until the supplies and the
> clock are up. Nothing changes for a device tree that has neither.

...

>  config TI_ADS1298
> -	tristate "Texas Instruments ADS1298"
> +	tristate "Texas Instruments ADS1298 and ADS1299"
>  	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
>  	select REGMAP
>  	help
> -	  If you say yes here you get support for Texas Instruments ADS1298
> -	  medical ADC chips
> +	  If you say yes here you get support for Texas Instruments ADS1294,
> +	  ADS1296, ADS1298 and ADS1299 medical ADC chips, and their variants

Make this a list, see how other drivers (recently updated to support more HW)
do it.


>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1298.

...

>  // SPDX-License-Identifier: GPL-2.0
> -/* TI ADS1298 chip family driver
> +/* TI ADS1298 and ADS1299 chip family driver
>   * Copyright (C) 2023 - 2024 Topic Embedded Products
> + * Copyright (C) 2026 Stephan Costa Barros <stephanbrrs8@gmail.com>
>   */

Fix multi-line comment style, make the text of tristate in Kconfig, this one,
and in the MODULE_DESCRIPTION() the same.

...

> +	/* TI sells the 8-channel part as plain ADS1299 */
> +	if (indio_dev->num_channels == ADS1298_MAX_CHANNELS)
> +		indio_dev->name = "ads1299";
> +	else
> +		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads1299-%u",
> +						 indio_dev->num_channels);

Why do we need this? Can't we derive it from IIO ABI?

> +	if (!indio_dev->name)
> +		return -ENOMEM;

...

>  static int ads1298_init(struct iio_dev *indio_dev)
>  {
>  	struct ads1298_private *priv = iio_priv(indio_dev);
>  	unsigned int val;
> +	unsigned int i;

It's not used outside of the loop, make it local to that for-loop.

>  	int ret;
>  
>  	/* Device initializes into RDATAC mode, which we don't want */

>  	if (!priv->reg_vref)
>  		msleep(ADS1298_REF_START_UP_MS);
>  
> +	/* The ADS1299 comes out of reset with its inputs shorted */
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		ret = regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),
> +					 ADS1298_MASK_CH_MUX,
> +					 FIELD_PREP(ADS1298_MASK_CH_MUX,
> +						    ADS1298_MUX_NORMAL));
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


