Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00523A7F59;
	Mon, 24 Aug 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559042; cv=none; b=L9uVyro2r91EaRzTsryNKDhQswiF0hHs7nTKtvHXiITZnC9fO+IIv+Rlh2KRcoTP6eGqcT9O9TDQdYkbO2URwysjaFvohinHkoj4CnA5GBUcA4m8U9VheNY7VrXytceh9UhEPLN+j7YbwpW6vpj9qfsB4A00IRnPTS8S/r6KFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559042; c=relaxed/simple;
	bh=ktqyT/6Le6ZFDEJQf//i0lV4t3Zy65DXodVaLmH+wgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPs7Y586FyQ6xpOOVAvZIv8N6qNh+3AMz7MWYOTJm9wrb422FlgOuGdoFo5aoA4wTGaCl/IJuDmoAXBqRYn02+20u6uA259AJo84XQ3OwwQR/ywZj9tdo1wH1ocEpegTUdt3QpFmNKM/q1Sd04scqeE6NGYrVbGcA66sqKOlzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/W266vq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/W266vq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787559040; x=1819095040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ktqyT/6Le6ZFDEJQf//i0lV4t3Zy65DXodVaLmH+wgI=;
  b=J/W266vqo7qrHJ1GcGhkGXp1rpZZy2NhVnG5vWVi7LzODKm+VlgS4TZl
   rQRo/aHq8t4L6aWkn8fKMqaAQhKOwinNnw+yASy3waT14w92iWq1YQgRb
   XrZdcpRXDRoq/QGo5I0qy/MNzEEneDs3JIbE9F0/P1zAPxoieEJ7rn+VP
   YSyBY3/gQ0jGRo1hO80benI05BiuuGQSFcf11tyzzCDzRi7JxwQEToNvj
   MMPuCOfmxpriRAGjkGjIEnToNlCuajH1YlkvU2+tRaiNTNZINhYbJslj2
   jDRGRmmduBCRtrZ+b9cqKTILOOEEEYdZJPN/U7r3lYMXSoAAAKdhVv4Ez
   A==;
X-CSE-ConnectionGUID: elzljZ0BQGOz5BnMdVIDMg==
X-CSE-MsgGUID: yHgkBvQ3T9S0wO+9kz8p5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88207878"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88207878"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:10:40 -0700
X-CSE-ConnectionGUID: KLvaJA9LRNmwn0SLRaP54Q==
X-CSE-MsgGUID: 9/w9qm4KS/in6ivp5FFdTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="268894383"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:10:35 -0700
Date: Mon, 24 Aug 2026 11:10:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 13/14] gpio: ad7768: Add AD7768 GPIO auxiliary driver
Message-ID: <aov8eJeY8lAsl0wm@ashevche-desk.local>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-13-bb8fbd06d4eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-ad7768-driver-v4-13-bb8fbd06d4eb@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 04:07:06PM +0200, Janani Sunil wrote:
> The AD7768 provides five GPIOs controlled through registers shared
> with the parent IIO device. Register an auxiliary gpio-regmap driver
> and use the parent device for runtime PM.
> 
> The device has separate input-state and output-latch registers. Add a
> reg_mask_xlate() callback that checks the line direction and reads the
> programmed output latch for output lines while retaining input-state
> reads for input lines.

Nice driver!
See a few nit-picks below and after addressing them
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitmap.h>

> +#include <linux/bits.h>

bitmap.h covers bitops.h that covers bits.h.
So bitmap.h is superior of those.

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>

...

> +static int ad7768_gpio_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{

	struct device *dev = &adev->dev;

> +	struct device *parent = adev->dev.parent;

	struct device *parent = dev->parent;

> +	struct gpio_regmap_config config = {
> +		.parent = &adev->dev,

		.parent = dev,

> +		.label = dev_name(parent),
> +		.ngpio = AD7768_NUM_GPIOS,
> +		.reg_dat_base = AD7768_REG_GPIO_READ,
> +		.reg_set_base = AD7768_REG_GPIO_WRITE,
> +		.reg_dir_out_base = AD7768_REG_GPIO_CONTROL,
> +		.pm_dev = parent,
> +		.reg_mask_xlate = ad7768_gpio_reg_mask_xlate,
> +		.init_valid_mask = ad7768_gpio_init_valid_mask,
> +	};
> +	struct gpio_regmap *gpio;
> +	struct regmap *map;
> +	int ret;
> +
> +	map = dev_get_regmap(parent, NULL);
> +	if (!map)
> +		return -ENODEV;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(parent, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, AD7768_REG_GPIO_CONTROL, AD7768_GPIO_UGPIO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	config.regmap = map;
> +	config.drvdata = map;
> +
> +	gpio = devm_gpio_regmap_register(&adev->dev, &config);

	gpio = devm_gpio_regmap_register(dev, &config);

> +	return PTR_ERR_OR_ZERO(gpio);
> +}

-- 
With Best Regards,
Andy Shevchenko


