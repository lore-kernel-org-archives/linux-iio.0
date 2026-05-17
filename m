Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB235DA77;
	Sun, 17 May 2026 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014348; cv=none; b=ipi041ETRvB255c2VQtUVtjXzTeJLYmHBUt48ieccg63GSy4YYFLSmlq0L3+pYSAOx50dUuGNtvohGVW1mAAUXkJuRz0Y2bufU7Px6+Ccf/z+qZk7z69J9CYastNhTq72RAf1KPjgcqKFB2//WBGpI1ewNVBalD+4JXdfCgML1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014348; c=relaxed/simple;
	bh=dw9+lip63kI2HZWhmsgwxFDH9PKg9Zn3Imd1Y82Eif8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmI9zropQt61u+3rjMrX/sGUPuMdamMgqZUvv4pqTn6JDjbF0JHZQHDuamyZA2+YuFpGCvVEj72WAOFQp69D3KF3PF0bRNLacmHl/rSloqA4nS88gl6l92D3rDXPVfZhhMW9qOoMOz4755laXV9d44NFiPpMcnFVuotC3bBmzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqluFeQx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqluFeQx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779014347; x=1810550347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dw9+lip63kI2HZWhmsgwxFDH9PKg9Zn3Imd1Y82Eif8=;
  b=RqluFeQxpL9cYDqO7+2hKuEq+DM11yEcqMUD7qtBqubUw10y2rF51/k2
   WSN0RmA8JH0snwtwDx0MYQ3xwc+2z40+jM1sYrLReiWL4XyfNZgf1RflU
   EKxjor1T2dpPI7N5b4cVUAWrQFLzUBx4YJ57MoLKOkRxUtdTdxcdwmxd5
   jyDN/9q+vJtXF0JhT0vFs5q9/w/p5gHnTRbiDLydSs3d29B6EKRhUwFyQ
   jg4Atiha+gEPEShaVTpVgPBXv76dpJVpxpA4B/4ugXOnDkR/Udexu5pkn
   snrkoqTPsqnuqlb3W7+9rhIYmFWci8Z5gJjXDSBZVlybVz/QdhTsLlLeH
   g==;
X-CSE-ConnectionGUID: 0M5l6nyySZOQ2S49BDVGnA==
X-CSE-MsgGUID: hWtNsFb4SayaYdG3vz1Oaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="97325834"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="97325834"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:39:07 -0700
X-CSE-ConnectionGUID: zX87yuq3R46rC/vUnI28Zg==
X-CSE-MsgGUID: m/1DbfGMTO+wSU1U54+uVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="238266996"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:39:02 -0700
Date: Sun, 17 May 2026 13:39:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz, kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/12] iio: ssp_sensors: factor out MCU enable/disable
 helpers
Message-ID: <agmaxHxz_JJ3eLAi@ashevche-desk.local>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
 <20260515174017.3962168-5-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515174017.3962168-5-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 11:10:09PM +0530, Sanjay Chitroda wrote:

> Refactor the MCU enable and disable logic into small helper functions.
> This simplifies the control flow and improves readability.
> 
> No functional change intended.

...

> +	if (!data->shut_down)
> +		return;

> +	data->shut_down = false;

Strictly speaking this should go to the end of the function. However for the
proper synchronisation it might need a lock, but I think it's done in the upper
layer and disable/enable pair is never called in parallel.

> +	enable_irq(data->spi->irq);
> +	enable_irq_wake(data->spi->irq);

-- 
With Best Regards,
Andy Shevchenko


