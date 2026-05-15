Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4E3D646D;
	Fri, 15 May 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837224; cv=none; b=S3l6+hdw9e92ufRdh7UNUS/tFUczhQvexAdQ+f8XoqpW5SweW0QjfdKtNG8etqLqkMM8qGBo8qi6dVMLUznPVn3+T42Abh4D/v01e5XJgqV3iyEYLS63q8mB10u1CqHub2LWqCHRoSx12jnxTpsHYUDasRgC5uBXuSa9stpCntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837224; c=relaxed/simple;
	bh=3CPAkx9yIEtqzPlXREwAuQyeXg/nb9inT4H1AV0ImEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh2fmdNbi5hkXktut83BIgyuoc6D/NCc/9fo8djRCMcIlax5WRTppiV2dOhdsktjoBj3hsgmcILI7s5JTLHmb/7cLbmvlMvfMxaHfFePLfD5L1RETvaJVZ8z5W+Mj5mzsR0Hcu+I8Q80iE9dWn1zTSACbwQL4OVmW2Ql0ntRkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4a0s5Gl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4a0s5Gl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778837222; x=1810373222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3CPAkx9yIEtqzPlXREwAuQyeXg/nb9inT4H1AV0ImEM=;
  b=k4a0s5GlEOtXAPxO1+NNUIRgEwVG49eHNM/pFzcwddJIj393E6vU5nxT
   K89SN/07QsTF5QSxqL2eMDYowczcRVztj2yfWOrXHW75XiNs4WHWebLXx
   cL5RtwvIVmQBJifAHj9o+39wOXqH0zhNa/OIWitrDQiq4zu0Hkj2eWJzb
   hraKQZjQz9o2A8vVYgSmNm/BAH2Q6wlWYTydJ8+BLBgJ87z9y9qHVOmXD
   SQ61WPPyA6t2gwrverb4v4/uwzfRbME4w7l4oW+pOEgKcvupzQmeZXJWs
   tWPV6AaxnY3qqYZS55DBa01rk31C7WTraQpUMFZiBGXfqPD/9wppF5a4B
   A==;
X-CSE-ConnectionGUID: IsgcTVSGR1udMGUaZOAB4w==
X-CSE-MsgGUID: 88lcvRtJTSKE46n+mT1d9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="105248640"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="105248640"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:27:01 -0700
X-CSE-ConnectionGUID: ehTBC+14Rc6nlGWd7Enpcg==
X-CSE-MsgGUID: rdDzyRzqT9eg9E+FgzAdIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="232249466"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:26:58 -0700
Date: Fri, 15 May 2026 12:26:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] iio: adc: sun20i-gpadc: support non-contiguous
 channel lookups
Message-ID: <agbm3-GUqgzecUlQ@ashevche-desk.local>
References: <20260514-fix-sunxi-gpadc-sparse-channels-v2-1-d4a66b70c7a7@mmpsystems.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-fix-sunxi-gpadc-sparse-channels-v2-1-d4a66b70c7a7@mmpsystems.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 14, 2026 at 05:19:34AM +0200, Michal Piekos wrote:
> Using consumer driver like iio-hwmon which resolve channels thorugh
> io-channels phandles will fail for sparse channels because IIO core by
> default threats phandle argument as index into channel array.
>         eg. <&gpadc 1> will fail if there is only channel@1 specified
> 
> Add .fwnode_xlate() which maps DT phandle to the registered channel
> whose chan->channel matches the hardware channel number. It allows
> sparse channel maps to be consumed by drivers like iio-hwmon.
> 
> Tested on Radxa Cubie A5E.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


