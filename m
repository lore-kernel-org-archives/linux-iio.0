Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96652264C0;
	Sat,  8 Aug 2026 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786221225; cv=none; b=PU0fY2EjgzT4kqBcWpVvVvvnHvOxDv8sFcP+4W62XkX7A+VGpQ5faJc/Ze46c932jKgoLub2K656zN1rCZuTsSdXBDdEG/ssDtJzwYvHufFlQGV2r3hQyuHaXHOJgHEqHitwrGwtviwKbV52IgpGkOGIYDiKUiW1XX+kVfi39UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786221225; c=relaxed/simple;
	bh=XLezFx3+FT1rDp0UafMefWEfdWnzz0g6tNztN1MV+nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQYHKtkfact4VKmnNagFpnf6XC6S/ZS/5/8EkiPCFs9Ms8mXx533uF3/7mBvuTYv9hyhHTb8dBS1OZGyCaJrgTQTnGZjgTpM8IZRaQ2aaAMFIzxJ85zgRWR7mMQMc7pIy5dOim0ks92aNd/G5qH9WpkzuYUYzCqqOnoZ3wCvK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6eK8h23; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6eK8h23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786221224; x=1817757224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XLezFx3+FT1rDp0UafMefWEfdWnzz0g6tNztN1MV+nM=;
  b=f6eK8h23ehuC7mEfvHUpQzllWTbx7YLo0+JLCbY2B4EFsJTYbuoa21ps
   ya/ex5JLKTm+29mOeNvY4Iaon4WBXfxg1RprOPqMT0w5Ru8tUvwiyJtvp
   GnvT6IzBVU56An1plLnJre7RofZLtsdtkaxPYeK3C3+f8Gn8tvKVFq+Vx
   Lt/wX+2Od6niXJGxgrDeT/20j0cq8+ZaAVrxQSAR2ZLOjU9iAlCRye/Dd
   K4SMCuwqbcMmibajf/fhPUsQRlrXN0H14rcC1PjR/8DxA4TZLQ6XdjGMX
   dt0EfaLQ9vzURxbJ0M+8+o3gQWbea4T3BuPP8h7ZsQN2N4VyBM7YjZZT9
   Q==;
X-CSE-ConnectionGUID: eBRqvUrDQOGV3j4qJh5SrQ==
X-CSE-MsgGUID: h3b6OMDtSjGpl/GAujI33Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="86647137"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="86647137"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:33:44 -0700
X-CSE-ConnectionGUID: V/VshTl/QvW9eRzG4HuU1Q==
X-CSE-MsgGUID: P1HDFp8+R7iuCY/mHWVCBA==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:33:41 -0700
Date: Sat, 8 Aug 2026 23:33:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Danil Sirin <danilsirin24@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: mma8452: add ACPI match table
Message-ID: <aneSo9VObeSt3PD_@ashevche-desk.local>
References: <CALoEA-zR7Z75k3uNRD_Swqf7G0+mYmFkPfXTJ5O-mBr6_iu8qA@mail.gmail.com>
 <20260807171326.1137-1-danilsirin24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807171326.1137-1-danilsirin24@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 08:13:25PM +0300, Danil Sirin wrote:
> The mma8452 driver supports obtaining chip-specific data through
> i2c_get_match_data(), but only provides Device Tree and I2C match
> tables.
> 
> On ACPI-based x86 systems, compatible devices such as the MMA8653 are
> enumerated via ACPI, preventing the driver from binding.
> 
> Add an ACPI match table mapping the supported devices to the existing
> chip information structures.
> 
> Tested on a Bay Trail tablet exposing an MMA8653 device via ACPI. With
> this change the driver successfully probes, reads the expected chip ID
> (0x5a), and registers an IIO device.

...


Jonathan beat me up to it, so follow exactly what he said, we do not accept
fake ACPI IDs, they must be properly registered. Yet, for the broken ones in
the wild (device is on market), we need to have a shameful comment and a note
to the vendor of the firmware (BIOS) to explain them that they are wrong.

Also check the MS catalog for the ID if it appears in the Windows drivers.
This information also has to be added to the commit message.

-- 
With Best Regards,
Andy Shevchenko


