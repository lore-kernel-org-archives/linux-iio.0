Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA91345725;
	Mon, 10 Aug 2026 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351822; cv=none; b=QVPNNHUuI4qreqVuHHLB5idBELcyvH7H8CSBcqubGOcUZ0sOlQBK2OVD/Vmhay1J+M9WZtAohjwZBwNs7Pcvl9t5E7VMV2h5jOv68WNpPR+2Eq1EyEhRCBvRUIYz5FAIkUuLqo97fe+O0QN4XmeCaXPgwcaqAv5RP+oeZA6uxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351822; c=relaxed/simple;
	bh=N4Nr2eFNkFMyFR811cgocCBwnEeCOB8K9fsN7nrZMJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7nvlfPtyWrzZWCRT9FVOzm8Amt5QqB3NdpTrXEcAbVFXN8WlBiKdM+z9hS+PJ0en8rEm+0o29pmWYjr9E6nz/npnZ02x6krNt5LEbu2ErngUchtw668rwzIDC176C58f5Gd92pVVg/+ob9GPiHo+5WveuVTML3aIZSq6eEaG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZF0Hx0Jh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZF0Hx0Jh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786351821; x=1817887821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N4Nr2eFNkFMyFR811cgocCBwnEeCOB8K9fsN7nrZMJ8=;
  b=ZF0Hx0JhwvcAhWrzfkkQX/r+t2ucuVeEVXzlztefYVR4vZlnOWsZmuxL
   c/Xf3Vv16a7V5HdiUh5vTS6II8RA+Lnxg+ae54bGnuE/TRwqhMD9EU3Pz
   kW9cX/MYH4O7Tr6JgH4apW3znLY8k7yelzHcPLlsfZ9JolhP7Oua6PQdH
   MOPNByEC0FXajW7VWiiqeFGiLbqk9AYBNrQOIFH06ThDSuBNGWy5Z1sBA
   v8dZSvQ3lSTsCdP6EYxeUVk0knQzjpp2Se8gxWkWtgpCOC4oCPn+Uf4zi
   CrWNVmztWTJQLo2XlCLWePU/Y5uahpd8R0HvHiBr5dO/yR4BlwobWtSwg
   g==;
X-CSE-ConnectionGUID: Fv2pBuLsTrWTechCB3/PRA==
X-CSE-MsgGUID: sT68fSS1QO6l4XuG9LbWeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97208508"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97208508"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:50:17 -0700
X-CSE-ConnectionGUID: ef2v6EubRMWtyAproHJ0ng==
X-CSE-MsgGUID: gx2UyzLTRAmGuAoX+t+dww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="266472606"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:50:15 -0700
Date: Mon, 10 Aug 2026 11:50:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: adc: ti-ads112c14: add DRDY interrupt support
Message-ID: <anmQw2X2-CjzSMko@ashevche-desk.local>
References: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
 <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-1-76e0d30e6c6b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-1-76e0d30e6c6b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 04:19:46PM -0500, David Lechner (TI) wrote:
> Add handling for the DRDY interrupt to wait for data ready events rather
> than polling (only when it is wired up).

...

> +static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ads112c14_data *data = iio_priv(indio_dev);

I have seen some discussion about this, but what's the problem with the

	struct ads112c14_data *data = iio_priv(private);

?

> +	complete(&data->drdy_completion);
> +
> +	return IRQ_HANDLED;
> +}

...

> +	if (device_property_present(dev, "interrupts")) {

Unfortunately this is no-go for ACPI-enabled systems.
On ACPI we expect to have 'interrupt-names' but 'interrupts' is OF-only.

> +		data->drdy_irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
> +		if (data->drdy_irq < 0)
> +			return dev_err_probe(dev, data->drdy_irq,
> +					     "failed to get drdy interrupt\n");
> +
> +		/*
> +		 * REVISIT: would probably need to implement a pin controller in
> +		 * order to support open drain option here.
> +		 */
> +		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
> +					 ADS112C14_GPIO_CFG_GPIO3_CFG,
> +					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
> +						    ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_DATA_OUTPUT,
> +					 ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC,
> +					 FIELD_PREP(ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC,
> +						    ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DRDY));
> +		if (ret)
> +			return ret;
> +
> +		init_completion(&data->drdy_completion);
> +
> +		ret = devm_request_irq(dev, data->drdy_irq, ads112c14_drdy_irq_handler,
> +				       0, dev_name(dev), indio_dev);
> +		if (ret)
> +			return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


