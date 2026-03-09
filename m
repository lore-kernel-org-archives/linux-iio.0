Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E053A7F4E;
	Mon,  9 Mar 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075022; cv=none; b=latUGS60iZzgr6egOuT+pihDvMzQtokUsfcIayBzNpOFC1IJIWLOBba4bUALinD+3CsbDcIovHQN1H86a7yQoXssbFnGi45nuO/kU2qw/zOC0rxxMiRZeKStPI7CnNLJmmx05B/s2W+1dpvYC4lJ+zTyTrPBneZcDJorCgkgBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075022; c=relaxed/simple;
	bh=J36kJ3gMxvxVUNgtL2n+oRt+1dh7m+m3HbyMbYeNUZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgIAsKe1lQ6YTUSsuhCDT9aguMsHkhGYW2n184dkMJjVaT31WPenSbJOe7g89dg2Vclr1IDE0Ud7E39JA3cr5oHoNOlqiYlV1pr1J33X0EuRA/pRVZWh835ynhNDY+yEiASlsOHuOO8NYjR1T8jDhJRzv+Fy2yTQbplzi4y4its=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+uAdcKK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+uAdcKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773075020; x=1804611020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J36kJ3gMxvxVUNgtL2n+oRt+1dh7m+m3HbyMbYeNUZU=;
  b=n+uAdcKK0OTn/4db/TlUSIl7LAugPpwj5T/MJVqOv1wECFV8uFJxVxNw
   RekRx8NE+GqP0gmJuuwC3RiruVewfrgDGlRojotXAbg5lbM3CVG2exewF
   2PQkQlNxKvNM2rwa0nv69fbpTpy9iB+xcRjQenhNPpaXzRJYc9f1/+gq/
   2miKZ9EgCAprGtKdJzFHj+s+CNP86tO9Bj0g8acnppE0EwW+siCToOw0A
   ON2RohIH6+ZLNjvR2i+UfJmL2mduCg/TiFPAfzSbsNpp8DcqxkyyTedhH
   gojxi65mRnjiWBkK81rIiRKNRRBe/0zbWPMlibVoG6ATN5iA1vESb4VZO
   g==;
X-CSE-ConnectionGUID: 1mtZixxfSO6yU6SyV8cITg==
X-CSE-MsgGUID: cpECphMLSl6fHALwkk9B8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84814662"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84814662"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:50:19 -0700
X-CSE-ConnectionGUID: DYMO4PotRi6MmSCQveK/Hg==
X-CSE-MsgGUID: +OqjJR/7RFOVN6ybEpqr/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216713293"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:50:17 -0700
Date: Mon, 9 Mar 2026 18:50:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: Fix Vref validation [1-999] case
Message-ID: <aa76Rz-I-FRpagWU@ashevche-desk.local>
References: <20260309-mcp47feb02-fix1-v2-1-6a5ef30e4b27@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-mcp47feb02-fix1-v2-1-6a5ef30e4b27@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 02:12:23PM +0200, Ariana Lazar wrote:
> Store reference voltages in uV instead of mV to avoid invalid error code
> in dev_err_probe() call. Vref variables store the actual value returned by
> devm_regulator_get_enable_read_voltage() function instead of the results of
> dividing it by MILLI. The corner case [1-999] divided by MILLI of the
> voltage reference variable value would become 0 is covered too.

...

> +	vref_uV = 0;
>  	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
>  	if (ret > 0) {
> +		vref_uV = ret;
>  		data->use_vref = true;
>  	} else {
>  		dev_dbg(dev, "using internal band gap as voltage reference.\n");

>  	}

Thanks, but in some cases this will be rewritten. Why not put the assignment
into the 'else' branch?

...


> +		vref1_uV = 0;

Ditto.

>  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
>  		if (ret > 0) {
> -			vref1_mV = ret / MILLI;
> +			vref1_uV = ret;
>  			data->use_vref1 = true;
>  		} else {
>  			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");

-- 
With Best Regards,
Andy Shevchenko


