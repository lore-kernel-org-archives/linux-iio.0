Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FE446C03;
	Thu, 16 Jul 2026 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225903; cv=none; b=J9ecqImJWTmrEGm5QKFFNL4ZMHOGaaMi3zdDpcDOZvCd01XpaC7QTNbZByG05QdhB/kavourngm2+dGHAOAXv7B3EgmHYl81GljeFxSxBJp2CO25Qovo/a6mFZQ66rtcqGBsmPcmHSsHqiwZCRNi/orfC2bi2tgrCaVgW89OjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225903; c=relaxed/simple;
	bh=ASXHjHLbjaG4HhkZTy5ARP5M0a5OaI9ugzKbquyfTh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0JwGU9Ckw0ArtFNjBXK1xBosd+8JyLWRR4bZ1pchmg6zk+T2WeDxrkH/NAFvvGzVEZD/JqgdJgC/4DUYjx7FCcFVEBl9pMQ8apPgye0wdRArJhch4sN8jMMEKThsJ2+png0hAW32VsS3b4hYMVCgi3L9i6eiK+Yis04Fr8pvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WC/IJEgP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WC/IJEgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784225901; x=1815761901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ASXHjHLbjaG4HhkZTy5ARP5M0a5OaI9ugzKbquyfTh0=;
  b=WC/IJEgPxho2chSnGs3wjKv2z5SPcLrcWqAUb9SH0vFY7tqKq2EUA06W
   53aKxSKDMeLQthaww/5EA6UtKXJaHWWjFvuZTYGorQZC87hLw1Tob4zEV
   Yt1PyWLPI+yIiDibennPfVNymV46V1jf2/nkzMA1D5yyxU3CmEBJ0G3v/
   DVe0jnhLgE1HOXuHgRU3wwyIdSdlMp4aw+RgHARUMfsN1JA28E1ijpMN4
   HaUto/qcALf5PXM9voS5JmaDQM0idmbfk7w6hlGAHAhE0Chjb8BT3G7m7
   ZOC6xI19+1zoXuMiwRoGLVs66QzF8/19LSOPJYVzChGFgI6Unl7HO0Q2X
   A==;
X-CSE-ConnectionGUID: Y31V9GbZSuixOjzWAmh6xw==
X-CSE-MsgGUID: yoi12dRcQjyu5RBJrZb42w==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95498160"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="95498160"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:18:18 -0700
X-CSE-ConnectionGUID: AxXYP0dITHCcLtJD2mnQDQ==
X-CSE-MsgGUID: tOPTf6ULR5mxsL5l5fe1tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="279844539"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:18:15 -0700
Date: Thu, 16 Jul 2026 21:18:13 +0300
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
Message-ID: <alkgZTnHyvEasMCk@ashevche-desk.local>
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
 <20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
 <cA7m1VgJxkr39GAxpnMPw9PVIKX2TR8Ju4Q0m6L2SxS_jJNITfZ6AA5LOeMIK0jGFXaUptY1_vPhDd_imWw5FQ==@protonmail.internalid>
 <aldH3vtk_eKh6oCC@ashevche-desk.local>
 <87ldbco582.fsf@geanix.com>
 <Tu8Mavh-mfl8Vv75Oab3vrghtEbTXiYPZ4qhj6RZv8xe5nWKP4lG1KSuJXEQfyKeio7zv9myLbmifMjFTl8juA==@protonmail.internalid>
 <aleQVYrK9YBoLqGl@ashevche-desk.local>
 <874ii0misv.fsf@geanix.com>
 <alefh86sqW-XvLHl@ashevche-desk.local>
 <J2apVLUJhrI3AOweGpouqGGB0XhxbcqLiWasDpOdm4d2YGgNv8PuE-udUGJZcH0z-V9yyqbjIwMKDdtuam0mp6ya5F6GHUzf6OjRCo0GdaA=@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <J2apVLUJhrI3AOweGpouqGGB0XhxbcqLiWasDpOdm4d2YGgNv8PuE-udUGJZcH0z-V9yyqbjIwMKDdtuam0mp6ya5F6GHUzf6OjRCo0GdaA=@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 04:51:34PM +0000, Esben Haabendal wrote:
> On Wednesday, 15 July 2026 at 16:56, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Jul 15, 2026 at 04:25:20PM +0200, Esben Haabendal wrote:
> > > "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> > > > On Wed, Jul 15, 2026 at 01:35:41PM +0200, Esben Haabendal wrote:
> > > >> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> > > >> > On Wed, Jul 15, 2026 at 10:07:39AM +0200, Esben Haabendal wrote:

...

> > > >> >>  	if (client->irq) {
> > > >> >>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
> > > >> >> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > > >> >> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> > > >> >> +					   data->open_drain ? IRQF_SHARED : 0,
> > > >> >>  					   client->name, indio_dev);
> > > >> >
> > > >> > Why do we care?
> > > >>
> > > >> Care about what exactly?
> > > >
> > > > About exclusivity of the interrupt.
> > >
> > > Ok.
> > >
> > > >> We need to add IRQF_SHARED flag in order to allow shared interrupt, and
> > > >> we should not add it when using (the default) push-pull mode.
> > > >
> > > > Why not? How would it make any difference from SW perspective?
> > >
> > > Not adding the IRQF_SHARED flag prevents use with shared interrupts. I
> > > think we are on the same page on that.
> > >
> > > Unconditional adding IRQF_SHARED flag would allow configurations where
> > > other devices share interrupt line with mma8452 compatible chip
> > > configured with push-pull, resulting in broken or unpredictable results.
> > > I don't see why we should not care about that.
> > 
> > But it's not their problem! If it's this device that prevents this
> > configuration, it should have a check. With this code it just hides
> > and changing a DT property will lead to kernel warning.
> 
> The chip such does not prevent the configuration, and does not prevent
> sharing the interrupt. The irq pin in the device can be configured in either
> push-pull mode or open-drain mode.
> In order to allow sharing interrupt line with other chips, the chip
> must be configured with irq pin in open-drain mode, which is what the
> drive-open-drain device-tree property I am adding in this series enables
> developers to do.
> If/when you add this property to the device-tree, the irq pin will be
> in open-drain mode, and the IRQF_SHARED flag can (and should IMHO) be set
> as the interrupt line can be shared.
> If/when the drive-open-drain property is not set (existing device-trees
> and current only supported behavior), the chip cannot support sharing the
> interrupt line, and adding the IRQF_SHARED flag would be a bug, as the
> chip irq pin requires an exclusive interrupt input.
> 
> Maybe the confusion is caused by the fact that the drive-open-drain
> does not describe how the irq pin IS behaving, but rather how it SHOULD
> behave, and possibly required because of the HW designed having tied the
> irq pin to an irq input together with other irq sources.

Why do we care of push-pull then? Can't we always make it open-drain?

> > > > Yes, I understand the HW case.
> > > >
> > > >> > The (hidden) problem this will have in the future is that the IRQ core
> > > >> > will splat a warning in case that other shared IRQs might be
> > > >> > configured with different flags. Putting that flag conditionally makes
> > > >> > it a mine field for the users. Instead just unconditionally add that
> > > >> > flag and we will get reports as soon as there will be a user that
> > > >> > shares the same interrupt pin with some other devices which drivers do
> > > >> > not use the same settings.
> > > >>
> > > >> If we add the IRQF_SHARED flag unconditionally, it will be set also when
> > > >> push-pull mode is enabled. I don't see how the kernel will be able to
> > > >> notice that that is not going to work. If you have another device that
> > > >> uses IRQF_TRIGGER_LOW|IRF_ONESHOT|IRQF_SHARED, it will not work with the
> > > >> MMA8452 device when configured as push-pull.
> > > >
> > > > Right, and why do we care (again)?
> > >
> > > Why we care that the system as a whole (SW on top of HW) will not work?
> > >
> > > If we don't care about that, why do we even have this IRQF_SHARED flag?
> > > The only purpose of that is to tell the kernel that this particular
> > > device / interrupt will work with shared interrupt or not.
> > >
> > > Isn't that exactly what I do with this change? Nothing more, nothing less.
> > >
> > > > It's pure DT/FW/HW issue, not an SW issue.
> > > > Otherwise it will become a carefully placed mine for the poor user who will
> > > > use these flags and try to share an interrupt with the mma8452 device which
> > > > has no set property and uses push-pull mode.
> > >
> > > I don't get how you see it like that. Adding IRQF_SHARED unconditionally
> > > would create exactly the mine field you are talking about. Poor users
> > > can specify a system configuration (DT) that tries to use a shared
> > > interrupt line, but configures the mma8452 compatible chip in push-pull.
> > > The poor user will not only be poor, but also unhappy.
> > 
> > > By applying the IRQF_SHARED dynamically, the kernel will be able to fail
> > > in a controlled manner instead, making it much less painful to create a
> > > working system configuration (DT)
> > 
> > And my point that we need to make less painful runtime experience.
> 
> Yes. We agree on that.
> 
> But I do believe that my patch is that painful runtime experience.
> 
> Adding IRQF_SHARED flag when irq pin is configured in push-pull mode
> will be painful. I know, that was my initial approach. Does really not
> work, and can lead to wasting time on debugging the HW.
>  
> > > Going back to your poor user story above, if the poor user tries to
> > > share the interrupt pin with the mma8452 device, it will get an error
> > > (just as it is with the kernel today). The device does not support
> > > shared interrupts. Reading the DT bindings documentation, the user
> > > should be able to find the drive-open-drain property, and add that to
> > > the device-tree to make things work. Maybe even consider if that is
> > > compatible with the hardware being used.
> > >
> > > If IRQF_SHARED was set unconditionally, the user would not get an error,
> > > but most likely would get a system where no irq's were raised for the
> > > other chips. I sincerely believe that debugging this is much more
> > > painful than reading device-tree bindings.
> > >
> > > > Did I miss anything?
> > >
> > > I don't know. Maybe I am missing the obvious here.
> > 
> > I consider the case when shared interrupt is enabled on both devices, but
> > second one (driver) missed the same IRQ flags. This becomes a warning in
> > IRQ core.
> 
> Missed which IRQ flags?

_LOW, for instance.

> > Shared interrupts it's also a contract with all stakeholders on keeping
> > the same flags for all devices.
> 
> Of-course.
> 
> And adding IRQF_SHARED is a contract that says that the interrupt can be
> shared. I can only see that it would be a bug to add that flag in cases
> where we know that the interrupt really cannot be shared.
> 
> As for the IRQF_TRIGGER_LOW flag being set, I think that looks correct
> as long as we do not support switching to active high irq polarity.

No, it's not. It overrides whatever platform wants to have. It prevents
PCB level designs from anything else.

> But on that topic, the chip actually supports selecting between active
> low and high irq polarity. Should we implement something along the lines
> of what is done in smi330_setup_irq() in iio/imu/smi330/smi330_core.c?
> And thereby allow using the device with active high irq?

...

> > After looking into genirq code I don't see other way how to handle this.
> > It looks like we need to address the TRIGGER_LOW first, in other words
> > we need drop that flag when IRQF_SHARED is set, and leave it to users
> > to setup IRQ trigger properly on all sides.
> 
> Why do we need to drop the IRQF_TRIGGER_LOW flag because IRQF_SHARED is
> set?
> 
> Users as in those specifying the system device-tree?

No, because like I said, the SHARED is a *contract*, it's not just a setting.
And that contract includes the similarities on the IRQ flags. One may not
have two devices with different trigger level, it's a common sense, right?

So, SHARED must exclude anything that comes from the platform description or
IRQ chip controller (limitations).

So, without addressing that, it makes a little sense to add SHARED.

...

I would accept this patch without adding SHARED, perhaps. But still question
why we can't use the OD instead of PP for the pin to begin with? Do we have
real HW that uses IRQ input without a pull-up?

-- 
With Best Regards,
Andy Shevchenko


