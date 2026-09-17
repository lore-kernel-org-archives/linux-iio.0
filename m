Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985B3B14C2;
	Thu, 17 Sep 2026 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624195; cv=none; b=KvL9gzqA2OcDmjieONKbdMqTP0TDFl0QM5SJAvvTzZ8o05RoxWgTbYDXH/udV/0NeHnm19B4QTYcdy+QxCjQ2TxgkIBDoBE60yilnNgmhvYFXvl/Ieb2fBTVnFmF6IUJEQIoOMQQknRTUb2HYOOlwv0lOT5jbAKBo8t4YXDVBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624195; c=relaxed/simple;
	bh=59P7Y18Ydw5mkPxnsBk+xpCbi1DdyDKJjxpEyzjpf20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pcnu80RjFMYLo62VbeRf0VFdBGcVcvWZgdcesF2jh1noSftOd6zXF1KjVvHsUfN6NKEKARzk8mtcc3M3wdQi7ncqbgCTPH28tBXbcgYdV2vj7679uudieiVhNjH49tww4UkTtif7zx1rP2eywCpo0kqWXvMZnn9Y1Z47xQfd+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyv7kBkF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyv7kBkF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789624193; x=1821160193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=59P7Y18Ydw5mkPxnsBk+xpCbi1DdyDKJjxpEyzjpf20=;
  b=gyv7kBkFx7IDS8Oy7HzyWrVPsuSNE4tbi/y6LNmAP/Gv1ZqTdy07WalJ
   thoWfPbfGDM15EoJ/eJdzricZRaThoBUwtan7LkSWqEh+ul80gADDB8HR
   jMm5yjXC+HQZ1OeCl4TsXLUHtDIv/SDYRxvgQjbdJ38tPWbbg1whDFKPO
   /KNJ7opH76D+AH79+ZHjQ2ZQO4rvpdiTfLqur1frPgbZkhFzbJuqCWTiE
   fXFpPUHHkSuDOo26yrREEI5WKJxSw/wmW9Yes9rBO0J5Pl1rmSZCs8uXt
   MTj6hsbiBUwiqVSqkTMCZ5ZpmDPhfRidd2oWCavPIPU8tWuURELZbjARb
   w==;
X-CSE-ConnectionGUID: zNJ+tfp5SgyXCwtaI9fuog==
X-CSE-MsgGUID: JxwppWd0TqmHo1cAgetaIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89876444"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89876444"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 22:49:51 -0700
X-CSE-ConnectionGUID: UtfYpDp6QsWxFvIddu146g==
X-CSE-MsgGUID: nf4LjH4tSUCIbjYEGJPJxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="298668405"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 22:49:42 -0700
Date: Thu, 17 Sep 2026 08:49:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Cc: linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com, samagazaryan@google.com,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@roeck-us.net, Frank.Li@nxp.com,
	jorge.marques@analog.com, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, lorenzo@kernel.org,
	enelsonmoore@gmail.com, rppt@kernel.org, pratyush@kernel.org,
	giovanni.cabiddu@intel.com, gabewhigham@gmail.com,
	haren@linux.ibm.com, pasha.tatashin@soleen.com,
	jirislaby@kernel.org, adrian.ho.yin.ng@altera.com,
	ustc.gu@gmail.com, jszhang@kernel.org, adrian.hunter@intel.com,
	akhilrajeev@nvidia.com, tze.yee.ng@altera.com,
	manikanta.guntupalli@amd.com, shubhrajyoti.datta@amd.com,
	jarkko.nikula@linux.intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] i3c: add i3cdev character device module for
 user-space access
Message-ID: <aqt_dCazxTDR4cpk@ashevche-desk.local>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
 <aqVUyYkpKT8iX4Jz@ashevche-desk.local>
 <20260916-454d66ca84cc91479b195aa5@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916-454d66ca84cc91479b195aa5@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 03:57:10PM -0700, Meagan Lloyd wrote:
> On Sat, Sep 12, 2026 at 04:34:01PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 11, 2026 at 02:09:35PM -0700, Meagan Lloyd wrote:
> > > The i3cdev driver is a character device driver that allows user-space
> > > to control and interact with I3C devices.
> > 
> > > Currently, it has the ability to perform Single Data Rate (SDR)
> > > transfers - basic reads/writes.
> > > 
> > > With the addition of sysfs driver_override, there is now a
> > > straightforward and direct way to match the i3cdev driver to any i3c
> > > device without stepping on the toes of more specialized drivers that are
> > > loaded automatically.
> > 
> > Is it safe? Why on the earth do we need this? The commit message has not enough
> > information.
> 
> I can't see a reason that it'd be unsafe. To give additional confidence,
> it's already in-use in many bus_types:

This argument has nothing to do with i³c. Each bus is different on a physical
layer, electrical protocols and programming flow. Each of them has own
constraints.

> To answer why we need it:
> If we want to write i3cdev as a standard device driver, it can't
> actually match anything by default. This is because, some devices on the
> system may need specific drivers and i3cdev is generic and should
> technically match every device.

Yes, but I have seen no reason why we should expose i³c bus to the user
space. With i²c we already know very well that it was (and still is)
a bad idea. Why i³c is better (especially taking into account i²c
compatible mode and more complex programming flow)?

> Since the driver_override is default NULL and is set via sysfs, this
> allows any specific drivers on boot to be loaded up and would allow
> explicit control on what device i3cdev gets bound to.
> 
> This was my rational. I will refine the commit message with more details.

Put a real life example why the exposing i³c devices into user space is
absolutely necessary.

> > > This is accomplished by the i3cdev driver not having any entries in
> > > the i3c_device_id table. After boot, simply set the driver_override
> > > to "i3cdev" and bind the device manually via the sysfs bind knob.
> > > This can also be automated with udev rules as well.
> > > 
> > > The character device interface will be exposed at: /dev/bus/i3c/<bus
> > > id>-<Provisional ID>

...

> > > +	for (int i = 0; i < metadata->nxfers; i++) {
> > 
> > Why is 'i' signed?

> Mostly for readability and to make sure the line length on loop headers
> is kept below 80 chars. As a precaution, to make sure that 'i' can
> represent any metadata->nxfers value without overflow during loops, I
> check that metadata->nxfers is less than/equal to INT_MAX in
> get_metadata().

No need to add useless checks.

...

> > > +/** + * print_i3c_err() - Prints the I3C error encountered during
> > > the prior + * call to the core's transfer function.  + * @i3cdev:
> > > i3cdev_data object + * @metadata: Kernel's copy of i3cdev_xfers
> > > (ioctl I3CDEV_XFER input) + * @i3c_xfers: i3c_xfer array that was
> > > sent to the I3C core
> > 
> > > + * Returns: void
> > 
> > Huh?! Where is this coming from?
> 
> In i3cdev_ioctl_do_xfers, if i3c_device_do_xfers failed, I wanted to
> print out the first I3C controller error encountered. The controller
> drivers can set this in the i3c_xfer.err field. Hence this function.
> 
> It's to aid debugging and provide useful error information.
> I can certainly refine the wording on the print_i3c_err documentation
> header to make this more clear.

My point is about kernel-doc. Why do we need the return section for void?
Where it comes from?

> > > + */

...

> > Please, rely less on AI and more on the common sense and
> > proof-reading.

> I think I gave you the wrong impression. The new contributions in this
> series were written and developed by me. I used AI for quality assurance
> and cross-referencing. Since I incorporated some AI-flagged suggestions,
> I tried to acknowledge that with the Assisted-by tag.

I see, then there is a room to improve the code. But the main question is
why do we even need this whole interface to begin with?

-- 
With Best Regards,
Andy Shevchenko


