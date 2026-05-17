Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5C2C027B;
	Sun, 17 May 2026 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778998904; cv=none; b=C8BX3Q44no8b+jaKm/VgPpVMT80CS5pYyudJtzJypVKIPbWCvzfQ/ZxGutudCvcG3Kwr8cmZaYga+CyXIWfZR57q9azmVXi+t/VRlYpbFRcal+Qs4mYn3KuboHdH2GUDinWcyEc+EVIlkFxnQy2nLxMkGxS3wlN7y0UMn/k3XmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778998904; c=relaxed/simple;
	bh=MFs0X5T5l/V3f7Mn14jCCW8eUJvUjiqMcQSUrk2+98w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ3rhmv/NMGMe1rbyyJumVYjvzmkGqlkVZQ7URJKmBieSdrJZO4wtipFhSVaYzorYX+MfccwHnnO0s1ezIf10oJ0M4YM25ynxDwsQykkzPrxS0vxJ8AiWX+c6HuiycO8mVFOD00OoM8vvKKOWfKzOJkdIhKQME0+BEUuvORu6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtFkhMTy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtFkhMTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778998903; x=1810534903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MFs0X5T5l/V3f7Mn14jCCW8eUJvUjiqMcQSUrk2+98w=;
  b=GtFkhMTyB1+mn+GRMe3Y29u0Q7slAL0GbWHBtXCND+7PicjjjifQRPg+
   99mu6SlKmei1h09iBGwlebTf0NJH0wa9yIL1hQMOWKeWFHGkks6T4QJ7x
   QSsw/7dnIsYEOD3CQGnHUbAuAx8bgsdALkrWZbpQ6aQBd3Ta61e2ZLUaJ
   TcbMs8O8ja2cU7FJxqVuOsvZQzLmErozKOne53e3ldfDMw3r0xFTKy7GM
   Md0HGaUDBtv/gkbElkEIx9hzBTI3QdbWyWWlO4EuTL22g49bsnZpsT7sg
   E/B9MjXHKk1Sdg3+F9fHvhExXBCa90P5Iz/HtvIWdIUh56r1jdbcCrri4
   A==;
X-CSE-ConnectionGUID: ZNWG6ExIQ2KxUSr5bpkSIQ==
X-CSE-MsgGUID: 1lU2TPIRQnC2CDQKvDF9kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="91280545"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="91280545"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 23:21:42 -0700
X-CSE-ConnectionGUID: ShTrU9S9Qt2/DVTiedohcQ==
X-CSE-MsgGUID: 2OnQ+iWBQtK/F+rsT3pxow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="239210789"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 23:21:40 -0700
Date: Sun, 17 May 2026 09:21:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Cc: jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: magnetometer: add driver for MEMSIC MMC5983MA
Message-ID: <aglecY6YjWccJTza@ashevche-desk.local>
References: <20260511191135.36691-1-vlad.kulikov.c@gmail.com>
 <20260511191135.36691-3-vlad.kulikov.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511191135.36691-3-vlad.kulikov.c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 07:11:35PM +0000, Vladislav Kulikov wrote:
> Add support for the MEMSIC MMC5983MA 3-axis magnetometer. The driver
> provides raw magnetic field readings via IIO sysfs with SET/RESET
> offset cancellation for each measurement.

Good driver, something to improve, though. Jonathan, can you tweak these in
tree? But perhaps wait a bit for the answer on "why no cache?".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

+ arrray_size.h

> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>

+ dev_printk.h
+ err.h

> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>

...

> +static const struct regmap_config mmc5983_regmap_config = {
> +	.name = "mmc5983_regmap",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MMC5983_REG_ID,
> +	.writeable_reg = mmc5983_is_writeable_reg,
> +	.readable_reg = mmc5983_is_readable_reg,
> +	.volatile_reg = mmc5983_is_volatile_reg,
> +};

Why no cache?

-- 
With Best Regards,
Andy Shevchenko


