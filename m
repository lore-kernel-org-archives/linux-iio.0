Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A51378D70;
	Sat, 12 Sep 2026 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219602; cv=none; b=OWBBnnnz/cC0ZYTCbu08I/EMFGBNbpdUCEER6s7L3NkCRuL4dOcg1Lmrw9WIxBQlTmahix2uMUIMzb3aGiD2TdMM0f8uvxHSRdcexeuubHtM3MKnuvwhlhqm1YMjFxl1vCPCUAJAbBYYjlSqmAs5b0SDI586HUcyKn3cPrV7LUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219602; c=relaxed/simple;
	bh=yEdHAE+3bcZt2OPIcMdL5pMw6xNfiVpySqNf0KElyvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOKV9s1fH37mdh+RhRAEERa9nkECjdWg+UZnQi7PG5AqvFQh9/cvCDBJgCTarZRgHH08VwZcD9xkTUf7RNxYNewOwM4c2fRXLE8KECJpUBRY+HeF8uY6whqtI05gq4vjDXuKHi3/7Mi1TRv7g+cQ/zW1d9wPWeMlWYeggW+cGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qv2CY92f; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qv2CY92f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789219600; x=1820755600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yEdHAE+3bcZt2OPIcMdL5pMw6xNfiVpySqNf0KElyvE=;
  b=Qv2CY92fdz7Os1b0RS2U27uvgrgkB5tTwbJ+pvd+O2TI0xhTn1bUPsuL
   idXk7zs5N3Aq22ObdQfJTjyokGZr9v4ciz8Pi9Gj5p6bbNtRRtzA8YuUy
   2cZKfSXJC/7DHbvt2o6qF+rIQLNkuJ39Chi8iVJgpFB2/h3ZjfGQgeMPy
   BVGShKWnnTdoI3hO9xaYY39I0TYhJ5SBIl9QFuH8luRgnXwCKzL2SKDg+
   aW+8ETPUFSwfg3w1bSx4chVw7gFYowHFgZRHZ5D59uGKpcEDYV7+7i1MA
   Ft5A3JFee3Q81Zx+0ei7WawIvrmGNsPjrJc0Q9cxDTMLGdDgtU+8XLHgt
   g==;
X-CSE-ConnectionGUID: FS/FGm5aQ3SGmzmJrzM/oA==
X-CSE-MsgGUID: xOIDPAXWRh+9VLNfFEVYBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="107169029"
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="107169029"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:26:39 -0700
X-CSE-ConnectionGUID: GQbgj8vCSRaXeqMUuH5a8g==
X-CSE-MsgGUID: OpbmrgK6TmqgV3aXDm4S7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="422108"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:26:30 -0700
Date: Sat, 12 Sep 2026 16:26:28 +0300
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
Subject: Re: [PATCH 0/3] I3C character device driver using driver_override
Message-ID: <aqVTBIKRP3iRDCvf@ashevche-desk.local>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 02:09:32PM -0700, Meagan Lloyd wrote:
> This is a rework and revival option for Vitor Soares' I3C character
> device driver patch series from 2020 [1] that I've been exploring for a
> few months.  Recently there was a revival posted to the list [2], so I
> wanted to share this design option as well.
> 
> In [1] and [2], the i3cdev driver automatically attaches and detaches
> depending whether another driver has attached/not. In [1], Boris was
> suggesting we explore a more straightforward and traditional binding
> method aligning with the Linux driver model. At the time, there wasn't
> a way to auto-bind while keeping manual binding possible as they shared
> the same match() hook. Now with the new driver_override feature,

Where is it new? It's quite an old mechanism in the driver core...

> the auto-binding of i3cdev on boot can be avoided if the i3cdev driver has
> an empty match ID table. After boot, where specialized drivers would have
> already bound, user-space can explicitly opt-in by setting the
> driver_override sysfs file with 'i3cdev' and manually binding via sysfs
> (or by simply loading the driver if it's loadable). This can also be
> easily automated with udev rules that run whenever the I3C core exposes
> a new device.
> 
> One downside of the automatic attach/de-attach is that if a different
> driver is loaded later, the first driver could have altered something
> on the device, breaking any assumptions of the subsequent driver.
> 
> My series builds on [1] through:
> 0. Addressing code review feedback in [1] from Greg, Boris, and Randy.
> 1. Using actual_len for accurate read response reporting. The kernel
> will report actual_len received from the core to user-space via the
> uapi i3cdev_xfer struct.
> 2. Placing limits on the number of transfers and bytes in requests to
> prevent unlimited-sized transfers or kernel memory allocation
> 3. Checking inputs and descriptive return codes as guard-rails
> for user-space and to ease use of the i3cdev driver
> 4. Checking on MWL to ensure that we respect device limits
> 5. Proper lifetime management of i3cdev_data and underlying device
> 6. Addressing dangling fops in the event we have an open file descriptor
> when a device gets unbound.
> 7. Fast-path locking to ensure transfers complete before a device is
> unbound.
> 8. Allowing only one file descriptor per I3C device to avoid bugs
> around multiple processes interacting with the device and altering
> the device underneath the other. For example, without this, one process
> could change the device's page or address pointer register underneath
> the other process.
> 9. copy_struct_from_user to ensure struct i3cdev_xfer could be extended
> in a compatible way. This is to be forward-looking towards potential
> HDR mode expansion and code reuse.
> 10. Reserving the IOCTL number formally
> 11. Updating the Documentation to be a syntax correct example program
> template.
> 12. Preserving /dev/bus/i3c/<bus id>-<Provisional ID> naming while
> allowing sysfs path to be neatly named i3cdev-<minor>. This avoids
> repeated <bus id>-<Provisional ID> in the sysfs paths which can be
> confusing/circular-looking.
>     e.g. /sys/bus/i3c/devices/0-deadbeef001/i3cdev/0-deadbeef001 ->
>          /sys/bus/i3c/devices/0-deadbeef001/i3cdev/i3cdev-0
> 13. Updating all naming references related to i3c_priv_xfer to align
> with new i3c_xfer struct
> 14. Updating the MAINTAINERS file for the new pieces of code
> 
> Note that i3c-tools [3] or a fork of it will need small updates:
> 1. Update include/uapi/linux/i3c/i3cdev.h to match updated uapi structs
> 2. In i3ctransfer.c, use actual_len for reads

> I've added MODULE_VERSION("1.0.0") in the i3cdev driver, so i3c-tools
> could use that to determine whether to use the old out-of-tree uapi or this one.

Absolutely no. This is legacy macro which has no need since Git era. In Git
the module version is the Git SHA hash of the tip of the used tree. Nobody will
understand what 1.0.0 means and how it maps to the applied patches (if any of
them affects the behaviour of the feature in question).

On top of that, upstream has no clue what and how many possible custom ABIs /
UAPIs exists, and we do not care, to be honest.

> [1] https://lore.kernel.org/linux-i3c/cover.1582069402.git.vitor.soares@synopsys.com/
> [2] https://lore.kernel.org/linux-i3c/ap_1-gFF7S821xJT@ninjato/T/#m9107c1785a4a16b1b3cb84c3269d17fac35819c8
> [3] https://github.com/vitor-soares-snps/i3c-tools

-- 
With Best Regards,
Andy Shevchenko


