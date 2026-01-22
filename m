Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B835B137;
	Thu, 22 Jan 2026 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097534; cv=none; b=N/1l0u0xlqGY2E4SZ7StkVwE6caV8rEWrVacGHHwtPEjsAu1XU9h0RxtMY9MMTUk0a8yFzqdiVL3KkprVJMgfeAbEa2vFlTmOHvl06eptUhux+1erJCmyRPd/xiHrMhmeN8NJ9KUYQzEc+LnBq34Fn0peY7AmkaeFy/Xy0kjcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097534; c=relaxed/simple;
	bh=kbIdqHPMmgZQRWua+iyeE8vCklaOMmNA3CGbcDRpNBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m431vIsR1YqGvNpqm2CVYux5uZWAz6wvOso2QUr9vcfuhUUxudN+aUER7FWm1oLCizMO2sTvo8QFqqY+R4zWaL+pxNngQ2krWVKTjwewsGOwvhcFheAYQN5RL8WRm+iY1MyISohMGkZf4/HaIHaVBedetQ1y78a35tvxzBOh5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvkE5v0j; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvkE5v0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769097531; x=1800633531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kbIdqHPMmgZQRWua+iyeE8vCklaOMmNA3CGbcDRpNBo=;
  b=NvkE5v0jR3xOvuy9UNtYLZDZXxBEgebXs9aZGGHQwSHx14+TNr/eJHvV
   rGhntkyeDHfGKWemLmZqSra8ARz842jGo+O400RncXSSOTpr6q+DZCZaQ
   wJQb0tfMB9Lv3dLCIzL2kKy336IM5LexpuqEXegvBasVNNTisTPQgNYic
   zAwE9D/qG4L0awFJRz+Rggr/Aemf2NQWkc+3zFwE5oxTzKPhM+piEKLeS
   yQ6zjCrMZLnh4XvNRlgYhho+e4lwa05b/M8cQWFkygjTmitPOvfiD1m8u
   5LKRH4P3ER3S4kjwwD860YDrk6deJRIgpyT/4XdfXprWzaAdzt/+8lXbV
   A==;
X-CSE-ConnectionGUID: wyo2XQhERmGmTQwztnMCxg==
X-CSE-MsgGUID: ijouDTLsRnCT/zu1Fk0jdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81060658"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81060658"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:58:45 -0800
X-CSE-ConnectionGUID: UuU2az1FQc69cd8RpYe8LQ==
X-CSE-MsgGUID: GLX5B3t/QZeHI8NlVNFBFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211220957"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:58:43 -0800
Date: Thu, 22 Jan 2026 17:58:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drivers: iio: mpu3050: use dev_err_probe for
 regulator request
Message-ID: <aXJJMZGeSboC4K8t@smile.fi.intel.com>
References: <20260122153425.8751-1-clamor95@gmail.com>
 <20260122153425.8751-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122153425.8751-2-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 05:34:25PM +0200, Svyatoslav Ryhel wrote:
> Regulator requesting may result in deferred probing error which will
> abort driver probing. To avoid this just use dev_err_probe which handles
> deferred probing.

I believe this deserves a Fixes tag.

Anyway, the rest LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


