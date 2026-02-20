Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B81CAA7D;
	Fri, 20 Feb 2026 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574341; cv=none; b=elgog39IWvY1QjmA/TpLCr0t00iHmVeEzwZv3uX2OeLCUHPCAujZqDHWaFo6Bdz9336P+pDlXFevr29/7Yxb9hnZfxqLBIEufptgLU6lIoOTXFFMkP9C2V73wutSck2SNFlJz7OqFyk94LTrd7JAN3WiLGZAks3Y899Sk22aFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574341; c=relaxed/simple;
	bh=RHFutnNKCiADzH3IhdRKV+458gfx/OM0sw/5yVDQMMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzVFXbpINLZ8oUi5DnZ0e9HEi+kYvNWUjS14bbASBVf3y3uzSdkeJ0lEpkILxZy1puNduLcEodDk6nvRFxnmevEhpEwaFO+Q2ZwrhJ78myPXbR2lEsyObElrpBmYTic+2xvQZxgTeuesdPwTkA/02VHx8v2t7wB/ly3eKz9Znbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZjjt6sC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZjjt6sC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771574340; x=1803110340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RHFutnNKCiADzH3IhdRKV+458gfx/OM0sw/5yVDQMMY=;
  b=kZjjt6sCQcyv2Ts295TC/4BUBP76ONexW7f0sAA7380VgJhio16V9qkJ
   WEJS3un6a4Md2OSwoq5SW3xAlymKiCuwkOPA1J9ksDAIkn+z9VrCqHVq9
   FLo9N5Zo9htWPizefgU6OpNnIGL6b8fQ9jHDoBVlodjGfTq9nOdomiy9G
   HfmLOKmwneh/O+4BUi3ic8d+OFw2HQETTFiG9zS2IS3RKxtPKKcee5RWO
   +ckahTO1TszxOFxNg57efq162wRRZP6IkFYic+MRI6gUAqy6+SrVvHr3W
   fjkhE2/ji6O4ROzvw3+oEuaTwCWI9kqQCg4n2fTMbTO5Gzc2hYXNm93wv
   g==;
X-CSE-ConnectionGUID: jgwcgPe8R8eH1TMdpp7FNg==
X-CSE-MsgGUID: d6RHXy2yQiihfNWUq3XWlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72368724"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72368724"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:58:59 -0800
X-CSE-ConnectionGUID: GxPklxemTqW/9IdQ9zJRAw==
X-CSE-MsgGUID: 4ui/8WfSREi1p4r2uWmxpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219794508"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:58:55 -0800
Date: Fri, 20 Feb 2026 09:58:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
	git@amd.com
Subject: Re: [PATCH 4/5] iio: adc: xilinx-xadc: Add I2C interface support
Message-ID: <aZgUO-zihSIQ8d8_@smile.fi.intel.com>
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-5-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220053941.611415-5-sai.krishna.potthuri@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 11:09:40AM +0530, Sai Krishna Potthuri wrote:
> Add I2C interface support for Xilinx System Management Wizard IP along
> with the existing AXI memory-mapped interface. This support enables
> monitoring the voltage and temperature on UltraScale+ devices where the
> System Management Wizard is connected via I2C.
> 
> Key changes:
> - Implement 32-bit DRP(Dynamic Reconfiguration Port) packet format as per
>   Xilinx PG185 specification.
> - Add separate I2C probe with xadc_i2c_of_match_table to handle same
>   compatible string("xlnx,system-management-wiz-1.3") on I2C bus.
> - Implement delayed version of hardware initialization for I2C interface
>   to handle the case where System Management Wizard IP is not ready during
>   the I2C probe.
> - Add xadc_i2c_transaction() function to handle I2C read/write operations
> - Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI.

...

>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/i2c.h>

No, split driver to a few files:
_core.c
_platform.c
_i2c.c

The last two will be just a glue code.

...

> +#ifdef CONFIG_XILINX_XADC_I2C

No way for ugly ifdeffery!

...

> +static int xadc_i2c_transaction(struct xadc *xadc, unsigned int reg, uint16_t write_data,
> +				bool is_write, uint16_t *read_data)

Should be simply u16.

...

> +	char write_buffer[XADC_I2C_WRITE_DATA_SIZE] = { 0 };

No '0' is needed.

...

> +	if (is_write) {

Bad design. Instead make two functions, one for read, one for write and drop
the boolean parameter.

> +	} else {
> +	}

> +	/* Read response for read operations */
> +	if (!is_write) {

> +	}

...

> +static int xadc_hardware_init(struct xadc *xadc)
> +{
> +	int ret, i;

Use unsigned iterator inside the loop.

> +	for (i = 0; i < 16; i++) {

Magic 16.

> +		ret = xadc_i2c_transaction(xadc, XADC_REG_THRESHOLD(i), 0, false,
> +					   &xadc->threshold[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = xadc_i2c_transaction(xadc, XADC_REG_CONF0, xadc->conf0, true, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = xadc_i2c_transaction(xadc, XADC_REG_INPUT_MODE(0), xadc->bipolar_mask, true, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = xadc_i2c_transaction(xadc, XADC_REG_INPUT_MODE(1), xadc->bipolar_mask >> 16, true,
> +				   NULL);
> +	if (ret)
> +		return ret;
> +
> +	xadc->hw_initialized = true;
> +
> +	return 0;
> +}

...

> +static const struct of_device_id xadc_i2c_of_match_table[] = {
> +	{
> +		.compatible = "xlnx,system-management-wiz-1.3",
> +		.data = &xadc_system_mgmt_wiz_i2c_ops

Leave trailing comma as it's not a sentinel.

> +	},
> +	{ },

The opposite. IIO has established way besides the fact that sentinel by
definition must be the last, trailing comma is confusing for a bare minimum.

> +};

-- 
With Best Regards,
Andy Shevchenko


