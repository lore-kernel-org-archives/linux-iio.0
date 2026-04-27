Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B292D8376;
	Mon, 27 Apr 2026 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275094; cv=none; b=dzD2yP+PgXxZ/C/fWjdne6goyEL6hOm2BPVQRDIeZq3qqdB06ZEx9G1LxtTR81k8rHUxBJ1GDR6euDeotUT7YD83137mOhK/Ef8cHB3yc59PH1sGOECiKA1jKwKenD9NWqNvUwg5RB5pAjqcvnHCG7ZVXGwXokS+zYP5JDIw2yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275094; c=relaxed/simple;
	bh=thr3jWfew5iP+RyjLMHpadXLuuJAsa+/RTZpASszao4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTYSG5aYIU5EAvtZV2uaS1yVQ5QJbVTONu5M/GjUvDDi1pb+t9iqbvqKoYxSKRtrbaF1loBlArJF7aNlwkFKxV3Fdp9C1kUGW0ox1CJWCxl7leokvxftaStQWDx+AzzEzL3AiK6nBHgRW5zRYBZr6n8mqWevSy4x7xtwA18z9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGl7+h6K; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGl7+h6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777275093; x=1808811093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=thr3jWfew5iP+RyjLMHpadXLuuJAsa+/RTZpASszao4=;
  b=IGl7+h6KszUuF1F9/7Y1OJ+7U1cqx1+QI9UWEPBKGtnqDVesLutLDHqC
   4vU+DVArwedaemf64J8Ys1TwQwqVpumJLQ34tuNiV/ZmPxKUpA8ZMBIqo
   f+EFv61dsQlJ587LE/IceJcW4FFPj4j1k9ozIqxmhdomSNiuT03NdhTVb
   s4mSRYRwNJYtxpIH/GHHKStUjubE8WlKEWylmot3H+TUPS5Sn3PNaGF8v
   DpZKI/Rxd7B7qVzeBwarhdaUbSBIvQ5ec93GoN/vKZC44qdUbshy5J7Ll
   /XtkkBnYRaoXUdmVH0o2tO3Eva3kNgEhvtjYx4chmdaz3IxXiYiwpK0sH
   g==;
X-CSE-ConnectionGUID: AlrqfP/TQTaFRptKwoXacA==
X-CSE-MsgGUID: KtPxzwtTQH+Flha203wIzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="77313933"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="77313933"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:31:32 -0700
X-CSE-ConnectionGUID: jrsLKhjVR+CIijIhE4OXnA==
X-CSE-MsgGUID: Yyj1hTf+RU69hqOv4E1KVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="257081901"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:31:30 -0700
Date: Mon, 27 Apr 2026 10:31:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7625: fix type mismatch in clamp() macro
Message-ID: <ae8Q0MtuZgMxCOM9@ashevche-desk.local>
References: <20260425071615.20406-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425071615.20406-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 25, 2026 at 11:16:16AM +0400, Giorgi Tchankvetadze wrote:
> clamp() expects compatible operand types. The period calculation uses
> nanosecond constants, while the local target variable was narrower than
> the upper bound expression.
> 
> Make target unsigned long and use unsigned long bounds, including
> NSEC_PER_USEC for the upper limit. This keeps the operands naturally
> aligned without adding casts.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -	u32 target;
> +	unsigned long target;
>  	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
>  	int ret;

Preferred to keep the reversed xmas tree order (no need to resend, hopefully
Jonathan tweaks this whilst applying).

	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
	unsigned long target;
	int ret;

-- 
With Best Regards,
Andy Shevchenko


