Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45DB32B13E;
	Tue, 18 Aug 2026 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034407; cv=none; b=jmAVjt0ykqtadONTXolYvGO2epx6MJeYyrqmBKibPTMBfUCKbdiDwve0/yAcC0l0GdVTk7F20jPAdX7DDmhBnfFsnodxTpH9tjnSSfPbpD7AYaV4PpgtN290dlP3F061vbSsvAW7G5sOrZHFT2wJQamn+Ex3SpTebxWFHRynwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034407; c=relaxed/simple;
	bh=226CSiqAda9x7CinLY7cmJoxrEfoM932gNgblV9H/ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CflD7SuHxwGWlPKLBbibBrnumZlIVnU3/GiPgWtkSbMsaKF4yS9bpld3m2Jt1bwPYYlOCXpfFv4+oyTuY5hbKfe/uykQuLiAL2Uo0hxlA+r7PdtnlGH91KYhkgUb63TcZaC7pwPq2/UivkdRg2HXDUcQI4tgm6lDN4NIrIm+fQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8V5TMc4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8V5TMc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787034406; x=1818570406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=226CSiqAda9x7CinLY7cmJoxrEfoM932gNgblV9H/ZU=;
  b=Q8V5TMc4/H62wzfGV6ULadZovZP9ccE9LNNFMz44HcSEKeTRkD5wxuuH
   JGF6/OY04I35f3nd4OX/2uXgZwA+d54zza0lKerjsgbiYwkT5+BIUPiNp
   Q4DJYgX6RhsE94mqE/yyToeCR3iwWnUHtraTXaoJToZPYdN7okYuijT0s
   ssbOd3NVKroZIaiprngB2mEDZyI+fyTeRGTIqWrNGyW+Xf3ngkvH3P6ry
   4hfYfhfMgM/AtDWw77rzF0ZOKCkGDD9Msuc/edGhATYCyAJulp08e1jA4
   IFc3HJS6DY9g6o5p9rEEbDcKObgUPFzOMCoTb6EqRwm2Ro30rMdcHkFht
   g==;
X-CSE-ConnectionGUID: zketVhkgTmqCgxQ1CXR19Q==
X-CSE-MsgGUID: 3GpKPeFdQCq3IfrkCi5YFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91197768"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91197768"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:26:45 -0700
X-CSE-ConnectionGUID: NWwlIx9IRU2Q1aBSm+EIqw==
X-CSE-MsgGUID: YC0NV2p/SUWMOjJedI6a3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="260916270"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:26:41 -0700
Date: Tue, 18 Aug 2026 09:26:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio: dac: ad5504: strictly separate ACPI and DT
 probe paths
Message-ID: <aoP7Hr3ahJK87tyP@ashevche-desk.local>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
 <20260817211118.21833-6-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817211118.21833-6-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 05:11:14PM -0400, Taha Ed-Dafili wrote:
> Refactor the ad5504_probe() function to explicitly separate the ACPI
> and Device Tree execution paths. Previously, the driver relied on a
> fragile -ENODEV return value check from the regulator framework to
> bypass the voltage check on ACPI platforms.
> 
> Following modern IIO subsystem design patterns (such as those found in
> adc/ti-ads7950.c), fork the logic using ACPI_COMPANION(). On ACPI
> systems, where dedicated voltage regulators are typically omitted from
> the firmware description, bypass the regulator subsystem entirely and
> initialize the reference voltage to the hardware default 60V scale via
> a new macro AD5504_VA_MV_ACPI_DEFAULT.
> 
> For Device Tree platforms, treat the VCC regulator as mandatory and
> wrap the allocation in dev_err_probe() to cleanly handle potential
> deferrals and error propagation.

...

> +/*
> + * In case of ACPI, we use the 60 V as default voltage reference.
> + */
> +#define AD5504_VA_MV_ACPI_DEFAULT	(60 * MILLI)

Name it

#define AD5504_VA_ACPI_DEFAULT_mV	(60 * MILLI)

What does VA stand for?

...

> +	if (ACPI_COMPANION(dev)) {

It's better to use has_acpi_companion() or is_acpi_device_node().
I prefer to see the latter as that one unifies the style of checking
across the drivers and subsystems.

For that you will need to use dev_fwnode() from property.h and acpi.h
for the macro itself.

> +		st->vref_mv = AD5504_VA_MV_ACPI_DEFAULT;

...

> -	st->vref_mv = ret / 1000;
> +		st->vref_mv = ret / MILLI;

This should be  (MICRO / MILLI) instead of MILLI.

-- 
With Best Regards,
Andy Shevchenko


