Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F533C198;
	Wed, 15 Apr 2026 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246003; cv=none; b=a54TTIZ/heL7RIAI21UIjbkH9h98FXze5IRPYwFnfcNkDGqRBForILr5lQN74NqFsTAS1JMWdEeh9ipFaxOm9Vb6rHtDPcTNc3KAcc10PDFkbVhi9B8KHfFlN+e5a68O6JYHv1Ojxf6Ou5Yj1LpQq2FtH58OfG1DzzGO6fIDHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246003; c=relaxed/simple;
	bh=q28b4SCu//B4/jIvdGx4TWflMBi3wvwvy/2fKQ4WXgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia0tkpkUXmDCJclCmOI5nuvCw3vDUP4BGWlzh0BAwxDxc6XiCncDaqQVHLGx09FpIzihp0poYNEcxb1ONbGRafzPS8Hx//OVzl57vyRIpDHD+4dv/fx5slWhP8Lh671YwOYNUfTrR7XgS9FH4jqbsoi6Ael7DuDvCYyyGWKUs4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLi0I5sx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLi0I5sx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776246002; x=1807782002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q28b4SCu//B4/jIvdGx4TWflMBi3wvwvy/2fKQ4WXgk=;
  b=dLi0I5sx1KrCl7uTju479kbnhUqj4A/Rw85WQHqONT7puf6VL0FUfsVG
   +cuwqWoZ7gCZoWfKT8GYrylOVKSjOnvjKgFG5tpM+J4dw2oVt3keAaAmU
   u3agkAy7+Y4Q/c8TyG4U6vfXBNhQ1rSY81A78dJYbCbeCy07CO0BnA37y
   OadTAIZHYC7W0R6J2+kMUpX7RjnSQh7TMF+HJc4t4dBdDr5FoXGuhITaC
   A4BYIGZd3SKTlV/EMoEefQrwPxNh7SlHgZvRXI3smgq+APDPD4Clu3p8b
   bxw0ikwnp/ToPJTBikn6X2ffCkE2rndo/6R7DGIaeKff0WtpRU/cUDELD
   Q==;
X-CSE-ConnectionGUID: /hjvot0DRC6xQJPl3ZwhmQ==
X-CSE-MsgGUID: 7sJx/FV3SlS+KGq68cOAAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77124049"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77124049"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:40:02 -0700
X-CSE-ConnectionGUID: hDfVgCtVToWPFCqF4A4Uxw==
X-CSE-MsgGUID: bwcTg9czRHSjFUO1BsY02w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230598309"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:39:58 -0700
Date: Wed, 15 Apr 2026 12:39:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: ssp_sensors: Use dev_err_probe
Message-ID: <ad9c7JT-ES7f2Nbi@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
 <20260415050749.3858046-7-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415050749.3858046-7-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 10:37:48AM +0530, Sanjay Chitroda wrote:

> dev_err_probe() makes error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).

...

>  	struct ssp_data *data;

While at it, introduce a temporary variable

	struct device *dev = &spi->dev;

and reuse it below. Note, you may add a new patch to reuse it in the lines that
are not related to this patch but may utilise the local variable as well.

Actually, you can introduce it earlier in the series, exempli gratia when you
moved probe to use managed resources.

>  	data = ssp_parse_dt(&spi->dev);
> -	if (!data) {
> -		dev_err(&spi->dev, "Failed to find platform data\n");
> -		return -ENODEV;
> -	}
> +	if (!data)
> +		return dev_err_probe(&spi->dev, -ENODEV,
> +				     "Failed to find platform data\n");

		return dev_err_probe(dev, -ENODEV, "Failed to find platform data\n");

(And you can leave it one line as trailing string literals are fine to be
 longer 80 even in strict mode. You may even double check with checkpatch,
 it won't complain.)

...and so on...

...

>  	if (data->fw_dl_state == SSP_FW_DL_STATE_NONE) {
>  		ret = ssp_initialize_mcu(data);
> -		if (ret < 0) {
> -			dev_err(&spi->dev, "Initialize_mcu failed\n");
> -			return ret;
> -		}
> -	} else {
> -		dev_err(&spi->dev, "Firmware version not supported\n");
> -		return -EPERM;
> -	}
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Initialize_mcu failed\n");
> +	} else
> +		return dev_err_probe(&spi->dev, -EPERM,
> +				     "Firmware version not supported\n");

I would now negate the conditional and drop redundant 'else'. Also note
the missing {} in the 'else' branch as per Coding Style.

	if (data->fw_dl_state != SSP_FW_DL_STATE_NONE)
		return dev_err_probe(dev, -EPERM, "Firmware version not supported\n");

	ret = ssp_initialize_mcu(data);
	if (ret < 0)
		return dev_err_probe(dev, ret, "Initialize_mcu failed\n");

-- 
With Best Regards,
Andy Shevchenko


