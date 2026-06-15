Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179F30C17B;
	Mon, 15 Jun 2026 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519025; cv=none; b=FsMDF41YDtZzMyfDFq4aG+znnvheu7fnm6RwMyMS+p6Iv0VPZTd/ktITjLu1MBHWGL+y4DqZOgfYH7nWM25fAZIjJ1yABJ1rzZ7RB0TLsoyyuN7ANgeZtrHpqWPhvysiwYif8mI746cDH9p7ayWuFkZxJVGECcfkyhElICddD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519025; c=relaxed/simple;
	bh=JlxMRRzmNLl5motzE3G6Kxf7KBpQ0QeKSXmg+oxTlDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozAFajBCznnu5U9JnUSTvk3exFo2vPKCLn6amdQfA5/0JKMKamz9k3mNmmECuiNPV6a142r9qzW7oGXbf40NLWCr5/q8cQ4K2Zr2byV9yJQUndDxBn4kcKDam2RTQEygEiGEOrGtWIFqwzPSUYU2rRFvtXNjVWVq1+4sTMZknmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqjYFSU7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqjYFSU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781519024; x=1813055024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JlxMRRzmNLl5motzE3G6Kxf7KBpQ0QeKSXmg+oxTlDA=;
  b=cqjYFSU7ombQta1JLG4IyVaCHu0SBbbUnYB/uzfIqn+am6g3AAOlXVxH
   aA2HLFIU11q3BnaQ64iZoEH2fXQ/QJJaQtzzNX+UxKwDQXuhdHwJ3DNc6
   zPwiFa/qSaBrh6V96Jo+uuOQsNTjSTiA8hjPxUToCVMx+hGwArzPkQ/EZ
   KK2Y/FCI11O9IvCnFFgH7WmsBUlkENkHO6yacQO5tV1KtEGWWuRy/Hjyk
   F6Z5MQTOELalBA6Jg8AB4Ih/CK7cmLQOLXoJwNcEsSlisdQKh1kfeGbT5
   /ppMLFWndK4J+PNOLJhLruW6HNH0t6kBWmyaflQQX2GeTBZJ9KN9OIjBm
   A==;
X-CSE-ConnectionGUID: 4cxcmnKvTO2gZeUHOoVgfg==
X-CSE-MsgGUID: MRsM3rh7Rzq2DCrZWRrrZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82102479"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82102479"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:23:43 -0700
X-CSE-ConnectionGUID: 5X9uSTOYTlGXJeJgC+24mg==
X-CSE-MsgGUID: XVYi6KlESCqG5krYV3y3qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="246544081"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:23:40 -0700
Date: Mon, 15 Jun 2026 13:23:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V12 4/9] iio: imu: inv_icm42607: Add SPI For icm42607
Message-ID: <ai_SqaTvBYI7wL79@ashevche-desk.local>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
 <20260611202607.85376-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611202607.85376-5-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 03:26:01PM -0500, Chris Morgan wrote:

> Add SPI driver support for InvenSense ICM-42607 devices.

...

> +#include <linux/bitfield.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>

...

> +static const struct spi_device_id inv_icm42607_spi_id_table[] = {
> +	{
> +		.name = "icm42607",
> +		.driver_data = (kernel_ulong_t)&inv_icm42607_hw_data
> +	}, {
> +		.name = "icm42607p",
> +		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data

I believe I have commented on this already. But anyway, please leave
a trailing comma for .driver_data assignments as well. Same for I²C
driver.

> +	},
> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


