Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691332D7C7;
	Mon, 23 Mar 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263151; cv=none; b=cCx7Bn3BBHeY1p7MWdE2W9hw3g91KHGwiiFGisLUsYGjq/G7p+bEm/Qrw3u88bZaJnmkxf/qQLda8H9BBRywmOwnQTqiDnS8zcBgzLvNMfQG0+RR7FNDFs2iuC71g2iyxSt11Y3h6KKN4KnAOZmrsZrnmeZPnyP8X7BcwJb7FvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263151; c=relaxed/simple;
	bh=dYFyRYEwxpvZcJORzLC/7c9c4OiyVF87NhTBMWfsyQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGWmh9PLV7wfG6yHiESoZ3zPoSB0efKXGycjPrxxXoItPI74OFM73LuJ1jIL3T3G/QuStL2t0lTom8D7zI0YP65kGZCy7yguDuULOMH6D5+qRzvi4Ll1h0b4IiptjK0iSPqs7GUpkj7oZzYpfHez8E9WvjWD6SxoZIhzYcBu62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7/QlFh/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7/QlFh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774263150; x=1805799150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYFyRYEwxpvZcJORzLC/7c9c4OiyVF87NhTBMWfsyQk=;
  b=k7/QlFh/qqX5BxGDRvashMcozUsDN7Zb1MeqtGFyuThjpqOD1MwCL+xz
   R3VMBjqrorgK3NotNL0HdMPW4biDiBAfiNX4E86FI8h/dLZtK6zApgMNr
   WbMgADXG7uvfPl++ysJ3ESnrHyKvjdsk3tJAGrHxwQZtKWc1IYYUfM4te
   jVvjNMevVy+Hknp4OqJ/mOC7gU/chyoKOheZic7G1g04prgpes9RjvZui
   0V0x1/gSQMhrKIyVQ4v/oYEwPJrYyKwNdmAENXk6hg7TkJE+8MGfrmzAb
   mFtvqUle9Nx77SuUK/sUqnUTUv71NMTKU1kywQLWgzs13p8cV9tMcw+lK
   Q==;
X-CSE-ConnectionGUID: YEs13jSmS9Ke0AJJaHXnbQ==
X-CSE-MsgGUID: KcXsfWPIR8SdO6euyvB0pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="78854045"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="78854045"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:52:29 -0700
X-CSE-ConnectionGUID: CQ7Wgjq5SmObBNzJ4UBJgg==
X-CSE-MsgGUID: Eu6qvPOJTFi1hr7Iho4xsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="254467029"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:52:26 -0700
Date: Mon, 23 Mar 2026 12:52:23 +0200
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
Subject: Re: [PATCH v2 3/4] iio: adc: xilinx-xadc: Add I2C interface support
Message-ID: <acEbZ0O3HKrGx0u1@ashevche-desk.local>
References: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
 <20260323074505.3853353-4-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323074505.3853353-4-sai.krishna.potthuri@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 01:15:04PM +0530, Sai Krishna Potthuri wrote:
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
> - Add NULL checks for get_dclk_rate callback function in sampling rate
>   functions to support interfaces without clock control
> - Create separate iio_info structure(xadc_i2c_info) without event
>   callbacks for I2C devices
> - Add xadc_i2c_transaction() function to handle I2C read/write operations
> - Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI

...

> -	if (xadc->ops->type == XADC_TYPE_US)
> +	if (xadc->ops->type == XADC_TYPE_US ||
> +	    xadc->ops->type == XADC_TYPE_US_I2C)

Can be one line.

>  		return 0;

...

>  	/* UltraScale has only one ADC and supports only continuous mode */
> -	if (xadc->ops->type == XADC_TYPE_US)
> +	if (xadc->ops->type == XADC_TYPE_US ||
> +	    xadc->ops->type == XADC_TYPE_US_I2C)


Ditto.

>  		return XADC_CONF1_SEQ_CONTINUOUS;

...

>  int xadc_write_samplerate(struct xadc *xadc, int val)
>  {
> -	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
> +	unsigned long clk_rate;
>  	unsigned int div;
>  
> +	if (!xadc->ops->get_dclk_rate)
> +		return -EOPNOTSUPP;

> +	clk_rate = xadc_get_dclk_rate(xadc);
> +

Unneeded blank line.

Also, don't you asked for options?

>  	if (!clk_rate)
>  		return -EINVAL;

...

> +	i2c_set_clientdata(client, indio_dev);

Is it used?

-- 
With Best Regards,
Andy Shevchenko


