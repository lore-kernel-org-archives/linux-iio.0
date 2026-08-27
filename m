Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B6357D18;
	Thu, 27 Aug 2026 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859183; cv=none; b=JDhTF42/WbFWU7PuzTf/PeS81iordDJrwqaLBBlzWS6dvHNggcmk/7ib8Yk6xA10z//E8r3Vvr4CvGIFkRzJt9Bw2OdENPzCVWxOUrbIThqBayZY0a/kpzY48iY1WvpO4RilixcdSMLcT7ugRFduW2UpfU66Gun+1oPBtJxW1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859183; c=relaxed/simple;
	bh=k2zvWP+jd3A9dnjgl99iDXAuGXLIZAF6qg+0gsTZiiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCXW2GXpDNjPJddRgAu9Jtb4dhuNEcBWtKMwy/5OLpQvQINn4/A0JK2mJI0IpyoEA8PGT7y5Z3JAnrzp49FREWsVBBPOrtgpytDxS8Vzi5tlVN84GGTuj//d7Eptk+LZ6CoSR2wx0MlJfuVeXuqKIAXzplESeLCkjL3wREV3TkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5tfI/Gr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5tfI/Gr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787859182; x=1819395182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2zvWP+jd3A9dnjgl99iDXAuGXLIZAF6qg+0gsTZiiQ=;
  b=Z5tfI/GraxeXQm0IZsoHn6NAIZDhsrWe5UNfPkvZDA9BPpoQ/VHxhiCl
   Ob8PrQhyWeQ4oW7S8zCMiL6DOJDcMXURhI3MxvwG50QzrT7QtfjOu45y7
   aX45vP4qEV9Rvrx/cfM4PDXVdt9LJCkVUPD3SI67KAJJIXQAn514LDLzK
   ffo2qkwgSZilWfhLZ5LP+Irj97jRj9gG6LJkOFjfmTjOIDP1qsyypLoX9
   0Esbm/Y1JX9wWZCYplbbX6zlvqCiLyQx7qFNn1QlCPOZS+iuY+9xCBPP9
   JdpJfQCHZxANvcWgSWynCq5v2fTUPstehI4LFU+CcvLTMyym842jjWzjJ
   w==;
X-CSE-ConnectionGUID: 0IE1eLMzTKiEitjkQS310A==
X-CSE-MsgGUID: WkJp34kyRbWx10j2ZUlzYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88245262"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="88245262"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:32:57 -0700
X-CSE-ConnectionGUID: idRS5hEMTRmgCAPJp6uhhw==
X-CSE-MsgGUID: ZggOMbR4StCTE3ZxTLpTkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="266152638"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:32:54 -0700
Date: Thu, 27 Aug 2026 22:32:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] iio: adc: ti-ads1015: replace custom shift macros
 with FIELD_PREP/GET
Message-ID: <apCQ5MP8Q3wSNEQb@ashevche-desk.local>
References: <20260827172100.39176-1-architanant5@gmail.com>
 <20260827172100.39176-8-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827172100.39176-8-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 10:50:59PM +0530, Archit Anant wrote:
> The driver currently uses custom _SHIFT macros and manual bitwise
> operations to read and write to the configuration register.
> 
> Modernize the bitwise logic by replacing all manual shifts with the
> standard FIELD_PREP() and FIELD_GET() macros from <linux/bitfield.h>.
> This improves readability and prevents potential bitwise errors.
> 
> Remove the now-unused _SHIFT macros from the top of the file.

...

> +	cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) | FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
> +			 FIELD_PREP(ADS1015_CFG_DR_MASK, dr);

Indentation is broken.

...

> +		cfg |= FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
> +				  data->thresh_data[chan].comp_queue) |
> +			FIELD_PREP(ADS1015_CFG_COMP_MODE_MASK,
> +				   data->comp_mode);

Same issue here.

...

>  static int ads1015_disable_event_config(struct ads1015_data *data,
>  	const struct iio_chan_spec *chan, int comp_mode)
>  {

	struct regmap *map = data->regmap;

> +	unsigned int val = FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK, ADS1015_CFG_COMP_DISABLE);

Split the assignment.

>  	int ret;

...

> -	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> -				ADS1015_CFG_COMP_QUE_MASK,
> -				ADS1015_CFG_COMP_DISABLE <<
> -					ADS1015_CFG_COMP_QUE_SHIFT);
> +	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG, ADS1015_CFG_COMP_QUE_MASK, val);
>  	if (ret)
>  		return ret;

	val = FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK, ADS1015_CFG_COMP_DISABLE);
	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_COMP_QUE_MASK, val);

-- 
With Best Regards,
Andy Shevchenko


