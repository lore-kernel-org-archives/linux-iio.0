Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C4D41F349;
	Thu, 24 Sep 2026 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287902; cv=none; b=rqIlgKKHjIcx/2lqfZFT+hq3U97oBs1Pnz4hctV5NAOO0pS4nyAkalYRPp5vLfEhi0/PykUXRNylaS6vro+C4fBBRw0HpyaoyD/YYMbk372TJvBddzgsMlJYW9vbiH7T1Jl63njICPJfEvPk/VmFZvWW7/uHQpDLvKABbBdxHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287902; c=relaxed/simple;
	bh=as72uMcCbD4JiFvSQaNcychQmcCTurW5nyfAJ5ediK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwmJK3WIFYkNPo2XVMW2rhUMPy1i4L76MkHjC7kIv+Yyg5P8XbQI6WLUvBz/DHPzpmAxUTeDstROzdoP9DF53U7AQV9x3vfU9c4FcbCv5BvHN4KFsrDnSmAe9Am2ZBI/c2O2DPtYzqpLqspumve2B1QZ1Rrn1Es37aGbftxvvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YW41R6az; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YW41R6az"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id 22BFB20B7167; Thu, 24 Sep 2026 15:10:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22BFB20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790287851;
	bh=r3n8IcDEhgi+VEQtnJMrWd+GOlGZCNoe/fBGoTU0rkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YW41R6azC4xYKKcnEtJJkEiFHG/tmwZMcdKv+DQcnTjv9Dmb4rhgfvVLnrVg80Ei6
	 FAI63I7VWQFSfwHzIfBnWDX/uORWeG8i+fhrArgHwryFLCxjdPMSA3fvpRWp9m9O8g
	 V+6A4YsyE4YnxBIc7Z7Mrkrs0N/JKwrXfUMzdZrE=
Date: Thu, 24 Sep 2026 15:10:51 -0700
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	y@linux.microsoft.com
Cc: Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
	linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
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
	linux@analog.com, linux-iio@vger.kernel.org, andi.shyti@kernel.org
Subject: Re: [PATCH 3/3] i3c: add i3cdev character device module for
 user-space access
Message-ID: <20260924-db82fe4537102d1920dd09bc@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
 <aqVUyYkpKT8iX4Jz@ashevche-desk.local>
 <20260916-454d66ca84cc91479b195aa5@linux.microsoft.com>
 <aqt_dCazxTDR4cpk@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqt_dCazxTDR4cpk@ashevche-desk.local>

On Thu, Sep 17, 2026 at 08:49:40AM +0300, Andy Shevchenko wrote:
> On Wed, Sep 16, 2026 at 03:57:10PM -0700, Meagan Lloyd wrote:
> > On Sat, Sep 12, 2026 at 04:34:01PM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 11, 2026 at 02:09:35PM -0700, Meagan Lloyd wrote:
> > > > The i3cdev driver is a character device driver that allows user-space
> > > > to control and interact with I3C devices.
> > > 
> > > > Currently, it has the ability to perform Single Data Rate (SDR)
> > > > transfers - basic reads/writes.
> > > > 
> > > > With the addition of sysfs driver_override, there is now a
> > > > straightforward and direct way to match the i3cdev driver to any i3c
> > > > device without stepping on the toes of more specialized drivers that are
> > > > loaded automatically.
> > > 
> > > Is it safe? Why on the earth do we need this? The commit message has not enough
> > > information.
> > 
> > I can't see a reason that it'd be unsafe. To give additional confidence,
> > it's already in-use in many bus_types:
> 
> This argument has nothing to do with i³c. Each bus is different on a physical
> layer, electrical protocols and programming flow. Each of them has own
> constraints.

My take is that if you're using the i3cdev module, it's up to the
programmer to review schematics/datasheets to know how to program
the hardware devices and bus (in the case of hubs) correctly.

Note, this thread's driver_override approach was not favored by the i3c
subsystem reviewers, so please continue any further discussion in the
prevailing approach's thread:
https://lore.kernel.org/linux-i3c/20260921230603.2518652-1-samagazaryan@google.com/T/#mb42d9b2785f8508d39eaf782b3d29189226b8029

> 
> > To answer why we need it:
> > If we want to write i3cdev as a standard device driver, it can't
> > actually match anything by default. This is because, some devices on the
> > system may need specific drivers and i3cdev is generic and should
> > technically match every device.
> 
> Yes, but I have seen no reason why we should expose i³c bus to the user
> space. With i²c we already know very well that it was (and still is)
> a bad idea. Why i³c is better (especially taking into account i²c
> compatible mode and more complex programming flow)?
> 

cc'ing Andy Shyti from I2C subsystem for context.

Andy, we're considering an I3C character device driver interface.
If you have any feedback from your experience with I2C, can you
please share it in:
https://lore.kernel.org/linux-i3c/20260921230603.2518652-1-samagazaryan@google.com/T/#mb42d9b2785f8508d39eaf782b3d29189226b8029

> > Since the driver_override is default NULL and is set via sysfs, this
> > allows any specific drivers on boot to be loaded up and would allow
> > explicit control on what device i3cdev gets bound to.
> > 
> > This was my rational. I will refine the commit message with more details.
> 
> Put a real life example why the exposing i³c devices into user space is
> absolutely necessary.

I'm supporting a kernel running on accelerator cards that plug into
various server SKUs where hubs/devices along the bus are not physically
on the card & may differ across SKUs. So, I'm looking to program hubs
flexibly and dynamically from userspace to setup bus hardware paths.

The hub drivers being posted to i3c subsystem require hard-coding in the
devicetree to setup the ports physically according to intended
bus/hardware design. As mentioned, these cards will not know what SKU it
will be plugged into, so the devicetree hard-coding cannot reasonably be
determined ahead of time. Theoretically, you may be able to add some
bootloader support to go query SKU information from other server
components and then populate the devicetree for the kernel, but that
will require heavy lifting and plumbing between other server firmware
components and the bootloader.

Further replies and discussion can be routed here:
https://lore.kernel.org/linux-i3c/20260921230603.2518652-1-samagazaryan@google.com/T/#mb42d9b2785f8508d39eaf782b3d29189226b8029

Thank you,
Meagan
> 
> > > > This is accomplished by the i3cdev driver not having any entries in
> > > > the i3c_device_id table. After boot, simply set the driver_override
> > > > to "i3cdev" and bind the device manually via the sysfs bind knob.
> > > > This can also be automated with udev rules as well.
> > > > 
> > > > The character device interface will be exposed at: /dev/bus/i3c/<bus
> > > > id>-<Provisional ID>
> 
> ...
> 
> > > > +	for (int i = 0; i < metadata->nxfers; i++) {
> > > 
> > > Why is 'i' signed?
> 
> > Mostly for readability and to make sure the line length on loop headers
> > is kept below 80 chars. As a precaution, to make sure that 'i' can
> > represent any metadata->nxfers value without overflow during loops, I
> > check that metadata->nxfers is less than/equal to INT_MAX in
> > get_metadata().
> 
> No need to add useless checks.
> 
> ...
> 
> > > > +/** + * print_i3c_err() - Prints the I3C error encountered during
> > > > the prior + * call to the core's transfer function.  + * @i3cdev:
> > > > i3cdev_data object + * @metadata: Kernel's copy of i3cdev_xfers
> > > > (ioctl I3CDEV_XFER input) + * @i3c_xfers: i3c_xfer array that was
> > > > sent to the I3C core
> > > 
> > > > + * Returns: void
> > > 
> > > Huh?! Where is this coming from?
> > 
> > In i3cdev_ioctl_do_xfers, if i3c_device_do_xfers failed, I wanted to
> > print out the first I3C controller error encountered. The controller
> > drivers can set this in the i3c_xfer.err field. Hence this function.
> > 
> > It's to aid debugging and provide useful error information.
> > I can certainly refine the wording on the print_i3c_err documentation
> > header to make this more clear.
> 
> My point is about kernel-doc. Why do we need the return section for void?
> Where it comes from?
> 
> > > > + */
> 
> ...
> 
> > > Please, rely less on AI and more on the common sense and
> > > proof-reading.
> 
> > I think I gave you the wrong impression. The new contributions in this
> > series were written and developed by me. I used AI for quality assurance
> > and cross-referencing. Since I incorporated some AI-flagged suggestions,
> > I tried to acknowledge that with the Assisted-by tag.
> 
> I see, then there is a room to improve the code. But the main question is
> why do we even need this whole interface to begin with?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
> -- 
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c
