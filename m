Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596213F1671;
	Mon, 11 May 2026 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507193; cv=none; b=SGROX2AepEJL6rzIQFUR9IIYuUPaRGZJKkxstEaoLVZAU+c34DeovWEYv8eCOK5XPmcup/2j3UYRxuBivOUi+bM2Jz8RTrblexQwu59iFYLGXZN6Oay7EzFNkhD6zD/ao2uIP2CY34xh9nAF8qseC8E+5MpXxjWYi2oPItfmPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507193; c=relaxed/simple;
	bh=m9KX0W7Ew9Nmb5bzwLlaT/DHaXId4BiRU6KdgPkV5/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBPnc3TY2n+YaCtcvROV3Y+lcQt//J5jh8PAJZaNst2h0UrG5PrdpHJEUiGijHuktz88sWfRllbfx99+CyH/2344wpObG+eUS9kDGA9shb1RAe8Ifz/+IUy4Sf/bdGi8+zGJfNbG4F/hjoyrU6MBWueAcJ5DsdIwQC1Fr+edK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXZDQRcb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXZDQRcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778507192; x=1810043192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m9KX0W7Ew9Nmb5bzwLlaT/DHaXId4BiRU6KdgPkV5/8=;
  b=dXZDQRcbstFU+l1MJTMI38AVdXCpmYoM80ipLH+3CCv7O0mgX1GBphTW
   iWQ2mVq7j/vwEcEdJYsmCfSuMZJYUjFU6M+reWtTIiW+RV+yop8ISUFf4
   DxAKKhGD6n4DehfF5wog+8cTPpmn7noXGoPTMOhh0uA/jXSd3PA8RSER6
   kNWDzC4jVD8Bp6kNSOtbK9h5NovHm+VwX+UT9CnPvTVE8+0KLKQz/mkPM
   bBI0x05WiHY7vhcuCETMsRKDKhvXzHEJ293TVOzhBnerqwaawr20daoV4
   5slaajliHw2VxFpswHPrX0LH6IdKDjGsaSN8o15GaOUWa1z9zzhV4kHSh
   Q==;
X-CSE-ConnectionGUID: oGvZskF8TfKFbF+DK++fmw==
X-CSE-MsgGUID: 2fMMshnNSc2nT+TzAJfCkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83006626"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83006626"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:46:21 -0700
X-CSE-ConnectionGUID: izLNf2KiTkuXl+4jh0U6+w==
X-CSE-MsgGUID: IF8l6EFgTsidkOzAYCSPvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="231065974"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:46:10 -0700
Date: Mon, 11 May 2026 16:46:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
Message-ID: <agHdnHcKrMSAeeUf@ashevche-desk.local>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
 <CALoEA-wQ_hYsP8iOhHf6yAzpgA-Bq+78bC=BqZdaPcz9bW1Gww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wQ_hYsP8iOhHf6yAzpgA-Bq+78bC=BqZdaPcz9bW1Gww@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 03:33:06PM +0200, Joshua Crofts wrote:
> On Mon, 11 May 2026 at 15:23, Stepan Ionichev <sozdayvek@gmail.com> wrote:

...

> > No functional change.
> 
> I would say that this is a functional change, you are changing
> how resources are managed and how teardown works. (But
> maybe I'm wrong).

Actually yes, this is quite a change that might have some subtle differences.

...

> > -       trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
> > -       if (!trig) {
> > -               ret = -ENOMEM;
> > -               goto error_ret;
> > -       }
> > +       trig = devm_iio_trigger_alloc(&pdev->dev, "irqtrig%d", irq);

Looking at this and taking into account the above, have you checked the
- trigger lifetime versus platform device
- parent-child relationship in the sysfs

The latter might lead to interesting side-effects.

> > +       if (!trig)
> > +               return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


