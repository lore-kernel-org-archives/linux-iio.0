Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4AB4C9574;
	Tue,  9 Jun 2026 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026756; cv=none; b=kvII3QMewOFWPf4JvPorCEXc0BAPkSBDYIl61hhSbGJofUCEgSAnFWI8j9AFF3Om24CsNjRRjLXu4rrPsJRnPpT6OL4KE5pJwDGPJX+TOka5QfTl4/bOQ5UrcwDR6AYntAdJVj080qaMegoM+fhWFCW3uTiuukzdCy7ajNETuXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026756; c=relaxed/simple;
	bh=/IaJ6qCkvpUse7a9hqA+D6NA3gfvR/wftVsQ//v4UMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNjBUN4gsUzEbF0nJ1pq/ZLS6NZ2wl6b5l72OkqsBgyFcFZ34V3+IA3BNCr4FlMyP9OIhxfqlFS9HzZVRdhUiFvzg6HZACfQZe6kPuu1Ey/hlkpR395t5VmGvYECdaF8AKAXCJu0dJAtMd8l7GQc4cx7m8KG8Jbq7uWsEls/VAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcHmvo6D; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcHmvo6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781026756; x=1812562756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/IaJ6qCkvpUse7a9hqA+D6NA3gfvR/wftVsQ//v4UMk=;
  b=QcHmvo6D1rkoIBw1hY607YPNqBJv+GpS9v8uTDHEa5Ew9UdJ/kgCRwPZ
   bVWjadSIkDd1ypPJIZr9wGmUj6ZxblRQd75RZuU2Z5A0oOKz6kZMLAuYf
   F4RsJgcH7PBrlys4gNnlMTyB1GEnbUk6UrX9LkqmesPAWeX4878PINZ2S
   vHPxrxut/gWw/y5jdyhDSW4y8IOgC9F/bx3xK4h91WoMotjHXwKDsF9s8
   Q8IKHM9TC2103Fnv8eLN/6Me/L0n2/DkgvlTLz8FUHMpMVzHUaFAHnONy
   2fQWd/XoZqBHcMknaL5qisPiD5+jtCGZicp1Vw/8oP09RoAIY2PMhNvUm
   A==;
X-CSE-ConnectionGUID: yhQ3uhuPQfexnSbGJhfxTg==
X-CSE-MsgGUID: xPV4FZnwQJ2HzrE5WeinaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99214900"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="99214900"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:39:15 -0700
X-CSE-ConnectionGUID: Lxsnj1fKQKO4GWh3SSv64A==
X-CSE-MsgGUID: LYxSE+wUTEiceQ07BqgTKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245079082"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:39:11 -0700
Date: Tue, 9 Jun 2026 20:39:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: adc: versal-sysmon: add I2C driver
Message-ID: <aihPvR0u5Lo3xELX@ashevche-desk.local>
References: <20260608183801.1257051-1-salih.erim@amd.com>
 <20260608183801.1257051-4-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608183801.1257051-4-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 07:37:59PM +0100, Salih Erim wrote:
> Add an I2C transport driver for the Versal SysMon block. The SysMon
> provides an I2C slave interface that allows an external master to
> read voltage and temperature measurements through the same register
> map used by the MMIO path.
> 
> The I2C command frame is an 8-byte structure containing a 4-byte data
> payload, a 2-byte register offset, and a 1-byte instruction field.
> Read operations send the frame with a read instruction, then receive
> a 4-byte response containing the register value.
> 
> Events are not supported on the I2C path because there is no
> interrupt line and the I2C regmap backend cannot be called from
> atomic context.

...

> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

+ types.h // uXX

> +#include <linux/unaligned.h>
> +
> +#include "versal-sysmon.h"

...

> +static int sysmon_i2c_probe(struct i2c_client *client)
> +{

	struct device *dev = &client->dev;

> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init(&client->dev, NULL, client,
> +				  &sysmon_i2c_regmap_config);

	regmap = devm_regmap_init(dev, NULL, client, &sysmon_i2c_regmap_config);

(exactly 80 characters, so inside the limit).

> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	/* I2C has no IRQ connection; events are not supported */
> +	return sysmon_core_probe(&client->dev, regmap);
> +}

-- 
With Best Regards,
Andy Shevchenko


