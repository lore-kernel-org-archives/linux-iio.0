Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43E3E9F60;
	Wed, 22 Apr 2026 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863636; cv=none; b=LYG3KG+Aq5N5gjmEuItezgnIUsS32PD4ZCpAVkrMbmEZGtDFY7PHkINTzfN32ropRtGLz8X/+POrBvhO8/RA7uoNKYS0mPyMDqbtDXAFmA2gOZYlq04k8ZVUJ7S5o/MBrv8WHxps8IpAoSdYn2S4A4SnLTzXBOt7zRI8UONiXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863636; c=relaxed/simple;
	bh=1Vj4CZbB4CsH0pgkNdVqtD9Es69MOM35hm+nyt7OBDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qahd+yuZYj1j9Lm3q9x5cdUg751DQJADGLeEvWWx/ztPae7dsYjTwgVc6rENSeFPx11x8CYx1vBIzEZJhlBNMs+lW//w9LXpTQz/fOFe2vS/9l2cSp2LTKexCSVlUbudpc4/OVTcwbwMvSzeV2nHhDDqnLDBmGno5t6G+H6F7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mx5AA9gP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mx5AA9gP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776863634; x=1808399634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Vj4CZbB4CsH0pgkNdVqtD9Es69MOM35hm+nyt7OBDc=;
  b=mx5AA9gPhlh1T7DmWfyo6wvyNLjxpRARPt1y+1rKUBfJhIdwkyxIeSeJ
   bM9DqxNdCkOZUazbdx9AwV+ShOqlT1Vxo50F2Cq+9qlPuFSPj9zJeBccB
   SX2r0BeBxqQs1OteAQl+kKWytto90Sl75oT6dZuYDgFKneoSJHrUEA77g
   F/PknKys1PvIkdqTfD4bMn73qW+JzbvRK9DCwH0XHPk+lFTQXXG18PCgJ
   oKNhaSy74kGqU9GKj/P50RfTkgrrXjm17nCgEzM8SO3RmC3gkqoDJWrdM
   wBdNIOG6IeZamEBpFEb8IukwFa86lzKHqGxdQxMAPwZqk73Q6OeG+aIlN
   g==;
X-CSE-ConnectionGUID: D+EZVRR9RVOIxjdX9/WyxA==
X-CSE-MsgGUID: Vp3/J2grQdKPROxYBSbT9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81425854"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81425854"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 06:13:54 -0700
X-CSE-ConnectionGUID: 5qRtExQ/RCe/Fc4rZU5DJg==
X-CSE-MsgGUID: z/6jlOd3SQa6HKuucUbYdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231458640"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 06:13:52 -0700
Date: Wed, 22 Apr 2026 16:13:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: magnetometer: ak8975: fix wrong errno on
 return
Message-ID: <aejJjusTGt1Dv0WR@ashevche-desk.local>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
 <20260422112207.1313-6-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422112207.1313-6-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:22:06AM +0000, Joshua Crofts wrote:
> The driver currently returns -EINVAL on polling timeout instead of
> -ETIMEDOUT.
> 
> Replace return code for -ETIMEDOUT and remove unnecessary error message
> as error is described enough by error code.

The idea is to drop messages because this is well established error code
and we have a POSIX message being associated with that (meaning all libc
implementations should follow). That said, it's not described by the error
code, it can simply be retrieved from libc *based on the error code*.

Can you rephrase that?

...

You also want to align the code in
https://elixir.bootlin.com/linux/v7.0/source/drivers/iio/magnetometer/ak8975.c#L700

The all three wait_conv...*() are called by the same user in a single
if-else-if chain.

There are two definitions:

#define	ETIME		62	/* Timer expired */
#define	ETIMEDOUT	110	/* Connection timed out */

For IO the first one makes no sense.

The driver says

`	/* Wait for the conversion to complete. */

which implies the IO with the device, and "Connection timed out" maybe not
the clearest form of it but better than "Timer expired" which rather misleading.

-- 
With Best Regards,
Andy Shevchenko


