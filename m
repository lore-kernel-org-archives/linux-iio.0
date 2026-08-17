Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7F3B5E10;
	Mon, 17 Aug 2026 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965334; cv=none; b=tj/IcJGePmfB5eIEHyu5xNKlR5W3pkm/KskdlfqV68MrIrtEu9MEgKbtcg6ZgY+A6hSWEWunO4krA7LOH7N7zQBptuUcnOeimshDMheXgo2/kYI5eErw8RTNHvJEZn5+IOVFrSuP8BgPFalz28JViCK4SQno8Pq43Hw4Ud9Y99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965334; c=relaxed/simple;
	bh=tKwnrrIu2kal6pWdhpkNGPu7zRq/0jbusyObZKem3UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiUEk+XeZAQ4vgjAFqB49xL5Q/Pq93JyX2jvw0ki8H30WLfgDOE3tdpm2D3JTQIl107EwCL+Kqw2DaboTqFTeEqiZnWr9SMKmLda40ViUVD6seElNDx6oXdrdFPH78ttHY8gnn1MnpmfNNNVpUbt0JyuzGE7vxwEjyOyMGlkD6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7sUo9ll; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7sUo9ll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786965332; x=1818501332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tKwnrrIu2kal6pWdhpkNGPu7zRq/0jbusyObZKem3UE=;
  b=n7sUo9llYZaA6pUKtab7xCJqwu6SROQztmcKXH7OQgHTrwXfguE6KHA2
   fSnE1c2LqX/0tAV6WTg1GW75w/KjnVlNLl4iONMennPSkcQKqb+4KxVyO
   xH7ey+uQlPYfmE0VosNVz8m0qjlpk5JWfBzvQIcEjmkiTvyq4TTwCPnNV
   6E6XGuqgZudXN6ZaJayYtpgmQLcnTdk6r5wKFBuXdRO8QXao8KCTvBSLN
   VcmGJRLGxEOZqgTEeAIgBlbvs8i6dy9s+eaXmTZbhDh20JFXY2QK/8uA2
   /Y3LX9D7si7UkmQOq50oYzNvFqrD5LZyCt/BcF0FVF4sIvXF3BZXkyEpB
   Q==;
X-CSE-ConnectionGUID: 9f7R/8grSIqvM3gYvdHIvQ==
X-CSE-MsgGUID: XXwhiB8WTJ+aQNdoLcAlFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98800432"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98800432"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 04:15:31 -0700
X-CSE-ConnectionGUID: MHhmRpU9RuSDZzf+WNBSfw==
X-CSE-MsgGUID: OtCYfmO3Tz6NZNYSDRYrTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="260672542"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 04:15:28 -0700
Date: Mon, 17 Aug 2026 14:15:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: dac: ad3530r: parameterize DAC resolution
Message-ID: <aoLtTlpc6HIyR_a2@ashevche-desk.local>
References: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
 <20260817-iio-ad5710r-upstream-v3-3-3a4bf7b9c78b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-iio-ad5710r-upstream-v3-3-3a4bf7b9c78b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 02:37:13PM +0800, Kim Seer Paller wrote:
> In preparation for adding the AD5710R/AD5711R, which support selectable
> 12-/16-bit resolution, add a per-chip resolution field and use it in the
> raw read/write and scale paths instead of assuming 16 bits. Drop
> AD3530R_REG_VAL_MASK and AD3530R_DAC_MAX_VAL, which hardcoded the 16-bit
> width and are now unused.

...

>  	case IIO_CHAN_INFO_RAW:
> -		if (val < 0 || val > AD3530R_DAC_MAX_VAL)
> +		if (val < 0 || val > (1 << st->chip_info->resolution) - 1)

		if (val < 0 || val > (BIT(st->chip_info->resolution) - 1))

OR

		if (val < 0 || val > GENMASK(st->chip_info->resolution - 1, 0))

One (GENMASK) works for 32, another (BIT) for 0. While it's tempting to use
BIT() for readability, the 0 is unlikely is correct, but 32 might be.

>  			return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


