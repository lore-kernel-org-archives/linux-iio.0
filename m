Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498C3815D8;
	Sun, 10 May 2026 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778417704; cv=none; b=qaL79uZ5hITp+kncElQfIAfHB89cYXkM7A41Yv3xaeis2e9COPM3vd2BaRjqaqymklQFjjlJ2tppXDw1UjLzW3OiyBFL0/pGxjp26zu+1Bzv8RQuh59njMEsXrcFbx9Uu6yTcNR5o3NV5hMEy6W6EcP6euCRchN2/5uwpBYHzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778417704; c=relaxed/simple;
	bh=aVvnxtYsL6RBsZRox1ADfAUMdBEtP1dBPulb6F7sMOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0zCW/RY31lS4JjiHaR1Ed+4SlD8vol66+/WE3mtbj0iVVnSHL35td7DcYv7X5C1ttfoOEDyfAWwCqoe+18LTdaZGCF6ITDnQe9fNDLDGI4zrzibJxBoiAfJrUE+N+jPgRrcbf+XE5Ts7oP1tvR7ZUqCZk53r0GZPL9JqbWxybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1Ke8Eq/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1Ke8Eq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778417702; x=1809953702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aVvnxtYsL6RBsZRox1ADfAUMdBEtP1dBPulb6F7sMOA=;
  b=N1Ke8Eq/dCzNB4REiDf479q0B5q1oQPZbnSk/zw8DX9jJ4Mjt1KHneOg
   9rvBf03h/jfy5WM1ZCxUWnO1q1aTMx+n9N/kAYebWF+KRkp/HWwBug/mr
   qw1hgAvtn+pcdMx5wG2Zi5ORscvrNuJIcW2FVqn1t/mku8YYfDSNUaWZt
   0te0wIU5Cg0jxNBCbxeBfBvqqTkHEWw275xXwgQKxiByiwTf7A5SeSfPN
   Hi1/LqrnF6EQPBvge/KMNlP1aCET6DQKgwVmeVPrA3WsltCewvnqMAPT7
   Ix0cY3oGy5fUVAJbdaNzZpI/LZ3Fc7pCByrxpWPDPxjLJbWuD3TBLkSkn
   g==;
X-CSE-ConnectionGUID: k3a2iMg0RVmKBXcIK7RSkw==
X-CSE-MsgGUID: eqrWgJ/yQtmw8DSgml3GjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="81891736"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81891736"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:55:01 -0700
X-CSE-ConnectionGUID: C+uXFmDeTmmEyyJNl9fNFA==
X-CSE-MsgGUID: FdltFk89TAuOJ7wx4SQ7nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237313177"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:54:58 -0700
Date: Sun, 10 May 2026 15:54:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	puranjay@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl355: replace usleep_range() with fsleep()
Message-ID: <agCAH5ShX3enzwwh@ashevche-desk.local>
References: <20260510050820.27748-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510050820.27748-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 10:08:20AM +0500, Stepan Ionichev wrote:
> The "at least 5ms" wait after software reset has no specific upper
> bound. Switch to fsleep() which is the kernel helper for plain
> "about N microseconds" delays.
> 
> No functional change.

...

>  		/* Wait at least 5ms after software reset */
> -		usleep_range(5000, 10000);
> +		fsleep(5000);

Even better to use predefined multiplier:

		fsleep(5 * USEC_PER_MSEC);

This gives a hint on the value units without even needing / reading
the comment.

-- 
With Best Regards,
Andy Shevchenko


