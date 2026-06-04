Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1353B8D5C;
	Thu,  4 Jun 2026 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557485; cv=none; b=Z0Z9ywcUoz+XhBWp16q+Wc9FhC0HezylUchBehbrCkOCmPkdJaX6r37O2RZZFGlqIHTfusTUcZQzbd9loBteIErhx5/XkLTz6KveawrQUGLJb/5Z3d+0Q1Q/b6+NgVb8eP2U1ebyBPQQZXqYIm9SQjMdKH+2n9+C1UzxVrdNsp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557485; c=relaxed/simple;
	bh=RqcXuJvYAFt2+iRQE5KNL1qoAip4We8+XF+OHMLdvz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeqlMtrLdhmAj0TEeb6b4V0D5pRbZHXCqF3BAJm80FF7awG07ItB+cm6CL6eEKhyaCWPRPUQEVN3GTRuVfPI2+J2l1yYI/k3oBuXX3zs/aX2ciQ904bMTMFGIQbjcpgHFb5fAX906qhjyMkrznIe4cSZuBgE4OaSLUW9dEVYAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0fGUSES; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0fGUSES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780557484; x=1812093484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RqcXuJvYAFt2+iRQE5KNL1qoAip4We8+XF+OHMLdvz8=;
  b=d0fGUSESnPCVf0RMfc2lw2qeXn2VPJs9OmuZUV3G5PeoQpY3echUItli
   PoDXtGZoMWEEwTwaFzTEHHFdZAYHQXzKkL+guCxcnE3oN8sOFluWB1Xbc
   0vk4yrocnYqut6e2jhmbZERAYUA1HKIoxjUTnjE2E2DLruDE52/l7Opmz
   BE10vGx78hlMCTLtF1INIcZF8aYSK6CfNks5s/qSb9ZRsAP690YdspdTd
   lO6KnPe4QZ2MzxfC6T7BdBEhATgpA6shcZfBUvGIoqEzWXLtKyVe4aV2J
   YJCzBhRo2svqURhvzwOruE56u4sxDE7hhCoL2Kwodqex4pNkO84pxDFfs
   g==;
X-CSE-ConnectionGUID: FVdG4d+uQ2Gkt97cuYJKhQ==
X-CSE-MsgGUID: mKmU+MfRQaaO8jEZ+Odzlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92064009"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92064009"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:18:03 -0700
X-CSE-ConnectionGUID: 7Y7LKIr2SH2cwfN6VrPyLQ==
X-CSE-MsgGUID: qiNvkXOBRyaSOn7x/gvFHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241966936"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:18:01 -0700
Date: Thu, 4 Jun 2026 10:17:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, masneyb@onstation.org
Subject: Re: [PATCH 1/1] iio: light: isl29018: support cover-glass gain
 compensation via DT
Message-ID: <aiEmplRsQnvlacCD@ashevche-desk.local>
References: <20260604054723.2983181-1-github.com@herrie.org>
 <20260604054723.2983181-2-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604054723.2983181-2-github.com@herrie.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 07:47:23AM +0200, Herman van Hazendonk wrote:
> Boards that mount the sensor under a tinted or coated cover glass need
> to compensate for the optical loss before downstream consumers can map
> the reading onto a useful lux range. The driver already exposes a
> runtime knob through in_illuminance0_calibscale, but every user has to
> re-apply it after every reboot (or rely on a board-specific udev rule),
> and a power-of-two cover gain like 100x is a hardware constant of the
> board rather than a policy choice that belongs in userspace.
> 
> Add an "isil,cover-comp-gain" device-tree property that seeds calibscale
> at probe, mirroring the pattern tsl2563.c already uses for the same
> class of problem (amstaos,cover-comp-gain). The default stays 1 so
> existing systems are unaffected, and userspace can still re-tune via
> the sysfs attribute afterwards.

Haven't DT schema patches needed to go separately?

...

> +	/*
> +	 * Allow boards that mount the sensor behind tinted / coated cover
> +	 * glass to bake the optical-loss compensation into firmware via
> +	 * "isil,cover-comp-gain", following the precedent set by
> +	 * tsl2563.c. The value seeds calibscale (default 1), so userspace
> +	 * can still retune through in_illuminance0_calibscale.
> +	 */
>  	chip->calibscale = 1;
> +	device_property_read_u32(&client->dev, "isil,cover-comp-gain",
> +				 &chip->calibscale);

With

	struct device *dev = &client->dev;

at the top of the function this will be made shorter.

Additionally the above approach won't be accurate when property is present in
DT but by some reason can't be retrieved. It will puzzle the user. That's why
the robust approach is

	struct device *dev = &client->dev;
	const char *propname;
	...

	propname = "isil,cover-comp-gain";
	if (device_property_present(dev, &chip->calibscale)) {
		ret = device_property_read_u32(dev, propname, &chip->calibscale);
		if (ret)
			return ret; // optionally dev_err_probe()
	} else {
		chip->calibscale = 1;
	}

Taking the expansion of this pattern we might need to actually introduce a full
set of device_property_read_*_optional() to make this churn less required.
Perhaps for v7.3.

-- 
With Best Regards,
Andy Shevchenko


