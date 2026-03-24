Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31CB3F7881;
	Tue, 24 Mar 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355086; cv=none; b=FG/P3cgKpzec0aW3KLXFLsdQoGxTS9WbjECfTK2UZ5cxKWBObnVkkqp42qaYUox5tIkcaoiMVJCs0nZ05VqeZCZaOIgLX+vGKwgy8fZHsMB3ZU2lK1pH+j39EH05Pv352t34KE8DaXenCpyFRMlduHgveay/niJ+EnTd2Eupw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355086; c=relaxed/simple;
	bh=tibauC6EDHsVnUyYQmTYB95m6uuZD7Ols7sPBiWQEOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvrs8i4TCjlyEAQ/t1g5U4k0JBao3UXifwL0PttJTesQpyUOEa+38jBQnvq/OogqzYN4FbQNrZtjy8iLrdidDTJDYxxHqBvQThApPHfT50hw9l+bJKhda0mfQXcg1Ypq9NKZ0REN31hL9cd2MhHh1BomecNl4O3rZqHJjRNGz78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YM5G3pP4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YM5G3pP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774355085; x=1805891085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tibauC6EDHsVnUyYQmTYB95m6uuZD7Ols7sPBiWQEOo=;
  b=YM5G3pP4drx8G43FVkEr2hwilapc5gdEZr43KliODMtx0+MpHBty8OaL
   +iIVP2sgk2EydPXtKid0QFTaR2VADzeC6ERb33lUa/R4v5qJlB53In/Ws
   l0oIzvEFXU25NHhqk0198jHBU6thwHwSUsxZ4S3JtQuWAojbcKqP9Sruv
   looXJWQmhU+h2et0Bpcex7gWaM/5Sxa9OikDtOEXILw/3+Fzhnj6OfEMn
   gwD5aJhSdMPBLoZwBjUNofdObCKVOutNucx7hRSD6ofRTV8UtPnvZ1Uu1
   /NylHjx4M1iQjv5f98vo+vrZoQUpordxY7VnjSUUP6+OccHgjKtKsnX4Q
   A==;
X-CSE-ConnectionGUID: RpDbyIN4Qs2DoBv9p1IwYQ==
X-CSE-MsgGUID: p7j4K0HmRBSqNbv3FBiE1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75390655"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75390655"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:24:45 -0700
X-CSE-ConnectionGUID: CF0QT4HISXmympux3Upkag==
X-CSE-MsgGUID: /EWX0NH5SL2Xlnmm26MGKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228394355"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:24:41 -0700
Date: Tue, 24 Mar 2026 14:24:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: adc: ltc2309: Introduce chip_info structure
Message-ID: <acKChrd_0cRXu7-k@ashevche-desk.local>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
 <20260324071331.842-2-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324071331.842-2-carlosjr.jones@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 03:13:28PM +0800, Carlos Jones Jr wrote:
> Introduce a chip_info structure to facilitate adding support for
> chip variants with different channel configurations and timing
> requirements.
> 
> The chip_info structure contains:
> - Device name for proper sysfs identification
> - Channel specifications and count
> - Read delay timing for variants requiring settling time
> 
> The ltc2309 struct is modified to store only the read_delay_us value
> rather than a pointer to the full chip_info, as this is the only
> runtime-accessed field after probe.
> 
> This preparatory refactoring does not modify existing LTC2309
> functionality.

...

>  #include <linux/bitfield.h>
> +#include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>

> +#include <linux/array_size.h>

It starts with 'a'...

...

> +struct ltc2309_chip_info {
> +	const char *name;
> +	unsigned int num_channels;
> +	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
> +	unsigned int read_delay_us;

Now on some architectures this might have gaps. Have you run `pahole`?
Even if it's fine, I would rather see

	const char *name;
	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
	unsigned int num_channels;
	unsigned int read_delay_us;

OR (if there are limitations of __counted_by_ptr() attribute)

	const char *name;
	unsigned int read_delay_us;
	unsigned int num_channels;
	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);

> +};

...

> +static const struct ltc2309_chip_info ltc2309_chip_info = {
> +	.name = "ltc2309",
> +	.num_channels = ARRAY_SIZE(ltc2309_channels),
> +	.channels = ltc2309_channels,
> +};
> +
> +

One blank line too many.

...

>  static int ltc2309_probe(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev;
>  	struct ltc2309 *ltc2309;
> +	const struct ltc2309_chip_info *chip_info;

Try to preserve reversed xmas tree order.

>  	int ret;

-- 
With Best Regards,
Andy Shevchenko


