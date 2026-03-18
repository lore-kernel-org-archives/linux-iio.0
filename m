Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7ED3DB62A;
	Wed, 18 Mar 2026 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845042; cv=none; b=udNmul8xpXsWHWMkvUBZgMrCe1nFsZVNYAkkc55VV1Ig8ib+6xO59oGADr3fbHp2Qj2H264Y3i5/SlPnEKI5kD0SxFbGX6asPPMfcD6J3XyXi/YGA5au7A6G3VvVVqk0jsO6WWWGITUvAF4jQ5xZMjNxLhpcVxJRu6lnP8RYbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845042; c=relaxed/simple;
	bh=ziUJJrxQoChCmmBitdk5qu+DBlIoOZvljIrMYiiSpfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVGZCs0rBxFL+5rT/a0SGKOR1ifn83A/nOFpNfBfMh0KAE71vFa2oK8wRTAhUp2o9AnmyOFxW40YsgeadQFZQRcYy3A/W9Fw+OAUBtusJnodQt771qaBJzcH7OsuRJdUhVQ80/LPeYVzWiEoUOkeIVl5HmCg8N2pKyS5VqlE5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhFhCvKr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhFhCvKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773845041; x=1805381041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ziUJJrxQoChCmmBitdk5qu+DBlIoOZvljIrMYiiSpfQ=;
  b=LhFhCvKrYFnFFRUZ0ffc0X2P8uq4lrBcnx9yNQ8T+VuTTIk7/tXNoEUt
   iMG9aYNwPNxwv8Sxp5nBLrIe2qfAE2vOCvQYg0rjfdMVNOuKr0mA83e+x
   T2Q4WZSOPcDjIL7uRxunk/I8aBy01Snz8A49GNcyEIP+i39Kb5sZImyQ5
   nEOi5Mk48PM1PSlg7hGsDjEa4SDf1r1insK/bm5HTbPy4OCRpwg2aj2u2
   A7/Gaw3LDCap0jgO/2oJ6i8JiPxjIBzEWacdWS7rbeB6aYa2O87xwbqnZ
   ukFAqrDCHAQw1uOUgUPyuoXHHHNtgEyuQop9APp4wzajRH7RF68Qm7WYl
   A==;
X-CSE-ConnectionGUID: N7xsQILZR1G83jW7r+lVKg==
X-CSE-MsgGUID: aaPxn8uiTBeKyuO1wIxXVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86257299"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="86257299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:44:00 -0700
X-CSE-ConnectionGUID: Sw49CquMS4WKUCtZQP9r0Q==
X-CSE-MsgGUID: JbrpFaUZRPWTM4c59pGXGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222704468"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:43:57 -0700
Date: Wed, 18 Mar 2026 16:43:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: adc: ad799x: use devm_iio_device_register
 and drop remove()
Message-ID: <abq6KlV7wSgAse_f@ashevche-desk.local>
References: <20260318092715.42538-1-architanant5@gmail.com>
 <20260318092715.42538-5-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318092715.42538-5-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 02:57:15PM +0530, Archit Anant wrote:
> Convert the driver to use the device-managed versions of
> iio_device_register(), iio_triggered_buffer_setup(), and mutex_init().
> 
> Use devm_add_action_or_reset() to ensure that the VCC and VREF
> regulators are disabled safely and in the correct order during
> driver teardown or probe failure.
> 
> Because all resources (buffer, regulators, IRQs, IIO device, mutex)
> are now fully managed by the devm core, the unwinding order is
> guaranteed to be correct (reverse order of allocation). We can now
> safely remove all manual error handling goto labels in ad799x_probe()
> and delete the ad799x_remove() function entirely.
> 
> This eliminates boilerplate code and prevents potential resource leaks.

...

>  		st->vref = devm_regulator_get_optional(dev, "vref");
>  		ret = PTR_ERR_OR_ZERO(st->vref);
>  		if (ret) {
>  			if (ret != -ENODEV)
> -				goto error_disable_reg;
> +				return ret;
>  			st->vref = NULL;
>  			dev_info(dev, "Using VCC reference voltage\n");
>  		}

		if (ret == -ENODEV) {
			st->vref = NULL;
			dev_info(dev, "Using VCC reference voltage\n");
		} else if (ret) {
			return ret;
		}


-- 
With Best Regards,
Andy Shevchenko


