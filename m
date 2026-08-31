Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0D3D953A;
	Mon, 31 Aug 2026 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165011; cv=none; b=ZlNjmyrPwMQ+KRu6ufu2pOSJ09uTNHDLl7wyyVB2GPnFfkbhcC543RCvQCoEZKI8VkM4e8SbbSLs0+0XEJpjaPvKclAmgl5zthclvWu0f9md2n8UK65EdOM/OhWXKurRuCagqkFY+amqhgMV5hghbpkfRn5vqb6npJ81HB3kjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165011; c=relaxed/simple;
	bh=ATspSjA9D9kmXkpiyFHPiPzcJOkuOD1ca/lLimrC54w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWyTZ0jfkXl6NUjj1+6204LEuMvJqC6aduL6HGOXvQOW/0naUR7rMAmV7FX0qe+UF1EIBVsx+i8UvxgEHYmu2Z7yjHitrRoF3RcZxmyAlAfubZ6NqqqzPMobsyGJVeLuGEgwbr83iOcwtxHesWzqC9xgrosue3h/GQZrdjNeG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqjOImvi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqjOImvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788165010; x=1819701010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ATspSjA9D9kmXkpiyFHPiPzcJOkuOD1ca/lLimrC54w=;
  b=BqjOImviM0uf4YMmrQdHLVU4a5ZGUVsBCn698yfPmLAe7KiCN4klJIjY
   om0rOTNlzaaaKkGXrFmXI9Wwf7bMwZER+tk72aMwh3ZZmTfTLwurGKe0N
   BjO47PwaQgCJAmTJUhoRiWaE0lhMsKJhCWidi9meet9/jKkKxiWWBTudx
   xjF/D5YJr4Q/6CAA1HML8yUtFMPWi0L6/SmydPB2XhxpxsyZnjx/4lWKV
   88z/FZPPJd+BmSRMVhWD1CE8dEw0bdKiKzxwYA2+tQ8aQxzqVnDU5HBIc
   DC8ClRxaOF4HLU6WmdRmctSvhWM0U/ncvGxBdh0lTXquxLO8KYx4Dm2xw
   w==;
X-CSE-ConnectionGUID: gsxvvwrbRXCCXcb+2qX43w==
X-CSE-MsgGUID: Z7tt4Y/PTvuTMIovIErkbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88419198"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88419198"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:30:09 -0700
X-CSE-ConnectionGUID: Gyq1+FqqQhWRhFliq2i9tQ==
X-CSE-MsgGUID: TcvaGLo8TeesJbGbXm9SSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="265493103"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:30:04 -0700
Date: Mon, 31 Aug 2026 11:30:01 +0300
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
Subject: Re: [PATCH v5 14/20] iio: adc: ad7768: Add per-channel conversion
 delay
Message-ID: <apU7iUhnmaEGmEmG@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-14-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-14-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:37PM +0200, Janani Sunil wrote:
> Expose the per-channel synchronization phase offset through the IIO
> conversion-delay attribute.
> 
> Derive the delay resolution from MCLK, power mode and decimation rate.
> Validate the requested delay and program the corresponding phase
> register when applying the active channel configuration.

...

> +	mclk = clk_get_rate(st->mclk);
> +	if (!mclk)
> +		return -EINVAL;
> +
> +	mclk_div = ad7768_power_modes[st->power_mode_idx].mclk_div;
> +	params->step_ps = DIV_ROUND_CLOSEST_ULL((u64)mult * PSEC_PER_SEC *
> +						mclk_div, mclk);

	params->step_ps =
		DIV_ROUND_CLOSEST_ULL((u64)mult * PSEC_PER_SEC * mclk_div, mclk);

	// Can mult be declared as u64/s64?

-- 
With Best Regards,
Andy Shevchenko


