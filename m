Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37BD331EB6;
	Tue,  9 Jun 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029838; cv=none; b=iTRRt3JyuHnsb7sYlGTteqbtrnOT7cT2Rzuue1BKCMiahDeo7kinA/3EuxBaDtGlVrywijFkm5GBrrDkoHghyN2vME+lXleMBXll5zDOT0+XOUFlCt64EQe5wM9/vlYGnjMpz1iMirawdVMZp3mtQz81U5+IvoDP99ixQgzmCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029838; c=relaxed/simple;
	bh=W0vFigz4egcwCqqfYcLa0B3UG4B5j/8tAmG05me37jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdKvaIfU90817vzd+VbKl9v7C7EBIfSDhcjnP12fMizMzwFnpQ47S48FvKMZBChpvzCjSNYX+wsQ0gdWKHeKUQBBb2yDqP2r4ihHbrViboTdxGMJbgUFiZpomaOyHeyq0JCw4hBTI6CZ0i5+JnGHrmmjVLOgLacc0LuO33I3yaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFuI4KDI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFuI4KDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781029837; x=1812565837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W0vFigz4egcwCqqfYcLa0B3UG4B5j/8tAmG05me37jA=;
  b=FFuI4KDIA1uU6b9bfFaCxFhTM/3yVEKXjbe+PXjE/eHg/r0ZBPdyN0yp
   T9AeLmk2HkNd7j/lwvyNvdsgY0DPurCCHbmsPZHXb9vUJBNoFOLC24uF7
   j+Q6dqGoNHpTWkMZCXnUy8GBFK9IXF9yNPYrTl5ktReuxb/OQgFlobRsS
   WS6WJoTVNFdDsMJDIRpR5z42tZKLgRPpd8th+epHM4M/hZIzS2Nmb3KVU
   AT0owFu0H/4Nu10Ha6lpi85CpifLqGeAVEnHjjjLsA9w5to/t00s1opXH
   LiSVo2wZWZu8S7oXfVQhOUe0a+WaBjufTuZJbrtpidiCeFGGbToy75wA5
   g==;
X-CSE-ConnectionGUID: mX7RinPiTkyjbvhSE83vZw==
X-CSE-MsgGUID: nfCpBU5JT+mOCvgzuiSU/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81781634"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81781634"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:30:36 -0700
X-CSE-ConnectionGUID: 1+SmyyssQRKPAPX76A14TQ==
X-CSE-MsgGUID: XHLlIjFDTwKlwWHCZBRSQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="241798924"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:30:33 -0700
Date: Tue, 9 Jun 2026 21:30:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
Message-ID: <aihbxowyAIlSeDjH@ashevche-desk.local>
References: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com>
 <20260609-mt6323-adc-v2-2-aa93a22309f9@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-mt6323-adc-v2-2-aa93a22309f9@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 04:31:59PM +0300, Roman Vivchar via B4 Relay wrote:

> The mt6323 AUXADC is a 15-bit ADC used for system monitoring. This driver
> provides support for reading various channels including battery and
> charger voltages, battery and chip temperature, current sensing and
> accessory detection.
> 
> Add a driver for the AUXADC found in the MediaTek mt6323 PMIC.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

A few nit-picks, most important from which is the scoped_guard() versus
guard()() use.

...

> +static int mt6323_auxadc_prepare_channel(struct mt6323_auxadc *auxadc)
> +{
> +	struct regmap *map = auxadc->regmap;
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(map, MT6323_AUXADC_CON19, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* The ADC is idle. */
> +	if (!(val & AUXADC_CON19_DECI_GDLY_MASK))
> +		return 0;

> +	ret = regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19, val,
> +				       !(val & AUXADC_ADC19_BUSY_MASK),
> +				       10, 500);

It's better to split on logical boundaries:

	ret = regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19,
				       val, !(val & AUXADC_ADC19_BUSY_MASK),
				       10, 500);

> +	if (ret)
> +		return ret;
> +
> +	return regmap_clear_bits(map, MT6323_AUXADC_CON19,
> +				 AUXADC_CON19_DECI_GDLY_MASK);
> +}

...

> +static int mt6323_auxadc_read(struct mt6323_auxadc *auxadc,
> +			      const struct iio_chan_spec *chan, int *out)
> +{
> +	struct regmap *map = auxadc->regmap;
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read_poll_timeout(map, chan->address, val, (val & AUXADC_READY_MASK),
> +				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);

Perhaps

	ret = regmap_read_poll_timeout(map, chan->address,
				       val, (val & AUXADC_READY_MASK),
				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);

(see above why).

> +	if (ret)
> +		return ret;
> +
> +	*out = FIELD_GET(AUXADC_DATA_MASK, val);
> +
> +	return 0;
> +}

...

> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &auxadc->lock) {

I'm wondering why we haven't moved to guard()() here

	case IIO_CHAN_INFO_RAW: {
		guard(mutex)(&auxadc->lock);

> +			ret = mt6323_auxadc_prepare_channel(auxadc);
> +			if (ret)
> +				return ret;
> +
> +			ret = mt6323_auxadc_request(auxadc, chan->channel);
> +			if (ret)
> +				return ret;
> +
> +			/* Hardware limitation: the AUXADC needs a delay to become ready. */
> +			fsleep(300);
> +
> +			ret = mt6323_auxadc_read(auxadc, chan, val);
> +
> +			if (mt6323_auxadc_release(auxadc, chan->channel))
> +				dev_err(&indio_dev->dev,
> +					"failed to release channel %d\n", chan->channel);
> +
> +			if (ret)
> +				return ret;
> +		}
> +		return IIO_VAL_INT;

-- 
With Best Regards,
Andy Shevchenko


