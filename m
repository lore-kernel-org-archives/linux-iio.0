Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C937A485;
	Tue, 18 Aug 2026 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061974; cv=none; b=gUWZkAT4W3Jt+Zt4LA1zUF3LXss8nNEUrQDZrKEfUknmLUXWaJvAZraANgX8PLUbhtZ+LnHtiQvu7QEU4dlJDdlay2H/jbeuQPswTYQfu5TFajzx7OhdnrwtWz5ixVvvs/szPCaJnrrni36JV15erekeXZh4PHOG6/z9189YFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061974; c=relaxed/simple;
	bh=Uu+fJEP9olq8fpTemdL2Ttf3jXlpHbvyy1j5zPf9e2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl73xYNuLWHPOz/otDf5Nt1J+xmCtK6hFgmiZJNv2vF8qaaiu5GtcTPrEN+3nmb1qFHcpUA5L1nDrYPp0pmMruZXXuuUt9IiX6SHovI/Y1O2/9K6v8KLTp2M+eXn+kOEltWhsW1JAfD1FtRUbJZ9Y7667rLlVTT22NNoC457rs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmcVgacf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmcVgacf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787061973; x=1818597973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uu+fJEP9olq8fpTemdL2Ttf3jXlpHbvyy1j5zPf9e2A=;
  b=AmcVgacfDlDxyAQu0S+0OwXIFFWWDc2DWKs/kBOrwSr1YzrnIfHAj0Iy
   gLX/ib1Ao2KS/xuIe0tK+lXe3hip+cy3CAlbFn5SD1d4bdh4HqePZYupS
   W78zvj6/gKtf30vyN2HaQj2pjAKSYVOB4mLLFEJ3A+igbVthCwk9QNBxp
   F/Kkunf3jZrNUSBkTbOSyf4sXMrc1Mj8GdV9Cdk/RriraOk8sX+7QDYgW
   K0cQUgcrLCm78N3gACSAmUbJwO/lmaSzpSXf25mU35iFb8C2YYdLoNus7
   ZHXNVkx/IHBB6h4sJEbQjkEvY/GCFfPef8jZmwxkAhsI1M993dXUNT2lG
   Q==;
X-CSE-ConnectionGUID: 9P9mOdO1SoiYvLly5196nQ==
X-CSE-MsgGUID: zJR8GrIOQxmF6JYW7K5ldA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87677058"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87677058"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:06:10 -0700
X-CSE-ConnectionGUID: TsSmJN0mS0myplhL//O1AQ==
X-CSE-MsgGUID: 5jhqLaumTiKyiTB05Ku9VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264791962"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:06:07 -0700
Date: Tue, 18 Aug 2026 17:06:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: Fix runtime PM leak on trigger
 errors
Message-ID: <aoRmzF3_wTfyiEfU@ashevche-desk.local>
References: <20260818133046.858005-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818133046.858005-1-ruoyuw560@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 09:30:46PM +0800, Ruoyu Wang wrote:
> The first user of the MPU-3050 data-ready trigger takes a runtime PM
> reference before configuring the FIFO, sample engine and interrupt. If
> any of those operations fails, iio_trigger_attach_poll_func() tears down
> its IRQ resources without calling set_trigger_state(false). The buffer
> error path then releases only its preenable reference, leaving the
> trigger's reference held and preventing runtime suspend.
> 
> Use PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() so a failed resume does
> not leave a usage count behind and later setup failures automatically
> release the acquired reference. Disarm the scoped cleanup after the
> interrupt has been enabled, leaving the disable path to release the
> trigger's reference. Keep hw_irq_trigger clear unless interrupt setup
> succeeds.
> 
> This issue was found by a static analysis checker and confirmed by manual
> source review.

...

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

I'm not sure I suggested the solution as targeted by this patch.

...

> +		retain_and_null_ptr(pm);

Ah, I see, in such a case it might be better to leave the bare runtime PM
calls. Sorry for the suboptimal proposal.

-- 
With Best Regards,
Andy Shevchenko


