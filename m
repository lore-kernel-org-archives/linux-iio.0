Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DA3C2B8F;
	Mon, 31 Aug 2026 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164806; cv=none; b=Y4x6kQnH1WcKQf8X114EYDvcQMuctKZRGm6SodCFcyMPb32aIOrt7ff8yb+6cCfpMlZ+JNKrfYlN957PUvwIKKpNGPmJ/9gWFGer+ELRG0SldvoPFvIVxirTWsMyxcUcALs+g6jD8Ac4P1OAtRp/mYvapK1Z8yIJzPRsVjc6Y64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164806; c=relaxed/simple;
	bh=EYGaBasvwHpOTSkApWMpEFG5CRz6v6kZSL7h1iC5nYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHXXP8Kt/AvJucsTsxYshq20GEKsCRuRzLNo3aqrLtrylPHCeZtAjIHZBHQZTRw7h83NygsOh25aw40inMCfKpLJn1nG7llfZbSMATFvE7oMh0am8KW2M9RjceksvL/hMPzsV3UwRHeqhoOsBWFEjLFImVgATQYbAqEh8khJ9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=je2+U+Kb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="je2+U+Kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788164805; x=1819700805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYGaBasvwHpOTSkApWMpEFG5CRz6v6kZSL7h1iC5nYY=;
  b=je2+U+KbXYu9TXvUpaE4tJ2lSK01HNIq3WyxzK8OdS35yn6O2njakA4v
   CXtrtIUwDIyEDogQS2c/tmjZKJUqA0ch+uqqaSQw2yM0pV3b7aXHozfcl
   R0rbeXbUZKzwwRSQcLWzZgYJY19ADNmAM/btnjuoqFWwayuSpc4gETxFV
   /vQQbYzXxPAPq74LBZL8Lq2aSShyRX0+MjM1klaZQDBPFZ0b3KNvnr+Si
   JwD/Is+0Qar6Fc/CUyEJ+fF9lL8/ruZYa7RdqvFe9dhft/jslgtsruWVU
   KABkXYSa8RMwsGMD7kzbvXVs3LX9ZN7coWtpwOHmC56QUuWdktiLZnS8T
   Q==;
X-CSE-ConnectionGUID: mbzpYk7FTgeEBQ525OUOIw==
X-CSE-MsgGUID: ZDSQoojbQAiI+fD2/KrdqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88615820"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88615820"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:26:44 -0700
X-CSE-ConnectionGUID: ZvQUIszGR62WSweUwQICrw==
X-CSE-MsgGUID: 9luAs2UaQXGF0Gm4D3O3gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="268775231"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:26:37 -0700
Date: Mon, 31 Aug 2026 11:26:36 +0300
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
Subject: Re: [PATCH v5 13/20] iio: adc: ad7768: Add calibration controls
Message-ID: <apU6vIykfQ0RP2-_@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-13-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-13-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:36PM +0200, Janani Sunil wrote:
> Expose the per-channel offset and gain calibration registers through the
> IIO calibbias and calibscale attributes.

...

>  		chan[chan_idx] = (struct iio_chan_spec) {
>  			.type = IIO_VOLTAGE,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS) |

Why? Leave the existing code and just squeeze the new ones accordingly.

> +					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +					      BIT(IIO_CHAN_INFO_SCALE) |
>  					      BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
With Best Regards,
Andy Shevchenko


