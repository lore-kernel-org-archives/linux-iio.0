Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DA3D6CCF;
	Thu, 15 Oct 2026 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089709; cv=none; b=Od1Bx2tYxtVf6tR1QXOKGlT6ZExrOUVUZdCO/IQHKUv/zQco+vkkd9WqsDfIlNtf9VgVZhLdeZFPoXNw2By8EJkwu9KnZJlnY9MQorddDtLW9hrXlqwz5awlDZ98ZOub+0URkOfx0KPqd0StDlc2C1XUsih3nPMxlnGdPl/kBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089709; c=relaxed/simple;
	bh=m8N3+5cR3Lgd93wxfdvA9OwDbvRJdyGpsxTIuxZx3FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvq6vK/ZNqehHMWkrCenkiZ60bT9q7J3FE2mPnmXATruhihQgKbfdW1KWD7vi8M8W64fhnTvcXIwo1EUXDql7sG20c3PoFXT/OkASee0JP3p6CWkdLgziMp5fvwF9Lk46E9XBai6ECfiaAEGkMB96GZylqw8UK3cSOdLku5OAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDHk8GVC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDHk8GVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792089708; x=1823625708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m8N3+5cR3Lgd93wxfdvA9OwDbvRJdyGpsxTIuxZx3FA=;
  b=IDHk8GVCUnevp92D2+372v9c7xjWD3yGjDtl1SJc579XLN6riLq0e4Db
   9YK1BE/HhsatgvxjIk1DJQja/MrIQu4nzOJniA5QlMPHze0wHq3YA7/li
   zqulCB48NCiPk0gZK1FVvY/vf8XIsvkCP0+67dmjwqv8d9ykXiPMdqRqx
   Hl2nuBQ3pV2iT806i+r5E65+qeQlbL/Dyu7aoo3FsKpRKt7ZbB3VMOy3I
   QfFe79nOMLP0lJVLGLJVsR9G2lJHiYREBhIukdjJnE2lQBDM0JjrJUWA0
   LuBKuvOk23Pm4/+EJ/ZN3DIXNzhP5a3sULsYDb346/ivuQuUkeN0ApW5t
   w==;
X-CSE-ConnectionGUID: gT6IkueXTwWjWbr1v+1XJw==
X-CSE-MsgGUID: lDIa9KVRRxu8+/hAwX68ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="881307"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="881307"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:41:46 -0700
X-CSE-ConnectionGUID: Q9r+r6TDRm+2gcMiJ7B0DQ==
X-CSE-MsgGUID: L8ICcmHiSDufiUiNDQjCBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2081424"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:41:43 -0700
Date: Thu, 15 Oct 2026 21:41:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 02/10] iio: backend: add devm_iio_backend_get_optional()
Message-ID: <atEeZPOLASHAcnjF@ashevche-desk.local>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 01:49:42PM -0300, Rodrigo Alencar via B4 Relay wrote:

> Frontend devices might not need a backend driver to rely on. An IIO device
> that supports backends can behave differently when they are not available
> and that should be acceptable. Such parts may provide basic functionality
> solely using the control interface (SPI for instance), being able to have
> extended features when a backend is present.
> 
> Add devm_iio_backend_get_optional(), which returns NULL when the backend
> is not described in firmware, i.e., when the io-backends property is not
> present or, for a named lookup, when the name is not listed in the
> io-backend-names property. Other errors, such as probe deferral, are
> still returned.
> 
> To make that possible, a named lookup that does not match any entry of
> io-backend-names now fails with -ENOENT, the same error returned when the
> io-backends reference is missing. Also, the missing reference is no longer
> logged as an error, leaving that to the caller.

...

>  	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
>  		fwnode_find_reference(fwnode, "io-backends", index);
> -	if (IS_ERR(fwnode_back))
> +	if (IS_ERR(fwnode_back)) {
> +		/* not described in firmware, let the caller decide what to do */
> +		if (PTR_ERR(fwnode_back) == -ENOENT)
> +			return ERR_CAST(fwnode_back);
> +
>  		return dev_err_cast_probe(dev, fwnode_back,
>  					  "Cannot get Firmware reference\n");
> +	}

Simpler to do is just to add

	/* not described in firmware, let the caller decide what to do */
	if (PTR_ERR(fwnode_back) == -ENOENT)
		return ERR_CAST(fwnode_back);

just before IS_ERR() check.

...

>  		ret = device_property_match_string(dev, "io-backend-names", name);
> +		if (ret == -EINVAL || ret == -ENODATA)
> +			return ERR_PTR(-ENOENT);

No. Please, use device_property_present() instead.

>  		if (ret < 0)
>  			return ERR_PTR(ret);

-- 
With Best Regards,
Andy Shevchenko


