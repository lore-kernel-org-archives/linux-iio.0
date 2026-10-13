Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132037AA94;
	Tue, 13 Oct 2026 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876035; cv=none; b=GXZepAEq1q5BIqTv2/V9G7quMztNIQzcRX/lj2lSHzPzjSj8DTv3iEXZEI4NGGdc8u+oQOeZLZVczKDVJGnzy967K+dV5Ns6eAum9vUYWuuYuJQBzSnePkQjzr2CSOF+8qvUGsY2cnqxEQShSnQi2DK2q62BInP+6xp3Q79B04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876035; c=relaxed/simple;
	bh=lhtNOvnGjrJ0YJ4RZuJIlnz6dosHMOa7q4UAX6irEKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzyXuMMjkZHHVJRO7ndkWoSRELQGwMJBIlBlu3hdwKRhSd1OHyURznZtl2JnCyqJg6naty27s8A/efsKQ2v3yywSdPzkwZDd7LYQdCEZ7PD7kudy1Ujm9MSfAaHFZI4GGdzHS9j3IoMnc9NytsT0hr1PCnnEyjBOrYIIXd6/nZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuoizujY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuoizujY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791876035; x=1823412035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lhtNOvnGjrJ0YJ4RZuJIlnz6dosHMOa7q4UAX6irEKE=;
  b=AuoizujYw0EOPW2VlQxRyGHfp5EPCbMKte/l0WyxVJz3HBjQtvxlAC+Y
   Qi2WOHDeaRKuMF2Bl1TKrrITTE9wSQ/LU5tuzV6Lt5X75c7ZxdB65h56D
   PildgI0KYJlu55dolS7tmZ+l+HRL2Eq2lw8Sw3KQgl3i1ufp3g/59MQy3
   ORU6EhkVAqb4K+TraaITeH4gBFoJ+OrctLHPt8/cHKfe3Ra2m/SD3Bb4m
   nmYdbBQvbCLGsWk1KUqjWaWg4pt/UM15mFDbpJZIe+X8kilCl3mlh+7gZ
   x46+FH9I/SggjqW7xl3xjBbQ1mXasn4K/usPxR3yrkAzEEFTTe277wP0W
   Q==;
X-CSE-ConnectionGUID: Amy6rrU3RBeAuTMT+srRdw==
X-CSE-MsgGUID: bYhhAcITTb6M0CJ5G/+Ixw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="493141"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="493141"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:20:34 -0700
X-CSE-ConnectionGUID: /GKU5FLRRDqryMAPqrZGoQ==
X-CSE-MsgGUID: HAM54pmgTfOkzHUQTBPriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1052200"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:20:30 -0700
Date: Tue, 13 Oct 2026 10:20:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 07/13] iio: adc: ad4134: Support buffered data read
Message-ID: <as3bu1imLnoBE1lb@ashevche-desk.local>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <5d31212a27c2099c226cce189aa96677e75ca529.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d31212a27c2099c226cce189aa96677e75ca529.1791309733.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 06, 2026 at 03:17:56PM -0300, Marcelo Schmitt wrote:
> Enable users to run buffered data captures triggered by IIO trigger device.
> Add an IIO timestamp channel so each data scan is provided with measurement
> time information. Require single-read operations to be in IIO device direct
> access mode to prevent buffered and single-shot data captures to disrupt
> each other.

...

> +static irqreturn_t ad4134_trigger_handler(int irq, void *p)
> +{
> +	IIO_DECLARE_BUFFER_WITH_TS(u32, channels, AD4134_NUM_CHANNELS) = { };
> +	unsigned int chan_bytes = BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS);
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4134_state *st = iio_priv(indio_dev);
> +	struct spi_transfer xfer = {
> +		.rx_buf = st->rx_buf,
> +		.cs_off = true,
> +		.len = chan_bytes * AD4134_NUM_CHANNELS,
> +	};
> +	int ret;
> +
> +	gpiod_set_value_cansleep(st->odr_gpio, 1);
> +	fsleep(1);
> +	gpiod_set_value_cansleep(st->odr_gpio, 0);
> +
> +	/* Run enough DCLK cycles to match the data frame length. */
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret)
> +		goto out;

> +	for (int ch = 0, i = 0; ch < AD4134_NUM_CHANNELS; ch++) {
> +		if (!test_bit(ch, indio_dev->active_scan_mask))
> +			continue;

for_each_set_bit() ?

> +		channels[i++] = get_unaligned_be24(&st->rx_buf[ch * chan_bytes]);
> +	}
> +
> +	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
> +				    pf->timestamp);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko


