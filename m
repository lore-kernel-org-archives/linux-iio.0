Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AD3DBD73;
	Wed, 18 Mar 2026 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844859; cv=none; b=I7V473tnJ1em/nPdQ+MU7TPJZ17IPO1beICFpsvrw3aYn1aWcF1Ggh/ThpqSrXcq2SYBjX1iHiwIvTRXbN/mjen0dIQxr7z+2btvNllQy4UV/M3yoKsAUkoz5by+/+HW71wfwPRgKetx83JuR6nyoIeZ6VWV/aPOIJw9o945CTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844859; c=relaxed/simple;
	bh=qmx0FR4aJBmqTxYHrYV3jbj/vc9cdEQpEDxq1Me5jVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB/PWsyoWBpchl7BRR2jJU5uyvoVRjAQC/y8AURRYQX1ksFCOvTEU1k+TpEf8rwJ3+TuVYj7o9xIn1tw6HBHeqDdq1G26cah++9P1ForZCzZFZ09hA5kugQXrEXlqE9Dere2xMINru/EornrwRd9PE8PekUgaKfdwF9MNBiSHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P72TJqJ1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P72TJqJ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773844858; x=1805380858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qmx0FR4aJBmqTxYHrYV3jbj/vc9cdEQpEDxq1Me5jVo=;
  b=P72TJqJ1Tb876FQSD5EnigyTR5kFFJK74D1eEt/aMqpZJgvtwEfE02x3
   wOH4YqtT/+uTln0/d6aTRwr9V+2H56o9rEkxY3Bnu0QX95FM/Mr3/NkwV
   tY9JGhkhu4yzCGKcNFqUOUdWNC0MwaJ467YdXm7xEjRgKOmedGgfy03+C
   oEHhDb9vf/RGMy7UeRifPGQv1WnHOGkku65Eed/1/X7OlP6reNuVtEqk+
   WSnTrM2WSAiaS8iX/iAmGAzky1v1vE/4e9Mac/o2qIh+BRKgCl4FY9RSr
   ldLPsFQR1OYyhtiFfqRSlhnDLSgpAM7YwvUzf7qqADXAaBI+ZOtSoGptv
   w==;
X-CSE-ConnectionGUID: UmOKgBEKTke4323hCXhsrA==
X-CSE-MsgGUID: P8z9GNhtRCuX2uV5SV5oJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74788016"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74788016"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:40:58 -0700
X-CSE-ConnectionGUID: 746yei+tR5eqBGnFtsSUIw==
X-CSE-MsgGUID: PMR3fvouTBiGtIz3kS056A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="245671427"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:40:55 -0700
Date: Wed, 18 Mar 2026 16:40:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: adc: ad799x: cache regulator voltages during
 probe
Message-ID: <abq5dbYrYuq5DQ5J@ashevche-desk.local>
References: <20260318092715.42538-1-architanant5@gmail.com>
 <20260318092715.42538-4-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318092715.42538-4-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 02:57:14PM +0530, Archit Anant wrote:
> Reading the regulator voltage via regulator_get_voltage() can be a slow
> operation. Since the reference voltages for this ADC are not expected to
> change at runtime, it is inefficient to query the regulator API every
> time userspace reads the IIO_CHAN_INFO_SCALE attribute.
> 
> Determine the active reference voltage (either VREF or VCC) during
> probe() and cache it in the state structure. This improves the
> performance of ad799x_read_raw() and removes the dependency on the
> regulator pointers during fast-path reads.

...

>  	case IIO_CHAN_INFO_SCALE:
> -		if (st->vref)
> -			ret = regulator_get_voltage(st->vref);
> -		else
> -			ret = regulator_get_voltage(st->reg);
> -
> -		if (ret < 0)
> -			return ret;
> -		*val = ret / 1000;
> +		*val = st->vref_uV / MILLI;

Not sure I understand properly this MILLI in conjunction with FRACTIONAL_LOG2
below. Is this simply millivolts? Then we have "(MICRO / MILLI)" pattern as
of today to show that in a better way.

>  		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;

-- 
With Best Regards,
Andy Shevchenko


