Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB655344044;
	Fri, 17 Jul 2026 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311803; cv=none; b=pD/FTb8YLtCkcZo7EiTQTokFdSUYRSv5Mvix+VDuvqrB1DOPwUe0mTv7fKu/bKDAjl8jstMsrlWAR+5TTZHs3HH36iwYA+d2lk9GSajZlk5LGJauUVh6ARKD0a3jkGmbV0PlyvtTTIcUzr17Z9F/JiipoYb894v7fKXFpMtFjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311803; c=relaxed/simple;
	bh=SIkNe2VoDIMYydSotihO3ya17IET6rA23vsy2BTnTsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX85HxaE2/nYAUtJaIgRtbBrD6AevfbK6P3X/UJykvKg8gA7qnwlK759V2iApCID34XjDvyqM4D1qFmoemE3qLCRZKIrrpew3PJfgLRQyy730vDymYXURKjgMmyttviH0iAMx9S6aE1dONhmYJwM6hcx5VXXUaIkWZBYVp3fP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGQ0fDO+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGQ0fDO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784311801; x=1815847801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SIkNe2VoDIMYydSotihO3ya17IET6rA23vsy2BTnTsE=;
  b=ZGQ0fDO+GDjwBcV0Hm+smQ3yHI+y233YPQ2asyRRmssW5Suftj4vEoo8
   kqH5PDj7VLxBDHau+8K4eXcUUJTx/THstXcK9pBw3KvN2dMTU7Al4C5e3
   RHwOtenRNSXPTn1jrEogKk3v6/ixaSrOD7nV29X055h1wuDr3zQ6SRPtU
   VLq7vdYcnhkNhI3LwGifYg8QKZEka3fBwGO1hb6Fl3y1hrSjNNANFIX8R
   mE2ZsV6Gy0O78mTigGT8qzzT1o0jhJ1xk4UsEGRUdgEBvem62uJCl23qb
   0ZplzVnLsXrRU9bTnDOxYjmK5ofvvFXJRr8OpPw3jgRc4zs8zDI1d0Qx+
   g==;
X-CSE-ConnectionGUID: ImgTenESRdORk32sbSsY8Q==
X-CSE-MsgGUID: z+KeioVgT1uR6tlHCP19oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="88665233"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88665233"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:10:02 -0700
X-CSE-ConnectionGUID: TbpizYBdSsm/W586b3aLhw==
X-CSE-MsgGUID: W4P2RYFbSOm0+ZUYR9gTQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="258852307"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:09:57 -0700
Date: Fri, 17 Jul 2026 21:09:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: invensense: improve period measurement by using
 a longer delay
Message-ID: <alpv8rAJk65aW7h4@ashevche-desk.local>
References: <20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com>
 <20260717-iio-common-inv-sensors-timestamp-rework-v1-2-d1afee2805cd@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-iio-common-inv-sensors-timestamp-rework-v1-2-d1afee2805cd@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 02:39:41PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Period measurement can be difficult when using high sampling
> frequency where the jitter criteria is hard to meet because of the
> system jitter.
> 
> This new version is using the delta time between 2 distant interrupts
> to measure an interval of at least 20ms. 20ms is a good compromise
> between the mitigation of system jitter and the delay to update
> period. This way we decorrelate the period measurement from the
> interrupt timestamps syncing using only the 2 last interrupts.

...

>  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
>  				     size_t sample_nb, int64_t timestamp)
>  {
> +	const int64_t delta_threshold =
> +			INV_SENSORS_TIMESTAMP_MIN(INV_SENSORS_MIN_IT_DELTA,
> +						  ts->chip.jitter);

This is less readable than the split version.

	const s64 delta_threshold;

Also, what const gives us here?

>  	struct inv_sensors_timestamp_interval *it;
>  	int64_t delta, interval;
>  	uint32_t period;
> -	bool valid = false;
> +	bool valid;

	delta_threshold =
		INV_SENSORS_TIMESTAMP_MIN(INV_SENSORS_MIN_IT_DELTA, ts->chip.jitter);

(yes, I would go for a bit longer line).


>  	if (sample_nb == 0)
>  		return;

And why to assign it if we have to return, for example here?
Move the assignment closer to its first user.

-- 
With Best Regards,
Andy Shevchenko


