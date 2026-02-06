Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED922FF164;
	Fri,  6 Feb 2026 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386861; cv=none; b=kCu2B0y0To+CE2ur7nVvSxThPVTxBtAlxp74VJqmg0UPfselMHQM+Hj12umBMLWy6S4FEuDlqgbgvOODk5q1n/7bh0zAo3AcJBST3cn9y+OE+PwMd1Ogh8Wns0Aoa9uPFcVoWQNTTX8hS0jg6hrfYmhqU1N4h1NI/TA9cS7bGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386861; c=relaxed/simple;
	bh=jjY7T6zPdXiV7TPJjJr8fNiRnEDQ6W3NH6nvHVz9Cgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4Ilkw7Zz5KGIukeYOpRCUlQANpob45RGHyb5Nr5YhstuYOACoiLm7d56P9ygbnBAhLDn6ZPjl7vX0Qws76noRb/2LzUg/ki8JsgwOLpb7LCJmq/k4cZgEWhXcFa016Xfep1Zop/wc4akeseWT+sguaJpyvy07nNCCJBoS2kVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8TvY+oo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8TvY+oo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770386861; x=1801922861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jjY7T6zPdXiV7TPJjJr8fNiRnEDQ6W3NH6nvHVz9Cgw=;
  b=I8TvY+ooPm3YXgRZTP5tpGchgV2p0VwnkTyOeJj2atcP/ihpL1xny2vy
   yWxrNSK3lXBe1nzZaDZ0tixTIYSkRy66zadB/34Q8rhbOnQwtoeJfNklt
   ugdktZB/iXunzJfmdvtOlqlmWu4S8M6Dns4TYm35BadKyfNWH+MW/+BXH
   rAt90wIrcbqaXiJFTc3KHC/97PXAgfX+JxSYTW5n416YrMUkrmNJmWLZq
   Qcw2w8awJr9fvV3SkInaJwjaKGdbRu63P8uQRYe8u0BElJVB9l8ShdZEO
   /LT9EqbO4FRAawoaDAt0s57SJn0toROffsBia7AlAPND4iLR74Dc8TljQ
   w==;
X-CSE-ConnectionGUID: o3f55elESP+PsP0fpbdrAA==
X-CSE-MsgGUID: /YotLe6WQQyy1dYeU21FIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71493287"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71493287"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 06:07:41 -0800
X-CSE-ConnectionGUID: 8rIOHPvXTOaKLnXmaHS0Bw==
X-CSE-MsgGUID: lpPApGQqTWOCl97EVg7eDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="209968539"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 06:07:38 -0800
Date: Fri, 6 Feb 2026 16:07:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jorge Marques <jorge.marques@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] iio: adc: Add support for ad4062
Message-ID: <aYX1qCSTSuIEt2GV@smile.fi.intel.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXvT5FW0hXQwhm_@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYXvT5FW0hXQwhm_@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 04:40:31PM +0300, Dan Carpenter wrote:
> [ Smatch checking is paused while we raise funding.  #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Oh, this is indeed sad. Wondering if LF can donate...

> Commit d5284402d28f ("iio: adc: Add support for ad4062") from Dec 17,
> 2025 (linux-next), leads to the following Smatch static checker
> warning:
> 
> 	drivers/iio/adc/ad4062.c:1557 ad4062_probe()
> 	warn: passing positive error code 's32min-(-1),1-3' to 'dev_err_probe'

>     1555         ret = ad4062_request_ibi(i3cdev);
>     1556         if (ret)

	if (ret < 0)

resolves immediate isssue, but...

> --> 1557                 return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");
> 
> The comments for ad4062_request_ibi() say it returns negative error codes
> but the comments for i3c_master_enec_locked() say it returns "a positive
> I3C error code if the error is one of the official Mx error codes, and
> a negative error code otherwise."

...would be nice to have a conversion helper to get Linux error codes
from the Mx ones.

-- 
With Best Regards,
Andy Shevchenko


