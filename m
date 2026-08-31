Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5F3D091C;
	Mon, 31 Aug 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164653; cv=none; b=RFI0QNuUq/txbKC3AKAWuZOlpw6087AAnVcqBcbXsz8C1TB8KG2BL40gyCyAaIxaFwnb5bq/7TKQ5KzDkHpHQp2aErLa8D/a1mOWUoyIGuuvh31UQoo55TuWzLlW4eX502DOL7FROagq53OwroAICBbzJyTd9MwHj1wKZF8W4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164653; c=relaxed/simple;
	bh=vgA3zpqNaTzLvT/+D3MNTEM59DfrWMBlkVBIFr1Re4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM9ZjxmVrqs1eAsZAwP/YLPswD+CyNFVUxnN/ah3FMcZEZfm+Q3DqxtbIN5WQwu2OimaVuCFT3Su0WIpp4p3LY5MHk5tq5Fl0I8AleS0szkU16ZerV9TBj0Nxznphv8Wj391hX5PMOXQUWozfZ/vUnKxvDFa8cIVXkCIsaIa4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qa75MHf4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qa75MHf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788164651; x=1819700651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgA3zpqNaTzLvT/+D3MNTEM59DfrWMBlkVBIFr1Re4c=;
  b=Qa75MHf4ydiVmq0j+GJs879SNA75mCMDSTulRmH1/Ms4RSCSzEbJWglX
   62XUow4rxJ5SEZr9bRwFM3MkQU3Nazvg2k1x9JQYlYrkoacPANsy3J3IR
   0x36lm5cfYnGc7cOz3GOPc9s6oMHZzIby+y3cUk4IjNXqWhMtPiwr0Mm7
   VCqJHBFP5YUe1exPz4xxb6oe3587swSYaFWod/colYsjGa4TSXPEzBgg7
   yITJCJ8GdsJKqAXNN7z7KGXXRtV6SZ907cj231eGgO9JQdk2DuoeFPuIj
   SJcanQi/i3HFYouSN+ADrJYM8j8zgUHPdGcAooYtwVCL93HwX5HOT2iQf
   w==;
X-CSE-ConnectionGUID: zszTgySAT1Se2dIzh+147g==
X-CSE-MsgGUID: uLTcED3NTQ+8KABw6pGOdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="100077419"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="100077419"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:24:09 -0700
X-CSE-ConnectionGUID: FS3IHPnBQ6OOHmv2xdIRhg==
X-CSE-MsgGUID: ljHjJm2GQteKdQYSYayz0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="265491212"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:24:03 -0700
Date: Mon, 31 Aug 2026 11:24:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v5 10/20] iio: adc: ad7768: Add sampling frequency
 controls
Message-ID: <apU6IJiecn_0xQQs@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-10-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-10-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:33PM +0200, Janani Sunil wrote:
> Expose the requested sampling frequency and available rates for each
> channel. Validate requests against the rates supported by the power mode
> tables and apply them when buffered capture starts.

...

> struct ad7768_state {

>  	unsigned int power_mode_idx;
>  	const struct ad7768_chip_info *chip_info;
>  	struct ad7768_avail_freq avail_freq[ARRAY_SIZE(ad7768_power_modes)];
> +	unsigned int n_freqs;
> +	int freqs[AD7768_MAX_FREQS];
>  	unsigned int ch_freq[AD7768_MAX_CHANNEL];
>  	struct iio_backend *back;
>  	unsigned int vref_uV[2];

Just double check with `pahole` that this is optimal layout.

>  };

...

>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> -	unsigned int vref_idx;
>  
> -	if (info != IIO_CHAN_INFO_SCALE)
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE: {
> +		unsigned int vref_idx;
> +
> +		vref_idx = chan->channel >= st->chip_info->num_channels / 2;
> +		*val = 2 * st->vref_uV[vref_idx] / 1000;

1000 --> (MICRO / MILLI)

> +		*val2 = chan->scan_type.realbits;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		guard(mutex)(&st->lock);
> +		*val = st->ch_freq[chan->channel];
> +
> +		return IIO_VAL_INT;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


