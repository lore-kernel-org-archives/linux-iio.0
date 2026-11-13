Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584455;
	b=vvmbx5FHLfbNbMF01PeDaOYfBPyx6+lqWooIKR1nImef0Jv+RziwRoasw3LqyOk3cOKM
	 rl1Ldg2RrPq8mDCvfiQfAKYGjo9XlpRP05D8D6ps4mIfOUs/sy3gq/hBn1G00s7OO3HkA
	 N4s60PFoVlwS/h3sUQlS1NPFW/StF2TmE4nSmI6VTYuajvOnQSWOy5bO2IDLSuHIKHE6g
	 moaNltzxef5cxZSxqMIk/ENO+lxdyxr06yer0k2mgaK6TQtiLSNbjTPgZrOMNwb/m/Fbx
	 /1oxCLjmWiMNGtEi2t21F8g5eeNVZQbDcOYxESf/bCdaPOmY3TbsODYbAiMvswBNU2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584455;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=M/5AfdX/Z0i/Rm+LooPoSTOr+dHyCrjT6srdLcYz5lY=;
	b=isf9D3bKVG+0/slT1KvCQ7+vWmuEE91Z7REAz9k3WPLxmdi2goaOYE9lAvW9KOuHCxsO
	 HjzVI0gByMGtDB81+/d8PYpznRXZNrepWtdgkawfyRhOo68yskpPWB6NUfFjAG+EuULaM
	 1aOAHF4aYbmpDqdcM/YCBOW0dLY0Dc5oQgsckN3x5YQAfBEqK83c9nTSvqECsrcQuFhCH
	 WcJQx9fVla+PnL7T73sSV4swwN1mYlRZGtQ7/RsamPlYUzaL3vga4t7MbmV1OzWZNfdRn
	 CNx25lVJyav7LoZ3RNct6r8RdAWiLKdfiG/dD8eUgfgKnr/Qwbdg/Uaux61BlxTH16w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbTQAM7Z;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D6606A327;
	Fri, 13 Nov 2026 15:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B7D6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbTQAM7Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794584455; x=1826120455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HYt69qA5pD83okxtiPgkSwKaBYtyhJX/GokhDg6mGag=;
  b=AbTQAM7Z8D4B7nubOOKXPzBW8Ok6rioYbXWZZTchOJp6A8SFy2hYIm+L
   VLxYD9pBf2mDyLn4ATRgFxUVYU1quBTnKg4xyA+cPmy/JqiCM+V1yqMfR
   re9Z4Cotl/NI3E8ooq0ZT37xxK1sZyqWiG7QtdXyvkTm1I14TLOOdYSjr
   fvYeObvcmepZtc6P+UgoBqDfA8e23amiYcpN/k8bQTEAT2Scwbe8TSxiQ
   bid0Y+KOzQFPn6nU4sVqnlrQgxHmaT8olclbfV0LFHLh2Ux0WnF93adUZ
   xF+hggt/9tz1hpEFyw9s/VbDFPFVUKZlTPd9EvMhY7ew/7dUYG7n8d4+w
   w==;
X-CSE-ConnectionGUID: cHGKfiPnQK6R1Bk+cHm0dw==
X-CSE-MsgGUID: aCAS+WrvSK6kho9lj+YDXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3378286"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3378286"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 07:40:54 -0800
X-CSE-ConnectionGUID: KWT4RppXRsG0aNLHEpi2SA==
X-CSE-MsgGUID: HInV2e6jSwydOlqN47o/Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9220464"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 07:40:48 -0800
Date: Fri, 13 Nov 2026 17:40:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz, Joshua Crofts <crofts@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	herve.codina@bootlin.com, thomas.petazzoni@bootlin.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <avcvfUcFwdJWjvs8@ashevche-desk.local>
References: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
 <20261113151543.2241604-3-maxime.chevallier@bootlin.com>
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
In-Reply-To: <20261113151543.2241604-3-maxime.chevallier@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:15:42PM +0100, Maxime Chevallier wrote:
> Add a new driver for the TI TLA2528 ADC chip. It has 8 12-bit
> channels, that can also be configured as 16-bit averaging channels.

I forgot to check if there is a justification of the brand new driver,
I assume there is.

> This is a very simple driver, allowing reading raw values for each
> channel. GPIO mode isn't supported for now, as well as buffered mode and
> the 16-bit averaging mode.

Some nit-picks below, but they do not prevent from this patch being accepted,
so

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
> +{
> +	__be16 data;
> +	int ret;
> +
> +	guard(mutex)(&tla2528->lock);
> +
> +	ret = regmap_update_bits(tla2528->regmap, TLA2528_CHANNEL_SEL_ADR,
> +				 TLA2528_CHANNEL_SEL_MANUAL_CHID, channel);
> +	if (ret)
> +		return ret;

Ideally this needs a comment explaining in short why regmap IO accessors may
not be used.

> +	ret = i2c_master_recv(tla2528->client, (char *)&data, sizeof(data));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(data))
> +		return -EIO;
> +
> +	*val = be16_to_cpu(data) >> 4;
> +
> +	return 0;
> +}

...

> +	ret = regmap_write(tla2528->regmap, TLA2528_GENERAL_CFG_ADR,
> +			   TLA2528_GENERAL_CFG_RST);

With locally defined

	struct regmap *map;
	...
	map = devm_regmap_*init*(...);
	...
	tla2528->regmap = map;
	...
	ret = regmap_write(map, TLA2528_GENERAL_CFG_ADR, TLA2528_GENERAL_CFG_RST);

this can kill two birds with one stone:
- make this one line (yes, 82 characters is okay)
- keeping data structure free from error pointers

> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


