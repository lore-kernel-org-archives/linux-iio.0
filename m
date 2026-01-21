Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286353502B6;
	Wed, 21 Jan 2026 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987131; cv=none; b=CmfT6zgXK++zOOCfECrOT7gtEujM4J0Nb1yQozkV8CnM3E08sDeu5MicepOYIwP0+aa7wivh+hhul0G1SDcKkMfNmud4IOwHKLyqgcKyj4KU4OLvD6KQxoHzdSLJtctqYu5Lx6R5wQF0ESCEx0PqR7Uxrchqv0jTpdI9cjX32WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987131; c=relaxed/simple;
	bh=pK3xF14d/sdmpNhyY0OCtNZmYjuPYQkW4SF0otPqzn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIoas+00QWdN8ZYjzowHOfH8cHKq2tQ6WbS8ACQpvAP/O1JqZXr7p6+ShBbrDA+8563FYPpAka0W0+3wpUiz5KZAw5K/AAKoyBNcjyaOcw73LB3toZLtFQG6H8kTaOd2RsLqM2xaDgRchVIYjUNUNdnM4fCxKMEDLkfXMSHJx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oLHYNOhD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oLHYNOhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768987130; x=1800523130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pK3xF14d/sdmpNhyY0OCtNZmYjuPYQkW4SF0otPqzn0=;
  b=oLHYNOhDCczTJ3NQvLEjg+jhtUjoRK5xCJ5NqXKJ9tGBcehlqhFwgwCx
   lxMjuuqwzHymFj3CWc/GIYtE2krC/6/33b/czcATf8AJf9RYVzn0DGLhA
   2WRpl6YL7+CU/5x2LtuP/iii5keOoCJZ0SPBGaKcc4SvBW/EXVmcgZj2X
   dTwfxkyiff3+oEANlZWskxXOikS0PIedEDGtuUW/bxlCEaohe2yMAm9Hf
   X3ew25kZ4A8Nwnb4VxA25Su9X4vu9JnnTNzu649xyrUvH31IK8Px9HgfR
   Gymt6yIODAzPJle36vBDU6Bv0Ol31JdDdtWh5Mz70EyDrPMLNlR8VwuN6
   g==;
X-CSE-ConnectionGUID: We05w/NLT4qDNETQw64sdw==
X-CSE-MsgGUID: m003vc7VTYa9JTc7PvGD6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87788523"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="87788523"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:18:47 -0800
X-CSE-ConnectionGUID: tR5SvLReTtOjI2kxdc+u5Q==
X-CSE-MsgGUID: slwWj9hvSaKWPWKf85lOaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="243967835"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:18:45 -0800
Date: Wed, 21 Jan 2026 11:18:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] iio: proximity: rfd77402: Document device private
 data structure
Message-ID: <aXCZ8gRTsR93A5Kz@smile.fi.intel.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-4-5b944d0605dd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-b4-rfd77402_v5-v6-4-5b944d0605dd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 21, 2026 at 02:05:44AM +0530, Shrikant Raskar via B4 Relay wrote:

> Add kernel-doc style comments for struct rfd77402_data to describe
> the purpose of each member.

Assuming checkpatch.pl doesn't complain (see below why),
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +/**
> + * struct rfd77402_data - device-specific data for the RFD77402 sensor
> + * @client: I2C client handle
> + * @lock: mutex to serialize sensor reads
> + */
>  struct rfd77402_data {
>  	struct i2c_client *client;
> -	/* Serialize reads from the sensor */

Not sure if this can be removed due to some checkpatch checks.
Have you run it to verify?

>  	struct mutex lock;
>  };

-- 
With Best Regards,
Andy Shevchenko


