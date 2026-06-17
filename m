Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA513D53C;
	Wed, 17 Jun 2026 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707950; cv=none; b=ap3b66jLVf4Skw4xARnSNvCAB0oM7fskDVU3TDa6kGK7eDe4gOwZkz+x7fvBnt7LNnrY2DwkZ44n5vYQB7d+K6vUaR20Hw/ocqcLkKxAnYg6OccmBmp1l/S+UaoZFSollrxMzYFXFzrwBSW8AC6ddFqFuxhrhg35YyuFHBOiBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707950; c=relaxed/simple;
	bh=eZGIYzmxGiuFNHAxcAGiA59QIAxKK3f5WQxIsVPvN2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3gE/W3/2T7THrcwryXqoK0b5vpbFZR4UGJFwsPEgSDeTXqSTu7csbQKKq3LfHKYjyDYrTjYyfIK1g3im9YphW/JPpXEiGtrw25Icqr3tKVYf+j0QqlWOMYKbUOXyA+OGSG6KFNQiEb+p4X/ImL9x+T9iD6C6VJy8sP6dClQAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1hmhuy5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1hmhuy5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781707949; x=1813243949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eZGIYzmxGiuFNHAxcAGiA59QIAxKK3f5WQxIsVPvN2g=;
  b=W1hmhuy5aDNZcdET7CFzw9PeIGAmbmXXmJfTSLkJbGaU5FPnjthjwMpq
   F9FHmD38ppdoC6fFLVa/H7CrhJEXtFoWAP4TSInfWMXavWAzaLJnvT+2a
   h1ZznVvvcFauASUBPN9KF/pXwO0r8wwbwqRqUJqqp5voOH0E4cLWC+pon
   aF27kYG3Lz/YlkkL9LBkPn5w4VgsX8MGrjQ5Y0XFADdtuGbio2PUX2WVm
   qbhJJWDdQ2iJ9+NgKhrP4tjNQrDZ8345aYTyeQ6X3odvTz5JPs2yn+SVP
   kpWnpyL1RlMqErs3Uxt55LquNIS2OHD/U6cCOIiXz+x65e5nmBjGx4fBp
   Q==;
X-CSE-ConnectionGUID: DFDtsgMFTRSW4QyTn2CS0g==
X-CSE-MsgGUID: oKP/upSyQhaekw28d+7egw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93619984"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93619984"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 07:52:28 -0700
X-CSE-ConnectionGUID: GcGGUseQS9WFLekC5skMOw==
X-CSE-MsgGUID: Rlr9hVpiRpWhaOvU9DDa3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="272158230"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 07:52:24 -0700
Date: Wed, 17 Jun 2026 17:52:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/5] iio: adc: add Versal SysMon driver
Message-ID: <ajK0phP9-pt9njrb@ashevche-desk.local>
References: <20260616131559.3029543-1-salih.erim@amd.com>
 <20260616131559.3029543-3-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616131559.3029543-3-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 02:15:56PM +0100, Salih Erim wrote:
> Add the core driver and MMIO platform driver for the AMD/Xilinx Versal
> System Monitor (SysMon) block.
> 
> The SysMon block resides in the platform management controller (PMC) and
> provides on-chip voltage and temperature monitoring through a 10-bit,
> 200 kSPS ADC. It can monitor up to 160 voltage channels and 64
> temperature satellites distributed across the SoC, with a consistent
> sample rate of 8 kSPS per channel regardless of how many channels are
> enabled.
> 
> The hardware also provides four aggregate temperature registers that
> are always present regardless of the device tree configuration: the
> current max and min across all active satellites, and the peak and
> trough values recorded since the last hardware reset.
> 
> The driver is split into two compilation units:
>   - versal-sysmon-core: Channel parsing, IIO registration, read_raw
>   - versal-sysmon: MMIO platform driver with custom regmap accessors
> 
> Voltage results are stored in a 19-bit modified floating-point format
> and converted to millivolts. Temperature results are stored in Q8.7
> signed fixed-point Celsius format and converted to millicelsius.
> 
> The MMIO regmap backend uses a custom reg_write accessor that
> automatically unlocks the NPI (NoC programming interface) lock
> register before each write, as required by the hardware. The regmap
> is configured with fast_io since the underlying MMIO accessors are
> safe to call from atomic context.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

with a caveat of using namespaced exports (see below).

...

> +EXPORT_SYMBOL_GPL(devm_versal_sysmon_core_probe);

Please, also use symbol namespace.

...

> +static int sysmon_mmio_reg_read(void *context, unsigned int reg,
> +				unsigned int *val)

Make it a single line. It will be more readable.

static int sysmon_mmio_reg_read(void *context, unsigned int reg, unsigned int *val)

...

> +static int sysmon_mmio_reg_write(void *context, unsigned int reg,
> +				 unsigned int val)

In the similar way.

static int sysmon_mmio_reg_write(void *context, unsigned int reg, unsigned int val)

In both cases it's only 83 characters.

-- 
With Best Regards,
Andy Shevchenko


