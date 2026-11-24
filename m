Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510696;
	b=bYHOLcWRpKgNv2YJ17WV1cHShpx8LvpFsVqhi4+NaehseDBHvzcGgXDp5enaneaWM4GN
	 +nrQqC7352Z9AXyd2Pi42AkJ4xt8Ei4QdyT17QpzAQKCM2CIF4Vm2662qQyDitHCO9BIu
	 4CLYd4pW1idmKzppXA/orXNpG1J3sAjyMrQJiWcycPIq//rXWsyfKiShXpmSdORuDk5QM
	 jBNUka3wLym1NBQn6iNGlN4SaPm3GD9GPvd1UcXcsv2jDm1Idm0OXZJaHUMHa/woB0DLj
	 pDB1PE4oxuCxcCn0X6Ck1gnWN/8GbYuxVRQHZz3IwPFFlMxp7g4Y4Z14Eon7LeB/DQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510696;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=uypAw9njmlBmu2y3Ii68CKxNaGcAwxeH08nWOm3pwrg=;
	b=NVROlxoU9+IG8i62y4zNhZIUtU6vCSPeX0vpIJ1BX091+ebBARL+IVYXvQ2wAJzeTBNd
	 7la221EjbeNGF9JwPO36CttNKoQjEKJJu2lq0YsLQBmZ8A9uL/Rjob4NOfomHVcNMR/Ko
	 aThQKVUPlS8UVVUXl3GwjV+Oz2XB37WLuKGNJmND2YLTuSX3Dt6AWRd1NLwvTYrCFii9M
	 +wM/VHTcLHvZbh35eJ3BinK9sxNvozBgForwnSnAF9VngG2LTYamCiVzizXPLZ9I1Myu/
	 LZLqeIl2RoI6sKR/KFaJIiwWek2leazQ5uiVHx6wosyeMXkc+XnoPQ8QFHyIi5vM6tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lgWrMo66;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB20606A6B8;
	Tue, 24 Nov 2026 08:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CB20606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lgWrMo66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795510695; x=1827046695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ih7E3wwpJpqM89tJOu4dLAZT6Ef01QZxSAgGl3JbEm8=;
  b=lgWrMo66T1V/m60nXCSSw2DqsHFDpBllJRd8z5SY67ACS+aihmAJ8o3T
   0Z2KDFIxD0+dqaSsfT+5ZnLOwV7v+MDPF2x3l7T8udlTcqeUr3VAdrueU
   YuScCCNqgcuuJK3kzO95U+OcIT94c3rW98fGJbEkyoFVAiy5Z6ljQdkUu
   eFBIZ5KgHJG45E6QmDtznE7a3w2TdCFM2dT5FwyEa7NsjThhghCzqS0S+
   vThkFFpGfvoECkwgydOKoharY5udcjg9yNEKgjhYMvLfG99ZdFJCfqaqI
   h1D8BSpKaxmjRV2DJXvtf2B7IUXrWC5gmhdd7QBzFOj+yNWY1j/a5G9to
   Q==;
X-CSE-ConnectionGUID: SAnm5+L7QuGVcI2U5M5RcA==
X-CSE-MsgGUID: fqVUDl8NQB+n7eE0wfO5JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4351630"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4351630"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:30:20 -0800
X-CSE-ConnectionGUID: cz2dUDc8Qtqw+z0R17y4XQ==
X-CSE-MsgGUID: GWQgG8ZgQta1taE25aB0Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="13187899"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:30:17 -0800
Date: Tue, 24 Nov 2026 10:30:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] iio: pressure: dps310: use time unit macros for
 sleeps and timeouts
Message-ID: <awVLF8HE_fLkGeo4@ashevche-desk.local>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
 <20261123220649.36887-6-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123220649.36887-6-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 12:06:47AM +0200, Rupesh Majhi wrote:
> Write the microsecond values as multiples of USEC_PER_MSEC, like the
> poll timeout next to them already uses USEC_PER_SEC. Wait the 15 ms
> after a reset with fsleep(), which allows less slack than the old
> 55 ms upper bound.

...

>  	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -				      ready & DPS310_COEF_RDY, 10000, 40000);
> +				      ready & DPS310_COEF_RDY,
> +				      10 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);

Wrap this on logical boundaries

	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
				      ready, ready & DPS310_COEF_RDY,
				      10 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);

>  	if (rc)
>  		return rc;

...

>  	/* Wait for device chip access: 15ms in specification */
> -	usleep_range(15000, 55000);
> +	fsleep(15 * USEC_PER_MSEC);

Usually we give some margin, so putting here 20ms seems reasonable to me.
With that in mind, msleep() is fine to use explicitly as delay is so-o
long anyway.

-- 
With Best Regards,
Andy Shevchenko


