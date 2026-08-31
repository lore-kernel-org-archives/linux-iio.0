Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3039D6F6;
	Mon, 31 Aug 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162369; cv=none; b=ZusTMgPixEKhsEsamglfWOf2ZT7rE/zlLKmgZYeWH2KxS5MNLKxMRFYCxm8UYxsqbFNfrFr8x7UwwmSRzVki3qyNILJWDpnP17FjSMwnONsU5dYeDJs1m1XzdLSEV47KwRHfIFMeitRCMxS3Z+Hzvt2pcOmPwhZnUr3JxOHgEIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162369; c=relaxed/simple;
	bh=jxYEJFq5WeOv7zGQ4U4bqSMEsmWhySJfkk+RAspg6gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmm9UOtloVjU96wLFelJgUufcRDavRM59uHdwTvobjezWEf3rdC1FExQ+zsWi+ialdxsFzEUrFHrCKen3WqWMIdxlZIOaVL0gRk/VOQXHx52s97jnz2gS1L4Ukpdva0lVNQQZ9iQcaKySd3tdsTKbDu8CeWlKtpSFn8W0sAtLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRyRvwSc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRyRvwSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788162364; x=1819698364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jxYEJFq5WeOv7zGQ4U4bqSMEsmWhySJfkk+RAspg6gI=;
  b=QRyRvwScVZwxOIIsgn7Big9mTWG7f9mA3eL6OsRoZ8wPXi3LVp8VAlMu
   OEhoyaHbAED3xs3jflzW0oL3WtK39GSo8wtjcqR9ic+fpN5dbFvy1RRKU
   vMl7v/jcKdpXlTcnd9+p3NiaCGypEeUsfXizXEj31iuDumDanqdg94/uJ
   ODRzqe1SiAfJ7K02mSIi45MmUXKAoM1yq3mCRa4TY7Y3K1Zwmx9psTk9b
   BT2yKGO9FMNzEVJ1HyhDMoyj2l3bMKlzemHZbdvqv+mESN91s5DKwKuLl
   qHqHhy+9AMAB+e1QW28iSrFg6SZ+ng5981SoL3UbtZeWUVJMx9S8Qv1P3
   g==;
X-CSE-ConnectionGUID: ZArewE1oQteuiuLbdkJz0g==
X-CSE-MsgGUID: /oiGamLbQwekrDw0hY3n2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99161807"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99161807"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:46:02 -0700
X-CSE-ConnectionGUID: oTcE0FtxRMyJj/6/Z2zUYg==
X-CSE-MsgGUID: LWnWEmfGRI+dCcgF6h01SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="272238973"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:45:57 -0700
Date: Mon, 31 Aug 2026 10:45:54 +0300
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
Subject: Re: [PATCH v5 12/20] iio: adc: ad7768: Wait for digital filters to
 settle
Message-ID: <apUxMi9zpUASjLCt@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-12-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-12-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:35PM +0200, Janani Sunil wrote:
> After synchronizing the channel mode configuration, wait for the longest
> settling period required by the active profiles. Derive the delay from
> the selected output data rate and the datasheet filter-settling limits.

...

> +static void ad7768_filter_wait(const unsigned int *mode_freq,
> +			       const enum ad7768_filter_type *mode_filter,
> +			       const bool *mode_used)
> +{
> +	unsigned int t_settle_us = 0;
> +
> +	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {

> +		unsigned int settling_samples;

Taking into account the values and multiplication below I would make this
to be u8. This will make it clear that the values are not high and there
is no multiplication overflow. Another approach is to have it as unsigned int,
but rename and change semantics, id est use with multiplier.

> +		unsigned int t_mode_us;
> +
> +		if (!mode_used[mode] || !mode_freq[mode])
> +			continue;
> +
> +		if (mode_filter[mode] == AD7768_FILTER_TYPE_SINC5)
> +			settling_samples = AD7768_SINC5_SETTLING_SAMPLES;
> +		else
> +			settling_samples = AD7768_WIDEBAND_SETTLING_SAMPLES;
> +
> +		t_mode_us = DIV_ROUND_UP(settling_samples * USEC_PER_SEC,
> +					 mode_freq[mode]);

		if (mode_filter[mode] == AD7768_FILTER_TYPE_SINC5)
			t_settle_samples_us = USEC_PER_SEC * AD7768_SINC5_SETTLING_SAMPLES;
		else
			t_settle_samples_us = USEC_PER_SEC * AD7768_WIDEBAND_SETTLING_SAMPLES;
		// or even define the respective constants in units of _US

		t_mode_us = DIV_ROUND_UP(t_settle_samples_us, mode_freq[mode]);

> +		t_settle_us = max(t_settle_us, t_mode_us);
> +	}
> +
> +	if (t_settle_us)
> +		fsleep(t_settle_us);
> +}

-- 
With Best Regards,
Andy Shevchenko


