Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B730C602;
	Fri, 23 Jan 2026 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155097; cv=none; b=pkadJFHkiBxN1+PXifkoaGafTIrdE/r/R/8BYtZJO8L5dFbXVFMtebxjv//bb8b/K97nf9gT1/W1GKEloUgjjPkuoGxHW1+qttQE3s8ge8GcnvlGniMti8sDzgFTA3MDTHMxcxkXpMNcWR6n5fanuSj2oa+8a3YEQS8E/BmtZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155097; c=relaxed/simple;
	bh=XFE2jRjeo9x23ItP0ztyTpjWy9V6hV9I2JOlha8PL04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr9GK7+deN9LBCfdzbuJ5mXV/oMNWPu/j48Eb28f6sMcpdt4QdoY62byaF2WYjng3+F/P8zLx4YLkPLm/yux1k+kdzBjV4m2eAatGFpuC9qvheZtUKFvpJRboES59OgQKoQxctA9YZbGaf6qLxjgrU7A0v9gxDgBUfnWUgSAoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SH1O9FE6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SH1O9FE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769155096; x=1800691096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XFE2jRjeo9x23ItP0ztyTpjWy9V6hV9I2JOlha8PL04=;
  b=SH1O9FE6wt1X8HlMhKcU/aLYFjhtAzlMPiQw5QpE4eYOtyOZRYNHP7gp
   KHmZDxkXSEAt+X2Ya/bqdrqyW+2LET7gn7vdqX2/2QiMFFamHk2s1k8Pn
   e8wDohMzshVdX9y8xEJi5vDvxgwfT0Y+BrP/9B490O9n6GB0f2VOBP9JP
   EeyRwlcydnrj51bL4byVvFJ3vjTWukQ9uTLifusrFyugb6MYDWkiL2c9m
   2bX3J+nXfUnICTnGS8Hc6IzhRMSn/DJEW8IlVvB3JAJnoPri2Rqsh6tWU
   sXSfEGRWuvM7DcAaeL9sz/b+1UDVgNMe9pm73kbFMKgd4FJDMRHLGlVin
   w==;
X-CSE-ConnectionGUID: LB72Yi7aRCuWfDEG3I/YdQ==
X-CSE-MsgGUID: HF2tbRf+Q2mdx9MwgBfl3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70457267"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70457267"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:58:15 -0800
X-CSE-ConnectionGUID: hhi594cSSuulAtlaaPO1xw==
X-CSE-MsgGUID: cIKRrZPSS62WAIUyPD+u5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211964806"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:58:13 -0800
Date: Fri, 23 Jan 2026 09:58:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <aXMqEtk8K68sqAyQ@smile.fi.intel.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
 <20260122162335.2020006-4-flavra@baylibre.com>
 <20260122200757.47863f0f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122200757.47863f0f@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 08:07:57PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Jan 2026 17:23:34 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
> 
> > The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> > accelerometer invalid samples (i.e. samples that have been acquired during
> > the settling time of sensor filters) with the special values 0x7FFFh,
> > 0x7FFE, and 0x7FFD.
> > The driver checks FIFO samples against these special values in order to
> > discard invalid samples; however, it does the check regardless of the type
> > of samples being processed, whereas this feature is specific to gyroscope
> > and accelerometer data. This could cause valid samples to be discarded.
> > 
> > Fix the above check so that it takes into account the type of samples being
> > processed. In st_lsm6dsx_push_tagged_data(), change the type of the data
> > parameter to __le16 *, to reflect the fact that this function is called
> > with an aligned data argument and avoid casting to __le16 * when checking
> > sample values.

> I'm going to guess Andy meant all the way up rather than pushing the cast
> upwards.  I think this can be done in a fashion that cleans up the type
> representation in general.

Indeed. This version is not so better than the previous.

...

> > -				st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
> > +				st_lsm6dsx_push_tagged_data(hw, tag,
> > +							    (__le16 *)iio_buff,
> 
> This is ugly but at least it's near the declaration so improvement on previous.
> 
> However, I smell a cleaner solution.  If I read the buffer definition correctly
> it could be replaced with
> 
> struct {
> 	__le16 data[3];
> 	aligned_s64 timestamp;
> } iio_buff = { };
> 
> //note the zeroing because the code never writes the hole which is
> bad...  Also that the { } is guaranteed to fill the hole with the build options
> the kernel uses (there is a selftest for this).
> 
> Which will let you pass iio_buf->data to this call.

Yes, this looks way better and allows to get rid of all assumptions and
castings.

-- 
With Best Regards,
Andy Shevchenko


