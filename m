Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328483;
	b=iWTk5BoijEKBW3VrrhM9kt11GCMKCtkgU+lpzPAEVEyjYEu5pQtFWvmysl7aNb3Eb4Fs
	 8xBfLl0eDiy9opwC/8pSrCH4CxuSXDHfm9bFwL0CIiYKWMqC6Qvp05BKwoCQwx6KSqfgA
	 jy3js4GlRhsHnD/SJidoxCnzfzs5vTG9RJQ0bGRcJMvsTd+B2OrIffXxR1XOsJFn0ZOyG
	 0n8m4YhLN5FHaJdvBRmxPvxjHpkBo4mSzhOUCK99tLCQ5X/Ku6xYaju49ZCrtz5EI3lVR
	 eR2mKxKLf8I7RBrwPsVe1LjmKZ1lj90xw3NaRoySLP6YbjXYFKf3C57HXnN9Z5Ptxlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328483;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=A/5LL2oP+jZw6FK1LnyXF4yA4UCBdbE9fOMI+QqDcr4=;
	b=ohvuQ74HSQOR+NUt2xJCWFDzDR/rWOOZaPAA8LVH6INvev6rJ9hPIpylQOMrBlJGtUCN
	 k2Qpa/CKMv8EkYS3oub1hODDFqVA8b9xN2cwGGKRbZL6fwUxdJxZoK+aQ77jsxFGblLtg
	 KliM3uwq1/8DPY6FaDwh+vIHVvHDmySHHxXVGIQmZ2G073BvCUnJJBuxofa9TTDQKQzd4
	 lOuYlmC0YSfm1PHX8C9fV2n/xKaYajqUcMJoX/DEF8ZVzBQDiKuKMSSUj9rEcAMiCLQ+L
	 oYP9DIaN9wScww2hX2Zo9HSkiItAEqrgl3dfrN+WKZ2yBKeUZOOyLtLB501uwFmnQlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rkv4JPct;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C6606A205;
	Tue, 10 Nov 2026 16:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D2C6606A205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rkv4JPct
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794328482; x=1825864482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=62tf4jRuBAhAw6YJUn1Bb7RvCWjFNxKFAHNol+T/IT0=;
  b=Rkv4JPct00/26/YOS2cK1WBkM9XyYe+Gp2gA5vSE9P8OByRlKEbeBUlO
   bzF9uy2UeotZNyJCibxVo1AVQ2We79eW5ZJJHJ1zr5pP9HYVgKh7tEiQT
   xF8gI9i1P68COMOFRSek1lPrls7P8S0oKvRyTwWVyBJHHNY3ThS1gIhmi
   RCaPhGtZCvDcYkhaIaiEb0kT5zapitt76HaT6RsUfQVHdLZB/yfGR/nJU
   u4fwA7dPlTTxvAgedQAIwP6PS17nAHbnP9bLz+G9xxsDmcdxHgwyIn21N
   PIbDsHY7yd8JDIo59hj1GJuPUDKjICputJvxWuQKcXDa+McBLloC90Qay
   A==;
X-CSE-ConnectionGUID: CE+w0Lv0TM6W6ebYvDZ1Mg==
X-CSE-MsgGUID: kSlkoRDkTDaGn2msKAaSKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2974631"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2974631"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:34:42 -0800
X-CSE-ConnectionGUID: jGJAXPcdRle/P09ygKzg3g==
X-CSE-MsgGUID: 4EeMYk2fRkuNsMxdZCUkTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8629844"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:34:39 -0800
Date: Tue, 10 Nov 2026 18:34:35 +0200
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
Subject: Re: [PATCH v5 16/16] iio: adc: xilinx-xadc: Add I2C interface support
Message-ID: <avNHmwYFsrpN99Nt@ashevche-desk.local>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-17-dileepkumar.nagavarapu@amd.com>
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
In-Reply-To: <20261110050201.1850399-17-dileepkumar.nagavarapu@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:32:01AM +0530, Dileep Kumar Nagavarapu wrote:
> Add I2C interface support for Xilinx System Management Wizard IP along
> with the existing AXI memory-mapped interface. This support enables
> monitoring the voltage and temperature on UltraScale+ devices where the
> System Management Wizard is connected via I2C.
> 
> Key changes:
> - Implement 32-bit DRP (Dynamic Reconfiguration Port) packet format
>   as per Xilinx PG185 specification.
> - Add separate I2C probe with xadc_i2c_of_match_table to handle same
>   compatible string ("xlnx,system-management-wiz-1.3") on I2C bus.
> - Add NULL checks for get_dclk_rate callback function in sampling rate
>   functions to support interfaces without clock control
> - Create separate iio_info structure(xadc_i2c_info) without event
>   callbacks for I2C devices
> - Add xadc_i2c_transaction() function to handle I2C read/write operations
> - Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI
> - Defer XADC hardware initialization until first device access, since the
>   I2C path reaches the PL SysMon indirectly through a platform controller
>   DRP bridge that may not yet be operational at probe() time. Initializing
>   on first read/write instead avoids probe failures caused by transient
>   unavailability of that downstream path.

...

> +struct xadc_i2c {
> +	struct xadc xadc;
> +	struct i2c_client *client;
> +	bool hw_initialized;
> +	unsigned int conf0;
> +	unsigned int bipolar_mask;
> +};

Have you run `pahole`?

...

> +static int xadc_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	unsigned int conf0, bipolar_mask;
> +	const struct xadc_ops *ops;
> +	struct iio_dev *indio_dev;
> +	struct xadc_i2c *xadc_i2c;
> +	struct xadc *xadc;
> +	int ret;
> +
> +	ops = device_get_match_data(dev);
> +	if (!ops)
> +		return -ENODEV;

-ENODATA

> +	indio_dev = xadc_device_setup(dev, sizeof(*xadc_i2c), ops);
> +	if (IS_ERR(indio_dev))
> +		return PTR_ERR(indio_dev);
> +
> +	xadc_i2c = iio_priv(indio_dev);
> +	xadc_i2c->client = client;
> +	xadc = &xadc_i2c->xadc;
> +
> +	ret = xadc_common_init(dev, xadc, ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = xadc_device_configure(indio_dev, 0, &conf0, &bipolar_mask);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup the device\n");
> +
> +	xadc_i2c->conf0 = conf0;
> +	xadc_i2c->bipolar_mask = bipolar_mask;
> +	xadc_i2c->hw_initialized = false;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

> +MODULE_IMPORT_NS("IIO_XADC");

> +

Unneeded blank line.

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>");
> +MODULE_AUTHOR("Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>");
> +MODULE_DESCRIPTION("Xilinx XADC I2C Interface Driver");
