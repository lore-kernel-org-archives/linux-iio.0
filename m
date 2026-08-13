Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021A3E6DFF;
	Thu, 13 Aug 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611327; cv=none; b=eoe/Nwb20Fv1K3hN0mw0lIZXrdyAtTobPHjlWYwB/J9JFy+xghhuhCGmAkN0GO+JK4FQvHeU6wqns9fIdJ6U/CVTfIPF9iq7v03I0H+GXTzLGJGTix6Prr4IqRRcXG8qvYenrlOWTSqwtG/dTdF7q33M2P6jd2E372k6ftQIKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611327; c=relaxed/simple;
	bh=JxMITKl/Vvf69pA/mw2tA7mC9Bpu8exRXhyjox9ZHos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1njRmHH7EVq7u2CtJbEfOmNBeeyH4yvZFSfWAo79Qa3n81qJ8w6CG/sOYy6Gf63V5ezlUnyRMx/CUmZKd8x1IWKvf3BgEdzZQ6TeaOD/H5EmAUjAKRQwnGYPhlPPw7hZl0Mts/xaXrAy5yJ0EewX7EoVJQy9uXdeulq646WF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5BigMK7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5BigMK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786611325; x=1818147325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JxMITKl/Vvf69pA/mw2tA7mC9Bpu8exRXhyjox9ZHos=;
  b=m5BigMK7B5eiLYJ3Yc4yklXYwOEatKqbBZkG8J/dH2hr6PUtUoE47Vvb
   TImuiXThTf8BJ9aGCIJ8gIKcO1f6iRaWIqxV3WM4dXj53eRlbioaRe/6T
   rRB/5+aUwP5eTUogC93Jcm9QeIjNB/hQ+f6z64sYaLS2XtDfH/18G16ci
   9ZwLk51Dz1llbMy57EZY2nPkLrzMst0Y89vjIg/zTH9lvzTAIpRY9noC6
   cvYdTtNX1tqH1/CkbVhGyXe7FuLPiFdF/lZpJBLJxbRs5NjNZDDvTvUYI
   BEgCMoJX2Em3Q9PlfQL3+QWCCAPMjfN0UQiN+o5FrUUpTg7l79inctVE+
   w==;
X-CSE-ConnectionGUID: 8W/8tgI0TXSQyZXy6oSZdA==
X-CSE-MsgGUID: Tq9zD/J2Tm2lXIcwDfd8Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="109966859"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="109966859"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:55:24 -0700
X-CSE-ConnectionGUID: mB+TROm4R+SH3d8x+JDxKg==
X-CSE-MsgGUID: uW4LAO2OS3WYyUl4Jp0YCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="263422499"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:55:21 -0700
Date: Thu, 13 Aug 2026 11:55:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iio: adc: ti-ads1015: use dev_err_probe() for
 error handling
Message-ID: <an2Gdgc3XgNyYr9m@ashevche-desk.local>
References: <20260812164433.23011-1-architanant5@gmail.com>
 <20260812164433.23011-6-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812164433.23011-6-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:14:30PM +0530, Archit Anant wrote:
> Simplify the error handling paths in ads1015_probe() and
> ads1015_client_get_channels_config()  by converting dev_err()
> calls that are immediately followed by a return statement
> over to the modern dev_err_probe() helper.
> 
> Note: This patch takes advantage of the previously introduced
> local 'dev' pointer when converting the legacy
> dev_err(&client->dev, ...) calls, avoiding unnecessary
> code churn.

...

>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Failed to register IIO device\n");
>  		pm_runtime_disable(dev);
>  		pm_runtime_set_suspended(dev);
> -		return ret;

This shows that runtime PM calls were put to the wrong place in the previous
patch. Just move them to be up, then this will be naturally accepted change.

> +		return dev_err_probe(dev, ret,
> +				     "Failed to register IIO device\n");
>  	}

-- 
With Best Regards,
Andy Shevchenko


