Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE381D555;
	Fri, 20 Feb 2026 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771573808; cv=none; b=BcOSxajB+k2OJ4I9Ak5uvYBRo+rhskkP6n9yT6jLZbygIrlVErwckkDNImvfou/5s323pmlgLNQ59VBt41PAvSf1BLAinlpck7VoIayqE5MPrjeQYWej6UUjE2SVDPHXRtXw3SvS1fB1Y3liZ5IqgbIKiNSl656ufowL07a9hqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771573808; c=relaxed/simple;
	bh=3+AoRFtzUL4Di9TqIr6oRG/bKUTY7As8hvY/CM5Ll5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Omc9/CLKlrdwIXl1KVgXRGHAXPv0tcJfxk9dr1AF1b/xKUb06qKuoLgUtcaU8FYZnBMnnuHEB3+8u/xONffAWyCRQZC40ipR8hnK9B0vKqyavhGFeFNzrP0e/5UuJaDwSXaljv3U08Z7aIqBv4P0u02aOS0x09LMfTje7mKYMpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD5HWLmZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dD5HWLmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771573807; x=1803109807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3+AoRFtzUL4Di9TqIr6oRG/bKUTY7As8hvY/CM5Ll5Q=;
  b=dD5HWLmZjX0PgccL2V19A2REjvxYwQNeFR4v7OlNUB4NNDDLjubZ+uGJ
   SJJxoHqMcIyAaEazVtNY1S82v1c1+z5VNvQzUerO2iEbOq6cnEdIjed/o
   gmkv9e4OL6y2giHp+4ewM8EHwZcA6tp8/wodZqgahDHqvbLgDCwjxx0bf
   Z3jYJK/Zs4bkSu3t/jINX5Lk4R/CfzuJVzcVV7mVQvk0HcdOV2Crag9Oy
   aDPTNaRkaqO8mGQ2yE+BjVPHucR97uYrFWPYdztbhoZMfBFWzSHsI0U1t
   L121oVoXE4rekm9cAp1J8hge1VP3gl1dkUfy+9P5fbJQ0fI6N9YTrmhho
   g==;
X-CSE-ConnectionGUID: tmKjsNGiScKVqpWO/mSGiA==
X-CSE-MsgGUID: C3WpdcKDQkiMkWr3TQMU4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72368104"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72368104"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:50:06 -0800
X-CSE-ConnectionGUID: dVA7vvsSTwy3CnrSSKBAjw==
X-CSE-MsgGUID: FbwUmViSRP6JIypUstUI5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="218920013"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:50:02 -0800
Date: Fri, 20 Feb 2026 09:50:00 +0200
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
Subject: Re: [PATCH 1/5] iio: adc: xilinx-xadc: Add helper functions for the
 device setup
Message-ID: <aZgSKB300JRB4yvl@smile.fi.intel.com>
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-2-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220053941.611415-2-sai.krishna.potthuri@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 11:09:37AM +0530, Sai Krishna Potthuri wrote:
> Refactor the platform driver probe function by extracting device
> setup and configuration logic into reusable helper functions:
> xadc_device_setup(): handles IIO device allocation and basic setup
> xadc_device_configure(): handles device tree parsing and bipolar mask
> configuration

Reformat text like:

- xadc_device_setup():
  handles IIO device allocation and basic setup

- xadc_device_configure():
  handles device tree parsing and bipolar mask configuration

> This refactoring reduces code duplication and prepares for sharing the
> common setup logic between platform and I2C drivers.

TBH without seeing the rest, this patch looks like an unneeded churn.

...

> +static struct iio_dev *xadc_device_setup(struct device *dev, int size,
> +					 const struct xadc_ops **ops)
> +{
> +	struct iio_dev *indio_dev;
> +
> +	*ops = device_get_match_data(dev);

> +	if (!*ops)
> +		return ERR_PTR(-ENODEV);

This is a dead code as it seems that ops is mandatory. So in case if it's
missed it will mean that the contribution was never ever being tested.
If it's tested, the check above is a dead code and hence no need to put
it here.

> +	indio_dev = devm_iio_device_alloc(dev, size);
> +	if (!indio_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	indio_dev->name = xadc_type_names[(*ops)->type];
> +	indio_dev->info = &xadc_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return indio_dev;
> +}
> +
> +static int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev,
> +				 int irq, unsigned int *conf0, unsigned int *bipolar_mask)
> +{
> +	int ret, i;

Why is 'i' signed? Also see below.

> +
> +	ret = xadc_parse_dt(indio_dev, conf0, irq);
> +	if (ret)
> +		return ret;
> +
> +	*bipolar_mask = 0;
> +	for (i = 0; i < indio_dev->num_channels; i++) {

The iterator is not used outside the loop, hence

	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {

will be good choice.

> +		if (indio_dev->channels[i].scan_type.sign == 's')
> +			*bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


