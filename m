Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327919;
	b=1Uysuf7xE4LImfaN0K7aJw0Et1KrbgBCQvDF+7JM8PwfIYtiaxQRHlsO8UgVujoi24MM
	 1hWj9dTWKEUx/WkU6DxCFiMQu5RZxyRtCywnsMHb+K7KDz4XeBahh2Eo1cNtK0BUJaq4s
	 zqK1JG5B56qVQSqNacLN97p+Ls/WPE6ZPPwK/Iq5Ic08Lh0wNWGw4PAc95+suJDJmzcbI
	 wCjUK1r/Fx0i90DgTm2kY/vm04zcFsiBtfZPfkWtYv4aqazD++h+REZ2CBwgDh0NRWgWc
	 Kc3gB3rQpb75L6AVm2eSD5Df7o1ZkMWr8Q/18PEuGUhB/YF5+zE0uu8TEdLws9bOgkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327919;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=EeDJ3iXHw1eTGr3jYLp8sNAP6zgbBAsImYmgoG9HH1E=;
	b=UKzxiB/M6wqYdre0nYr5JHmfg7bYFt7LVg4ahIP2eNgSjvyaU2eRJx7R+JLYeBgHYY30
	 uPZlUkvgrXxaER1PlJOSkpksvWNVSNe6oDfmYxPARnvkIq1qrkefZxVfn9m4yAlC6IHla
	 k1gzSOYsBFHjz4FNQBpjASheglbBL1RdJg6gBiODO58K982spavEPFo/jY8zAmRKKltPt
	 aCFFYV31p/k7cnaVPhc+Yrdx3f0VOH8paZtDwTpd+0xwtML0VZ/w41+m0Zc0tcI/ZAvhm
	 mfg9zmHOcN8oVuPBO75G9wdywSdaWGxZK4ubBElzV7WP+G/aVHhQFBBH/jJR7PIFD2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aUEhOHj2;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC24606A33E;
	Tue, 10 Nov 2026 16:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC24606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aUEhOHj2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794327919; x=1825863919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lyuz2D4EmFcet2JRZyG53EVIYy8D1CxnxYUn7KkldQw=;
  b=aUEhOHj2SvaeWr/fGfZlqJfy4skYaQjqfwpJr1+wwLgOGQl1zEQ6CnEi
   Y/cWWZBkCTkKI+mM+Saj4L57FSvSyU1EDYrFm6AvjHMHwNXdiNa9HjzwU
   COrgSVal1qbDTrgcpPblyoTlQmD8u3BNdK9vppL1E1fZgblqqJWWo5bxL
   PSUrI4zE+mTtIhYCqNXEdLfh5bBLTP4pbt5vYu32CuatYTx9DCxuMIXX1
   HwFmmLCdp7V3+AFnYehR0Lz6PVHqc8XjZFVpjpeGmdGMOith/UcTd6kN4
   r7b0xEOntyTf6sVsGntaHqT67G0Mlhgt5VKcXzmSe4XyL3+WUSdD2vL8x
   w==;
X-CSE-ConnectionGUID: 4jqyuKGJQzC+X3laTfuSDA==
X-CSE-MsgGUID: R8eCt+8bTqmlYPY91rQ3jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3082520"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3082520"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:25:18 -0800
X-CSE-ConnectionGUID: rpPa5ikRQqOeounq2lJdXA==
X-CSE-MsgGUID: GpEMo1VERpSvxmHTl/EiMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8784099"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:25:14 -0800
Date: Tue, 10 Nov 2026 18:25:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 13/16] iio: adc: xilinx-xadc: Add helper functions for
 the device setup
Message-ID: <avNFaNki0m47M80d@ashevche-desk.local>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-14-dileepkumar.nagavarapu@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110050201.1850399-14-dileepkumar.nagavarapu@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:31:58AM +0530, Dileep Kumar Nagavarapu wrote:
> Refactor the platform driver probe function by extracting device
> setup and configuration logic into reusable helper functions:
> xadc_device_setup(): handles IIO device allocation and basic setup
> xadc_device_configure(): handles device tree parsing and bipolar mask
> configuration
> 
> Move the bipolar channel mask calculation immediately after
> xadc_parse_dt(), as the channel information used to build
> the mask is populated there and remains unchanged before it is consumed.
> 
> This refactoring reduces code duplication and prepares for sharing the
> common setup logic between platform and I2C drivers.

...

> +	if (irq <= 0)
> +		return 0;

When == 0 is true?

...

> +static int xadc_device_configure(struct iio_dev *indio_dev, int irq,
> +				 unsigned int *conf0, unsigned int *bipolar_mask)
> +{
> +	int ret;
> +
> +	ret = xadc_parse_dt(indio_dev, conf0, irq);
> +	if (ret)
> +		return ret;
> +
> +	*bipolar_mask = 0;
> +	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
> +		if (indio_dev->channels[i].scan_type.sign == 's')

Wasn't that changed to format?

> +			*bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
> +	}
> +
> +	return 0;

Don't we have a specific for_each type of macro to iterate over all channels?

> +}

...

>  	irq = platform_get_irq_optional(pdev, 0);
>  	if (irq < 0 && (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))

Side note, this conditional is wrong. It doesn't handle properly deferred probe.

>  		return irq;

-- 
With Best Regards,
Andy Shevchenko


