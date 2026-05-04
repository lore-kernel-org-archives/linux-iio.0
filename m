Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1212E1E9;
	Mon,  4 May 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909592; cv=none; b=rZgSEkjslaYPEL7RG3Yhf1KWTQNHKZju15yX9hS4WOFKf7wPiS3beOmUrmqBszej0Y54663xPf01l3rMUBP4EVGcA28XdZ2I6557tsqibQboRMNs5PNLTSFHNSr7rmELSrxG8Oq6m6vi7r0MIOUJiNjr67df60LN++/9FsEoJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909592; c=relaxed/simple;
	bh=CYm8FgIgQtg6b7/viqj1XeEfaiD+lR1XoYD/Zo8+3S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv8Oin54sv7pdSADxbv17ZMSO59BeH8GBfffihwALK8xwhdmEFGzbBhymvZCastYxT6DFz15R38T8lzSjQ8PtGJdOCkgLCJQuVJTOvfWAhjbgA7rv4UFQ2HOEDNdJ0wDR76TZqGFb1sTxvIdN7U71npCM8Vd1Mb/nYLUkuFgtdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iol6vBuZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iol6vBuZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777909591; x=1809445591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CYm8FgIgQtg6b7/viqj1XeEfaiD+lR1XoYD/Zo8+3S8=;
  b=Iol6vBuZItkTfDUZl09ajLX73op7uTRIh55Gz1eiPNfo940+Pt8ynSFg
   9hX6obJkq4aCw3+IbGjkq7KNW4g5QsetsdF2ElcNDq2KsmdKqjhhWYtUu
   +SuGv3i2Bt3sKim84mLe7tymYA2BZJxx1oDtWcEE59S8Q/IFSwpFlqLbW
   X5n1S/iH6JhtP6rtG6EshwGTbvfKjhkrsqg7InCCGI4SFBNugiBUYaO8R
   rdyVWrWEGnx4iulEE2oU7Zf34cg+XEVTht9ZDJQlzWrQyrOd7TZ6ZsZca
   Ksdf9oqB0tA3un7hz7mgRgKhyTsC8Z3vDKwUPbMUN6t2ywvXO7G/HorSp
   w==;
X-CSE-ConnectionGUID: CQjKUIIoSEunGm5EJqWEEA==
X-CSE-MsgGUID: 2gExH5dBQL6rZAInIF3gPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="77787471"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="77787471"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:46:30 -0700
X-CSE-ConnectionGUID: VMcrsg8cS8CMuL9ZS0UB2Q==
X-CSE-MsgGUID: qfWQx1tpQiiuiA7Qy9jWCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="259201174"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:46:27 -0700
Date: Mon, 4 May 2026 18:46:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/11] iio: adc: hx711: split variable assignments in
 hx711_read and hx711_reset
Message-ID: <afi_UWFCSUYruPFG@ashevche-desk.local>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
 <20260503120949.80292-9-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503120949.80292-9-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 03, 2026 at 05:39:37PM +0530, Piyush Patle wrote:
> Separate the initial value assignments from the declarations in
> hx711_read() and hx711_reset().
> 
> This is a small preparatory cleanup before the later loop-iterator and
> variant-specific changes adjust the local variable layout in these
> functions.
> 
> No functional change.

...

>  	int i, ret;
>  	int value = 0;
> -	int val = gpiod_get_value(hx711_data->gpiod_dout);
> +	int val;
> +

> +	val = gpiod_get_value(hx711_data->gpiod_dout);

This line should be coupled with the conditional

>  
>  	/* we double check if it's really down */
>  	if (val)

	/* we double check if it's really down */
	val = gpiod_get_value(hx711_data->gpiod_dout);
	if (val)

...

>  static int hx711_reset(struct hx711_data *hx711_data)
>  {
> -	int val = hx711_wait_for_ready(hx711_data);
> +	int val;
> +
> +	val = hx711_wait_for_ready(hx711_data);
>  
>  	if (val) {

Ditto.

	val = hx711_wait_for_ready(hx711_data);
	if (val) {

-- 
With Best Regards,
Andy Shevchenko


