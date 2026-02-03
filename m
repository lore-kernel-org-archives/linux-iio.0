Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ACC33AD93;
	Tue,  3 Feb 2026 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119113; cv=none; b=lO+IR1gVZFA6XfcKlXdz8KvKUYIvqhMqA04fhsNqFLNePWQjNBBPV3DvtzaZVxBXet+2sXpqOfFQu7gPWhwUyQVxW5fL3mk4HM/bs5hdmcW7gWsSScR6ZOmytl+yPTjyKmW6hlG7BM3Cvypqyhl5nAXrVa9u5oSOUyICsQJUjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119113; c=relaxed/simple;
	bh=h47NV9fKEHXPKnDefLt6vJRzMPn6p4uLXZCMxXsVyk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBFq1LN+5E+XHXXmSMj6SosRvgBukqrtwrJekIH4775dUdW4IwBTPGk4Lrj+TA/ZpMhjOWJHjGZS9o2Bu9yMFPqS4kXfV/UU/6zQJ6aQtq/GCeaUX0EwDzuMlpjUkXT1ZVOIVjkpc1dR8ldnBvahy8HG/V6OPrwKIyjrWpNjkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrEeEBEO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrEeEBEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770119112; x=1801655112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h47NV9fKEHXPKnDefLt6vJRzMPn6p4uLXZCMxXsVyk0=;
  b=TrEeEBEOF+ct+O5APfFD/Hd6HYQjLZ13vU3GjIjZBcsbCtXdAtsIsPfg
   jqqQ1IF+ce51/wdgfSMg9O/2uyCn5i0rqq49ONVfrbknl4aXjRVW2y4a7
   zcwan0LPV8iHkqBCMGlNy/s4JE2GfI7q/br46AJngTeeg8m6Cb1FvexS+
   q1iYsw0uRwNrLrqXriOxozAENCJa2jCAvKIdTNhJvQ8MXHkEcBc+ak1SP
   OCKWtZC6hY05MnGXojHW81cAGvGnd5RZ6vtiXu9AKyBvV8j3XgIHtvnnY
   CeHKx1c9IsjQ3UO8/YHjprvr9hfZ5BnSoVx4u8a854+ir0BYOINjkLwpb
   g==;
X-CSE-ConnectionGUID: J2K8hDb6R2aBuwDRLlztgA==
X-CSE-MsgGUID: c5icmgEHTXONoj/r0WEcgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88862843"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="88862843"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:45:12 -0800
X-CSE-ConnectionGUID: 3KXQzmd8S9SqITl2kEcvlQ==
X-CSE-MsgGUID: c5drkZK0RLuVEwoChyLa+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="213960699"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:45:08 -0800
Date: Tue, 3 Feb 2026 13:45:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 07/13] iio: dac: ds4424: use fsleep() instead of
 usleep_range()
Message-ID: <aYHfwpL_2109UcCq@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-8-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203093434.2548978-8-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:34:27AM +0100, Oleksij Rempel wrote:
> The DS4422/DS4424 and DS4402/DS4404 datasheets do not specify a minimum
> delay between power-up (POR) and the availability of the I2C interface.
> 
> The driver previously used `usleep_range(1000, 1200)` to enforce a ~1ms
> delay. Replace this with `fsleep(1000)` to allow the kernel to select the

> most efficient sleep mechanism (usleep or msleep) while retaining the

Information in the parentheses is not needed and may be confusing in the future
if kernel gets some Xsleep on top of the given list (which by the fact misses
udelay).

> existing conservative delay to ensure device readiness.

There is a couple of nit-picks, otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> +	/*
> +	 * The datasheet does not specify a power-up to I2C ready time.
> +	 * Maintain the existing conservative 1ms delay to ensure the
> +	 * device is ready for communication.
> +	 */
> +	fsleep(1000);

Perhaps use 1 * USEC_PER_MSEC as an argument?


-- 
With Best Regards,
Andy Shevchenko


