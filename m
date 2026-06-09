Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDC3D0924;
	Tue,  9 Jun 2026 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985703; cv=none; b=P/SYkybShUDOP2b5JNQxj6G7nCWDOnibVaBEan6u+W4MOvsUWvBwYOyzAyTE8797at0Gkj+XYMoFX/KJaY8n2nzJenOpEQuBLS8B0ac0+PIBsx4WE9+kRWKxqf8UqRE5gCz6+pVsgW25jLgDC5fK9oV3lHz/fCmsVskJmXEE6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985703; c=relaxed/simple;
	bh=mBw3x1rmLKdLTuCYj8Mzn+7+fTd7wGHVTTsANJ/R48o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+PoIzNcEZGL2QNsSd9KGVrTHOwV7uBpakCO8FmkyNiRns8mgDaswzqfb/ynJNlqm5T90RL1dJE7Ba9g/Vi2OHVKDC15qt4JlnePnXW0m7X4K/RRJvj0vCzKYYFHufbZnxV+R+v989k+OaruZAIgD47QlO6K97IgA4+p2YQq1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyvITbge; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyvITbge"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780985702; x=1812521702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mBw3x1rmLKdLTuCYj8Mzn+7+fTd7wGHVTTsANJ/R48o=;
  b=HyvITbgecvTWksBkF9DV+Hof42qG6i/Fn2E1Ecx6f+LSfQzrtMIUMnDD
   57oVZeSO7p2lb+XFExicA1HzBs0SrQcNH2e0MPH9eDbytT/Yw1S5/7tp+
   np/mCeX6/yMdb+3kWFUssUb7hln9uv81Ls8usYBIP+tvQyoCnCfyPzkUn
   QXAxL/M4JiRJx2pbo6HmqAwIalxrbioSlI2at60gA83kgjByyIQFHkaYc
   j81VxenybTy6KZ6zcLnWvIPaBF/sN5/0Xrb5HHx5UKm0DvIDkZVbQyftn
   DzB9zQDQM26WqJTsDVX1rMUH5FnV56L3dU9iWJdjwANbDlQZwBBCXRDVJ
   Q==;
X-CSE-ConnectionGUID: lgxY3Ib+T1uSBZhe/HduPg==
X-CSE-MsgGUID: aXrJDKh2RkKiVRdv9xo0Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85361587"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="85361587"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:15:01 -0700
X-CSE-ConnectionGUID: W21b98FaRayUTfkU5dgBUQ==
X-CSE-MsgGUID: KT2aeC+PSeOlt2z50d9m4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="247637748"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:14:59 -0700
Date: Tue, 9 Jun 2026 09:14:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: bm1390: replace short msleeps with
 fsleep
Message-ID: <aievYfVvpJGCfTEz@ashevche-desk.local>
References: <20260609005710.85842-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609005710.85842-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 12:57:10AM +0000, Hungyu Lin wrote:
> Replace msleep(1) with fsleep(1000) for the driver's short
> delays.
> 
> The BM1390 datasheet specifies a 1 ms reset cancel wait time
> (tSC1) during the power-on sequence. Use fsleep() for these
> short delays because it automatically selects the most
> appropriate sleep mechanism and provides standardized timing
> slack.

Same comment as per v1.

...

> -	msleep(1);
> +	fsleep(1000);

And in case you really still want to do this, use multipliers

	fsleep(1 * USEC_PER_MSEC);

(but this might require time.h to be included).

-- 
With Best Regards,
Andy Shevchenko


