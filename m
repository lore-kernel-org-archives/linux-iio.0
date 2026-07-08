Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30E3BBFAD
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492003; cv=none; b=rZBhZnRnNJRtaHgO7wV86QDF9w0rCY9L7PgNYrXih0cFO2/jzcgkJBxjLyI0bYdwxJWs0cA/Z6MxvufP2ynDMbBfkKrLPpGZnb9OZUCXFL3WpVospKrLhFtekG3Ghkg55oZbluwBhdIjPAsAw8fiQnb9WKmNx599OQAwwww7/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492003; c=relaxed/simple;
	bh=pQDkQdwrZ036GE0N7zq7iri7BLGnkQ0Q0hNvDADzpp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1Z8oeD6zj4s2l+1ZOb4mUsjkxgVVWGJ4fec650XCxlcufFm55IB9rfB5RQSLFyh2jRh8IhttRg+azWngo7SdcbZjKubKeUa0qOTqSUdLmd3KaoJnTjgGgDZcoDfp9gOv4F4B/qeFRcO+imFUkCTb3T13WKXo/msXWFG7Ffz1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DP0zxTYG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DP0zxTYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783492000; x=1815028000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pQDkQdwrZ036GE0N7zq7iri7BLGnkQ0Q0hNvDADzpp4=;
  b=DP0zxTYG01QNpMeqZekPc4JX2jQgDV9t904+FLNmqelSz6WE8jiBiteY
   uAzljlLtwMUDol3MqWMmUUYiAFUlm17SLQ6bUsenNEW0NjgppUs0SzCnZ
   +jpcDfxlRaoAfS9cTLME/ZY2ZMuBwcK3Gz2+7qFuvkDBoNmAA7fIJ3w7P
   pxLOZlSNzviN+FNQniOLESWUDiZespyQtZfTANf8FIHuGe6PXKt/3uqvS
   xMKlnaf+3oPfkI9J+Ped3qshMhQWWuozqBO274Qzlit3LLZsoN2TvHX+E
   KerYMYbmD29gT4+M3iFRsQ8WW/Fyf2FRR/ZZKu4yXRitGMKHih9E1rgrJ
   Q==;
X-CSE-ConnectionGUID: C+FLiqf7TdOJ0e9/pcVcSg==
X-CSE-MsgGUID: JSU0UqQJQ/a2A/pxAI9Jgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84119031"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84119031"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 23:26:39 -0700
X-CSE-ConnectionGUID: ZSxxJVx0QOmPzaC9M3Vi2w==
X-CSE-MsgGUID: 3QCR+hGPRci/obuXTAPvpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254844470"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 23:26:37 -0700
Date: Wed, 8 Jul 2026 09:26:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Caio Groff <caio.groff@usp.br>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl372: replace manual bitfield ops with
 FIELD_GET()
Message-ID: <ak3tmgh9nUn6MkHs@ashevche-desk.local>
References: <20260708013002.1377142-1-caio.groff@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708013002.1377142-1-caio.groff@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 10:29:27PM -0300, Caio Groff wrote:

> Replace manual bit shifting and masking with FIELD_GET()
> macros for clarity and consistency with kernel coding style.

...

> +/* ADXL372_TIME_INACT */
> +#define ADXL372_TIME_INACT_MASK_H  GENMASK(15, 8)
> +#define ADXL372_TIME_INACT_MASK_L  GENMASK(7, 0)
> +
> +

A single blank line is enough.

...

>  	res = DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
> -	reg_val_h = (res >> 8) & 0xFF;
> -	reg_val_l = res & 0xFF;
> -
> +	reg_val_h = FIELD_GET(ADXL372_TIME_INACT_MASK_H, res);
> +	reg_val_l = FIELD_GET(ADXL372_TIME_INACT_MASK_L, res);
>  	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
>  	if (ret < 0)
>  		return ret;

The whole driver uses bulk reads and writes, why this can't be modified to
perform regmap_bulk_write() with the __be16 type?

-- 
With Best Regards,
Andy Shevchenko


