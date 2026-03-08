Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3F335540;
	Sun,  8 Mar 2026 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773001088; cv=none; b=Ii2ZhXLeRK2baOYlbEPt8X7wLHoKoNdF2NxdiHa7r9qQCrAhmi0rVhgN7OEkJjs/SUB2q+fOmnMu5CkqYdxzC9JPQWeIKzebEI7BYRtzH72hJ9ybZ2dVBTZest4kKOjE4IzYiw1nrbFZuMSn4GdncM3ZynoWoV0Hdz5nqMSF+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773001088; c=relaxed/simple;
	bh=wLtZYgLZyWsZHDzTxIRgJ6fz+xVePt46AHeGHgjaBo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq/GQxV8myZpHiyNhl/kPPJ7hkZaK/UZQX22tt2ksSkMV0VB0zLxTJg+0p6n1sQedzg27J4V7T6CThgdWFWsiqslR0eE3KDZY3HWGKv7PZLK4vy4VRW/WETjRbFTYOWGNiyBntCDkbwpiBzCsOGoz3BX6xOoa6khH/p58kqqDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esOrC2YE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esOrC2YE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773001086; x=1804537086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wLtZYgLZyWsZHDzTxIRgJ6fz+xVePt46AHeGHgjaBo8=;
  b=esOrC2YEujfCFBakiC80LT82bz24b7QC+ebBcO4LsryhelaZcMnaUf6k
   xobLZNEX+oukYiPv7dI+M6OhkYWgSO9BhLGfvEtaDHSZvMuToAmiSFqVj
   h10+enIJy0Lo4kgSoyKIVMFm1xrOxGDm0FAuszxss9a/62fcFO9hLVEEC
   8zTbALhOh1FiiC2Y5Cr1mjwLZxp9gYLR0e7pKDp6rcushqUSVpsCVbuhv
   eU3SEesM0ZuMtrmzkmtmGYlOFyrZ1zDGZuuEnZ5FEn8YVoevsU2Mj9B4w
   bLT+UEDuJXsw6VPXQMoZBDuas0vD0cBsBIt86FNzbO9/S4Hm3fXXX6Skq
   w==;
X-CSE-ConnectionGUID: Hq3/9P2QS8medts7y45s5w==
X-CSE-MsgGUID: 0nvCv84BSWSh9rE2IPAinA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74105409"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74105409"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:18:05 -0700
X-CSE-ConnectionGUID: LRlGCOZnRaecG7ZmGZbzuA==
X-CSE-MsgGUID: zUY2e5h3TByyKs9iBTXfOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216547716"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:18:03 -0700
Date: Sun, 8 Mar 2026 22:18:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max1363: Reformat enum and array
 initializers
Message-ID: <aa3ZeBGgvylPqAAr@ashevche-desk.local>
References: <20260307071555.14683-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307071555.14683-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 07, 2026 at 11:15:56AM +0400, Giorgi Tchankvetadze wrote:
> Reformat the device enum so each entry is on its own line and add a
> trailing comma to the final enumerator. Also reformat the nearby monitor
> speeds array for consistency.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


