Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C63E556F;
	Mon,  2 Mar 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457397; cv=none; b=dHuhMz0MEwL5Pc/hlpDboLkNx1cYHlg93iqSONUnZBnWP/4SdqxdqH9fLPCqympuU1dc+Y2KrHDyRsIfWzRMRyJQyNimNbvLAnmVUabAzBdKn+jX3irxhozAmn5sSndx+cv+328tNrsFgH8A/su5l4ACDE6mYbodyUsiWlUul24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457397; c=relaxed/simple;
	bh=jSI4SPd7w/ZJPoWHRQn0HdlFCPfObOJRusyvDsfkgOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf0s8eI0+sGKDuEmTR/dsK5EqwqSuF8D2MAfR3fDlhxGZBcbLhRiszMU2olrYmtS356oG4dX7haYUlsj+YIR+b+bbwfbdZD3UzwjQ2L/GwygZFwLJmvSCz0ORzNAwTTDn7I8kJgUJSp9U4YlFPLREv/9zR2qEBnNV1tsnnoKH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALrKvSwR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALrKvSwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772457391; x=1803993391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jSI4SPd7w/ZJPoWHRQn0HdlFCPfObOJRusyvDsfkgOw=;
  b=ALrKvSwRgm0wYiR89MhCNWCvB2dd9TBsJcR1f2CAi++vNIj+3F6yVLUo
   F8qVOV/jgA+KxF85suOSaloBQwJ+Vs0gXzmhcrgKV+MdNtolw2ovw5Er1
   qh2i/sZjk0o+gkoMbKqPmBpS8qNJgFHZw/FYWTWScCoHTfwbjY14T8wDB
   QcFj4sJOudwrpOHT5kuIyy/HpPr5jbnTBixzl9XzuFU274uH3cLdCuCsa
   F8PmzlMCPsIS2lcbi3t8PInDtADC0vBv0upGniB8ZvmKz1wAwhuk5QgEM
   4rw5+f/kLtaIT0V+sr9vryte8aS2vAv4y8TBRc/n2cnDdWQPaMiZEO5+I
   A==;
X-CSE-ConnectionGUID: nFBPZXK2TuK6Rf5sJUXY1Q==
X-CSE-MsgGUID: kW0dcLqPSWyQmbOVCd16tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="90859262"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="90859262"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:16:30 -0800
X-CSE-ConnectionGUID: DAORsD83QJ+Q3yrMbb4D0g==
X-CSE-MsgGUID: SQHfW3FqScGbEXw4yGPr4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217545904"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:16:28 -0800
Date: Mon, 2 Mar 2026 15:16:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: ad799x: use devm_add_action_or_reset
 for regulators
Message-ID: <aaWNqZBvFTiO0LNR@ashevche-desk.local>
References: <20260302130632.29144-1-architanant5@gmail.com>
 <20260302130632.29144-4-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302130632.29144-4-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 06:36:31PM +0530, Archit Anant wrote:
> Convert the manual regulator_disable() handling to use
> devm_add_action_or_reset(). This guarantees that the regulators are
> disabled in the correct reverse order of allocation during device
> teardown or probe failure.
> 
> This removes the need to manually disable the regulators in the
> remove() function.

...

> +static void ad799x_reg_disable(void *data)
> +{

> +	struct regulator *reg = data;

Unneeded.


> +	regulator_disable(reg);
> +}

static void ad799x_reg_disable(void *reg)
{
	regulator_disable(reg);
}

...

> static int ad799x_probe(struct i2c_client *client)

With

	struct device *dev = &client->dev;

it will look better.

...

> +	ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable, st->reg);

	ret = devm_add_action_or_reset(dev, ad799x_reg_disable, st->reg);

> +	if (ret)
> +		return ret;

...

> +			ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable,
> +							st->vref);

			ret = devm_add_action_or_reset(dev, ad799x_reg_disable, st->vref);

> +			if (ret)
> +				goto error_disable_reg;

-- 
With Best Regards,
Andy Shevchenko


