Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA81AF4E9;
	Sat,  6 Jun 2026 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780725506; cv=none; b=N4ardULZehdN/E9HzVNcUZfZWBoSFQGqCFYt7QXgd5YeTl+oOgm1OgRKf8xcrQE3edOe3nTnFARGJpr99Rqv5Fv7VtGkQQYjc/KCEBakg11TOdKmDitSyzilGwnHMynd/26cdgpUvbEHAnBbjuNpVSmldCmlV/9FWMvKSdJkStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780725506; c=relaxed/simple;
	bh=PZtVgJKiWyu6TqEjIvzIsAb3rFT8VjYAPB3iRvAorsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB42okp0bM5akTIaPXzkmaJbUeu47yVhaXXvSk5bckGGmuCBjJuX+JES8cIlZAZjh+v/TPyPI+r3fQqOSXYLP6zLSORBQ24AImQ+IfpEvVVnn4AT5oVJ+4EgCmIXmjR4r5FyfVnP/uhWcHzmZiP7lLoTFNqpLKd8Vgxch/BMPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9BKyzNx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9BKyzNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780725505; x=1812261505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PZtVgJKiWyu6TqEjIvzIsAb3rFT8VjYAPB3iRvAorsA=;
  b=L9BKyzNxyYu6GO4WVtWvh1UWqyDxvN3FxKasUtqxTUEjktserlFqiI8p
   VOyDBc2bRCwxaE0CmWz3ecMMnQCHJsBq8xhFl7NF7G5uabwZu+BXj5WAz
   dLY3+BtVkauUIczh3Ir5t9d95Mw+mLqvzGaHDpuY40QpiSzv4Y8qF/8Jm
   jm8t16OLNMZugvIEmWZgZ2S3HjxBvCaj3d9sjGBL5sItYUt7t1aSfYn4V
   cs8TaxOHyvuRbJXUXbX//gWLaRbn2Yfh5q0+v+9rq9wWwTxVy+Qf0Nfqu
   GfnqrUl7zugx713rlfeRsJSO4+Gx+Oqv4/KkbmsRN1mLVkD1//fRLunN1
   w==;
X-CSE-ConnectionGUID: bQOgLTSbSv2LewiUTs3XFA==
X-CSE-MsgGUID: I7/f6DpCR1qp9B5WYAVhfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="91865962"
X-IronPort-AV: E=Sophos;i="6.24,190,1774335600"; 
   d="scan'208";a="91865962"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 22:58:25 -0700
X-CSE-ConnectionGUID: kG6al3TRRZq/JVvR7Axi1g==
X-CSE-MsgGUID: ResRESnoQOmxaiGD21gfgQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 22:58:23 -0700
Date: Sat, 6 Jun 2026 08:58:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
Message-ID: <aiO2_ATPNmjpQErV@ashevche-desk.local>
References: <20260606004203.158853-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606004203.158853-2-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 07:42:04PM -0500, Maxwell Doose wrote:
> The current code uses mutex_init() instead of devm_mutex_init(), which
> is incorrect as the rest of the file uses the devm automatic resource
> management API. Fix this so that the mutex is set up in the same way as
> the rest of the device data structure.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
>  	state->command = command;

+ blank line here.

> -	mutex_init(&state->lock);
> +	ret = devm_mutex_init(dev, &state->lock);
> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


