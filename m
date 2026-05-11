Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0C3E92AC;
	Mon, 11 May 2026 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506312; cv=none; b=HM5dstnssUKX32O+bB1oTdosy3iBVIHX44ZLRLeLfPmiyoAZuhY1/83j6ziXpMwlH8Y0GvJd1HJzV1OdHW5Pb1WqMs6e39XJsFK4NCgj2UHc4NYQQUFXaEkXMOOGKVCk9LpHSch2ovDelHkYVpOaB/u6E8sC98vpuRxKkMwUdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506312; c=relaxed/simple;
	bh=uO7rdgfRVAdCzJPo3oVrN9SAWJ4sucUeXEaiTVO9OD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9+PqfCekDudrR9C9mv1clsMoPwUzdg431DkuujuXcp7gbU3PR/fboR3kVkSKLm43mXAoJGODLzsXiHrGXPgfso/Fo+r++/GyJpvyruttyWbyGtKI2Z6AgB4NwwUzFAAd7LbgdaKA1qCrws5qSxGS5ZBMi/hgD4uabrnJRQrM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTsanKwn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTsanKwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778506311; x=1810042311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uO7rdgfRVAdCzJPo3oVrN9SAWJ4sucUeXEaiTVO9OD0=;
  b=hTsanKwn3kkkS0X8+EsYYxzHk6Z3gLtkflD9JET+zeqKyty3T16u4qkt
   jrjtb957sk3fpDRm3co7SQN+rCH1MtQdtj9F/4GZdCSwYgj7X1Xy/gdRU
   gYJlRSBA29bPrf9cIfp6vGF29EkPexzdtvcInzGnkVVrXTPs/Fq+O2/Ts
   +EYsHXJAJvBAo4Z6lmLi8EoOwUtIzN+lF8Dy9ZLiKilUPJsnEgu3nM66a
   H2fTKM1SMtGEcTb11xkBemXnkOsjgjUBspIgAl2KsI+08cEVv+yz+Fcu0
   WJN+8g4KSliMMkWy4aZHm7xDIEiaPOgwVfuQoTP2KJWrP24pAXtHd1/0w
   w==;
X-CSE-ConnectionGUID: QfZbf4xCT8eFpi+ONQ76OA==
X-CSE-MsgGUID: D56YP8PQTT+Xs72vBiNqrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79113332"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79113332"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:31:50 -0700
X-CSE-ConnectionGUID: Gk8/2PKKTlGlRBo0yyRVsQ==
X-CSE-MsgGUID: c4tk7+iqS1a1CwewPDCwCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="260936098"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:31:48 -0700
Date: Mon, 11 May 2026 16:31:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: scd30: Prevent potential divide-by-zero
 error
Message-ID: <agHaQQs-be2P_fKs@ashevche-desk.local>
References: <20260509211921.84969-1-m32285159@gmail.com>
 <f7c6c9c6-c5d0-446a-bbbf-6991f6994375@baylibre.com>
 <CAKqfh0GXzfUMhp0+-BPpQ3ra3H5jSKUU0g5RnAtKhP88RDocmQ@mail.gmail.com>
 <f3030dd0-123c-4b3d-8b65-148058dfd44f@baylibre.com>
 <CAKqfh0HUttZhhC1ysiA64rxMztBvfuu+d=m2C8TrnCUuWzT4Gg@mail.gmail.com>
 <CAKqfh0EfaVqUPbhWZ4hVX_mFUN7_CVwir1sAHrR_LC=ZU7fk6g@mail.gmail.com>
 <20260511130311.52d65bf6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511130311.52d65bf6@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 01:03:10PM +0100, Jonathan Cameron wrote:
> On Sat, 9 May 2026 19:47:53 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> > On Sat, May 9, 2026 at 4:53 PM Maxwell Doose <m32285159@gmail.com> wrote:

...

> > Also maybe we update to use dev_err_ratelimited(), sashiko has a good
> > point here:
> > 
> > https://sashiko.dev/#/patchset/20260509211921.84969-1-m32285159%40gmail.com
> > 
> Do we care for something that is going to be a very rare hardware failure?

If it happens rarely, ratelimit is no-op (no change from regular printing),
the only difference if (and I think this is actually what may happen IRL)
there is an intermittent failure of HW and it starts spamming logs like a
hell.

> That's one interesting attack vector. I suppose maybe they have another
> exploit that lets them trip the scd30 into an odd state. 
> 
> Ah well, doesn't do much harm to rate limit it I guess.

-- 
With Best Regards,
Andy Shevchenko


