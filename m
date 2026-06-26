Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494673F4837;
	Fri, 26 Jun 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476772; cv=none; b=OxAAIMavpw63Aj+O9RrWrEROsY7fn9Lm8mEJOyEzjhwRjZAktMnrsKfcDiIhFpIHbID2IlhBJyX1HUIIuusI42BtaqqJE5E3gLcA3HFP3HXUD3AfGPUQLWvvJiNQRsYRUqNwOgZ3JoYLW/fCvkB2rWKS6AfTtAWbNev3iXzfC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476772; c=relaxed/simple;
	bh=4ANFMia0wbDzuK4Nho5SegwCPJiJIpotFgaVGjC2gUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aruc4j3/aFth7kjDgG1+JDJHFOn7ZVNeQctEy0+3nlqIcViP+Lzwy9iaNDhNVzJS5NraR0eNe0QGBbfY0XMqecBzJLgao33J+vMjfTTLYvAs8v8zBfTA7H6dyMDNcsaqHZOwlMfV0x6K6C2dE9Rj+1YFd3Kv8zJg07U1cXYUhzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iD1ySbT8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iD1ySbT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782476771; x=1814012771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4ANFMia0wbDzuK4Nho5SegwCPJiJIpotFgaVGjC2gUY=;
  b=iD1ySbT8ZfulFuNYRyF1VMrF0Bndp7/Y2V14M2w4QACeT5EBisL1gmdQ
   hEW2X9MfddpVBHMWUnMoRoPQbpo0P1AjQqAMOY5oLb8W38S4Q1Pg39zhA
   9ERWFkiK+se0DuwS2cwHYO9D7RJKvW628XaUBWRTrcEkTHWWISqPiETrq
   wQAyui2trGg9bWyHugn7TXZo16J2t1WmcG/4ltYe7PHKMIrC5CdEcGKMJ
   TlJ/nvB74BzNs34svRFFAFb6dN55nIPHHOmG6q84Y4xk2I99VIF2C/TLt
   AywZJ+NK2iT6OXHS6VKgh7aP43NWuSkTuKc4UaZ+ETPV8NoYb0tu1hPDJ
   w==;
X-CSE-ConnectionGUID: u7Yrg5/lR1yDT7tl8Y5ZoA==
X-CSE-MsgGUID: y+jMuomjRf2m8cA3hiPomg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="106062596"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="106062596"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:26:11 -0700
X-CSE-ConnectionGUID: KHJZfFLWR32yp74CICU71Q==
X-CSE-MsgGUID: LS1oS0WdSQqr97VPY9dRgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247344598"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:26:08 -0700
Date: Fri, 26 Jun 2026 15:26:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Message-ID: <aj5v3rDRlY7H39Tq@ashevche-desk.local>
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 09:38:07PM +0200, Joshua Crofts wrote:
> This series adds REGMAP_I2C support to three AL3xxx ambient light
> sensors that were previously missing this dependency, causing build
> failures.
> 
> To reproduce the build failure, run `make allnoconfig` and `make menuconfig`
> in which you select IIO, I2C and any AL3xxx sensor and `make .` will
> fail with errors such as:
> 
> drivers/iio/light/al3010.c: In function ‘al3010_probe’:
> drivers/iio/light/al3010.c:185:24: error: implicit declaration of function ‘devm_regmap_init_i2c’ [-Wimplicit-function-declaration]
>   185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
>       |                        ^~~~~~~~~~~~~~~~~~~~
> drivers/iio/light/al3010.c:185:22: error: assignment to ‘struct regmap *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
>       |                      ^
> drivers/iio/light/al3010.c: At top level:
> drivers/iio/light/al3010.c:48:35: error: storage size of ‘al3010_regmap_config’ isn’t known
>    48 | static const struct regmap_config al3010_regmap_config = {
>       |                                   ^~~~~~~~~~~~~~~~~~~~

Now all is better. The only thing is missing is Cc: stable@ line.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> I made a separate commit for each driver, to ensure a proper Fixes:
> tag is appended for easy backporting. Let me know if you prefer
> squashing!

I prefer per-driver patches, but let Jonathan to handle that.

-- 
With Best Regards,
Andy Shevchenko


