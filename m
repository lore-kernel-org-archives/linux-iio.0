Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561938F942;
	Mon, 16 Mar 2026 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657582; cv=none; b=HC6YPwzOUwZF4zvubuP1ZHMqb+ribDPaWds5h8LC/dN2nWK6ICOHXA6mbMIPtHWuc3W164SquIBPcOnMBtqK7o7Tw5zFiiSaTWcWKUjKkqjzzINjqf5qKWppfRV8HCmZHlb9+T+yA0dySTQTENDIXi59VvGYbq5FeenQLy+HK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657582; c=relaxed/simple;
	bh=J7u7Jxh7FWsnahqlm3HxAUpyLd5ql8vaBNir2aETvIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTJMo4xsy9CAw3Io9S2EJu9vB9SmhcR2SLP8adGzk4a7Rw4hpvFDKVxwhMl+w2ueWv+hAPjdzADUAuI3n9NzpLfh+m2gouBeRKQIOcGEPI+JjgAKWCFUeECbCeRgPB1v9hQ9trd6LWxCnMqWejeS8XVQHS1QjXzWPMh41jQdMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iv//iIuS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iv//iIuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773657581; x=1805193581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J7u7Jxh7FWsnahqlm3HxAUpyLd5ql8vaBNir2aETvIs=;
  b=iv//iIuS23HZXxWrgsynhHsGffhEBs5GcVn7JrHRqvE0JKIHWc4yztT4
   Q1VijlSQuWmA+5HLPIwpjrFy+SrK//93XWgqoqGMLuMSlH580aDu1O4+g
   en5K/koPDUV/bng7zyVPjwX4OzbinWPXt3Lhzya5DPhQzZR15cm9U1Dj9
   SgdKkagXcbT+kOU8Vvm7c2HhgEXzSbJdwuT9dcidk5xPYJqCcOkXn+z4b
   2tkXa4iTBa3D8DaAJg8DASJN/53JDmnYuQ3li+/ZRTOZ1vplWSXu4CvxY
   l1HQ7Bcvu/SS/aNwY3ARMWm1EF1m45tB7o/RTfbJ8E0IYXrEKCl3rbfF2
   Q==;
X-CSE-ConnectionGUID: x5ycXrPxRVOZkpELRGN/ug==
X-CSE-MsgGUID: FJoq3K+DSTmVMZPXcAOxgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74784297"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74784297"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:39:40 -0700
X-CSE-ConnectionGUID: i80MBCpkTr+/9IC5hOeAVA==
X-CSE-MsgGUID: XtiiTIkuQoWG3kWafMZqGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226546584"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:39:36 -0700
Date: Mon, 16 Mar 2026 12:39:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: light: vcnl4000: use variables for I2C
 client and device instances
Message-ID: <abfd5pLsCuPK4lV3@ashevche-desk.local>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
 <20260314-vcnl4000-regulators-v3-6-3c4a48d30676@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-vcnl4000-regulators-v3-6-3c4a48d30676@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 06:06:35PM +0200, Erikas Bitovtas wrote:
> After moving data->client and client->dev into variables of their own,
> replace all instances of data->client and client->dev being used in
> vcnl4200_init and vcnl4000_probe by the said variables to reduce
> clutter.

...

> -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
> +	ret = i2c_smbus_write_word_data(client, VCNL4200_PS_CONF1,
>  					regval);

Now it's perfectly a single line.

	ret = i2c_smbus_write_word_data(client, VCNL4200_PS_CONF1, regval);

>  	if (ret < 0)
>  		return ret;

...

>  	regval = ret | VCNL4040_CONF3_PS_SAMPLE_16BITS;
> -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
> +	ret = i2c_smbus_write_word_data(client, VCNL4200_PS_CONF3,
>  					regval);

Ditto.

>  	if (ret < 0)
>  		return ret;

> -	if (device_property_read_u32(&client->dev, "proximity-near-level",
> +	if (device_property_read_u32(dev, "proximity-near-level",
>  				     &data->near_level))
>  		data->near_level = 0;

The 'if' is redundant, I think you can drop it at some point, probably to avoid
churn in the follow up

 -	if (device_property_read_u32(&client->dev, "proximity-near-level",
 -		data->near_level = 0;
 +	device_property_read_u32(dev, "proximity-near-level", &data->near_level);

Assuming data is allocated with kzalloc() or equivalent.

...

> -		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  						      NULL,

Now NULL can be moved to upper line.

>  						      data->chip_spec->trig_buffer_func,
>  						      data->chip_spec->buffer_setup_ops);

-- 
With Best Regards,
Andy Shevchenko


