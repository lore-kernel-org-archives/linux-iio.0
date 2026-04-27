Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7A3914E1;
	Mon, 27 Apr 2026 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319851; cv=none; b=nPo5fBk2tk3/VgfR75S00hiJ5WGgnCW/SkmaWsK+GRIsQ7XcZaAfwkxGccmQfAHBRU60jKFPQtgMXfsrlceK6ZHuMA4tq8QNNhS6JfyoAOnrfYOVQTEFJI1Nafu2ibODkSdET6wVEZRhh+zcpaTOziEi8ofU7z+9EXQ3hD/NX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319851; c=relaxed/simple;
	bh=Pw7HNvlcyAS+y7RQOBGYuyt7kQu2IRAkfaF765xbBOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgA0DcRAiz4s9Wzadbkkk8RqORpSLiWkQEeEGcVZnv87mysx/v64W1adKQeBBbJXY0Zhp4F63mGwoATFw0xBfh0WxuLGtoFwGE3XHLYFwIUUjxSKW2eIvgpyzLzGwM+fJxNRXzLjyxReVxRJa3iMkCP1HaWTgz1rB5E2Aa6UPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQekhM0e; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQekhM0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777319850; x=1808855850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pw7HNvlcyAS+y7RQOBGYuyt7kQu2IRAkfaF765xbBOs=;
  b=LQekhM0eQThv9az829SlxbMrOPlM3Vp5l/CGrjluUoVLqzI7qOkbA6Df
   ++NwOC/+UA48QPbcWotVkVaTWyKfy9ZbhjRuk0N8+4Jc5D9J3y5P3JzzH
   W6H8G9jtHV3FJoMCr2Lw6Wiot77drhRe/E+MtHG4C52jgqGNW4vqLoJcP
   gHA2QwfqDDGA8eRLP6yL/AcH0W8PdU2iaRzdJC6y8GK6fn5umxjKQBxeX
   Jq8Wk9/AYNJ4lTJGeM7zH5CL14W3i2EgiqE9QS4A2+HjTG0hKEPo+tXM+
   VRfj/d+3FC530zWzzQzqYS59bynmlnDs/BjWVSMKAi0CnKyy7MYHnPxMT
   w==;
X-CSE-ConnectionGUID: aT8JmnaKQn+31aQZT/168Q==
X-CSE-MsgGUID: gUZF7t37QHSNelxTVUmdlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100878785"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="100878785"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 12:57:30 -0700
X-CSE-ConnectionGUID: pbPu76GKTGWypYYhuMR+2g==
X-CSE-MsgGUID: F9EgwQe4TK+9IAyoXjBwZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="229183594"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 12:57:27 -0700
Date: Mon, 27 Apr 2026 22:57:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] iio: adc: mt6359: fix unchecked return value in
 mt6358_read_imp
Message-ID: <ae-_pCMGbnOXxkkC@ashevche-desk.local>
References: <20260427190849.14963-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427190849.14963-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 08:08:49PM +0100, Salah Triki wrote:
> In mt6358_read_imp(), the variable val_v is passed to regmap_read()
> but the return value is not checked. If the read fails, val_v remains
> uninitialized and its random stack content is subsequently reported
> as a measurement result.
> 
> Initialize val_v to zero to ensure a predictable value is reported
> in case of bus failure and to prevent potential stack data leakage.
> This also satisfies static analyzers that might otherwise flag the
> variable as used uninitialized.

...

>  	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
>  	struct regmap *regmap = adc_dev->regmap;
>  	u16 reg_adc0 = cinfo->regs[PMIC_AUXADC_ADC0];
> -	u32 val_v;
> +	u32 val_v = 0;

This is hard to maintain. Better to assign it just immediately before the first use.

>  	int ret;

Otherwise, LGTM.

-- 
With Best Regards,
Andy Shevchenko


