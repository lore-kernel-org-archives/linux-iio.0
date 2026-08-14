Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8C448B99;
	Fri, 14 Aug 2026 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696127; cv=none; b=bjkdLdqHg3VZqrhv3I2mABIYByxM0n8U8pjaTemVwRnxJBthIwKsY4mmDnRzqwnVGu/zZbuS1OxpDgWTywBTG21BixgcxvYZ/plHXogKNtr6zzDDxB8LD4NmDEYZUCq7rw4k7e3wyelowyR+oqAzbISJwxMSgXWesoUu8rV+jXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696127; c=relaxed/simple;
	bh=HRljGX3TSBiQ/d+PmHmhkQ/8ZPeNNwKqNQZPe9EayZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlxzcSSWLg6WtjDngQFI8LtxQxqC0qnAPxX5AYvBIdzMFvY5usAJBgYxyDRGU8AJiju4peypQpQHx7WBtSDNIvnWiy2oQyNeG9ILiXhZMh5CQ72VjGnbYExllzwGNcdl43RipztBX9CigqJ6ZNPv6clNDDf5T7TGt/A4KmgQkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClVIRtHz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClVIRtHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786696118; x=1818232118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HRljGX3TSBiQ/d+PmHmhkQ/8ZPeNNwKqNQZPe9EayZg=;
  b=ClVIRtHzeGGp3/bAiQti0VfQQYBp0dR03U9nDn5qWD/dysaM5UorDUWS
   WEbIM6ipnXUyOy/1aSbyIayw/FTmmH0DuSjFJCq1tZ4MrZJADPJBRDYk9
   PD4Dbo01Y/j5JcvqjiEK02NIVZmlRRYVloe6ioxPwAqwVzlDtJrIjYCHT
   gq7WQbze1qc8eWuwFky7VimDhXiVaDSftMfwLof3IEA2gM51xromLTF0w
   ARdWatkjH/BhZh3vWb3oV10e2BhtubY/FuaqMI3CpNfYwv6Sz35Ho8j9C
   Rd9yS3yjPUKMyR5qiA86+NiWIuqMZ+vWgo+YKQMYYZuXNzH8yw5ReznSA
   Q==;
X-CSE-ConnectionGUID: JEhsbZ3BQOC/toD0rmvXkg==
X-CSE-MsgGUID: yXaQMuYZSnqBwsirqEemNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87403281"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87403281"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:28:32 -0700
X-CSE-ConnectionGUID: RWC9eLUXSrqk/rq4I9xX1w==
X-CSE-MsgGUID: pNJT3lZ+S7qXobv4VXgHwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260377327"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:28:27 -0700
Date: Fri, 14 Aug 2026 11:28:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 11/14] gpio: regmap: Use regmap_test_bits() for single
 bit reads
Message-ID: <an7RqI9bBIX6lu_5@ashevche-desk.local>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
 <20260813-ad7768-driver-v3-11-cb554399ad26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-ad7768-driver-v3-11-cb554399ad26@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 03:57:04PM +0200, Janani Sunil wrote:
> Use regmap_test_bits() when reading a single GPIO value from a normal
> register and when reading the direction bit.

...

>  	/* ensure we don't spoil any register cache with pin input values */
> -	if (gpio->reg_dat_base == gpio->reg_set_base)
> +	if (gpio->reg_dat_base == gpio->reg_set_base) {
>  		ret = regmap_read_bypassed(gpio->regmap, reg, &val);
> -	else
> -		ret = regmap_read(gpio->regmap, reg, &val);
> -	if (ret)
> -		return ret;
> +		if (ret)
> +			return ret;
>  
> -	return !!(val & mask);
> +		return !!(val & mask);
> +	}
> +
> +	return regmap_test_bits(gpio->regmap, reg, mask);

Wouldn't it look cleaner if written as

	if (gpio->reg_dat_base != gpio->reg_set_base)
		return regmap_test_bits(gpio->regmap, reg, mask);

	/* ensure we don't spoil any register cache with pin input values */
	ret = regmap_read_bypassed(gpio->regmap, reg, &val);
	if (ret)
		return ret;

	return !!(val & mask);

?

-- 
With Best Regards,
Andy Shevchenko


