Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EB0382361;
	Fri,  6 Mar 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798902; cv=none; b=SaIpaJy9Uqd5I0beAZ8IJw3oG1UsZ6RgSqXb3lP1/AfD1F9YaSLsk68SQy/7MmQvDexZ98MlQer0TnF+DFG1siaxmRToBBVeAh2hjrCFqvwc4Ta6Of3I/dkp4+fl8X7c16xljyquE7vL3kbgkhGjQZaA1pKgRve1K5hJhM1YOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798902; c=relaxed/simple;
	bh=klTuZw2IfxgSUEdfTpE/SnfDiLBiwXxvj2Gqun0SB9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clxnjTPyvnoHmD/jbmVI06+hKWx+zgAN0V7IHlJq0JKqLM0mvEdzg/YB+A0eWyRQY5LGL6QQw+u2yES1nDkc7xJ9vBlnrPdNzyzpT1LSwKx1xNEJx5x3ILU6nAm7uzgWejtQqq1Sic9LLmCwKUHTJsTlV57ZsULPGm7iF0zS6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHKXk2vi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHKXk2vi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772798901; x=1804334901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=klTuZw2IfxgSUEdfTpE/SnfDiLBiwXxvj2Gqun0SB9U=;
  b=XHKXk2vi8iIt9tyF6KGENflMAgWCyqz7YkTRHUZ+qT5u8XKY35wPZm9m
   BcaBkKupWhh1eDFmtK9s1bUDAvPi1uFlfILnfPMeCVkmNb1KpB1NySs+o
   m1I+uJJMb6ZatHpYGYdJ0Jlo4GTiXWKg6UVnT3b7DW2OWcAR70jFfVw/W
   d4m/+XhWe9GtYNCaHmASAofMpAqPWmJ2xLNwqtF2oqpBFJqABFViIUpv3
   eUDjaT+IniixVaUqqs7geZi21IwSU1bN1+duBiB6E+cpaI+keX5Gcd+Mu
   GJTmCwFd0CZWhlth/NlQg3Jti9ogC1YImulwJe3R5fduDmQTIiP8LTnhT
   w==;
X-CSE-ConnectionGUID: DLZ6EYXuRUiJmo2ToP2oxA==
X-CSE-MsgGUID: LxWtJDanRRyB3YBojRCF/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73096975"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73096975"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:08:20 -0800
X-CSE-ConnectionGUID: lbwt2nAoTHevC7HHl+X9Uw==
X-CSE-MsgGUID: +Ksmvh1dQjSSSsrr17WL4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="218941248"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:08:18 -0800
Date: Fri, 6 Mar 2026 14:08:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chunyang Chen <chenchunyang0908@gmail.com>
Cc: kuurtb@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads1018: fix type overflow for data rate
Message-ID: <aarDrwAITxtS1ziI@ashevche-desk.local>
References: <20260305021550.120614-1-chenchunyang0908@gmail.com>
 <20260305124302.129637-1-chenchunyang0908@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305124302.129637-1-chenchunyang0908@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 08:43:02PM +0800, Chunyang Chen wrote:
> The variable 'drate' is currently defined as u8. However, the data rate
> values in ads1018 can reach up to 3300 Hz, which exceeds the maximum
> value of 255 that a u8 can hold.
> 
> Change the type of 'drate' to u32 to match the data_rate_mode_to_hz
> array definition and ensure the data rate is handled correctly.
> 
> Fixes: bf0bba486b5b ("iio: adc: ti-ads1018: add ti-ads1018 driver")
> Signed-off-by: Chunyang Chen <chenchunyang0908@gmail.com>

New version — new email thread.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


