Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005D397AA2;
	Wed, 21 Jan 2026 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987022; cv=none; b=hFvPS5IziyxO9X8WJM7g58yaCPnNR+wCnSMqEv7zc+uJ7EtvSSqsqCKHwnHCFKEhikFiV4nxyjJQaBnWnB/6awohiHPT3DwqS2ODbvVZ4mZ9djMJ3mDE/Xz1kf9heq8KJUEBuN9GG6l73IFizgBvV1dONHrvovHbfoF8S90R7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987022; c=relaxed/simple;
	bh=sMZog2H9C3SvsSiGwEIi7Jsrzwe2un9Lud7PLNum0vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNaGarjqr8mMycUHBQNc5RZsi1d8JATnlOL7GIeTvuB7y/RM5lqeZ6TqGg99TvGqd1D68uU5y0yFkYSvmX0n1uLcyIJeTVix4orGZCHdN10bkWhPZ7YKZZM4YBPRgrSeXXM9UHRT6WpdPC+msNxIjQB/+UuUQgsuQgg1X1lE2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgozE5DE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgozE5DE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768987021; x=1800523021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sMZog2H9C3SvsSiGwEIi7Jsrzwe2un9Lud7PLNum0vs=;
  b=bgozE5DEOnsrONNSFZvHHjbLiVxM2P1AKBGVnFlzfwtdqdfvWzZoquQU
   wgyEu032SquEgJwYBJi8hb6L9Z5RhS7W4+md+s/ySU8ogwjWlZ24MQ2yX
   Vo0T0P5VEOuunl/E7+nlOVhatDlH1Pf6T7thbZkvuO5yYU7RLtyTDWsmZ
   FodmAsRFZTlWm9uk6pGzXpSmRjbmJsE+bYfCo3B7zSXmvaDAw0/4oTHd0
   9Rtmz6g8QQKy8JbGIIHG8NgGO0ObK8fPjRR7wko+safeGR2Wcn6g149Ol
   T+voUmocWl12BSgXbd+EqWoAthGwCKi7WrTIWui4SG+dED9Pzey+hb3sU
   w==;
X-CSE-ConnectionGUID: 9eg9DJkTSx2k05RdsjB5tA==
X-CSE-MsgGUID: 7k0gvfJCQcWP1yb6zx8duA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="95682702"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="95682702"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:17:00 -0800
X-CSE-ConnectionGUID: hfzvVt02Q1SMZ32I0LfN6Q==
X-CSE-MsgGUID: ukapNz4PTOi2+q1Q+Z428A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="205647310"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:16:57 -0800
Date: Wed, 21 Jan 2026 11:16:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/5] iio: proximity: rfd77402: Use devm-managed mutex
 initialization
Message-ID: <aXCZhtrdiXKGT35g@smile.fi.intel.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-3-5b944d0605dd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121-b4-rfd77402_v5-v6-3-5b944d0605dd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 21, 2026 at 02:05:43AM +0530, Shrikant Raskar via B4 Relay wrote:

> Use devm_mutex_init() to tie the mutex lifetime to the device and
> simplify resource lifetime management.

I believe it's currently more about debugging mutexes.

See how other commits in IIO look like

  commit 6e43c10675d876a5fb71e57a9bcca9533fccccd9
  Author: Nuno Sá <nuno.sa@analog.com>
  Date:   Tue Nov 4 15:35:13 2025 +0000

    iio: dac: ad5446: Make use of devm_mutex_init()

    Use devm_mutex_init() which is helpful with CONFIG_DEBUG_MUTEXES.

With the commit message being rewritten,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


