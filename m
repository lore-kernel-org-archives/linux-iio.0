Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF73A7F40;
	Mon, 31 Aug 2026 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788151492; cv=none; b=XlMH4BdHAfYyaRNEcMLrCT0fsAAIpyr97kQW6HvxDCiSOcZEk3XX5A9vWbfXfiIeOFGpXEGfAhjcMhBh5ABQzMKkeAP14TrZJ+SqYGIyOtvT//AMjv5gDou+h6w80BIsbNeTG7OwNDV0rYNXtpkd7cj/e982qvenkCgGGmjwH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788151492; c=relaxed/simple;
	bh=jhQui5UTwE6ppSDaOjdkw5eHphNlBEuD9mh+UF4B+oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRxyqVvJFisrNJkmVZIHG3w/YEmiJJeljfXNV4d8xuhBVps8s1asZy+XnKGcnFbhREJO8qR5fzpNF0ugFZZJJN7b6tHyhKf/dGHdpGOLqOagVTIYNPsN3JCCaZyIZJa8FxLN3FlAdnjvJYbeE4W4c8ZZbmA6ZeaxxZJ/jCStVEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4WmZycv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4WmZycv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788151490; x=1819687490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhQui5UTwE6ppSDaOjdkw5eHphNlBEuD9mh+UF4B+oA=;
  b=e4WmZycvTiJYvl2x1KhdX6EblofEOv8TmEAMkotKApLlXWpK1YJKDUrG
   u3VJH4MP31Zl5+3YbLzHmXwrfXdxoLLvCupdN34v5yB9QR0YrrLBeHl4C
   12CB67amo+6ywlOXS9B9MEki0mOAECrHbHzPHIZbB3P0cUwHidgAMNT+n
   /oMZJMkaDFTRmBH8DN8pnJjs2T1A2Oo94l9DoUvocxU3NYqE63wsKTNYa
   6jwRhGf68Gvrjf9IS1ubpWDfn6ABUZrsZ/sR3jnid1f5i5Tvukckcr/sG
   +8CWaz2W/ri70p35RV/ygO2RJyOAqcTEH1IOdnTB7V+E0N5U0UCmDD9Hf
   w==;
X-CSE-ConnectionGUID: BIvEBk3JQwGzfK+fEu800Q==
X-CSE-MsgGUID: VqbRBeO0TFOANngIISn+/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88673370"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88673370"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 21:44:49 -0700
X-CSE-ConnectionGUID: SuUS9VWWSn291tJD/sZ/cA==
X-CSE-MsgGUID: BU2OE7aNRmmFLNXH8xqH1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="306929043"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 21:44:43 -0700
Date: Mon, 31 Aug 2026 07:44:41 +0300
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
Subject: Re: [PATCH v5 07/20] iio: adc: ad7768: Add power mode helper
Message-ID: <apUGub4CL73fCStL@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-7-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-7-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:30PM +0200, Janani Sunil wrote:
> Describe each power mode and its internal master-clock divisor in a
> table. Replace the open-coded fast-mode setup with a helper that records
> the active mode, preparing for dynamic mode selection.

...

>  struct ad7768_state {

>  	struct clk *mclk;
>  	unsigned int datalines;
>  	enum ad7768_clock_source clock_source;
> +	unsigned int power_mode_idx;
>  	const struct ad7768_chip_info *chip_info;
>  	struct iio_backend *back;
>  	unsigned int vref_uV[2];

Looking at even this context I think there is better location for a new member,
run `pahole` to confirm and amend.

>  };

-- 
With Best Regards,
Andy Shevchenko


