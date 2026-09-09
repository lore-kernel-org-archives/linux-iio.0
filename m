Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD793577E4D;
	Wed,  9 Sep 2026 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961091; cv=none; b=LtRseYAlTp047ztORIsJlCPKYk0rTeCdWmFIoks3L3qEjSVGHgtdV1dlwu/IRu4BEyJxvxOh+Ti3I6AKOdbzKHcKNW8DD4bqfifnQAujDt6vZD+m6FBYEqEFiEGpO76q1dV635tdxbhxj2GkO/7H/YDXQ48L/A1AsC3dKeF5wvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961091; c=relaxed/simple;
	bh=cje7Tp7dTEIZwmAY4t+Buvq5Sjp6tsDRjolv/X1Spfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzveUZR7oc1wsZfSs2kjUYg7v5rIP3cJndkezq/HoeEQ+/HOv6Ei63p8SxserxV+dbLlKkV0sttTgI36lZB9Uat6dUGUHWE+sy2kO9L6dfdWbn6W8AHjumwe9UcSalL/sNUmR54zc/5PnMWJYHsNfjhexkJ0g3dD31rQEQg7Scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQxGAPzk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQxGAPzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788961089; x=1820497089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cje7Tp7dTEIZwmAY4t+Buvq5Sjp6tsDRjolv/X1Spfs=;
  b=iQxGAPzkH1Tu5sABu91j0TaGivDiXlz4WnEjOMfEbKnms9hkG0bL7ICW
   DjAzZOm3m2Ajc5192i39YAWOh/w2UYadpicX7/CZqUX/BItCPz5OV0Zgr
   uZDaf9GvTcLOKKEdo0ET0ktp8p0lgJJResGBR8waKpDmGBgVDIe1kBAGo
   1QAEUURY2D/OAz+cV4OOXTsXrzQN5xEl9OOxnn/irJhmdzdaQkgv7rQg7
   By+XSSm9BSIw6fH+VNAo/t/mQwPnxeE3Qr+5WCuPSNPsuZOjHTqjSHxy9
   75T6kpGw42FgIHPx4aUukVUOXTbow69/EcOtUQEx9/PgrsHwFnEdo5qbU
   w==;
X-CSE-ConnectionGUID: uyyAjsRzSn6k9BqTVCTHQA==
X-CSE-MsgGUID: Extxu9plRtGTqLcy0+QYSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106757560"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106757560"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:38:08 -0700
X-CSE-ConnectionGUID: Eo9HGucTRvubijVjCiqSfA==
X-CSE-MsgGUID: FJW1HddcSf+9BTHB4eYFHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="271304411"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:38:05 -0700
Date: Wed, 9 Sep 2026 16:38:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add support for PAC1711
Message-ID: <aqFhO3LCjsZkpNfg@ashevche-desk.local>
References: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
 <20260909-pac1711-v3-2-dff81003b82f@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-pac1711-v3-2-dff81003b82f@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 03:23:35PM +0300, Ariana Lazar wrote:
> This is the iio driver for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitors with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/byteorder/generic.h>

No, it should be asm/byteorder.h...

> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>
> +#include <linux/overflow.h>
> +#include <linux/property.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +#include <linux/workqueue.h>

...somewhere here.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

...

> +#define PAC1711_MAX_RFSH_LIMIT_MS	60000

60 * MSEC_PER_SEC


> +/* 50msec is the timeout for validity of the cached registers */
> +#define PAC1711_MIN_POLLING_TIME_MS	50

> +/*
> + * 1000usec is the minimum wait time for normal conversions when sample

1 ms

> + * rate doesn't change

Missing period at the end.

> + */
> +#define PAC1711_MIN_UPDATE_WAIT_TIME_US	1000

1 * USEC_PER_MSEC

...

> +/* 42000mV */

42 * MILLI

> +#define PAC1711_VOLTAGE_MILLIVOLTS_MAX	42000
> +#define PAC1721_VOLTAGE_MILLIVOLTS_MAX	9000

9 * MILLI

...

> +/* Maximum power-product value - 42 V * 0.1 V */
> +#define PAC1711_PRODUCT_VOLTAGE_PV_FSR	(4200ULL * NANO)
> +#define PAC1721_PRODUCT_VOLTAGE_PV_FSR	(900ULL * NANO)

The comment and the values are not in sync. I'm confused, for example,
by how NANO appears at all there.

...

> +#define PAC1711_DEV_ATTR(name)		(&iio_dev_attr_##name.dev_attr.attr)

Unneeded, please use the values directly, do not hide the rest.

...

> +static const int pac1711_vbus_range_tbl[2][3][2] = {
> +	[PAC1711_VOLTAGE_RANGE_IDX] = {
> +		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, 42000000 },
> +		[PAC1711_FULL_RANGE_BIPOLAR]  = { -42000000, 42000000 },
> +		[PAC1711_HALF_RANGE_BIPOLAR]  = { -21000000, 21000000 },
> +	},
> +	[PAC1721_VOLTAGE_RANGE_IDX] = {
> +		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, 9000000 },
> +		[PAC1711_FULL_RANGE_BIPOLAR]  = { -9000000, 9000000 },
> +		[PAC1711_HALF_RANGE_BIPOLAR]  = { -4500000, 4500000 },
> +	},
> +};
> +
> +static const int pac1711_vsense_range_tbl[3][2] = {
> +	[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, 100000 },
> +	[PAC1711_FULL_RANGE_BIPOLAR] = { -100000, 100000 },
> +	[PAC1711_HALF_RANGE_BIPOLAR] = { -50000, 50000 },
> +};

Perhaps above needs more definitions as I see the similarities with
the existing ones.

...

> +struct reg_data {
> +	s64		vacc;
> +	s64		acc_val;
> +	s64		vpower;
> +	s32		vsense;
> +	s32		vbus;
> +	u32		acc_count;

> +	unsigned long	jiffies_tstamp;

I would put variadic size variables at the bottom as they doesn't sound
like HW related.

> +	u16		ctrl_act_reg;
> +	u16		ctrl_lat_reg;
> +	u8		meas_regs[PAC1711_MEAS_REG_SNAPSHOT_LEN];
> +};

...

> +static inline u64 pac1711_get_unaligned_be56(u8 *p)

const u8 *p

> +{
> +	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
> +		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
> +}

Currently it seems this will be the first user (maybe some more are hiding somewhere)
of this. Nevertheless I would dare to put it directly into include/linux/unaligned.h.
This will eliminate possible duplication in the future.

...

For now I stopped here. Can you split this patch at least to two (introduce a
basic support for some part number(s) followed by the other part numbers to be
added and maybe some optional features?

...

> +static struct i2c_driver pac1711_driver = {
> +	.driver	 = {
> +		.name = "pac1711",
> +		.of_match_table = pac1711_of_match,
> +	},
> +	.probe = pac1711_probe,
> +	.id_table = pac1711_id,
> +};

> +

Unneeded blank line.

> +module_i2c_driver(pac1711_driver);

-- 
With Best Regards,
Andy Shevchenko


