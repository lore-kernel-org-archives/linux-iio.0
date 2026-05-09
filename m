Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAF37F8AD;
	Sat,  9 May 2026 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778309854; cv=none; b=jk+lyHWiR55dj9jbXXnnM4fopu7CKVn8Wgop1vFp4Ingdc/UPobXM+wWlQAwlNbh+HjXQ5n/3gUkeHm9oKZOAe4ioBMQRnzlqVl48BR4Kk+8ynHcC/u93xxTLZUqp3U+w7MJ5b83V0Idh1KwuP8X92veKr7iP+s21fNDVVLmZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778309854; c=relaxed/simple;
	bh=5Qzv1SATPTfl2chwFg8bltmrUqRdT/H8j7cTs2SHPQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBEdiTEms8Oz3H56lV6+vMTBI8RSLdIl6mj/0b6s5/Bs428tEesgWpvmV+YcTxKPLHUB9O42ohEO/HfKhcoWKYmftJo+t2jlmmzSE/1Zr2p61tu+YCybCjxJh4o23FiX6sDtvzT+x4In4NHH4cWP9GyKLmJzZO8i4IawMX1brio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNDSeS5n; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNDSeS5n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778309853; x=1809845853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Qzv1SATPTfl2chwFg8bltmrUqRdT/H8j7cTs2SHPQs=;
  b=KNDSeS5nRXTAUsLKskNB9FNPFQPgLOVVqkJc6UwlrD0/29LMQ3flH3vi
   qENQhCeOQT403CHNZeUJxY7KBDNCqbKWGBUeLiV033n/lz6w2Yi2Vs1ft
   +TlRUoK25UF53KSgPge23tY9bYwjFkgWdgw3yENCmsw/gdfcnwZGrGnCY
   aBrf0A539zgipXMd9mppQTthhGnjSli31EpP7EiDG1HtezHUp+F/ivKgT
   48biDZvRswAEozTr1FCM2hxvGET89YsOS0ukenJy+lEkclKnffF6KVk0j
   AQv/iPZnLW+CGqLH8dQVNw3ej9KAbyexMMVsW2U5uulH+17snmHupKUPF
   w==;
X-CSE-ConnectionGUID: hQ+ikK/qT2WsP/BWRclvLA==
X-CSE-MsgGUID: OzfiC8+/T46wV+DXzSmLFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79302526"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79302526"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 23:57:26 -0700
X-CSE-ConnectionGUID: NoN0p9OcQ8Ce4OkTnYFnSQ==
X-CSE-MsgGUID: HvUnvdzSRaGSs6+LGYT+Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="240951551"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 23:57:22 -0700
Date: Sat, 9 May 2026 09:57:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7816: propagate SPI error codes
Message-ID: <af7a0OV-3GLH490W@ashevche-desk.local>
References: <20260509020646.82778-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509020646.82778-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 02:06:46AM +0000, Hungyu Lin wrote:
> The driver currently returns -EIO for SPI read/write failures,
> which hides the actual error code returned by the SPI subsystem.
> 
> Return the original error code instead to allow better diagnostics
> and error handling by callers.

...

> static ssize_t ad7816_show_value(struct device *dev,

>  	ret = ad7816_spi_read(chip, &data);
>  	if (ret)
> -		return -EIO;
> +		return ret;

At least this is an ABI change and should have been mentioned in the commit
message and justified.

Yes, error code is an ABI and infamous case is already known when similar
change badly broke user space.

https://lkml.org/lkml/2012/12/23/75

...

> static inline ssize_t ad7816_set_oti(struct device *dev,

>  	ret = ad7816_spi_write(chip, data);
>  	if (ret)
> -		return -EIO;
> +		return ret;

Haven't checked this one, though.

-- 
With Best Regards,
Andy Shevchenko


