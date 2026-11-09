Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263479;
	b=uqQVNZApJ1pzax7bOEH+T05hKyTSnLgrEcx0TG3CDB3Fb4hP67baGQ9TczWhw2IlbTi2
	 CtuyYPXIwI5MbLyZFUTEoFS2pqE0Mhb5miQghjHTaO/PVnt71G/X8z+qWMQ7kHTReuKAG
	 OgSjx6fEvWS6y6PShyWiLiBDLDBBa4fBmRnIvRg/R83OZvD3VsK18LGnhudCFAcLsh0Wz
	 x+t4yOHsTxyWkm1oh3dU+FGvmviayhcUsxdX5l1i4SwLdymgLddz060JJH8kXnUuDPzFc
	 otBp9OhH8sx8/gsvPz6qMflM3E88qtEopPzs36mWczvTtwBGVv5zd0ddqg5wxUAdXUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263479;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=+Q/teHbjgmKyg42AqzsssNkJkbaIeHmrybg6EBOInXY=;
	b=2ygG+GEFSiw3SuqJrAYVh4sMAceKSSopYTbF75kEWtaCl9CvtKIVvFKGf70jtKOHmT1m
	 +ywgSlqYtBcwZ+bPA/kkLwwvfbKoGFqSRhel6WSZWzdPGeoQDezkOyMxNpvFzTH71CdPS
	 q3q888IVo5a/v8q2Q8XubM83u7GqdTTSBgpP0C+46xSGcNk0OfrblIv75Q+OdqN2bS7ew
	 +a8XEqrJEO1b603PgAJPagjpl06AqgaBybtQC2ACbSW/Viau3/msygQEgSqPUUw3Zsm3+
	 h+GWULiiiZHy7PDr86i9Pk/7Ua2YhX1PzxxubynX5wt2ssA++gbgtQ6Fz7yVkweHVkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FLg0eRe8;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1394606A330;
	Mon,  9 Nov 2026 22:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1394606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FLg0eRe8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794263479; x=1825799479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0oAGGV7ACZl5cUvd318Hu7OhYmxrskwT7NubZ04RIu0=;
  b=FLg0eRe849iIqmXvdLoHNmK9aBk0OKcDcjv9vxDpYq7Qs8nampCo1MjB
   84Hye/zQEUDo3mN3zzhC9h4oKT7NpU6NRBBEYyDZohne2quLcOjDSgC4G
   wbhLbaIeEVVwO2XskINVG9t9tw12Fli7ubKE1X5cUaJZ3gImkRT/cz55k
   wXfNFGTqQTuDZVgN4ZDRGuW4j/g+38Hr8S3/AvgsoG9UyeeD+wJH+zzqu
   ChckB1GxsYqLlghlD3rplUUDQWuSwgwifUeqKhHIZcr0HSQJGyDCrctDD
   iu737mw1SYxO3KoHFBtgip+lBxMVUcMaWRQ20HE//CmhFzVfgtHaGnqUv
   Q==;
X-CSE-ConnectionGUID: 68bZXqdBQl+PbI7oLdKgIw==
X-CSE-MsgGUID: G46CfTjWSPG9qDZd8DKOBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3024000"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3024000"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:31:18 -0800
X-CSE-ConnectionGUID: 0LYaPUOWQG+Grke/pgH/Mw==
X-CSE-MsgGUID: ICJZsGuUTRSLLXGmCIAm2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7974218"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:31:15 -0800
Date: Tue, 10 Nov 2026 00:31:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: admin@tsv-stahl-riesa.de
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add Capella CM3217 ambient light
 sensor driver
Message-ID: <avJJsIJvUVpfZXnb@ashevche-desk.local>
References: <20261106-upstream-iio-cm3217-v2-0-d97adde9171c@tsv-stahl-riesa.de>
 <20261106-upstream-iio-cm3217-v2-2-d97adde9171c@tsv-stahl-riesa.de>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261106-upstream-iio-cm3217-v2-2-d97adde9171c@tsv-stahl-riesa.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 06, 2026 at 09:56:30PM +0100, Patrick Fischer via B4 Relay wrote:

> The CM3217 has no registers and no ID. Writing a byte to address 0x10
> or 0x11 sets command byte 1 or 2, reading a byte from 0x10 or 0x11
> returns the high or low byte of the 16-bit light count.
> 
> Command byte 1 holds the shutdown bit and the IT_T field (1/2 T, 1 T,
> 2 T or 4 T), command byte 2 the FD_IT field (800 ms down to 66 ms). The
> count scales linearly with both. The driver exposes FD_IT as the
> integration time and IT_T through the scale, so the scale list offers
> four ranges for each integration time.
> 
> The datasheet is not public. The bit fields, the reserved bits that are
> written as 1 and the startup setting of 2 T and 100 ms come from NVIDIA's
> downstream drivers (drivers/staging/iio/light/cm3217.c in the 3.4 kernel
> rel-tegranote-r8 and the 3.10 kernel
> android-tegra-flounder-3.10-nougat-mr1.1). One value differs: the vendor
> header defines 4 T as 4 << 2, which is outside the two-bit field. On a
> Tegra Note 7 field value 3 gave four times the 1 T count, so the driver
> uses that. For the resolution, Capella
> gives a range of 0.01875 to 119156 lux. The driver takes 0.01875 lux
> per count at 4 T and 800 ms. This matches both the upper end (65535
> counts at 1/2 T and 66 ms) and the 0.3 lux per count that the NVIDIA
> 3.4 driver uses at 2 T and 100 ms.
> 
> The sensor has no data-ready flag, and a new setting only takes effect
> when the conversion in progress ends. A conversion takes IT_T times
> FD_IT, up to 3.2 s. Leaving shutdown starts a new one at once, so the
> driver passes through shutdown on every change and waits one conversion
> period plus a margin before it reads the count. The timing was measured
> on a Tegra Note 7.

...

> +/*
> + * 0.01875 lux per count at 4 T and 800 ms, the finest resolution. The
> + * resolution is inversely proportional to IT_T and FD_IT, so keep it as
> + * lux per count times milliseconds: 0.01875 lux * 800 ms = 15 lux * ms.
> + */
> +#define CM3217_NLUX_MS		(15ULL * NANO)

Hmm... Can we use rather formula inside the definition? Also one of the
multipliers from time.h might make sense here as MS are mentioned.

18.75 per 800 µs, or 1875 per 8 µs if I'm not mistaken. Hence

	(1875 * 8 * NSEC_PER_MSEC)

?

...

> +/* Scale in lux per count at FD_IT = ms milliseconds and IT_T = 1/2 T << it_t */
> +#define CM3217_SCALE(ms, it_t) {				\
> +	(CM3217_NLUX_MS << (3 - (it_t))) / (ms) / NANO,		\
> +	(CM3217_NLUX_MS << (3 - (it_t))) / (ms) % NANO,		\

These NANO again are misleading.

> +}

...

> +static_assert(ARRAY_SIZE(cm3217_scale_avail) ==
> +	      ARRAY_SIZE(cm3217_int_time_avail));

Having this on a single line is fine.

...

> +struct cm3217_data {
> +	struct i2c_client *client;
> +	struct i2c_client *client_lsb;
> +	/* protects the command bytes and ready */
> +	struct mutex lock;
> +	u8 cmd1;
> +	u8 cmd2;
> +	ktime_t ready;

Have you checked with `pahole`?

> +};

> +	/* the first count is ready after one conversion */
> +	conv_ms = cm3217_conv_ms(data);

You can add 10% margin right here with a comment.

	/* Add 10% margin along with additional ... for ... */
	conv_ms += conv_ms / 10 + CM3217_MARGIN_MS;

> +	data->ready = ktime_add_ms(ktime_get(),
> +				   conv_ms + conv_ms / 10 + CM3217_MARGIN_MS);

	data->ready = ktime_add_ms(ktime_get(), conv_ms);

> +	return 0;
> +}

...

> +static int cm3217_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct cm3217_data *data = iio_priv(indio_dev);
> +	unsigned int fd_it;
> +	u8 cmd1, cmd2;
> +	int i;
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		fd_it = FIELD_GET(CM3217_CMD2_FD_IT, data->cmd2);
> +		i = cm3217_find_avail(cm3217_scale_avail[fd_it],
> +				      ARRAY_SIZE(cm3217_scale_avail[0]),
> +				      val, val2);
> +		if (i < 0)
> +			return i;

> +		cmd1 = data->cmd1 & ~CM3217_CMD1_IT_T;
> +		cmd1 |= FIELD_PREP(CM3217_CMD1_IT_T, i);

FIELD_MODIFY()

> +		return cm3217_write_cmd(data, cmd1, data->cmd2);
> +	case IIO_CHAN_INFO_INT_TIME:
> +		i = cm3217_find_avail(cm3217_int_time_avail,
> +				      ARRAY_SIZE(cm3217_int_time_avail),
> +				      val, val2);
> +		if (i < 0)
> +			return i;
> +
> +		cmd2 = FIELD_PREP(CM3217_CMD2_FD_IT, i);
> +
> +		return cm3217_write_cmd(data, data->cmd1, cmd2);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +	scoped_guard(mutex, &data->lock)
> +		ret = cm3217_write_cmd(data, cmd1, cmd2);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to power on\n");

It's better to have it inside scoped_guard().

-- 
With Best Regards,
Andy Shevchenko


