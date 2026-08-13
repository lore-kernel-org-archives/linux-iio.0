Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560533382EC;
	Thu, 13 Aug 2026 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611763; cv=none; b=faUO8NUVpEhrjzrvKuJbVFUgpU4ML/krQz1cYtjyQHjZ+UXu6UMCJIuruM3HOUgoLmUgczl5a9OzHOUoOx2C2+aeFC3HtJM4AqAGWWveEHBUeVVYf3CYL3s0BMaW5Yr9L22lXCThS1rGv2FzAkfwmRTCilsw1d1Ah5vLwJSA+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611763; c=relaxed/simple;
	bh=QuULg9C73Vi9n3tj0aEhHuIZy6V/rVsELpgpI/Mh3Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/gn4UbdZJVS8ytTmUu1bqZhvnNRQSziIQtBdlAJ9erARqKv/pTEWrtyFC+U4C4NmxJwy0eygSa9TT+1VM0yEOclC8Mqp/wyfi4pBgjWzkniev+5Moq42bwQKScaquqosmwklvdhZ/ECx+SUNpGG9j0THJ+81YXrk5+fV/HbSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+e2Ancq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+e2Ancq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786611761; x=1818147761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QuULg9C73Vi9n3tj0aEhHuIZy6V/rVsELpgpI/Mh3Ts=;
  b=P+e2AncqTzfcDAcMm5PzXj+1bADmNB6E44g2HMgaiDN6/FOIYQr9nTIp
   BcdMUHmWubt3tvenLTh5iRS1fKbA5AKUB7egM95lMtzRiGwCDhXkEBEU2
   55ND2xcmOKGDbwIxd8GE/S+93h6oGpPoqcV5jP4JNi2yyQ4H9oVwNEloX
   Z/pxfz3tsTsedwkL9cvYZUO+GO8ze2d11ovHR1jeoqg10NpqurmPJMM0I
   4b2g/K/jpL5xr8Vvbg8Nx8xtKkXC9lWeC665REjdDYPwcpBdXijjH8xYW
   CM7ARakjFZd6nPueBQFIj6PcXWhJonwPpsGuZfaUSspK/ChhrFCPheL4p
   Q==;
X-CSE-ConnectionGUID: q4zPbTESR82XC7Fpe0NHDQ==
X-CSE-MsgGUID: agmbS6tcRnaXLD1wZm5zHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87305768"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87305768"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 02:02:41 -0700
X-CSE-ConnectionGUID: u5Prpb0sSl6+xZ7m09QABg==
X-CSE-MsgGUID: m945Pth5Q8C7LE57E/B22w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="302149832"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 02:02:38 -0700
Date: Thu, 13 Aug 2026 12:02:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] iio: adc: ti-ads1015: replace custom shift macros
 with FIELD_PREP/GET
Message-ID: <an2IK_bWkMReDaL_@ashevche-desk.local>
References: <20260812164433.23011-1-architanant5@gmail.com>
 <20260812164433.23011-8-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812164433.23011-8-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:14:32PM +0530, Archit Anant wrote:
> The driver currently uses custom _SHIFT macros and manual bitwise
> operations to read and write to the configuration register.
> 
> Modernize the bitwise logic by replacing all manual shifts with the
> standard FIELD_PREP() and FIELD_GET() macros from <linux/bitfield.h>.
> This improves readability and prevents potential bitwise errors.
> 
> Remove the now-unused _SHIFT macros from the top of the file.

...

>  	dr = data->channel_data[chan].data_rate;
>  	mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
>  		ADS1015_CFG_DR_MASK;
> -	cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
> -		dr << ADS1015_CFG_DR_SHIFT;
> +	cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) | FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
> +		FIELD_PREP(ADS1015_CFG_DR_MASK, dr);

Wrong indentation. Please, make sure in the lines you touched the indentation
is also correct.

...

>  		unsigned int cfg_comp =
> -			ADS1015_CFG_COMP_DISABLE << ADS1015_CFG_COMP_QUE_SHIFT |
> -			1 << ADS1015_CFG_COMP_LAT_SHIFT;
> +			FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
> +				   ADS1015_CFG_COMP_DISABLE) |
> +			FIELD_PREP(ADS1015_CFG_COMP_LAT_MASK, 1);

It might be better to keep a longer line.

		unsigned int cfg_comp =
			FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK, ADS1015_CFG_COMP_DISABLE) |
			FIELD_PREP(ADS1015_CFG_COMP_LAT_MASK, 1);

-- 
With Best Regards,
Andy Shevchenko


