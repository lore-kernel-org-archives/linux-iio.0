Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC339FCC3;
	Mon, 16 Mar 2026 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674521; cv=none; b=lC6TTUH8cP2CRLbIhWIHpDmpp7sNU+0O8x7AMkEAUPfqi7f+rTojMoMACNyCj66JAgz9642F6WJzu6BVYocVnG/Tp1ar09oGHa5aTszXWIVZKxyhBNLwGW8ZD08fj6nMQUbpCF8sO3DEaaG76mQCFRiQfs6sMrYo8vaLpSI8UQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674521; c=relaxed/simple;
	bh=l+1lS9IF5T52QWS47Q7ZCCsSP6rjXnGtQfIhuOPX8ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW1kwpn1nEJFr5zm/ODZFxHLl5OXZ8SyWKjWDWz8ktA7rafbOyqwC+kTOzLuXtoyEPU7i2fGbrHLfkVKDU92PHx+HqAnqde+/ldz/0VX2giBxNqe4wFkl3bg39yUjl8ikgYNiQH/gUurbYi29KZQCSXkQAlO3Z7rd29v+11/4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PylupEUu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PylupEUu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773674520; x=1805210520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+1lS9IF5T52QWS47Q7ZCCsSP6rjXnGtQfIhuOPX8ps=;
  b=PylupEUumxqeln//o8PXaxY1E8MCCfJec7n7n/qmns+wHRqLfHqVPmKo
   4tbRS1jseYU+jNBOT50Cs5jL10iOZW+oGxXkFTIHBV4rdZAv2A4tAQHL9
   0UuRAHb97A2S874Dfu79kxXtJCk6GAnV9Y+jd56wxJRZBbWnycy61YMxR
   xuSYNaI4SfNFFlJ7MxC2bl4949t5wm8gUQeb17466tYJsD8CIqlBBr9Xt
   DXwXuWVsvSzFPyhu0PcRY2IpAZIQrssU9K3nco9piBkI5N8qPuh0IFEXM
   OLYmP9LFqg4ZvuYmrvvPQPgJxJlnrH7WkPufJ49qoRKT5GmRLZPwNPFd0
   Q==;
X-CSE-ConnectionGUID: tKiLapplQGGw7NY2r9CzMw==
X-CSE-MsgGUID: oVRZseikSsOOd9CZPY4MiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85774902"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85774902"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:21:59 -0700
X-CSE-ConnectionGUID: 0M1XwILvTvmgrDhBjceGOg==
X-CSE-MsgGUID: JHKoCYvFQpe7XGWvoneryg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226077072"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:21:56 -0700
Date: Mon, 16 Mar 2026 17:21:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, cosmin.tanislav@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: ad4130: Add SPI device ID table
Message-ID: <abggEE6RPkMZlgrs@ashevche-desk.local>
References: <cover.1773311639.git.Jonathan.Santos@analog.com>
 <63f625f4f19c33f937bace7a37b921a0e4810559.1773311639.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f625f4f19c33f937bace7a37b921a0e4810559.1773311639.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 08:45:26AM -0300, Jonathan Santos wrote:
> Add SPI device ID table to enable non-device tree based device binding.
> The id_table provides a fallback matching mechanism when of_match_table
> cannot be used, which is required for proper SPI driver registration.

...

> +static const struct spi_device_id ad4130_id_table[] = {
> +	{ "ad4130", 0 },

No ', 0' part, please.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


