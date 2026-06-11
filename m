Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585237DE87;
	Thu, 11 Jun 2026 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206902; cv=none; b=qds3gQNjdlVlU8UQAX9JStXNuSeGkKT8sK0o5uCeTiSdlpznVDEnp6sJirTLNDCDB+CHMTvThF2lC7Swg74xqm/ICkh2XozleskuyZcl5kQyKExGvVQJz8A3Rqmup91ycEwAvxsCFJitKuhfplpInjOnQqMAzX4ywrtEGfafroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206902; c=relaxed/simple;
	bh=9HYVqEkTBk+W9sTm/UsyiNOHZTc2Vs3uZL+vLA75+gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPC5Jr/aaoYV6tQvlDeRGr9YiExK3/FJTbAD8PebJX6XmlTbi02xxhKuAoUkXDZd3djdiB6LtsAyKyjqjEkQ7K8FNlLIfRdOkT7hpK2s3w4u+sX8RqV+r9rCCR+avkGjZl05xiChQpRrz5xq8N8tOQmGHy3Z11r6wyMfHX5n0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4n6ABrC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4n6ABrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781206900; x=1812742900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9HYVqEkTBk+W9sTm/UsyiNOHZTc2Vs3uZL+vLA75+gk=;
  b=k4n6ABrCqPRIAwrsV76bu4CWp8zUatoM5KM5xG6ZbK5/DMmO2LKtSsgb
   gT3r04353VyOJ4WPCcM268mOnBp44LFnl7a3epBHk0/DMyhypiK7gOcje
   YEq0y58vTJ2IlzauwdfbJ77IbKKuYQamSgZV5U3J6IJp50kdWXk5Yc8gT
   vJ8Na46BZAHYJ5jfDSkBYbxKlWojqrSoeKvbE9VxQCzdfHn+e7E4bn4YO
   qrL+Vz8voshBqvZByRmRP94WYViLTL+mKxQlzhMKCnTZgc8nSEfTYEfPG
   VLOGirObUHK1hER92hBcxitZMU3HwP/3XE58LGYwzZTR1/6gREukFEYR6
   w==;
X-CSE-ConnectionGUID: EXd6iOJgTJ+mb6MwoljOVw==
X-CSE-MsgGUID: qqKJWlpUQuy5NMN/gjrVJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93520583"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93520583"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:41:39 -0700
X-CSE-ConnectionGUID: NZmom4I3TMqhdskBrcAdgg==
X-CSE-MsgGUID: IFxkRuRCTBy47PiDh/soDw==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:41:35 -0700
Date: Thu, 11 Jun 2026 22:41:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <aisPbXOB6cofF4_r@ashevche-desk.local>
References: <20260611-axiado-ax3000-ax3005-saradc-v2-0-913c9de7c64c@axiado.com>
 <20260611-axiado-ax3000-ax3005-saradc-v2-2-913c9de7c64c@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-axiado-ax3000-ax3005-saradc-v2-2-913c9de7c64c@axiado.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 02:37:44AM -0700, Petar Stepanovic wrote:
> Add support for the SARADC controller found on Axiado AX3000 and
> AX3005 SoCs.
> 
> The driver supports single-shot voltage reads through the IIO
> subsystem. The number of available input channels is selected from
> the SoC match data, allowing AX3000 and AX3005 variants to use the
> same driver.

Tried to not overlap Jonathan's review.

...

> +struct axiado_saradc {
> +	void __iomem *regs;
> +	struct clk *clk;
> +	unsigned long clk_rate;
> +	int vref_uV;
> +	struct mutex lock; /* Serializes ADC conversions. */
> +};

Is `pahole` satisfied with the chosen layout?


...

> +static int axiado_saradc_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan, int *val,
> +				  int *val2, long mask)
> +{
> +	struct axiado_saradc *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = axiado_saradc_conversion(info, chan, val);
> +		return ret ? ret : IIO_VAL_INT;

Better to use plain if.

		if (ret)
			return ret;

		return IIO_VAL_INT;

> +	case IIO_CHAN_INFO_SCALE:
> +		*val = info->vref_uV / 1000;

1000 --> (MICRO / MILLI) ?
(yes, with parentheses)

> +		*val2 = AX_RESOLUTION_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


