Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D737756E;
	Tue, 24 Feb 2026 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928199; cv=none; b=WMj8uVqG/esYDPrhg7ymUuS5ef2SDEJ5z5aGPl4kyaFyrxduwefWjqly/VV3lJmAykteJmfB8RTbAhjMp/ZyFXFBjXbqpifiFCrJgKhiG4oV5JHh/2IKa7xnWgVVdSCqr6Gg9+tJCNLDjM4oGZiarZNp5LV4sLgZptPW6IscU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928199; c=relaxed/simple;
	bh=m8ff2shhJccasRLgD+QQTq6ROWzFca+Hmau1lsl8phw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjW2Eh4jWnhuZmjyBc/Rdyrr7AoYY8+ZFjdAMY5AEPfLmNdYusd9X6dYWztIPYOZCloCtsdlcROlxq6bAvbnYXTDvjUaYap0HYv3Hx69cJt5Svi3tIgRZRKFOqJce+9wLhjfUGGj0Whmh82M84kHxq0cgxW0jyyUAceN5HJrvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWvmoQmI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWvmoQmI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771928197; x=1803464197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m8ff2shhJccasRLgD+QQTq6ROWzFca+Hmau1lsl8phw=;
  b=TWvmoQmIhC8XS0ZPM5DzdQ9d29WIb2aalFr7d0PnvCH54O+SBKAzGP+6
   ygzXOaVfRjxzW9YJTvimqhpmNpzE6Twrexuz6vyAo4Ni6t28K5e7aZnr2
   Ewg36dRMxll5XVAu7HKrEwNuUW90Ofhn++b1/CpmRnmMC8RAueP29hqnj
   ALbv3qDsV0vb3Kng/ZvEJKqglZQiqzxoHiDANdi59pm3Q45DmFpUgT2Ke
   k40ZvZZIr1KFqHfPt/IUqVDoiTdxvTARDOpZxYF4XVDW5J3rqpQOaQCI4
   z4Y8g2hSqCL+WUljt1x5nXVfkBI0oL2kQy2tbMilC/GK08X0AALtMT94y
   w==;
X-CSE-ConnectionGUID: 34JANNkXROmgqbdmrQ2+Gw==
X-CSE-MsgGUID: OGRD1MdATlGgfm4L14SzJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76800523"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="76800523"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:16:36 -0800
X-CSE-ConnectionGUID: h0i4XBDcRFuycxVGSdYwRQ==
X-CSE-MsgGUID: IfOB8CZiRvOGKBwtFylOxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220430925"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:16:32 -0800
Date: Tue, 24 Feb 2026 12:16:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: backend: add devm_iio_backend_get_by_index()
Message-ID: <aZ16flZ1Hx_JQX_O@smile.fi.intel.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
 <20260223162110.156746-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223162110.156746-4-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 06:21:02PM +0200, Antoniu Miclaus wrote:
> Add a new function to get an IIO backend by its index in the
> io-backends device tree property. This is useful for multi-channel
> devices that have multiple backends, where looking up by index is
> more straightforward than using named backends.
> 
> The new function directly uses the index to find the backend reference
> in the io-backends property, avoiding the need for io-backend-names.

...

> +static struct iio_backend *
> +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
> +				       struct fwnode_handle *fwnode,
> +				       unsigned int index)
>  {

> +	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
> +		fwnode_find_reference(fwnode, "io-backends", index);

Better for maintenance to have this near to the check.
It will narrow down the scope as required, in case more code appear in between.

>  	struct iio_backend *back;
>  	int ret;
>  

(yes, the above blank line is fine)

	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
		fwnode_find_reference(fwnode, "io-backends", index);

>  	if (IS_ERR(fwnode_back))
>  		return dev_err_cast_probe(dev, fwnode_back,
>  					  "Cannot get Firmware reference\n");

>  		if (!device_match_fwnode(back->dev, fwnode_back))
>  			continue;
>  
> -		fwnode_handle_put(fwnode_back);
>  		ret = __devm_iio_backend_get(dev, back);
>  		if (ret)
>  			return ERR_PTR(ret);
>  
> -		if (name)
> -			back->idx = index;
> +		back->idx = index;
>  
>  		return back;
>  	}
>  
> -	fwnode_handle_put(fwnode_back);
>  	return ERR_PTR(-EPROBE_DEFER);
>  }

...

> +static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
> +							 struct fwnode_handle *fwnode)
> +{
> +	unsigned int index = 0;

Better to maintain when assignment is closer to the real use. See below.

> +	int ret;
> +
> +	if (name) {
> +		ret = device_property_match_string(dev, "io-backend-names",
> +						   name);

This can be located on a single line (it's only 82 characters long).

> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +		index = ret;

	} else {
		index = 0;

> +	}
> +
> +	return __devm_iio_backend_fwnode_get_by_index(dev, fwnode, index);
> +}

-- 
With Best Regards,
Andy Shevchenko


