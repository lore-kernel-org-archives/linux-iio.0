Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAF2E8DEA;
	Tue,  7 Apr 2026 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573176; cv=none; b=nMqxZjpw6irU/CxoI3PbOw9AWH82PWQyZw1EJt4IAOC2ahcnFYt9H9gVScUb+e509R12CoEHN468t4uur/D142gjvtng4VTD/nopplzVZ++vuWtVN5M9ITBjr5WND7z/IKaRwPMzXH6Ll6UBOsTTp+LcEyjdsO/9VaW4cF+fpTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573176; c=relaxed/simple;
	bh=MBh1A7ZOApVu6tgjYRrDMhGn2k6yHcaWaU2mTjTyE84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxJhl7sUMlLIs2kbQV4rj71f9j8oax3yMm8o5OmNGKOxOWU662p3pKPv+J84vR4gjMVAPGC59BQ7S2Ct7YWGB57I23rRLkY8LZgo7fd/3NINc8TmXYH2PQPw5pW4c7j+Zx4o+aOGdB+D/QCQOJ6+Qu1jNdQTlUXD+tBlzgRHlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwCshkM5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwCshkM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775573172; x=1807109172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MBh1A7ZOApVu6tgjYRrDMhGn2k6yHcaWaU2mTjTyE84=;
  b=GwCshkM56ClNa6VVT1J6eTAT5SKj3E21fgXjqZ3MEfyE3ci11/E9lyLG
   9mPXjiiJ9VjoKToGdXrshVdxWtS2bPW7Sjoj47gTaB9HMco58ljrm2YGq
   mKlHXAIXAlPsf+F6CqRTnHwDt01EjVY8kzzxaycKGzI0x+JneItSeRcSm
   rY7fPWP2Hy6e+E6hGfmU2DBR/W6uQyumXjy3ifB89voKuoIkffWk1qIB7
   Qc8v8PlkIlSOPgmpODJyFwRhVewUzQPeX1fZ4pDXmNeslXMisgy4lqAED
   GwcUEykRPW/Ub7C2SiBSOKGLM4fV+0go9uhWJGdMcNGXTVQikC4NOKWrk
   g==;
X-CSE-ConnectionGUID: zX+nWBAXRfGRjVjLzqwVqQ==
X-CSE-MsgGUID: QGE1r1qzRjaLi7FU8x9J4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87241310"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="87241310"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:46:10 -0700
X-CSE-ConnectionGUID: gvCoZNvwQiGe5nCmpGl+Jg==
X-CSE-MsgGUID: Eh7srEzQQkiEWGlZvU5wOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="228450985"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:46:07 -0700
Date: Tue, 7 Apr 2026 17:46:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <adUYrSWiX-oexxGN@ashevche-desk.local>
References: <20260407-dev_ad5706r-v5-0-a4c7737b6ae9@analog.com>
 <20260407-dev_ad5706r-v5-2-a4c7737b6ae9@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-dev_ad5706r-v5-2-a4c7737b6ae9@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 07, 2026 at 11:39:45AM +0800, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed

Mostly okay, see minor comments below, the main one is about treating void * as
__be16/__be32 * without any validation.

...

> +static int ad5706r_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct ad5706r_state *st = context;
> +	unsigned int num_bytes, val;
> +	u16 reg;
> +
> +	reg = get_unaligned_be16(data);
> +	num_bytes = ad5706r_reg_len(reg);
> +
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.len = num_bytes + 2,
> +	};

> +	val = get_unaligned_be32(data);

Is it safe? The data is void *, no size of it is counted here...

> +	put_unaligned_be32(val, st->tx_buf);
> +
> +	/* For single byte, copy the data to the correct position */
> +	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
> +		st->tx_buf[2] = st->tx_buf[3];
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);
> +}

> +static int ad5706r_regmap_read(void *context, const void *reg_buf,
> +			       size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct ad5706r_state *st = context;
> +	unsigned int num_bytes;
> +	u16 reg, cmd, val;
> +	int ret;
> +
> +	reg = get_unaligned_be16(reg_buf);
> +	num_bytes = ad5706r_reg_len(reg);
> +
> +	/* Full duplex, device responds immediately after command */
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.rx_buf = st->rx_buf,
> +		.len = 2 + num_bytes,
> +	};
> +
> +	cmd = AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
> +	put_unaligned_be16(cmd, st->tx_buf);

For the consistency's sake use &st->tx_buf[0].

> +	put_unaligned_be16(0, &st->tx_buf[2]);
> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Extract value from response (skip 2-byte command echo) */
> +	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
> +		val = st->rx_buf[2];
> +	else if (num_bytes == AD5706R_DOUBLE_BYTE_LEN)
> +		val = get_unaligned_be16(&st->rx_buf[2]);
> +	else
> +		return -EINVAL;
> +
> +	put_unaligned_be16(val, val_buf);
> +
> +	return 0;
> +}

...

> +#define AD5706R_CHAN(_channel) {				\
> +	.type = IIO_CURRENT,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),	\

Missing indentation at the end with tabs.

> +	.output = 1,						\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +}

-- 
With Best Regards,
Andy Shevchenko


