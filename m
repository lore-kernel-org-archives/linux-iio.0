Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868174DF4BE;
	Wed, 16 Sep 2026 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599489; cv=none; b=MKKd9eOjThuC6UIkPCkIR2kdctgS5g0o+ayZxwgNlLzVCZ1q4Ot/HBWk+mmXtgBjZyeFKv3KY+ElaeNilcNWzFHouOXi7mSRUehfdiAG3pz4MDQzL+3Wn7u4l/5LwsgqUHYUhQ2r6XZ2Cy5lOi54AnvfAyLDzAw54GPisGzy2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599489; c=relaxed/simple;
	bh=ClCEok3CT57Zb0Uc0FasxIKpEnVdYyzMiUQspae6JfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwBiyr8ZaWfp3OtIAwUUBbKhb7y6xWzQtFmUbAnM+EE7zPHVqRs4dQ39RWKgHisDowlUIDAUesf+UfT2/DavGgjowVRV3tlCGzql38k9Ae1jacc2eF22jACAxazqzMNtCXiIcLfZgvn1tRNAhXqZj6upjc9cYiGAAEybuKSWhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oMNHj13y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oMNHj13y"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id 9622420B7169; Wed, 16 Sep 2026 15:57:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9622420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789599430;
	bh=0N7fIBRWd3/w9pGV5v/O/6SzjQp5f7M7FtwQz2jDFjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMNHj13yMDpsAxbsBEB4TdoxsOJUFK0CMVP4QtiWukYsqHK66WFNNHqJK+rG2msMn
	 vLx2+IIAc+Ilq0yi7/xS8S8rtfuQKpfxLacDgtbk50xmASuuxqjRVSAos+PlqKqXGC
	 lctB/o0//IR8mlYjqgJ2cfkO01n3HITlG17D2DrQ=
Date: Wed, 16 Sep 2026 15:57:10 -0700
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] i3c: add i3cdev character device module for
 user-space access
Message-ID: <20260916-454d66ca84cc91479b195aa5@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
 <aqVUyYkpKT8iX4Jz@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqVUyYkpKT8iX4Jz@ashevche-desk.local>

On Sat, Sep 12, 2026 at 04:34:01PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 11, 2026 at 02:09:35PM -0700, Meagan Lloyd wrote:
> > The i3cdev driver is a character device driver that allows user-space
> > to control and interact with I3C devices.
> 
> > Currently, it has the ability to perform Single Data Rate (SDR)
> > transfers - basic reads/writes.
> > 
> > With the addition of sysfs driver_override, there is now a
> > straightforward and direct way to match the i3cdev driver to any i3c
> > device without stepping on the toes of more specialized drivers that are
> > loaded automatically.
> 
> Is it safe? Why on the earth do we need this? The commit message has not enough
> information.
>

I can't see a reason that it'd be unsafe. To give additional confidence,
it's already in-use in many bus_types:

drivers/platform/wmi/core.c:    .driver_override = true,
drivers/hv/vmbus_drv.c: .driver_override =      true,
drivers/base/platform.c:        .driver_override = true,
drivers/cdx/cdx.c:      .driver_override = true,
drivers/s390/cio/css.c: .driver_override = true,
drivers/vdpa/vdpa.c:    .driver_override = true,
drivers/bus/fsl-mc/fsl-mc-bus.c:        .driver_override = true,
drivers/pci/pci-driver.c:       .driver_override = true,
drivers/rpmsg/rpmsg_core.c:     .driver_override = true,
drivers/amba/bus.c:     .driver_override = true,

To answer why we need it:
If we want to write i3cdev as a standard device driver, it can't
actually match anything by default. This is because, some devices on the
system may need specific drivers and i3cdev is generic and should
technically match every device.

Since the driver_override is default NULL and is set via sysfs, this
allows any specific drivers on boot to be loaded up and would allow
explicit control on what device i3cdev gets bound to.

This was my rational. I will refine the commit message with more details.

> > This is accomplished by the i3cdev driver not having any entries in
> > the i3c_device_id table. After boot, simply set the driver_override
> > to "i3cdev" and bind the device manually via the sysfs bind knob.
> > This can also be automated with udev rules as well.
> > 
> > The character device interface will be exposed at: /dev/bus/i3c/<bus
> > id>-<Provisional ID>
> 
> ...
> 
> > +	struct i3c_xfer xfer = { +		.rnw = I3C_WRITE
> 
> In such cases always leave a trailing comma. It will reduce possible
> churn in the future.
>

Good point, I'll fix that.
 
> > +	};
> 
> ...
> 
> > +	return !ret ? len : ret;
> 
> My gosh, wouldn't Elvis just work naturally?
> 
> 	return ret ?: len;
> 

You're right, that is much nicer!

> ...
> 
> > +	for (int i = 0; i < metadata->nxfers; i++) {
> 
> Why is 'i' signed?
>

Mostly for readability and to make sure the line length on loop headers
is kept below 80 chars. As a precaution, to make sure that 'i' can
represent any metadata->nxfers value without overflow during loops, I
check that metadata->nxfers is less than/equal to INT_MAX in
get_metadata().
 
> > +		ret = copy_struct_from_user(k_uxfer, +
> > sizeof(*k_uxfers), + uxfer, + metadata->xfer_size); + if (ret) +
> > goto out_free_k_uxfers; + +		/* Enforce that padding must be
> > zero */ +		if (memchr_inv(k_uxfer->pad, 0,
> > sizeof(k_uxfer->pad))) { +			ret = -EINVAL; + goto
> > out_free_k_uxfers; +		} + +		uxfer +=
> > metadata->xfer_size; /* u8 pointer so use xfer_size */ + k_uxfer++;
> > /* struct i3cdev_xfer pointer */ + }
> 
> ...
> 
> > +		if (!ret) +			total_bytes +=
> > i3c_xfers[i].len; +		else +			return ret;
> 
> Yeah, you really need to reconsider patterns you use in the code. Here
> 'else' is redundant. Homework to understand how (#easy).
>

Thanks for pointing this out. It would read better if I removed the else
block, opting to bail out early if ret is non-zero.
 
> ...
> 
> > +/** + * print_i3c_err() - Prints the I3C error encountered during
> > the prior + * call to the core's transfer function.  + * @i3cdev:
> > i3cdev_data object + * @metadata: Kernel's copy of i3cdev_xfers
> > (ioctl I3CDEV_XFER input) + * @i3c_xfers: i3c_xfer array that was
> > sent to the I3C core
> 
> > + * Returns: void
> 
> Huh?! Where is this coming from?
> 

In i3cdev_ioctl_do_xfers, if i3c_device_do_xfers failed, I wanted to
print out the first I3C controller error encountered. The controller
drivers can set this in the i3c_xfer.err field. Hence this function.

It's to aid debugging and provide useful error information.
I can certainly refine the wording on the print_i3c_err documentation
header to make this more clear.

> > + */
> 
> ...
> 
> Please, rely less on AI and more on the common sense and
> proof-reading.
> 
> -- With Best Regards, Andy Shevchenko

I think I gave you the wrong impression. The new contributions in this
series were written and developed by me. I used AI for quality assurance
and cross-referencing. Since I incorporated some AI-flagged suggestions,
I tried to acknowledge that with the Assisted-by tag.

Thank you,
Meagan

