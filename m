Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2335F163;
	Thu, 11 Jun 2026 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163357; cv=none; b=X/eA2+dePnRs9lGP3HSc8wj7Gq4B18odWmAku1tPn0ayrGfhvaspfb+/XSJrSNoPc5AK/OTokCUokI0ot1FD4b8rdTXYqRVsQdZi1ZArmDVXYI36OgblnvrUJwbFPrNcQFyRSw26VXDHzkRxXb+CTkdqnCKm/l+sfbz72hwmdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163357; c=relaxed/simple;
	bh=eUTaZdcVlZ7mbhJNGVeR+srWl7fhfY1SzOK+RRIWYq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJTjaimt1aHTO5Cs67hu3iynKYhyrMzHijAvMjt9NCVFr/bIeU3g1w+UX3CfCkyPFVKXuhUyTwY5antRfuPOXkLGvpculwznwntef9Yes/Y34bNmfBeDeKWC1Cdy89logI6uN/BlV0a8h8LQcxDzqzPJEwy1GKl1O6xRyPUalnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8AdGcZb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8AdGcZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781163356; x=1812699356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eUTaZdcVlZ7mbhJNGVeR+srWl7fhfY1SzOK+RRIWYq0=;
  b=C8AdGcZbJdGWhvXnnuEtrRZNv79yUv9xyLe61zZZyskpehMYy1ADCRbj
   +ekjPDS1PSVMh72pC54JCkXHU6anS/nEojUvzUIGyENzAQ1onhuU62mG0
   bGdcEOgctE5DBIsRtQmlha2DVaVIUXt8CYXyU+mCeo7wYzgGQWRfqYMq0
   r7lqzD2M80FWzs9+lEmM8+NSI22a8Z3j8s0DCBhV+023HHkFYaw7XCMLG
   3K4CFtAsRcFjqtgrrmSv4LjFdY2i/VVGJe/KopdqzEAeNhovNhA2F2+lf
   YUklaYoE7q9sAQF9QUU0z+fKEHIQCo+Cal2x7DqcxsGXpYt270QNeZHMu
   Q==;
X-CSE-ConnectionGUID: LTubp02LTPygbwDyALbilw==
X-CSE-MsgGUID: JZPg5AVJR4CECA5omA+jmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99393278"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="99393278"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:35:56 -0700
X-CSE-ConnectionGUID: gc9XZ82lQ06NICssykO0vQ==
X-CSE-MsgGUID: mjaJF0ZNR6i0VLMXbF0kdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="276595139"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:35:53 -0700
Date: Thu, 11 Jun 2026 10:35:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V11 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <aiplVZRI-0TCDnjL@ashevche-desk.local>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
 <20260610175455.19006-4-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610175455.19006-4-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 12:54:47PM -0500, Chris Morgan wrote:

> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.

...

>  2 files changed, 531 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

I'm not sure this is correct split by files. These files are not:
- being build
- being mentioned in MAINTAINERS

...

> +#ifndef INV_ICM42607_H_
> +#define INV_ICM42607_H_
> +
> +#include <linux/bits.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>

mutex_types.h ?

> +#include <linux/regmap.h>
> +#include <linux/types.h>

Do you need forward declaration for regulator data type?

...

> +#define INV_ICM42607_POWER_UP_TIME_US			100000

100 * USEC_PER_MSEC (will require time.h)?

...

> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

+ bitfields.h

> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>

+ device/devres.h
+ err.h

> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/time.h>

Also check if you need types.h.

...

> +	fsleep(INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC);
> +
> +	/*
> +	 * No polling interval specified in datasheet, so use reset time as
> +	 * polling interval and 10x reset time as timeout period.
> +	 */
> +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC),
> +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC * 10));

Besides too many parentheses, this can be switched to regular patter of "num * what".
Also, TBH, the plain values would be better here

	fsleep(1 * USEC_PER_MSEC);

	/*
	 * No polling interval specified in datasheet, so use reset time as
	 * polling interval and 10x reset time as timeout period.
	 */
	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
				       1 * USEC_PER_MSEC, 10 * USEC_PER_MSEC);

And in the similar way in other fsleep() / _read_poll_timeout() cases.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "reset error, reset done bit not set\n");

-- 
With Best Regards,
Andy Shevchenko


