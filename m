Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429C360EED;
	Wed, 13 May 2026 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704642; cv=none; b=SDYSeANtz6Qb+zMv/rwJ1ixfiBvqegM4sbM+Sk7HIRinrfGg7VVl4NTdTdeYIaZewVLRMYo8ks72yMvhmRbtQ73cbY1RSXRVCyzGY4F63emNa3ID3G62LdrUPN3n7od1QfyALaatFlEbZXyASryshBxzCuzshGqFWapO7E+Ah+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704642; c=relaxed/simple;
	bh=1fPqPt5FKZcsAeE7wxYgjEGDSVnnvgy1c7TOKRuWMSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Baj/1h95TGVfQ9xXr4LsWLjFoQmCKcN0Aph000nd/LCvZBNaI6uGbWu06MFdpHmmitvlSFUd3sDhB8PKr3mqnQLD7ihzDlsUSKhViFYFQBQ1JL2mRDuhOYsgsd+AC8LrPUQx881HIChwfwlFV82PGkVaC4uMDCZ11bn+wLe0oyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Way2Mck0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Way2Mck0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778704642; x=1810240642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1fPqPt5FKZcsAeE7wxYgjEGDSVnnvgy1c7TOKRuWMSA=;
  b=Way2Mck0dP+Cl/7cdo0A+/mao8zdGXJoe4qtsNxA9oUUxIzw4agMS8D0
   CtnMCr2oZRO3NiU62bXxMNP1KftcOWjHbfrbaImArOg/aVt2QQ8fBWram
   uuU1Ctl29YDSP/aVAx6ESgX3zGPow11a9bUIwLHhhVnfOPKT+ZRHvSLvc
   JR7GCdz9oLcw36GVAko6QMZ7jdcqPVTw8oGdHiE7eUQDBIlZ5Nr6BRGUc
   +G9yqKV1hJjhgTU5KfkEb7t5kyp6rhKVxKO25FCJwYiK09pZetUtq/b2W
   5E+5AtUlzw+h610/sYJcuZBx7Fra2J8LYHuMq4A7rO3s65Dae1pE+GRBG
   w==;
X-CSE-ConnectionGUID: JFNA4XELRxCSknw1B0ukGQ==
X-CSE-MsgGUID: B98eJAzFRMKLawAVsdATHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79623832"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79623832"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:37:19 -0700
X-CSE-ConnectionGUID: uqFT9qMGSQCufF1Nb1rcMw==
X-CSE-MsgGUID: 2TF2YoDlRoisIJ2M53T2wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="238077628"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:37:16 -0700
Date: Wed, 13 May 2026 23:37:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: Michael.Hennerich@analog.com, nuno.sa@analog.com, lars@metafoo.de,
	jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ad7768-1: GPIO reset path delays do not match the datasheet
Message-ID: <agTg-nZyXIJCjW6k@ashevche-desk.local>
References: <20260513150042.10939-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513150042.10939-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 08:00:42PM +0500, Stepan Ionichev wrote:

> Reading drivers/iio/adc/ad7768-1.c I noticed the GPIO reset path
> uses two bare fsleep() calls that seem to disagree with the AD7768-1
> datasheet (Rev. B). I do not have AD7768-1 hardware to test this,
> so I am reporting it rather than sending a patch -- maybe someone
> with a board can verify and fix.

...

> I am happy to send the patch myself if someone with hardware
> confirms it does not regress -- I would rather not submit an
> untested timing change blind.

This is ADI chip, right? We have a few senior developers from there in this ML,
let's ask them!

-- 
With Best Regards,
Andy Shevchenko


