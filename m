Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC016214812;
	Wed,  4 Feb 2026 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170856; cv=none; b=Bk8gjc4PlQfRq4Qx8/uHeRlkEg4nUn0i1UhqLgRZJ70rAkYOTVttqcTyYsuVd9tsSE3VeSRVvcktYJxR0yWKrDvWWUuva4PK8dQlULpup2vG9VsOeRTjN2fb1O8dOhZWPamP1ZE3FkGIXh+tTOEnznYxxCfrwbMWAbWdS5Fr2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170856; c=relaxed/simple;
	bh=zaBouzM87mqtHsfHsFR4z1oOTqxCjLOp+dS3AvxJyTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBa5s0uF9UdvEJxceGye/O80DdEkJv3lhbe6Fj8rZz1/B7mqw3J47iMKt0C6cEXQ50ZHEIS/AU36BBQ0xJElS3Xptom5+12zyA4n0hLUi+cJwuwSWxil70DLCP7OVfWtUba/vYGrIyMZbtMXfl8rki52Q5SYGwn1DHr4uOrhpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPTk1Dg+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPTk1Dg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770170855; x=1801706855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zaBouzM87mqtHsfHsFR4z1oOTqxCjLOp+dS3AvxJyTY=;
  b=GPTk1Dg+4tQy/iIRGESRM5gOc+S6V8CeKPbwqyY814ock8BMRIXgL08h
   s5hY07Wdz8OIYtrQKzJksXjymx1/22qZq5P+OgKsQJPe1j3NFaKgEbQ1h
   c5cPEgT53W3/NDecK1o4W1QQ0gk3IxUcNqsj7zZoLIuII9iBQFbB1mF/Q
   QmxojXYQQkrFs/yUEd8hVisLH1RljLlzu+7enEo0PCjkiEXysQduleAsb
   vcU3ww59+ABYRQ08I6MwhHSunlZJe1MEdHAe9i5cXiK1Q4P1Dd+lgZh9n
   z7zWqLl44z9Dftwl/rYrb8AMWZIv84+wRfjuLgVclgIojZRt+jbJaGrBY
   Q==;
X-CSE-ConnectionGUID: 9Dr4KHhbRbKIdMrBfPssRA==
X-CSE-MsgGUID: 42IfCp+2St+P8CB+LObM2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75206463"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="75206463"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 18:07:34 -0800
X-CSE-ConnectionGUID: 1tjR6wRhSbuhCQUhNU0p6w==
X-CSE-MsgGUID: AfhpFH7KRXaz1uThqcsxKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="247626925"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 18:07:31 -0800
Date: Wed, 4 Feb 2026 04:07:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 7/9] iio: amplifiers: ad8366: add device tree support
Message-ID: <aYKp4UrEhLInNNZZ@smile.fi.intel.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
 <20260203-iio-ad8366-update-v3-7-5d5636b5181a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-iio-ad8366-update-v3-7-5d5636b5181a@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 11:24:13AM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add device-tree support by dropping the enum ID in favor of extended
> chip info table, containing:
> - gain_step, indicating with sign the start of the code range;
> - num_channels, to indicate the number IIO channels;
> - pack_code() function to describe how SPI buffer is populated;
> 
> With this, switch cases on the device type were dropped:
> - probe() function adjusted accordingly;
> - Simplified read_raw() and write_raw() callbacks;

...

> +static size_t ad8366_pack_code(struct ad8366_state *st)
> +{
> +	u8 ch_a = bitrev8(st->ch[0]) >> 2;
> +	u8 ch_b = bitrev8(st->ch[1]) >> 2;
> +
> +	put_unaligned_be16((ch_b << 6) | ch_a, &st->data[0]);
> +	return 2;

With this return it will look better as

	return sizeof(__be16);

Alternatively it can be done via array:

	u8 ch[] = { bitrev8(st->ch[0]) >> 2, bitrev8(st->ch[1]) >> 2 };

but I find it uglier than the original approach.

> +}

...

> +	const struct ad8366_info *inf = st->info;
> +	size_t len = 1;
>  
> +	if (inf->pack_code)
> +		len = inf->pack_code(st);
> +	else
> +		st->data[0] = st->ch[0];
>  
> +	return spi_write(st->spi, st->data, len);

Hmm... What about

	const struct ad8366_info *inf = st->info;

	if (inf->pack_code)
		return spi_write(st->spi, st->data, inf->pack_code(st));

	st->data[0] = st->ch[0];
	return spi_write(st->spi, st->data, 1);

?

...

>  	struct ad8366_state *st = iio_priv(indio_dev);
> +	const struct ad8366_info *inf = st->info;
>  	int ret;
> +	int gain = inf->gain_step > 0 ? inf->gain_min : inf->gain_max;

Please, preserve reversed xmas tree order.

...

> -	{"ada4961", ID_ADA4961},
> -	{"adl5240", ID_ADL5240},
> -	{"hmc792a", ID_HMC792},
> -	{"hmc1119", ID_HMC1119},
> +	{"ad8366", (kernel_ulong_t)&ad8366_chip_info},
> +	{"ada4961", (kernel_ulong_t)&ada4961_chip_info},
> +	{"adl5240", (kernel_ulong_t)&adl5240_chip_info},
> +	{"hmc792a", (kernel_ulong_t)&hmc792_chip_info},
> +	{"hmc1119", (kernel_ulong_t)&hmc1119_chip_info},

The conversion to chip_info may be split to a separate patch.

-- 
With Best Regards,
Andy Shevchenko


