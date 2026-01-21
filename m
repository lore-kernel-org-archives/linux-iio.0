Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A71481FD5;
	Wed, 21 Jan 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999867; cv=none; b=VDw2+qb6og1I57X/fv9i73DQB2Re6V19SrYb/jBMgXOhNRXddT9CJ5b+aokQ7Y8bMQtiqdoET3hP4IRSB03BZveF5UfH+UXx6Ux5wNjBr257w7MwwY+69SqCPPVb25TBElvUvx2g1Bvv/sHZFu2ON+j8uQ2Hu7R1OVYFQXWwaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999867; c=relaxed/simple;
	bh=9O7X8QAgdGhKZWef74WRldrXq6PEy1VQGtVWTG7BqjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUPKvFO6Goeduxr7blL9CTjeBeNZTpMHlgXXit3KHAbOu/AbLpohCAz2GCQ1Cj3zj51QibYITG9EYoY8VO54eYpAoyKLuD4jEd6VVqhUya2EgMizlXWgrnu2k2cw1OnBHU+T40PvKZoqgl5e1Ohg6LRc0iYAdTYXcJgwMZ3hceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGP0PNOk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGP0PNOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768999866; x=1800535866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9O7X8QAgdGhKZWef74WRldrXq6PEy1VQGtVWTG7BqjY=;
  b=dGP0PNOkBQUuFR5mPSVNpRV9pQKanQkm1ppCJdau4Jpe6iGKsZghdRfH
   xeeJR1cOje+hEHvk8MqaWO6OfzhugnlG1HO8AMTdKamLBKdmwnlGVCW4m
   IfFQ9SIKt+x9y+Lv6ivLM2DvTTHP15N4qynIIEXMbG9HrBTa7hnh3J0WG
   pa7X0yWFXhy8Zo4A7dOieqICG3m9kTe/MZV6hBp8oIZ1GJ/KejTrsp/Jh
   hY+9VjjCwxsTe/VAW05NsJ9X0mNUiyaciwLovjSBOU0KRjtB7+Z1uSkJn
   tQf1qotNky/ZgtW9k1W7RpTpG3nS/SPXtzqSUTmSR2ENe5yRwSz+5tUmG
   Q==;
X-CSE-ConnectionGUID: FTaIUw4oSUinY0Wzp6wvrQ==
X-CSE-MsgGUID: vYIwEdVGToaK8uhL0W6VSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80942962"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80942962"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 04:51:05 -0800
X-CSE-ConnectionGUID: 02FZMHA6R3O9qfm7iaEtMA==
X-CSE-MsgGUID: YDYl+8ZtSc+QtejoyNmfqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206867148"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 04:51:02 -0800
Date: Wed, 21 Jan 2026 14:51:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix check for invalid samples from
 FIFO
Message-ID: <aXDLtKbJaDHbTaz5@smile.fi.intel.com>
References: <20260121112758.1831077-1-flavra@baylibre.com>
 <20260121112758.1831077-4-flavra@baylibre.com>
 <aXDK6KRIIPjJxfFK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDK6KRIIPjJxfFK@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 21, 2026 at 02:47:40PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 21, 2026 at 12:27:57PM +0100, Francesco Lavra wrote:

...

> >  st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> >  			    u8 *data, s64 ts)
> >  {
> > -	s16 val = le16_to_cpu(*(__le16 *)data);
> >  	struct st_lsm6dsx_sensor *sensor;
> >  	struct iio_dev *iio_dev;
> >  
> >  	/* invalid sample during bootstrap phase */
> > -	if (val >= ST_LSM6DSX_INVALID_SAMPLE)
> > +	if ((tag == ST_LSM6DSX_GYRO_TAG || tag == ST_LSM6DSX_ACC_TAG) &&
> > +	    (s16)le16_to_cpup((__le16 *)data) >= ST_LSM6DSX_INVALID_SAMPLE)
> 
> Since data is u8 *, it might appear on unaligned addresses and the proper
> conversion here is to use get_unaligned_le16() without any of those ugly
> castings.

Okay, (s16) seems needed or another way to allow 0x8000 and higher values.

> >  		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


