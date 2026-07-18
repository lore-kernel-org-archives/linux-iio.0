Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26290384224;
	Sat, 18 Jul 2026 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784363835; cv=none; b=ee34OlW65muvJcuaPYrj+qQHNLfOYcObJzHokNFGdN1Vu7cF1g/dfeStpPe2RRXdDcP/TmlJ41G1UJ1zvUL12h1cuHWeopmlkSekZuUX0n3H/OcPJPL+4qjoFiJ2ZcwzlGcYEtMPowR98ccCWYt9/CatOmDo4K8LUh9PpSJSCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784363835; c=relaxed/simple;
	bh=43zB5VFPlSn/y1C9jvfLsmz92uzL5OePbGmA/k+iq64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2JLj9Wtc2wccOpPASM9V8DD+2AehLoUsmr0TOiM0quYt3TURFWCsicgLmR5pRV0KdQ3Rcln77Ym7abQu4Q/rvJVJIxBWuK7HvX50EPxaahFEmd5XselorfnunsPUc484lw2w6FGNZ5EyGinIOdfSYRTGel4ale6hNVNuM7U1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fa6USujN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fa6USujN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784363832; x=1815899832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=43zB5VFPlSn/y1C9jvfLsmz92uzL5OePbGmA/k+iq64=;
  b=Fa6USujNidivJdv90xL0QnZ9Z/Mz3hN6XS/6w5ixupHxbpM1RuW+vbED
   jqi2m+sUh8wG9fS912RfoYzUCAq5BZw+KscKQ1GFfTuoPyrtIWTJhCBeX
   7KqrL4oOgRWN4pVK2QAZrbQ7uOgzKOkbHusy41FeOf64co3U+LV8r54iS
   M6QkoOK6rRcb8fJpH0V6lHZpuZIJtuB99iqmuIDOwvC90ptN4uxvqRf+Y
   OVfv9b6SWBUIa6E/sZ1lrujSp5nQGRZllb62XCCnPrTOf4xsVKDbq+NUi
   tb6pAI5vJZ8jd+dosjAjcwEBnn1BCp+dRp8zeVNxFzz6YIffNl7lYvy/0
   A==;
X-CSE-ConnectionGUID: un0CNXgWSqO/5md7uWccYA==
X-CSE-MsgGUID: YlHSDcytQiax0BY8j4YZLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95376621"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="95376621"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 01:37:11 -0700
X-CSE-ConnectionGUID: uOvpHmk2T36ltz8Gf+d8jQ==
X-CSE-MsgGUID: qmxCo5tGTdmE68ErivmUwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="260790331"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 01:37:09 -0700
Date: Sat, 18 Jul 2026 11:37:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: ti-ads1015: use local device pointer in
 probe
Message-ID: <als7MldPd1WjCmDZ@ashevche-desk.local>
References: <20260718075016.27750-1-architanant5@gmail.com>
 <20260718075016.27750-3-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718075016.27750-3-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 18, 2026 at 01:20:15PM +0530, Archit Anant wrote:
> Introduce a local device pointer 'dev' in ads1015_probe to
> avoid accessing &client->dev repeatedly.

...

> static int ads1015_probe(struct i2c_client *client)

>  	struct ads1015_data *data;
>  	int ret;
>  	int i;
> +	struct device *dev = &client->dev;

Preserve reversed xmas tree order.

...

>  	chip = i2c_get_match_data(client);
>  	if (!chip)
> -		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
> +		return dev_err_probe(dev, -EINVAL, "Unknown chip\n");

Side note: At some point we probably want to unify the error code for missing
driver data to be -ENODATA.

-- 
With Best Regards,
Andy Shevchenko


