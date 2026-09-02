Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA8495051;
	Wed,  2 Sep 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353827; cv=none; b=oCsyaUQURJIunpTK/N27Pdew5IJ9JyAo5WDE6PKgoe5XP/Qs5y6Z8ELNq8VbegPfRZONqeG3IyfQudFgu9vkt/Tg4OJ5UZfrc3dROHZb7fHOLHPPpK9yxflxFduEFk5jSGz6k4P7AeJHI+RztWuZYtTeZP09dRq7CQCJ0Bxzv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353827; c=relaxed/simple;
	bh=+sqEe1LGe4fEP5uabRD28y+M+U2lWTjublfmuX++eck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5wOJALe2S8qkASFElIOCARst4yGoLfEZ+OIthS+ivLYgxWsnpbOZPd6W4a+5Zop5yr+o43CR8yYBh+wCPGYm8CAxZ4k2r35pxEs4ejnJoSN/hdzU2uF7csy8f7gnv99jr9s9Y6sm/9gX3zAsEpEczHb6UqmB8WU8cscmim10eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYojRQK1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYojRQK1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788353825; x=1819889825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+sqEe1LGe4fEP5uabRD28y+M+U2lWTjublfmuX++eck=;
  b=hYojRQK13e4LKZKhJJihLnvyuc7RNnOBRbuIIphQ5MEJEeryQ91lX5kK
   jmPxSMgw3c9mCIVYwUtr7NIKuwXnvdyTwuYe6vmwhdtUPEQbenjbE7NxP
   +kAv737XWK1dr9bOUKse/wWO45ALJx4EU//6zhSDE9RouvDd9F1KdCoAG
   Cv7cUVlVLGYyYrVFhnzLQffztaYWug0ca8PzbcmOQcbpO4/gkhF758lOq
   ZqemsPCl0IC8jWF3QMW+p1HQ9nj1raBzIjLp4x0b3d2TtUJ5ZXC+8dZKU
   jKX2ydii2Ggkwp2cDlNNoSs9WgjTYIktrOV7rs31ujklCGUUfHd/H4hnD
   g==;
X-CSE-ConnectionGUID: /SCN0LYzQEqmwbDZafLM3g==
X-CSE-MsgGUID: TmqHZSqwQkWmrIjjrTjpDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100165334"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="100165334"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:56:58 -0700
X-CSE-ConnectionGUID: ydY/x6WaSTiRl04+a7s3zA==
X-CSE-MsgGUID: Yl8xqNi8R+e7HGDSivpLpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="273570230"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.118])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:56:51 -0700
Date: Wed, 2 Sep 2026 15:56:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <apgdEf3pi_soGr3T@ashevche-desk.local>
References: <20260902-ad5529r-driver-v11-0-301c491a0719@analog.com>
 <20260902-ad5529r-driver-v11-3-301c491a0719@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-ad5529r-driver-v11-3-301c491a0719@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 11:26:17AM +0200, Janani Sunil wrote:
> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.

Since there might be a v12 (depends on Jonathan), a few more nit-picks.

...

> +static const s32 ad5529r_output_ranges_mV[8][2] = {
> +	[AD5529R_RANGE_0V_5V] = { 0, 5000 },
> +	[AD5529R_RANGE_0V_10V] = { 0, 10000 },
> +	[AD5529R_RANGE_0V_20V] = { 0, 20000 },
> +	[AD5529R_RANGE_0V_40V] = { 0, 40000 },
> +	[AD5529R_RANGE_M5V_5V] = { -5000, 5000 },
> +	[AD5529R_RANGE_M10V_10V] = { -10000, 10000 },
> +	[AD5529R_RANGE_M15V_15V] = { -15000, 15000 },
> +	[AD5529R_RANGE_M20V_20V] = { -20000, 20000 },
> +};

Perhaps use MILLI multiplier?

...

> +static int ad5529r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ad5529r_state *st = iio_priv(indio_dev);
> +	unsigned int reg_addr, reg_val_h;
> +	int ret, range_idx, span_mV;

Why is 'range_idx' signed?

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * Read from DAC_INPUT_A register rather than DAC_DATA_READBACK.
> +		 * The DAC operates in transparent mode and directly reflects
> +		 * whatever value is written to the INPUT_A register.
> +		 */
> +		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
> +		ret = regmap_read(st->regmap_16bit, reg_addr, &reg_val_h);
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_val_h;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		range_idx = st->output_range_idx[chan->channel];
> +
> +		/*
> +		 * The datasheet specifies a 4.096 V external reference,
> +		 * matching the nominal output voltage of the internal
> +		 * reference.
> +		 */
> +		span_mV = ad5529r_output_ranges_mV[range_idx][1] -
> +			  ad5529r_output_ranges_mV[range_idx][0];
> +		*val = span_mV;
> +		*val2 = st->model_data->resolution;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		range_idx = st->output_range_idx[chan->channel];
> +
> +		if (ad5529r_output_ranges_mV[range_idx][0] < 0)
> +			*val = -BIT(st->model_data->resolution - 1);
> +		else
> +			*val = 0;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


