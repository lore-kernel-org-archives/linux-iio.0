Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F731F992;
	Tue,  9 Jun 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015373; cv=none; b=Wiimd1cQwUD4rUWCRseVBIA4saXFNdxjxwMxIBZv5JZXaJ4GpzvPhQc2xFqDo/XQs2uu9DEoaJ3vwq0/BoIV0P5i0ifoIqUINrQsy6U0X8sYHMH3hO3kYZew0hHn1ngGdWAIjeXeE/7UZIALQgVKCqS222+iS1G1VP9PCN6b8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015373; c=relaxed/simple;
	bh=kps1A+p+xxXbEA0Y3F4FbAx9LLRdA+ykCzh4vSJC9JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbaYZSiDwUliAtv5TICLHklUiZahGi5L6nWut8uW8SVDQI6crg8TkqFdJo1b7HGXdDw3wX9Dp9zf7Fv4WJBE1a65CmeK34KWKRASe8ZsKviGRvL/i+2NCqvbAaEcIcFm4kycly6M8MVNcEPU83OQIka2PUIRX2080x/wtn74DcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcsAio2z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcsAio2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781015373; x=1812551373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kps1A+p+xxXbEA0Y3F4FbAx9LLRdA+ykCzh4vSJC9JE=;
  b=hcsAio2z/YFiJGd6UOgCK94Pe6hzd4CsSzbU+oDBi6BrMOSTB8QRx5I3
   +O2+kqA0dYZB7AiZw3ytn1z5TAN8V4L3y6IuKkxzK0Ql9woZAcDXCO8xC
   /kBBNydNkboKwBrWzkKKn0id6KD0ZctM0v4RQ/HN8A8UI3RQLjw8vRyJ0
   YIxoRoEvkpBwebahThLuDPn5hcZcVi9kTisewjqCrEcscg1fJJ49Gmw5q
   /+z1oP5t0roppEbV6r1lNyxNTbWCbhHMUflxb3TC0nqkrNlh1oAwCpxnU
   uHn+JEjIWPHRxyUKRfHatGjgQP4u9nFdgfQ/Pw6vdrXul525rZmI5AHxS
   g==;
X-CSE-ConnectionGUID: XLDl4oBuS0aysWTg0VofFg==
X-CSE-MsgGUID: HrrmUwM7TpOpsvMMYkxWow==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85624916"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="85624916"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:29:32 -0700
X-CSE-ConnectionGUID: GFr3tAyKQ0+O4jnctLy/Lw==
X-CSE-MsgGUID: OagBLVb0TYm393725TLlyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="241735378"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:29:29 -0700
Date: Tue, 9 Jun 2026 17:29:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
Message-ID: <aigjR-Pf8Vy3sjxy@ashevche-desk.local>
References: <20260609012145.87180-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609012145.87180-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 01:21:45AM +0000, Hungyu Lin wrote:
> Replace open-coded bitfield operations with FIELD_PREP() and
> FIELD_GET() helpers where appropriate.
> 
> Also simplify bmc150_magn_set_odr() by returning directly from
> the matching table entry.

...

>  	ret = regmap_read(data->regmap, BMC150_MAGN_REG_OPMODE_ODR, &reg_val);
>  	if (ret < 0)
>  		return ret;
> -	odr_val = (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR;

> +

Stray addition. This calculation is coupled with the above regmap, so I see
a value of having no blank line there (as in the original code).

> +	odr_val = FIELD_GET(BMC150_MAGN_MASK_ODR, reg_val);
>  
>  	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++)

...

The rest looks good to me, I dunno if Jonathan wants a new version (probably
he does as IIO closed for this cycle anyway).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


