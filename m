Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854932652AF;
	Wed, 21 Jan 2026 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999676; cv=none; b=n9vR/gFPMydWEMndI2W5/hhSylGDFGUWYDWMlSU+63QLc3THEmvbP1q71eoIITDDHjugbuxWRFNZ5dSqDUYqYBDJt0vmIEHsM7bYlZKMhTxj3Hpsa5FhiI/uofhZ1MTsgnyyShYsubmFabrb3m+8a32B27dg8WPNfqbsfh4/yBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999676; c=relaxed/simple;
	bh=Rxxx0//u+6PJDfnkMrOzr9ElBNTPAirrPQWV/cpOfzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c81KKu66ASUjj6oCHZtugtV8uDuIh1pNJV1KhVRWawCeSFOIjr5tutZ40AHNJTmg/YGGk4AIs05KYSrPYI+e7ppcz0aq6lzCLmbrbO7fAhTtbxxliqgJW5YTsBepW8I7RETJWe24Y7JLD37YLQ7qdYFZJErcwqCJTLYlVDDgFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjfHs3KB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjfHs3KB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768999674; x=1800535674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rxxx0//u+6PJDfnkMrOzr9ElBNTPAirrPQWV/cpOfzw=;
  b=QjfHs3KB/9jZmwTpqhq7BOK3XsUkfT9sxQ6yTletXB0V/o/kD5702eUR
   fePr+MWbkZzhWlkd242aSsQqCJ0pkz8zxQR3DnbexJnapwirerTEGHppc
   BKdI0hi5KTWqsJwHC6fNvI18e5+0X2QA6Q2QW/OOols2F0OdwSyw9BhVB
   SHyWMRcwB7QdaexBllkeuW6nxsodyXW9VBHzI+0L+UVPxUb459fR07lV8
   TOsr8aLHQklz2uL5DEhzofRQjktf/C3F06hmzSzCqESBi0nZptQuSouQm
   GqNQ5YnaGJir7LJGz4Spk6UBbwlPUGIo8neDnM1xbDsUxe1E/Uhx0Nlaw
   g==;
X-CSE-ConnectionGUID: arw1RLrXTE2jrh7m7Ud7Ww==
X-CSE-MsgGUID: WLRMbXq3QDyWNXY3lvEUww==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="92893471"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="92893471"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 04:47:40 -0800
X-CSE-ConnectionGUID: wCVvv2TyRUuSXp3cts7VFQ==
X-CSE-MsgGUID: yZoxT8q8Q4C0udYbIPLIGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206356183"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 04:47:38 -0800
Date: Wed, 21 Jan 2026 14:47:36 +0200
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
Message-ID: <aXDK6KRIIPjJxfFK@smile.fi.intel.com>
References: <20260121112758.1831077-1-flavra@baylibre.com>
 <20260121112758.1831077-4-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121112758.1831077-4-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 21, 2026 at 12:27:57PM +0100, Francesco Lavra wrote:
> The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> accelerometer invalid samples (i.e. samples that have been acquired during
> the settling time of sensor filters) with the special values 0x7FFFh,
> 0x7FFE, and 0x7FFD.
> The driver checks FIFO samples against these special values in order to
> discard invalid samples; however, it does the check regardless of the type
> of samples being processed, whereas this feature is specific to gyroscope
> and accelerometer data. This could cause valid samples to be discarded.
> Fix the above check so that it takes into account the type of samples being
> processed.

...

>  st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
>  			    u8 *data, s64 ts)
>  {
> -	s16 val = le16_to_cpu(*(__le16 *)data);
>  	struct st_lsm6dsx_sensor *sensor;
>  	struct iio_dev *iio_dev;
>  
>  	/* invalid sample during bootstrap phase */
> -	if (val >= ST_LSM6DSX_INVALID_SAMPLE)
> +	if ((tag == ST_LSM6DSX_GYRO_TAG || tag == ST_LSM6DSX_ACC_TAG) &&
> +	    (s16)le16_to_cpup((__le16 *)data) >= ST_LSM6DSX_INVALID_SAMPLE)

Since data is u8 *, it might appear on unaligned addresses and the proper
conversion here is to use get_unaligned_le16() without any of those ugly
castings.

>  		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


