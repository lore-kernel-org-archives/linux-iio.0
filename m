Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2A35979;
	Fri, 20 Feb 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595820; cv=none; b=Cm3zKOpOEXbpeIPvPsyRywEJJ6GKT939m1fQS911ooYLxqdAgJ3sXuv5A0AZ6M2y+kLM39ADUXLcvpYjnohWujbSswAcQS55lb+fQcL+VQVrkLzle3wH2R0Kz6tmVNOR8Zsh4S176sqNZeiLwdiXZqKeovu+8YzL7OJLf7kP5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595820; c=relaxed/simple;
	bh=YwFsm4FIQUskyd8676lcG6vAt1KiEic0QJKtFxcKl00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH++ZEHo7MwhoX4zoN//1esAoudUXDwncu0+OBEGsSFXq5ntKm1jgaVg9tD1kzBG2N5eq3GRJT31yIJqmCZjc8z32L3ANmiS0Mt3mFlYawgbJwRqcGJPqigjUQ6eeZzjdcMwGnrck/qp1xavoEvJow3dl44TwytAwLfFtOOYLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiUaqfyn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiUaqfyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771595819; x=1803131819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YwFsm4FIQUskyd8676lcG6vAt1KiEic0QJKtFxcKl00=;
  b=QiUaqfynGChPsw791ghAuduLn4SXvjRpP4NnLreHwc9d+vKj7a/dZkqk
   1RshoPjiylOf4xmQyOz7QEhVUfWF/2mqONQdkbsqwyS+b6zYmvfVQ/Qw2
   5Ykh0+DpT4lgsodf70MV6IEHbYxZJPcfbG+ah7p/riP1hNhYZICuxh3TZ
   BbTFLHTvzhqDRFxLrT0uWOnQzTfVK98SPkpcVyLTACCAKwmKZJdcP8hdW
   sMjj1BEyb2maZxXprn/YxnindtFR3dkWbeO6TJQ4JZeAojdo2hSZoyp7d
   6Q0QsFcmtH/KCPCluaF/4fojWM94d3hADZQNxekBYZ2AhDe7yUnoAt1sE
   A==;
X-CSE-ConnectionGUID: dDAqvfKWTA2Ta4tzh+ccRg==
X-CSE-MsgGUID: c/B7vBdjSKWSEgyuiPwcbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72749749"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72749749"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:56:59 -0800
X-CSE-ConnectionGUID: +rKToOEUTL2IBqnxd2pKxg==
X-CSE-MsgGUID: vCPLkQ5sShip0Peqgtop3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214710304"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:56:56 -0800
Date: Fri, 20 Feb 2026 15:56:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: frequency: adrf6780: use dev_err_probe in probe
 path
Message-ID: <aZhoJlYUzuHXSGXL@smile.fi.intel.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
 <20260220131151.74329-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220131151.74329-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:11:39PM +0200, Antoniu Miclaus wrote:
> Replace dev_err() + return with dev_err_probe() in adrf6780_reset()
> and adrf6780_init(), which are called during probe. This simplifies
> error handling.

...

>  	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
>  					 ADRF6780_SOFT_RESET_MSK,
>  					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
> -	if (ret) {
> -		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "ADRF6780 SPI software reset failed.\n");

Consider adding

	struct device *dev = &spi->dev;

at the top, so this line becomes

		return dev_err_probe(dev, ret, "ADRF6780 SPI software reset failed.\n");

(while at it, I would dare to drop 'SPI' from the message as is easy to derive that
 the device in question is connected to SPI bus.)

		return dev_err_probe(dev, ret, "ADRF6780 software reset failed.\n");

...

Ditto for the rest.

-- 
With Best Regards,
Andy Shevchenko


