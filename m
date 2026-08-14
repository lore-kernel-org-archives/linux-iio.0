Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E074137BA;
	Fri, 14 Aug 2026 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697029; cv=none; b=A8osoAhuYk1NemurwKXeeSS0iuogmF93AVJDPP5W9HQKSEdcxPOazaglxx3q5666gv5kI0SjSPnY/cRdv4LjfMhxUMutwKfHOLMoAAjmow79hBeB7m2hwIuSezQ+VHuikRiNtjJJFsISNCmgtcw8kwkW0vQDFz4PHmkAeOzhDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697029; c=relaxed/simple;
	bh=QHK1lRF023k+l6x+AD/Ftl1KQyNl1dyWfbLpeBcC2ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSkh45vQzFz3jGmF8e6uqN06CJBTuXf+dIb+z58nDay32cy/FrcBLUcaFdO2oWqDRyFb+4pvhX/qnWIE+4eygAnX9+N+CrX871pox0A2Wrg/TJRrjsI/IXJodD8GpTHMV2toLDZzkQ0RQ0yGLlA0xoY9fL1lbDlWETHTaVRcLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jd9VVIcA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jd9VVIcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786697026; x=1818233026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QHK1lRF023k+l6x+AD/Ftl1KQyNl1dyWfbLpeBcC2ew=;
  b=Jd9VVIcAtS8MAT++PtasddiuvaEoaaxlzW2h1takswCmqjEdeGi4iuip
   J+b7QjcLis1kgd6QW+eKAOhY5WWeylrfiKcjUpKwsf9MKZTnWmcGYl+pf
   hj7NYFrvOOxIV0XjsXel9XPQt/LgJR3Z7UCbUQzX9ZGpr/QhWIr1kZKle
   dHBsKcNLti+77Yi5XnF5ZbSHWBC6fK0BwY7BzU0T1tUijizu8FW03nkn/
   CEn9nc9K9AB98kVrjxKbvzc405wbqw4vau0cKOPTpPlExHR7HWzWfRTRm
   FxER7t2/sMB+09C+z0hBIkDihBg9yhpvWW/lbMKKuOO49zMnpVrFawTxs
   A==;
X-CSE-ConnectionGUID: zdhWU5UQRUaPOoBw6ok3pA==
X-CSE-MsgGUID: YYWr98NfTemSQP7iSTUdJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86394672"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="86394672"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:43:43 -0700
X-CSE-ConnectionGUID: vkH07wKkTKiCLt/3hnt7jQ==
X-CSE-MsgGUID: DGgJZTlfQ1CTlVnXwZrPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="262847027"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:43:37 -0700
Date: Fri, 14 Aug 2026 11:43:35 +0300
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
Subject: Re: [PATCH v3 13/14] gpio: ad7768: Add AD7768 GPIO auxiliary driver
Message-ID: <an7VNxGsFCSo6CUh@ashevche-desk.local>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
 <20260813-ad7768-driver-v3-13-cb554399ad26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-ad7768-driver-v3-13-cb554399ad26@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 03:57:06PM +0200, Janani Sunil wrote:
> The AD7768 provides five GPIOs controlled through registers shared
> with the parent IIO device. Register an auxiliary gpio-regmap driver
> and use the parent device for runtime PM.
> 
> The device has separate input-state and output-latch registers. Add a
> reg_mask_xlate() callback that checks the line direction and reads the
> programmed output latch for output lines while retaining input-state
> reads for input lines.

...

> +#include <linux/auxiliary_bus.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>

Is it used?

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>

...

> +static int ad7768_gpio_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &adev->dev;

	struct device *parent = dev->parent;

> +	struct gpio_regmap_config config = {
> +		.parent = dev,
> +		.label = dev_name(dev->parent),
> +		.ngpio = AD7768_NUM_GPIOS,
> +		.reg_dat_base = AD7768_REG_GPIO_READ,
> +		.reg_set_base = AD7768_REG_GPIO_WRITE,
> +		.reg_dir_out_base = AD7768_REG_GPIO_CONTROL,
> +		.pm_dev = dev->parent,

parent

> +		.reg_mask_xlate = ad7768_gpio_reg_mask_xlate,
> +	};
> +	struct gpio_regmap *gpio;
> +	struct regmap *regmap;

Name it map, it will shorten some lines (see below).

> +	int ret;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);

parent

> +	if (!regmap)
> +		return -ENODEV;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->parent, pm);

parent

> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(regmap, AD7768_REG_GPIO_CONTROL,
> +			      AD7768_GPIO_UGPIO_ENABLE);

I would dare to put it on a single line

	ret = regmap_set_bits(map, AD7768_REG_GPIO_CONTROL, AD7768_GPIO_UGPIO_ENABLE);

(out of only 86 characters).

> +	if (ret)
> +		return ret;
> +
> +	config.regmap = regmap;
> +	config.drvdata = regmap;

> +	gpio = devm_gpio_regmap_register(dev, &config);
> +
> +	return PTR_ERR_OR_ZERO(gpio);

I would swap blank line as the below is tightly coupled.

	config.regmap = regmap;
	config.drvdata = regmap;

	gpio = devm_gpio_regmap_register(dev, &config);
	return PTR_ERR_OR_ZERO(gpio);

> +}

-- 
With Best Regards,
Andy Shevchenko


