Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE8443ABB;
	Mon, 10 Aug 2026 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391453; cv=none; b=XpSKCnscdJ1SetYreZgb/CdYk4geGfIaEa9CPIVrY1r1uLQZ3K3qbKRpGPNJHDx2HwAJJ4sPBO6xjS1c+dmRTJftoD6WHOcB4fFDwzUHoeW3LgnMk9i1LkKsE4ocZMKqm+uyVk38WYVkrXvKwHkKWVdNhHWG05cJGlK9kw8Slbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391453; c=relaxed/simple;
	bh=1kenTjDy5/jiB+NIlZULl23MF0NGyxOmFJCC0xfxefk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBgwJWY4c502s+DGAwrOPtG6/mVgQeuVZZiWV6CYNe2tBUmT6D04J2kTX3b6W/n1Mq3+smxkAoWL3zymCu75N6m5dg++o+WOSacVk+5Dwc5uVYdmxrFHvqJaprcXf2YnHhugashE7q/0B+OVnymNmkuG0WMln3tqvMtxUaMmcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHGLsd1N; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHGLsd1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786391452; x=1817927452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1kenTjDy5/jiB+NIlZULl23MF0NGyxOmFJCC0xfxefk=;
  b=KHGLsd1NTLln2HzEfswO/Tmvzcd81bNPl620PP2fzMZ5IMdfWPbe35uN
   yydVxh0RLPIon61oDLR9H0BSPEKhGNb04jTXye+Kj4HylAXJ2XVjxidA6
   tVubOgV/N0Ei4tZm+//tgHL9AlTiTVj8aPeTeeo2QXtf/KRtuT5QdCKYZ
   z1ERMQFnOzumSV+jmr9fkczV/fnAacyczlbdCs21TmeMynLiwvpX26oh7
   0MV4vkY88i4DT5t9FnZ2BkchT6Z5N+Fd1yW7dYoLWhTYAfrRNoRjxVK+6
   tTxp698jI1XL3zJKJItEL4lcLFMKCR3SCtXWkZokSDMhlAfoT9xTt+JN8
   A==;
X-CSE-ConnectionGUID: 89zxX84dRvmkrJrkkJUEaA==
X-CSE-MsgGUID: /cBx0jcgT0atjtxAJE2dRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86771287"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86771287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:50:51 -0700
X-CSE-ConnectionGUID: bfcsQ8CKQuG69hK0zSOsBQ==
X-CSE-MsgGUID: siChVGPPQtWkSfWg0Uh7Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="260526625"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:50:47 -0700
Date: Mon, 10 Aug 2026 22:50:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: accel: mma8452: Only apply trigger type when
 not set by firmware
Message-ID: <anorldy1yxtBMygX@ashevche-desk.local>
References: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
 <20260805-mma8452-open-drain-v3-3-6149f406a409@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-mma8452-open-drain-v3-3-6149f406a409@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 05, 2026 at 09:21:37AM +0200, Esben Haabendal wrote:
> Instead of unconditionally overriding the trigger type, it is better to
> only apply a default when no trigger type is set by firmware. This should
> be reasonably backward compatible, and should only potentially cause
> problems if systems exist where firmware specifies an incorrect trigger
> type. With a bit of luck, there are no such systems.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  	if (client->irq) {
> +		unsigned long irq_flags;
> +
> +		irq_flags = irq_get_trigger_type(client->irq);
> +		if (irq_flags == IRQ_TYPE_NONE)
> +			irq_flags = IRQF_TRIGGER_LOW;

I would even add info message or so that FW lacks of the proper IRQ type.
But it's up to you, most of the code that I saw and does something similar
does not print anything in this case.

> +		irq_flags |= IRQF_ONESHOT;
>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> -					   client->name, indio_dev);
> +					   irq_flags, client->name, indio_dev);

-- 
With Best Regards,
Andy Shevchenko


