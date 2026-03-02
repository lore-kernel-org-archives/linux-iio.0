Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118F3CC9EC;
	Mon,  2 Mar 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456386; cv=none; b=eiZW4ZffzqObY9YyQOI1KlKTJVY5TkuTDm2Wd8xi03nxxagl/whm97NgY9mkqD467x5I/chVY5asccuhDkdRMERViOI4SFrKdVL8DdDvo9b8LE4oOh+vqfW5LDvdeET5YISZOa/lUeSK4WLpI9aeF5L8fUy0t3ACJTG9gpdQ5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456386; c=relaxed/simple;
	bh=ljJtBY6uljOIJQHVpnbu7icxOo0mn3WO/aJQNWhtJxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsgBjD7x0/op9s4/PNAQW96toY6B5khZqSEvIEeO94GrQp/uL/zx48xGjwaxCFZwMMuHfOHfE5Cs+wBuqz91wsydgGyOXf9heaWmcACC+rfnRiH5Hk/b1o1N419S+Ki8D82OUQJKbL45DSD8AztPfvanE+eLax4eqs1L+Ixkt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7tqQYEy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7tqQYEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772456384; x=1803992384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ljJtBY6uljOIJQHVpnbu7icxOo0mn3WO/aJQNWhtJxQ=;
  b=T7tqQYEy9XaUqpfAQz/KzcA716VrwHN3u7LL1JWis1digWna/zJNZzPz
   +CR8WUoDlQSorN4p8GDMNewKiQf3cYWaH6SjZsR0sGBNTmVvmTGz2vvCn
   WpVnzh/6YpqikpDCgcUqDbhSW6DvLudO7dgqNDcGbNC0eyERFE6n6wmpo
   OZIS5Ohta7DrzQn4/05w2foL5/dJ+c9bZUpRwrWBH+T2E7rUYaTxtTJVA
   Jr+ocqPLG7HhkTN+ue88TuXv2mWCujnoHXLUBiUqm2MVeq2aIkMWX06HW
   lugRmClj8Zy9fpR19zr+dL97oL6mLLugP+X49u8yRh8pBstFrBFQ1vNom
   A==;
X-CSE-ConnectionGUID: 3fJFxkjBTMWGFAlExIJhMw==
X-CSE-MsgGUID: haqPCtiKTw+UFKuG0xdFVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84927919"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="84927919"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:59:43 -0800
X-CSE-ConnectionGUID: q7CfcWl0SxqBe1GtemvYcQ==
X-CSE-MsgGUID: g5mZC3fcQTmhyeGZgHE13w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="222281212"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:59:39 -0800
Date: Mon, 2 Mar 2026 14:59:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: accel: adxl372: introduce chip_info structure
Message-ID: <aaWJucx5VY38Qtqp@ashevche-desk.local>
References: <20260302122116.1282-1-antoniu.miclaus@analog.com>
 <20260302122116.1282-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302122116.1282-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 02:20:57PM +0200, Antoniu Miclaus wrote:
> Introduce a chip_info structure to parameterize device-specific
> properties such as ODR/bandwidth frequency tables, activity/inactivity
> timer scale factors, and the maximum ODR value. This refactors the
> driver to use chip_info lookups instead of hardcoded values, preparing
> the driver to support multiple device variants.
> 
> The sampling_frequency_available sysfs attribute is changed from a
> static const string to a dynamic callback that reads from chip_info,
> and the SPI/I2C probe functions are updated to pass a chip_info
> pointer instead of a device name string.
> 
> No functional change intended.

...

> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
> +static ssize_t adxl372_show_samp_freq_avail(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	int i;
> +	size_t len = 0;
> +
> +	for (i = 0; i < st->chip_info->num_freqs; i++)

> +		len += scnprintf(buf + len, PAGE_SIZE - len,
> +				 "%d ", st->chip_info->samp_freq_tbl[i]);

This is part of sysfs, use sysfs_emit_at().

> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(sampling_frequency_available,
> +		       0444, adxl372_show_samp_freq_avail, NULL, 0);

What's wrong with IIO_DEVICE_ATTR_RO()?

>  static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
>  		       0444, adxl372_show_filter_freq_avail, NULL, 0);

Make sure this is closer to its callback(s).

...

>  static struct attribute *adxl372_attributes[] = {
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,

>  	NULL,

Side note: At some point consider dropping trailing comma in the terminator.

>  };

-- 
With Best Regards,
Andy Shevchenko


