Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDA35FF75;
	Wed,  1 Apr 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056223; cv=none; b=TNbYDIMqvogPf14NUWQZQ9dQArMDh2w5TsMN8dOxlpeIEvXJc6LQUbQTOerRb4MG1C6jmb4FRbbNWZ1fKcXQbOmqFORIGoX5Y0KRXsgiw+FjlSADsmkdqACd0+zYhEkx0Fg0TR9WFAkuwn40femp3ve5HBJYwpd6LWU4fuN5v5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056223; c=relaxed/simple;
	bh=ByFJuUH+Ie4yVFpimizT/zfqfXLXJKFs0kW7xEv/8JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dz80RYHfoZp9Vik2wUgmkXuMrHPGM7k1IfBxurT3sKvtsG4UXpe0wvHIKozF3k88QkFbe6icxQpeYNtMVvj2wvgXpziNHBHdGvJvjyZWhlbf7BFp4/fO1BBRPt7R6H5Lp6uM86bCknm04woozhC0r4bRd78ESBiLt5oXYxnhomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEiJmjsN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEiJmjsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775056222; x=1806592222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ByFJuUH+Ie4yVFpimizT/zfqfXLXJKFs0kW7xEv/8JQ=;
  b=PEiJmjsNuUa45NZAkWEjQe+LjSdN799etRgXVYW+peWUHfpoNBPfnBgJ
   5zK8AU26VKECk2K+BpcgrFZw1pKPKxvt9q+b0ZhcnS4Bd2UtbPMQs2YKt
   ihXKC8VkmKBkD1vR1UDhlAlniO1EpgCZr7uv+G5Ir0ltw9bHhmwdh2nTr
   B76yri2NI4ooJGsyisz3caEnSMFAW3RXRZBePHEVZGvM0DSt5j4KE8V63
   Go0xn1O4enaT5uHNHrneQNKKmcuip47hgN6yt3ionpwH6xiF8Myv4K7jQ
   yuJ19g4j4ATiiE3gG/vTRAaYFRbTcpxN/mT8z8qclRst1NlcjfCGc8LV0
   w==;
X-CSE-ConnectionGUID: lIZFkxptSS+ua2vlvx85yA==
X-CSE-MsgGUID: VojahJgRQneydqt3X/UhXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93681482"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="93681482"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:10:21 -0700
X-CSE-ConnectionGUID: eyv0yO/mTIWZoQ80p9G/5A==
X-CSE-MsgGUID: Udf5qq5zSf6D/X7gCY0Ycw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="249737858"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:10:18 -0700
Date: Wed, 1 Apr 2026 18:10:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] iio: imu: inv_mpu6050: control vdd supply using
 devm-helpers
Message-ID: <ac01WETv_jIcYvRL@ashevche-desk.local>
References: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
 <20260401082737.781018-3-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401082737.781018-3-andrej.skvortzov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 01, 2026 at 11:27:36AM +0300, Andrey Skvortsov wrote:
> vdd supply will be automatically disabled on error condition during a
> probe and on driver cleanup. Since the vdd handling is moved to
> devm-helpers, only vddio regulator has to be disabled in the
> driver-specific cleanup action.

...

> -static void inv_mpu_core_disable_regulator_action(void *_data)
> +static void inv_mpu_core_disable_regulator_vddio_action(void *_data)

You can rename now _data --> st...

>  {
>  	struct inv_mpu6050_state *st = _data;

...and drop this.

>  	inv_mpu_core_disable_regulator_vddio(st);
>  }

...

> -	st->vdd_supply = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(st->vdd_supply))
> -		return dev_err_probe(dev, PTR_ERR(st->vdd_supply),
> -				     "Failed to get vdd regulator\n");
> -
>  	st->vddio_supply = devm_regulator_get(dev, "vddio");
>  	if (IS_ERR(st->vddio_supply))
>  		return dev_err_probe(dev, PTR_ERR(st->vddio_supply),
>  				     "Failed to get vddio regulator\n");
>  
> -	result = regulator_enable(st->vdd_supply);
> -	if (result) {
> -		dev_err(dev, "Failed to enable vdd regulator: %d\n", result);
> -		return result;
> -	}
> +	result = devm_regulator_get_enable(dev, "vdd");
> +	if (result)
> +		return dev_err_probe(dev, result, "Failed to enable vdd regulator\n");

I'm not that expert in regulator framework, but this change might be sensitive.
I dunno if regulator is exclusive or shared and if order of requesting may affect
anything. Just needs careful review from somebody more familiar with that.

-- 
With Best Regards,
Andy Shevchenko


