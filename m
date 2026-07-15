Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227D39DBDB;
	Wed, 15 Jul 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127376; cv=none; b=rWmsyDmvp8xCd+QrjbLdq5n1cF6z9qSU5WWWMrHtp/7mTgCJlhqT/XNqIb2zSOizC6agyw1os7i18HNn3pgxva2d66CmuPwQgb5akPHKELuTi9OSTzH5hQDDIOpIFTSiUNjh3Pd9G/HLDjG6koezSQbIA4SnCauJAdtdkEXhAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127376; c=relaxed/simple;
	bh=wtM9hjBXVrn0lHA/lpjsrjJuPI6qMGbLQOqkVjedowg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGtD4wdRrEERS8hagb2T6lKTn03nQLAQwck5qGMV1l9mDWCs4oJihl4Dcs8yRmph3rrwJkHTLN3lgsuwhO/C44AIhklCZOSJ9bAOylclSJu86bH83swJoGuPvv6jpfUb6+HozQ5ehx/pkwMvo9Wcy9G30WLoIJcI+aj5p78JSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lh96E/S1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lh96E/S1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784127375; x=1815663375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wtM9hjBXVrn0lHA/lpjsrjJuPI6qMGbLQOqkVjedowg=;
  b=lh96E/S1334rSfrEzEWmo+6ug5n4qIrOa7SwOaySmZZDhBhXetCLRLMz
   O/83ArJmbo8U9HJLmoo6J2DB0D5CfhasTamb413rV8DhIHlPqR5KBhbId
   HpUfRR6YdYIVHdJ/ngttp+X+R7ZnzzDxL3OZyOvESqNktk09LNfZABlk9
   X3Z10i4BXhyqL2SCEcVlx2ydKFyorPE4sGo7pCcw7pWy4fxrbyGt94Brf
   wz2Y1vnRVP5unGOtgrnPGSQkyy72+haQxSyrf09ItfMmJS6fG86OUgwOz
   FErj7TFq9Qubs7RVq/Ib4q75+Rxzw/7y5TR8yBhqr5W0gvZwTf3a8eX5h
   w==;
X-CSE-ConnectionGUID: OVURhvSQRBWdoH+Qs3Wi2w==
X-CSE-MsgGUID: KTv+B7hCQ4+bOEsAxKqjqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88444045"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88444045"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:56:13 -0700
X-CSE-ConnectionGUID: 1plS/O4nRx+CWswgXzo9hg==
X-CSE-MsgGUID: lyR1ovJQRX+vD3oJ+B1ytQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="260510610"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:56:10 -0700
Date: Wed, 15 Jul 2026 17:56:07 +0300
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
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Message-ID: <alefh86sqW-XvLHl@ashevche-desk.local>
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
 <20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
 <cA7m1VgJxkr39GAxpnMPw9PVIKX2TR8Ju4Q0m6L2SxS_jJNITfZ6AA5LOeMIK0jGFXaUptY1_vPhDd_imWw5FQ==@protonmail.internalid>
 <aldH3vtk_eKh6oCC@ashevche-desk.local>
 <87ldbco582.fsf@geanix.com>
 <Tu8Mavh-mfl8Vv75Oab3vrghtEbTXiYPZ4qhj6RZv8xe5nWKP4lG1KSuJXEQfyKeio7zv9myLbmifMjFTl8juA==@protonmail.internalid>
 <aleQVYrK9YBoLqGl@ashevche-desk.local>
 <874ii0misv.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ii0misv.fsf@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 04:25:20PM +0200, Esben Haabendal wrote:
> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> > On Wed, Jul 15, 2026 at 01:35:41PM +0200, Esben Haabendal wrote:
> >> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> >> > On Wed, Jul 15, 2026 at 10:07:39AM +0200, Esben Haabendal wrote:

...

> >> >>  	if (client->irq) {
> >> >>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
> >> >> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> >> >> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> >> >> +					   data->open_drain ? IRQF_SHARED : 0,
> >> >>  					   client->name, indio_dev);
> >> >
> >> > Why do we care?
> >>
> >> Care about what exactly?
> >
> > About exclusivity of the interrupt.
> 
> Ok.
> 
> >> We need to add IRQF_SHARED flag in order to allow shared interrupt, and
> >> we should not add it when using (the default) push-pull mode.
> >
> > Why not? How would it make any difference from SW perspective?
> 
> Not adding the IRQF_SHARED flag prevents use with shared interrupts. I
> think we are on the same page on that.
> 
> Unconditional adding IRQF_SHARED flag would allow configurations where
> other devices share interrupt line with mma8452 compatible chip
> configured with push-pull, resulting in broken or unpredictable results.
> I don't see why we should not care about that.

But it's not their problem! If it's this device that prevents this
configuration, it should have a check. With this code it just hides
and changing a DT property will lead to kernel warning.

> > Yes, I understand the HW case.
> >
> >> > The (hidden) problem this will have in the future is that the IRQ core
> >> > will splat a warning in case that other shared IRQs might be
> >> > configured with different flags. Putting that flag conditionally makes
> >> > it a mine field for the users. Instead just unconditionally add that
> >> > flag and we will get reports as soon as there will be a user that
> >> > shares the same interrupt pin with some other devices which drivers do
> >> > not use the same settings.
> >>
> >> If we add the IRQF_SHARED flag unconditionally, it will be set also when
> >> push-pull mode is enabled. I don't see how the kernel will be able to
> >> notice that that is not going to work. If you have another device that
> >> uses IRQF_TRIGGER_LOW|IRF_ONESHOT|IRQF_SHARED, it will not work with the
> >> MMA8452 device when configured as push-pull.
> >
> > Right, and why do we care (again)?
> 
> Why we care that the system as a whole (SW on top of HW) will not work?
> 
> If we don't care about that, why do we even have this IRQF_SHARED flag?
> The only purpose of that is to tell the kernel that this particular
> device / interrupt will work with shared interrupt or not.
> 
> Isn't that exactly what I do with this change? Nothing more, nothing less.
> 
> > It's pure DT/FW/HW issue, not an SW issue.
> > Otherwise it will become a carefully placed mine for the poor user who will
> > use these flags and try to share an interrupt with the mma8452 device which
> > has no set property and uses push-pull mode.
> 
> I don't get how you see it like that. Adding IRQF_SHARED unconditionally
> would create exactly the mine field you are talking about. Poor users
> can specify a system configuration (DT) that tries to use a shared
> interrupt line, but configures the mma8452 compatible chip in push-pull.
> The poor user will not only be poor, but also unhappy.

> By applying the IRQF_SHARED dynamically, the kernel will be able to fail
> in a controlled manner instead, making it much less painful to create a
> working system configuration (DT)

And my point that we need to make less painful runtime experience.

> Going back to your poor user story above, if the poor user tries to
> share the interrupt pin with the mma8452 device, it will get an error
> (just as it is with the kernel today). The device does not support
> shared interrupts. Reading the DT bindings documentation, the user
> should be able to find the drive-open-drain property, and add that to
> the device-tree to make things work. Maybe even consider if that is
> compatible with the hardware being used.
> 
> If IRQF_SHARED was set unconditionally, the user would not get an error,
> but most likely would get a system where no irq's were raised for the
> other chips. I sincerely believe that debugging this is much more
> painful than reading device-tree bindings.
> 
> > Did I miss anything?
> 
> I don't know. Maybe I am missing the obvious here.

I consider the case when shared interrupt is enabled on both devices, but
second one (driver) missed the same IRQ flags. This becomes a warning in
IRQ core.

Shared interrupts it's also a contract with all stakeholders on keeping
the same flags for all devices.

...

After looking into genirq code I don't see other way how to handle this.
It looks like we need to address the TRIGGER_LOW first, in other words
we need drop that flag when IRQF_SHARED is set, and leave it to users
to setup IRQ trigger properly on all sides.

-- 
With Best Regards,
Andy Shevchenko


