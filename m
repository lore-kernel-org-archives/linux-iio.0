Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E12DC782;
	Tue, 10 Feb 2026 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752131; cv=none; b=e9Eu3haYxa0+9sYMF4KkNYOk9i0k7YeWia2viptucaM5P/aGIRzNLYYoL0xzqTlTIbxPXPpcohJH7Vt8cFDvzETCGzd+VT2gd/O0H3kcVRP8hnTZ5gnTjOgbfh18p7YQUqcvFgiYCLWkVCMNi2189Hnp/syn5xsA2LTvg5KeRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752131; c=relaxed/simple;
	bh=M0CG4JCRSPTX7+IrST2LiwFWl4vMOFR2UpPmxkG0k0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny2/vGnIyV/Tu02mKu2B4C3XhKpV8PMKZu94wRf3xUAYV4wLh1pXT7cDcr3Vb4RA024fskz+fTytJzhOiPM+WLPBz5kADysN7D1CRbasBYhmNL2nJrrksufqiOchXil6a75Qgpmy/jk4fjbj8iLfTq3+WKARUclmHCHuKqKYCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ57B+aQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ57B+aQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770752131; x=1802288131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M0CG4JCRSPTX7+IrST2LiwFWl4vMOFR2UpPmxkG0k0s=;
  b=oJ57B+aQGmdj2jgCdp/hK2WXhmSWA4FyCXyoe79QbnoMwaDOehe69f/D
   QAX7SIOp49EmPsS3td4Oj85PVQhh2SDKH0aOUwkVrwy6I7fpGY2FB6BCo
   ETzcKHFoVn4SNkufTcewrBL0Vx4lcNWby+jbBQZY0cIfWOhkRrW5CMirE
   9ADEUjZqfwb+yfzYh2FQ+w3y2XH1mY+UVcw+SYJNWM2RjgHF/Pwi7lzUh
   Nrzxdokjn5Vkg0m5MMYR2ABRVuls+EksUlD8VT7yhbcLtLNgT0gOxG3kl
   6uxhQqg0JxWnrukIZpve4MMGvwgb/ONFXgTT3IUHp+DRBOe6IcZhiGAU1
   g==;
X-CSE-ConnectionGUID: w6nfms/ITdCfwE42HeE8sQ==
X-CSE-MsgGUID: s1Or/hSTSBiENwoPtEon4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89304173"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89304173"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:35:31 -0800
X-CSE-ConnectionGUID: XW+fQf7HQy+p+1TVoXiMQw==
X-CSE-MsgGUID: CT8fosT+RxWL3vpeWF4aag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212049551"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.131])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:35:28 -0800
Date: Tue, 10 Feb 2026 21:35:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: max5522: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <aYuIftCDo5O0IF9F@smile.fi.intel.com>
References: <20260210175137.44178-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210175137.44178-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 07:51:27PM +0200, Antoniu Miclaus wrote:
> Simplify probe by using devm_regulator_get_enable_read_voltage() to
> get, enable and read the regulator voltage in a single call, caching
> the value at probe time.

...

> -	struct regulator *vrefin_reg;
> +	unsigned short vref_mv;

vref_mV ?

...

> +	state->vref_mv = ret / 1000;

"1000" --> "(MICRO / MILLI)" ?
(yes, this way with the parentheses).

-- 
With Best Regards,
Andy Shevchenko


