Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436675;
	b=pXWeqOrde37Yg25LXyjiUa+wDzl9tCOaL0dQYe3Q3aoC75/W6P5DHFGvXwOkGCIcM0bw
	 cposIv51kSWe6KjR/zumH3sKkrDEivxF0hl8WF5sffEV/jCRDIbIcokzLi1LwyevFWkLf
	 35T62JYaJPGSSExcNtBCR/dEO3sOvvpXc/aMyd7FudoNqhQNFLvcjvntslpQTLPiaEWqF
	 krqt5rBrYseBKmsWO57Dm6Hiqx4bdtuKN0pX3wqLHUJPg8H0s6IBJ3/R7RyvG2OYVNbAT
	 1Xz2y6zwQGd0edyBjlUcOOGCE8PV9dmyjWjNW3BryCb3syeDSs47aA+Ek0hTIFpp1gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436675;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=4u4LKmqPQwyYsLxjj1JePiWhJRAotn+x2mWC12SUM8g=;
	b=dTgnwpT0TqNjfkgG641E4XYUTyV8nyp+KV5H3UqzZ4nKmKrUozWpwfMYIGe9wKMG5zSU
	 TFrn8MHEOwK8S4ZB1HqAlSYcXgdOjCB6hKmlLTF+VkOFt2fQu7oJFQil+RW/DbvKsnZjz
	 ynbpykMmSYkGFOBWD/JGNS6KoYzHnEGB4JdbLLYlYGsSTEqDeJGx3eT4IB40skB8WUGcd
	 5YMl9xNxGm61b3iyjH1+KYdCzu4iYezoZRXoK24+X/TNUVGkIdESA6ByNofHmM0DiyK1f
	 QL8fNenLc8agJFa7RmuzY/oKYV/8mEGpBe0P1XQPwcrPTfiLJLN4ra/pT0EUN1ILpxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KMYTDdgR;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9247E606A31D;
	Sat, 31 Oct 2026 08:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9247E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KMYTDdgR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793436672; x=1824972672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nwv4TqEAetnRJKnu4Hrrk+6Di2VlM6tDrcI2fKdJ5VQ=;
  b=KMYTDdgRIzF1/n1vdMfXlkE9pxaCXwXb8nmUvK4PIzXzZ4t4fZYraQOF
   sbFeoUxL2MBvcxvdBm/W/I7jinZ4Y2nz4kjZb4rMYHTqD1AXIWg56ngPb
   VM14NLzULT7aIbU8/yV3/KqaIZxRIrgGsTfEeotuTA+2GiwnAezjHxzHJ
   98m0EEZzvmJ+KhlD8IifReXBOZZJgzHe+m0urJaFMdR4oZg6AmeeLBojs
   FwUM690Loc7vK1EqlqEYDL8TmgRfO0TaXRgdRSESEIaJifKCCfZTqDdMO
   ROokVQZwf9mSMdjSeWwMGEpJH3DBzoBY+pcyaQNtiS7CmZvpCS81i/fQS
   A==;
X-CSE-ConnectionGUID: VYdfTtzORkW4SAN5TZ0YNg==
X-CSE-MsgGUID: 1UjASIP2RzKueJ/AtssqxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2216613"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2216613"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:51:12 -0700
X-CSE-ConnectionGUID: pzWFCsmLSBm2xkm65MLrJQ==
X-CSE-MsgGUID: JtZESsbbQ42wojQyHjrWGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5972826"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:51:10 -0700
Date: Sat, 31 Oct 2026 10:51:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nithishvelan M <mnithishvelan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH] staging: iio: frequency: ad9832: use devm_mutex_init()
Message-ID: <auWr-zLzIIaQ2Nzi@ashevche-desk.local>
References: <CAFonu5gDrT6znf3VUDjyg9=mTtB2nqXj9MFVO6cUZF3X4F-UeA@mail.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFonu5gDrT6znf3VUDjyg9=mTtB2nqXj9MFVO6cUZF3X4F-UeA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 31, 2026 at 01:02:58PM +0530, Nithishvelan M wrote:
> Replace mutex_init() with devm_mutex_init() in ad9832_probe() and
> check its return value. The driver already uses devm_* helpers for
> its other resources and has no remove() callback, so this ensures
> the mutex is destroyed automatically on teardown when mutex
> debugging is enabled.
> 
> No functional change intended. Compile-tested only.
> 
> Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>

> From d6899b1d88d9c9b224dd78b94b67caaad05098bf Mon Sep 17 00:00:00 2001
> From: Nithishvelan M <mnithishvelan@gmail.com>
> Date: Sat, 31 Oct 2026 12:03:37 +0530
> Subject: [PATCH] staging: iio: frequency: ad9832: use devm_mutex_init()

No, we don't accept attachments. But `b4` might, I dunno.

> Replace mutex_init() with devm_mutex_init() in ad9832_probe() and
> check its return value. The driver already uses devm_* helpers for
> its other resources and has no remove() callback, so this ensures
> the mutex is destroyed automatically on teardown when mutex
> debugging is enabled.
> 
> No functional change intended. Compile-tested only.
> 
> Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 35f823f24f..a90ee89803 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -325,7 +325,9 @@ static int ad9832_probe(struct spi_device *spi)
>  		return PTR_ERR(st->mclk);
>  
>  	st->spi = spi;
> -	mutex_init(&st->lock);

+ Blank line.

> +	ret = devm_mutex_init(&spi->dev, &st->lock);
> +	if (ret)
> +		return ret;
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad9832_info;

-- 
With Best Regards,
Andy Shevchenko


