Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1F37C0E2;
	Fri, 17 Jul 2026 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311614; cv=none; b=OsAu8Q0iMZ2Jy9h51VwIMnu168pSdm2aLC0+CldIk47zwq1rR/KBXrbZaEp9raFB11AhWiPMRSu+lzy9lBNQsVfBVY50jHojNQoneRgCJIfs9CIv3v5T8APEC5+/ElvkiJaeAAZNkEEpgYpaIr+LPJax4gzQSZVHxyWokbNzL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311614; c=relaxed/simple;
	bh=O7PToZh3LjUqPL2wfCeTk8L4N6xG4rUmZcCNL/H5ieo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJaSqAxbk7bL2rw38wnzUhlEK5raxnHXCadYwgxU7tkjLi3NXcP/ZX2XW/15st5mFUxWpS2Z/VnsnFQ1+Bpxma8x5M/vltTXVuJKKuWjFvg6v1hQmIxsOt9ypbmCiLL7dgTuI/LPbEgnG/bewzcRz6Uf3TUetmAiQ3JOqHYYC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icV4Cvh/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icV4Cvh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784311612; x=1815847612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O7PToZh3LjUqPL2wfCeTk8L4N6xG4rUmZcCNL/H5ieo=;
  b=icV4Cvh/AcDmDVESgU1Xkd0V0X7rGfjjl0Atw7WdrEbbzqTozEBwoyMs
   PvN4hwozUY8kAurmK3T1aHO86YeARCyptyrqF152blJ+ChwapeIexFAB+
   fZ2oAGunJeTQ7hURAlxIoIE6hmm09ndKFqOVnCd+kz6cR3mOJUVp5BAhk
   kvPkJdAV3gyE7k9nXx2vQ0V/DthvXIkPJnXXJOFC1zZtujsKWXc5SSTeG
   oWWib2aMC8XsWGT+ORHQkJZsclcS94iG2FUmDy+aWoEcTCgLYNeFBULhH
   hKnpX6Jxcw0DWuZv024XttYqMxyXGKec/BmgYFYJ3YBui5uGrGTWzdMZS
   Q==;
X-CSE-ConnectionGUID: UfOXlOU5Sr+Hh5ed1HS0gg==
X-CSE-MsgGUID: BjNU3GHLTKGFKq+ccGelrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85080680"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85080680"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:06:52 -0700
X-CSE-ConnectionGUID: xp3jWjeGR4SwlFcvQEKVKw==
X-CSE-MsgGUID: VLfFiNmGRP+eTYtlLtQzfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="257481560"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:06:49 -0700
Date: Fri, 17 Jul 2026 21:06:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: invensense: better timestamp alignment when
 using watermark
Message-ID: <alpvNm6GHF6y_-oR@ashevche-desk.local>
References: <20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com>
 <20260717-iio-common-inv-sensors-timestamp-rework-v1-1-d1afee2805cd@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-iio-common-inv-sensors-timestamp-rework-v1-1-d1afee2805cd@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 02:39:40PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Current interrupt timestamp alignment only change the next coming
> timestamp. For watermark where we have a batch of samples per
> interrupt, it doesn't manage to align timestamp since modification
> is limited because of jitter.
> 
> Implement a better version that instead modify the period to align
> to interrupt timestamp. Period is now computed by align timestamp
> if interrupt interval is valid, or we use the computed estimation.

...

> -/* compute jitter, min and max following jitter in per mille */
> -#define INV_SENSORS_TIMESTAMP_JITTER(_val, _jitter)		\
> -	(div_s64((_val) * (_jitter), 1000))
> +/* compute min and max following jitter in per mille */
>  #define INV_SENSORS_TIMESTAMP_MIN(_val, _jitter)		\
>  	(((_val) * (1000 - (_jitter))) / 1000)

Side note: Just noticed "per mille" for which we now have a constant defined
in units.h :-)

...

> -static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
> +static uint32_t inv_align_timestamp_it(struct inv_sensors_timestamp *ts,

Please, use kernel types. u32 here. I think we used to have such a discussion
a year or couple of years ago and become to an agreement that at some point
the types should be changed in the driver before accepting any new changes
to it.

> +				       unsigned int sample_nb)

...

>  	/* if interrupt interval is valid, sync with interrupt timestamp */
> -	if (valid)

Leave this line as is, just add assignment and 'else' branch.

> -		inv_align_timestamp_it(ts);
> +	ts->period = valid ? inv_align_timestamp_it(ts, sample_nb) :
> +			     ts->mult * ts->chip_period.val;
>  }

-- 
With Best Regards,
Andy Shevchenko


