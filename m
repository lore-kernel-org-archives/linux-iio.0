Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF634CFDE;
	Mon, 23 Feb 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836695; cv=none; b=o+waSRiEHsiu06N1bKR0anaA3KMB0vPuXlLTsnoVzftvkf4ILOGrWyoIvCUuew9xPuLyuwTwryYP3B/3Opr554DvknLiJyhb5KE91QUb0eHWLgOOkHPKTeTur3xR8kXbdv+BbxAzs4FCqXhLY4ZFbhXglhRn3ou/aC5D9dEykvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836695; c=relaxed/simple;
	bh=UF4qEiiige3WbA/jeemqfrp8EISETqp+6BcITLyM9h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsQwjgmjKN9fEz22xl4VOe+sKjvOEZMSbTTxX2i5DxbnjDAHI4b8oDvFakaBYk5tutU2GOTlYjz69dRdYTRV6f7yIyLM1XqB3bh0nxDpz9V4RcKUAL+26FiE9XCQZ2PrahQM0KbTFTPZ1rle4QrJx9xfpnvOOJzV5ZiimT/Vvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mV1LbGDg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mV1LbGDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771836695; x=1803372695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UF4qEiiige3WbA/jeemqfrp8EISETqp+6BcITLyM9h8=;
  b=mV1LbGDg4qg067DllPO+Xnw2mzE9vzET0SNqEKnR02SK9JEVRtLXDjw1
   +1yyZsGAGMSo5yFe049RcCunOtMLClrUYCbU0O8/psxsBLDiNI0ZMg7XI
   M/NyUn8jKGH68jhPzh3hRfvODB5dT89JF3WGYy2/Ocb7EWvDg3NLrsryJ
   qxB2kDVQzGphqvX4XuNQh2FGyOOaZscHYxB0pyu2JPwC3RNAL8Lgp698S
   +J4MeKluqVR7glg/G0yfVyY0FpDVWVJ7B32RBKwLsLoRudrwPtt0U+Uwq
   UfEOjkC7FfE8K7S6577VdAhjKZsPjXa3oYS2HHN/adnfsjCJf/UxRugcu
   A==;
X-CSE-ConnectionGUID: yxJoybzfS0e3yjQD41fAqA==
X-CSE-MsgGUID: FnbIbT7EQDeig6U/Fh8xFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="60398441"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="60398441"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:51:34 -0800
X-CSE-ConnectionGUID: ZDIqNTSqSXmP+f5LGffPBA==
X-CSE-MsgGUID: YBVD264lSPK6ADgVn2+njg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="238462108"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:51:32 -0800
Date: Mon, 23 Feb 2026 10:51:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: move opening brace to a separate line
Message-ID: <aZwVEd9LUt4Nsooa@smile.fi.intel.com>
References: <20260223082359.46403-2-giorgitchankvetadze1997@gmail.com>
 <aZwQszq2o4MlXpOS@smile.fi.intel.com>
 <CAE7dp2oVSDKM2FArSfLtjjUTBm1RPWQNXrsvOgDNvg9G+URogQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE7dp2oVSDKM2FArSfLtjjUTBm1RPWQNXrsvOgDNvg9G+URogQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 12:40:10PM +0400, Giorgi Tchankvetadze wrote:
> On Mon, Feb 23, 2026 at 12:32 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Mon, Feb 23, 2026 at 12:24:00PM +0400, Giorgi Tchankvetadze wrote:
> > > Place the opening brace of ad7173_calc_openwire_thrsh_raw() on its own
> > > line to comply with the kernel coding style for function definitions.
> > > Issue found by checkpatch.
> >
> > Is it the only problem like this in the entire driver?
> > If so, feel free to add
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Thanks for the review, Andy. Yes, it is the only instance of this
> issue in the driver. I verified with checkpatch and a manual grep for
> function definitions with opening braces on the same line.

Thanks for confirming, no need to resend with my tag, the tooling
Jonathan uses picks this up.

-- 
With Best Regards,
Andy Shevchenko


