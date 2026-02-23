Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A0321CFEF;
	Mon, 23 Feb 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855031; cv=none; b=Ed/gHhqOULMnbf/nEPiOXIxlIiXBxkcwXwvMnBYVRPsq8d1ALsS078wVnhc2SdtNDrIkV6V3YivpWGgt2XidcdnSY2mZoXTkWfckBPArHVGuGIihvy2EM3i6ikcUfSMJvGoEXTv/BOkbeN3MiHjI+P0m7r2ufteFT+rKnQFrmcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855031; c=relaxed/simple;
	bh=/MVsSFcFz6u+t0/3QPecpmXWT5CQDGWG3KUz/FKUY3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbd6r3n4XyfTOaamAaGOoDD8ieKsY2otUyi5gSLtkTrW0IR+uojXzOrEcUOo6ei8ynzmJpxMSeJtuJpHyQNyp/QGRs5vhNDw/ZVKTGBhdh7rVZMT05d3gqYA3ZlBN94jJ4+3v3BhUvOrw53RyNEFJWfF6btpSZO71kIk3/LUjPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IO32UegB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IO32UegB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771855030; x=1803391030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/MVsSFcFz6u+t0/3QPecpmXWT5CQDGWG3KUz/FKUY3Y=;
  b=IO32UegBxzfG59AJz61yZoOtuZI/bNzzF5diYHiE1bhxl3OdeIaLi0Di
   STn+U24heQcuKyLLk5HY7pH/+TwtNhsLFDJoyDWCcKNqKXbnUuW+rNbya
   2RYkDNOLdEujudLSwPOKOMYvkhIZX0sJEA9p2aeZYXIWE5cEAyaQBkIXG
   nd/5E8Nc66B2PCTg4xRFp7m8y/+KB1trwyawbQ6m96Kcm0ITiVG5Tzuz/
   B4OP3WpgSo2Rzn40Gp8Fct3O6cDMCii2SCo81GnxgmUG3c8r5gc9KLwXl
   EAyYrIVRgqMEi3rp4zR1a/ez7p7J+0qQDfxR5YjYn9l+OTtfYTWFoJiUO
   w==;
X-CSE-ConnectionGUID: aPMXU6zcScavyqbwmdxI7Q==
X-CSE-MsgGUID: npMQCSLRTACF9YILH4TEvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="84301177"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="84301177"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:57:10 -0800
X-CSE-ConnectionGUID: UT5HvjjBQAOE7M/WY78IUQ==
X-CSE-MsgGUID: 2xyPzFXRSmyJl5RikMlxhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="220115111"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:57:07 -0800
Date: Mon, 23 Feb 2026 15:57:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] iio: frequency: admv1014: use dev_err_probe in
 probe path
Message-ID: <aZxcsUme6mom-LKV@smile.fi.intel.com>
References: <20260223131418.55414-1-antoniu.miclaus@analog.com>
 <20260223131418.55414-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223131418.55414-5-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 03:13:55PM +0200, Antoniu Miclaus wrote:
> Replace dev_err() + return with dev_err_probe() in the probe path
> to simplify error handling and to ensure the error code is logged.
> 
> Drop 'SPI' from error messages since the bus type is evident.

Okay, it seems that conversion to use struct dev should not touch messages
that are going to be converted to dev_err_probe().

In that case it won't give an unneeded churn. Now all those lines become
touched twice in the sequential changes.

-- 
With Best Regards,
Andy Shevchenko


