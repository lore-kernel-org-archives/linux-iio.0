Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8242DEA93;
	Mon, 17 Aug 2026 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951708; cv=none; b=a4VFVKH/ubyszb1ftVgoBnTHbgepLUf0EqVG1gPnPfsjz+NBETobKoDqTUps/lA11Y5QgVq47utcYCTSof2q3d+wCkKLs5++9Pj266GBhWffhVMVHkwrK8ptf2aIMmjpIb8VQNpmiiz9clgkKQ8Qy0X2qQYUuyEH6rUC8MJA7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951708; c=relaxed/simple;
	bh=s9mXG8Q617eLSQ+7yxQL0RwYbcskeR/ngAyJ6xGlXkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUW8uaA/ndvqSmWZmpbDpRLnN8xtDYzxjMFlMhkmbzswez+QwJDnKsCuKZ5a876kd+s2XOl1odR2RQAM707atiC/dx6N3XqNeJCA9VNdfOj9bzN9MrStPBiVz75W5KSHA+qCciR+FO3wF0KW+YyYhQI+LWJp9DuR73EGGGp0vJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPtYnGKo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPtYnGKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786951707; x=1818487707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s9mXG8Q617eLSQ+7yxQL0RwYbcskeR/ngAyJ6xGlXkk=;
  b=hPtYnGKoeLSYQmxNsz/yejsZMi9/XiK2yUxbf4Oyk0LaBkNqxbOCHZMi
   ILSeAtaqIHbRX6daoPaaPS49fdwf25MXuE7FfAJu1bixMo/aEaNWb82jI
   MDm2OFlfATWknGECXO+7vUk4LsTvHZjeLsoYfceCF3/IBHg1im/YLUIIq
   gqkwdso6e5U9P9DXgsLstV5TJzQcd6WLVjG1gxOYlt6M7xJ7vQFMPWs08
   gY+3GEaTuWLbPZyPiWRSe1XiDTZ8riO64jIB9Sm9tLicj+CRFptpPvul4
   ulgk4SZLzmQjegtSnxgNV4L7CTJ0Nb7/QzzEMFtqlXT2fyb2wCfEotnA0
   w==;
X-CSE-ConnectionGUID: OeeAo1rwRxyCBmSKFYk7gw==
X-CSE-MsgGUID: mgleri9+SdqBLgOx1AwdxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98784354"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98784354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:28:26 -0700
X-CSE-ConnectionGUID: a5hbcW9lQ7CANrvWFMExBQ==
X-CSE-MsgGUID: mjjqXt+YQFKF93XBHKtf0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="289661250"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:28:23 -0700
Date: Mon, 17 Aug 2026 10:28:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v10 1/2] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <aoK4FXvkPT45RsIV@ashevche-desk.local>
References: <cover.1786661484.git.marcelo.schmitt@analog.com>
 <8b0d2e34163b85634266be3b9dd8f76697c89bd2.1786661484.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b0d2e34163b85634266be3b9dd8f76697c89bd2.1786661484.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 08:05:07PM -0300, Marcelo Schmitt wrote:
> LTC2338-18 is similar to LTC2378-18, differentiating from the already
> supported part mainly on the embedment of an internal voltage reference and
> addition of a resistor divider network connected to the input signal path.
> Extend the device driver, handling the internal reference and input signal
> attenuation, enabling it to also support LTC2338-18.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -	case IIO_CHAN_INFO_SCALE:
> +	case IIO_CHAN_INFO_SCALE: {
> +		struct u32_fract fract = st->info->internal_div;

+ blank line

>  		*val = st->ref_uV / MILLI;
> +		if (fract.numerator && fract.denominator)
> +			*val = mult_frac(*val, fract.numerator, fract.denominator);

He-he, I have a local patch to add mult_fract() macro for this kind of cases :-)
Perhaps need to submit it at some point...

-- 
With Best Regards,
Andy Shevchenko


