Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461006;
	b=gHPlqdqGCA2bc2E6EdJZeLN6nRqpkNmd65OI+IsNcJxPdTUT08OIB5yFnvM4bQRRvcOg
	 aDJY8OrmCPXH8am782e22280vFpXy5lVUj4r4uf3oUEoS3WHhUiItAKc7KnnSxjamAxNP
	 tTeH1YcKevv5UXdflGHm3wyfBAQJc8b27cK3zLWyTsneNfPY1Hpa7glcegfSa63QoaU17
	 iE19ZUruXUT6OoyIE+4SbqIzeVVC+n4ZR5iO8mlSiX41nsk1An/lunygDIk/QetjycFgq
	 OOaAI3AvwI1j2M4jazmq5fE+HlWOPnL9Nf+g9/fqmxlgp3V3/jS8dn/metz6nqobxQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461006;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6BfgYxMbbUj3tvGrrFAHr7ulDtIMRjljuzJLYixZFyQ=;
	b=FiGmPmTW+Eye+4Z28apc0JHZ+7kFbIzVaTmSozYyHc4Xmhqh3ocVlyYctpi5u9oyEDNd
	 sEiHljyDBBHibrjScTOo9auj9ndJbNdgl7ssilkGvE/7FU9HyeabYUmBh1sZhisO15FO6
	 q31zt2UCNgkiidXhYUPf8FK3KUuUuW1OSLIVaJdCZ5vwaZsQWt54jT0s/Sz9uPwbgDGow
	 ItGn7VYd1/t7bR/u6whUyUjOhN8J2p4Xi1PuH4uMpVSE9te2OUJy9Eiraq55X44Q2nmDd
	 uGIXXny1hLIInXl8yGQ0c6mo634y5+V5XXBdfgQAcj/FqzTr9v2om0udzq76M6lVIow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l8Zo1BiI;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954D2606A31A;
	Mon, 23 Nov 2026 19:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 954D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l8Zo1BiI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795461006; x=1826997006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kjpkAWYnqtk723b1a74tZyLz9yPQ/oi3AlaFAPa0gD8=;
  b=l8Zo1BiIqqg5tUAZBIWWyDATkIXk92XG2UIgD/j4UI5T3q9afA9cL88p
   P+vYfua4GulDdAIyN6xs+v/SASnlaBTQymC6giPZqG64zpJHNDS3VF2YW
   lOpIEoQyGsr1w1YXOiQkA8qeNGaroXiDgN6sWy2DpJOIaZYJYrtJ8mA3N
   /M48NeIY0UNagGOKmUjkLIxjYqbUVaEeO1bR8LfVk+hbfJvZhroccbynt
   s8qb3AHki0QtE4qIrmE1nH2uJpdXkShihHNmEfZnKDezLsgfBItat7IPR
   zkll+MPtqSAnTMjg/Rh1BEw59TSmzOb5w5V5jeoPjl1Nrp35lE1xarR6/
   w==;
X-CSE-ConnectionGUID: YzOLq2qMQ3ugL5C7RswToQ==
X-CSE-MsgGUID: g2ZEtUgST6m1ZdD9752nig==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4131256"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4131256"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:10:05 -0800
X-CSE-ConnectionGUID: Rxw3n4WERhCVfdIKfG3f4A==
X-CSE-MsgGUID: 9gdjGGmYRY6tMIv0XOGB7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11781525"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:10:03 -0800
Date: Mon, 23 Nov 2026 21:10:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Cc: jic23@kernel.org, marius.cristea@microchip.com, crofts@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: palmas_gpadc: Use guard(mutex) to
 manage locks
Message-ID: <awSPiGyelASPJUr5@ashevche-desk.local>
References: <20261123070802.14487-1-vaibhav.chahar26@gmail.com>
 <20261123172836.130440-1-vaibhav.chahar26@gmail.com>
 <20261123172836.130440-3-vaibhav.chahar26@gmail.com>
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
In-Reply-To: <20261123172836.130440-3-vaibhav.chahar26@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 10:58:36PM +0530, Vaibhav Chahar wrote:
> Use guard(mutex) instead of manual mutex_lock() and mutex_unlock()
> calls to modernize the driver and simplify error handling paths.
> 
> In palmas_gpadc_read_raw(), moved palmas_gpadc_read_done() into the exit
> paths inside the switch block so the out: label can be removed while
> preserving hardware teardown before unlocking. In
> palmas_gpadc_write_event_value(), use direct returns instead of jumping
> to out_unlock: label.

A few similar issues as in previous patch, AR: study my review and act
accordingly.

...

>  #include <linux/completion.h>
> +#include <linux/cleanup.h>

l is before o.

*yes, I see that the order is a mess.

>  #include <linux/of.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>

...

>  		ret = palmas_gpadc_read_prepare(adc, adc_chan);
> -		if (ret < 0)
> -			goto out;
> +		if (ret < 0) {
> +			palmas_gpadc_read_done(adc, adc_chan);
> +			return ret;
> +		}
>  
>  		ret = palmas_gpadc_start_conversion(adc, adc_chan);
>  		if (ret < 0) {
>  			dev_err(adc->dev,
>  			"ADC start conversion failed\n");
> -			goto out;
> +			palmas_gpadc_read_done(adc, adc_chan);
> +			return ret;
>  		}

Nope. In this case split out an inner part into a low-level helper
function and call it _locked() or _unlocked() (I don't remember by
heart what the correct one is in IIO for this case).

...

>  	default:
>  		ret = -EINVAL;
> -		goto out_unlock;
> +		return ret;

So, what's next obvious step?

>  	}

-- 
With Best Regards,
Andy Shevchenko


