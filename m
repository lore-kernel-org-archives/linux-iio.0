Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106D37D126;
	Thu, 16 Jul 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223521; cv=none; b=DCanI/yYNAutLTFGQekQTgjdFFyAK3gkc0nauQXMBQ7El+Yj80S5y9blcWtaFfFGUSrL54Xoza+hunhNEr26DX6Wz2K1NB/M6z1kUR5TDbXLs3SAFm8Zrns7eyWWqoZlYihbrBzzNbOwlQzLK9xBB+7kczIs2rwthG1U4yVB0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223521; c=relaxed/simple;
	bh=Lo1GMdgP8Iw9bEhz/4IiBQGtCI/8kK+Sz30Q1yfoxPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm/vzp4Bds6FzmfSByFzPr01dSlndbcgDKIONU1NMNPxDyNZ9di5DSj1A0Ktw50vnvx8Z4HHeGtb1UKliHJ9mM2kM5VQXwos/WI7QgapCH3P5GY170DRO/qDohHac+5ipbWpjq3jJ8Pycpq0WxS5CNdVPXMQj/x1v8ycHbAOGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTUGQ1Lt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTUGQ1Lt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784223520; x=1815759520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Lo1GMdgP8Iw9bEhz/4IiBQGtCI/8kK+Sz30Q1yfoxPI=;
  b=LTUGQ1Lt/V3g1+Z0FPjkU+Ab9xrq6ppHr92YrjyDEM/Jt7oFvPA8UjYQ
   wB6glRdpRfT68QRsUGCqovzgl9Pvgur4k9Z8bXghBxTkB2cSvDr1YH3xv
   /xhiiTFwhyYcgd7+gDtwHEgE9irt0Vs1XiChRJk2OV/fY9CzqhoZ86khb
   FWFUesAiop3LgKH0zR1hH1cQshCwsiNqc5iUiy+RHMPnQ/bFb/fJF0z4O
   PaF2coTDsDFa30l910/EnzmNk0HQA63wvEAQQmqZtShkO/0cV+JctYfWo
   FoaPHdj3JPaajwKROf+RYrJsHJHCzHNhCAvbDUhwKPpqYfBlbZm0FDKNe
   Q==;
X-CSE-ConnectionGUID: r0eQN4+HS0qkJFZSm6+OfQ==
X-CSE-MsgGUID: Q83w2rFoTIak6sKBi0ZHvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85089908"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="85089908"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:38:39 -0700
X-CSE-ConnectionGUID: 0BHBbRtuSFiYWh64bVM+0A==
X-CSE-MsgGUID: D2D7vP5QRemFKvMATJ5/nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="279832977"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:38:36 -0700
Date: Thu, 16 Jul 2026 20:38:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?utf-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: resolver: ad2s1200: use dev_err_probe()
Message-ID: <alkXGkOv2h9jTQ-5@ashevche-desk.local>
References: <20260716123100.100394-1-vo.kratky@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716123100.100394-1-vo.kratky@seznam.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 02:31:00PM +0200, Vojtěch Krátký wrote:
> Use dev_err_probe() instead of dev_err() to simplify the error path
> and cleanly handle deferred probing.

...

>  	st->sample = devm_gpiod_get(&spi->dev, "adi,sample", GPIOD_OUT_LOW);
>  	if (IS_ERR(st->sample)) {
> -		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
> -			PTR_ERR(st->sample));
> -		return PTR_ERR(st->sample);
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->sample),
> +				"Failed to claim SAMPLE gpio\n");
>  	}

As Markus said, you can drop {}. On top of that you can introduce

	struct device *dev = &spi->dev;

at the top of the function and make this all shorter.

	if (IS_ERR(st->sample))
		return dev_err_probe(dev, PTR_ERR(st->sample),
				     "Failed to claim SAMPLE gpio\n");

...

>  	st->rdvel = devm_gpiod_get(&spi->dev, "adi,rdvel", GPIOD_OUT_LOW);
>  	if (IS_ERR(st->rdvel)) {
> -		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
> -			PTR_ERR(st->rdvel));
> -		return PTR_ERR(st->rdvel);
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->rdvel),
> +				"Failed to claim RDVEL gpio\n");
>  	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


