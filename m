Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE13D75C8;
	Thu,  4 Jun 2026 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555604; cv=none; b=qVNn8E//FXf5nRaOe07U9ImEmg7rB+wUc94ZnaClKm1z+dRk1YLGTPKi06wPQH9VYJkiMb+4wOiTaxjLcpiByfvkD/dbpJRfrWHgRWi3wz/CGJ6fdqJln5ixzz+zvpt3l+X//RoLvGEJT6IRdS+kY6ZQUvrr4Gj7e2ZtdVQFXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555604; c=relaxed/simple;
	bh=Zog3dedIa6BWK3Csra0QhvzSchkw9WlmD8g22cDsU7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYksS9+kgr4I4GayNOEhtAWIJOmvdA7RQGQRKt9t6OTytXhgPCbNSKtTDTIxOfjxULLcXc0jrr2Wg3reMIqjXpLCBXTKtOWkDKfO1w2T2C5jTF2RsL7seOZt7PVK3YhM6/MBxDxACGLJ+k+ad/+f0V0ypI8E9oqeVpTUW33MWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=detRfL2W; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="detRfL2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780555597; x=1812091597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zog3dedIa6BWK3Csra0QhvzSchkw9WlmD8g22cDsU7U=;
  b=detRfL2WJ1JbbagmVVOsvB2UhE2YAPYb7hnxzZngZ1Jm7N4Gk7l/FR1j
   82VaWe8GSmxRCoayU3DYFj/i0depRvWMROue2GpFOjUBnSqEb19FZqjE5
   7gNpTA1ZV0M6k8dzTL+r/3hguYa/Il9pAD5kQcem9E0xGi9TBtTvabsxG
   xV4H15US9fE1w7QbD6F7EuSCTYsuu/iNH4BEXqgRJMLPNIsCm2xciZOrB
   WQou30tcRbryy2cUFX6ehjcxk509A/A9p8IJZij5jb8RGjWi6MqMq5zcp
   PT2JDbtBMjI69il5bQBNuGmdqeZoMSYojtmGBKtgUSE3gU+BglHdgQeQE
   g==;
X-CSE-ConnectionGUID: wCfSi8rUQ1ilWSXOGBg/yA==
X-CSE-MsgGUID: vYmCWpM5QX62xhlqqmnyeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91692036"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91692036"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:46:37 -0700
X-CSE-ConnectionGUID: yUhSNWxzQ6OtRarRF01uwg==
X-CSE-MsgGUID: 9DTEQXKqTCO7mPyiSr9VVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="243389670"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:46:34 -0700
Date: Thu, 4 Jun 2026 09:46:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v5 5/8] iio: light: opt3001: prefer dev_err_probe()
Message-ID: <aiEfRxM1NulIWOQT@ashevche-desk.local>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
 <20260603-opt3001-cleanup-v5-5-3ef7b926d555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-opt3001-cleanup-v5-5-3ef7b926d555@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 07:12:56PM +0200, Joshua Crofts wrote:
> Switch driver to use dev_err_probe() to unify error messages generated
> in *_probe() and probe path functions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

But I just realise that you are doing ping-pong style of changes here.
I just commented on the patch 2 about this. This patch needs to be rebased
on top of the patch 2 with the addressed concerns.

...

>  		ret = request_threaded_irq(irq, NULL, opt3001_irq,
>  					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					   "opt3001", iio);
> -		if (ret) {
> -			dev_err(dev, "failed to request IRQ #%d\n", irq);
> -			return ret;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to request IRQ #%d\n",
> +					     irq);

Most likely this one is also affected, I haven't checked, though.

>  		opt->use_irq = true;

-- 
With Best Regards,
Andy Shevchenko


