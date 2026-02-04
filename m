Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2C41323C;
	Wed,  4 Feb 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214818; cv=none; b=n/X+KgvL8bDuXIdyW1FboVvIIqE6EcYCHfasyKzohhdIpal0bH9nlVfE7qv9KDyGa8r9RwddM7/taf17Q1dNPL+VmYFgN4F/qwKVR2R6gmeJYkkCMjdB59qo17FZUsKr8WXnpORLBBXtGyEvVHocXWBDUidem1rE+Ed+TqQsGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214818; c=relaxed/simple;
	bh=zmBwGLhDUiwZIdMPsi+sqb3oedtUAJYBCtug/uouMLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgiqHI4YNHCn8ycLs0pZBuHvhZFfsA2MAWpFV+XRnyYaCX9SZWYcWfX+VLhLCj3/1ifHCdRyCUrgCznmIZaNEo5t3IyoJxYTV3LsgJFvLGQ/jC3B7BJW43GVDFSbSPICIReRFZDwe8oBGGGhT9anvbrr9sJtVbLQ1zLucAlleTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ND+CsL/Y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ND+CsL/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770214818; x=1801750818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zmBwGLhDUiwZIdMPsi+sqb3oedtUAJYBCtug/uouMLM=;
  b=ND+CsL/Yag+ViWThYZJcD2wHJjbwh3AmI7RYW9h0fHG7TzDl2fcTp908
   Kt+JZSszU73cIM9KJlFLsA23jh7EylFpviBJFMT2cl4+Rhsb+o2VzcHK5
   3/h8dS2LQBPro7H9PxVS+1LMZ9ge375c0VrYBeGHYdTuO/d/nsEP5YNTB
   ZrBB+MKVRz/rLr5mllAKOzeCQKPXuCvc4gcEj+2MRX886amjRkebnR5bc
   zYvosC/5UVF95imGb1jkrWmumQ3uVHvwK+rswX/bd6o6DUGV2fFa5PwgV
   tF6LJqjmmpvnteiu/3zdii+fQF9xyZOA0X5Gp3AQiyX7d+EpwQMpY4ZtY
   w==;
X-CSE-ConnectionGUID: 55yduEiGQVmHDnR83OjQLA==
X-CSE-MsgGUID: yQqwwyejTriO0PH70G13+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="58977311"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="58977311"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:20:17 -0800
X-CSE-ConnectionGUID: j/YBXKVGRfmKYXOich9OPA==
X-CSE-MsgGUID: 7CWQkiL2RgaakwgpEt963g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210191980"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:20:15 -0800
Date: Wed, 4 Feb 2026 16:20:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 06/13] iio: dac: ds4424: use device match data for
 chip info
Message-ID: <aYNVndcMVRj3JsKL@smile.fi.intel.com>
References: <20260204140045.390677-1-o.rempel@pengutronix.de>
 <20260204140045.390677-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204140045.390677-7-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 03:00:38PM +0100, Oleksij Rempel wrote:
> Refactor the driver to use device match data instead of checking ID enums
> in a switch statement.
> 
> Define a `ds4424_chip_info` structure to hold variant-specific attributes
> (currently just the channel count) and attach it directly to the I2C and
> OF device ID tables.
> 
> This simplifies the probe function and makes it easier to add support for
> new variants like DS4402/DS4404.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
with a hope that we get rid an I²C ID requirement at some point.

...

> +struct ds4424_chip_info {
> +	u8 num_channels;

If you wish, you can provide name here that will go to ->name field.
Linker dedups string literals, so it will be just an additional runtime
pointer.

> +};

-- 
With Best Regards,
Andy Shevchenko


