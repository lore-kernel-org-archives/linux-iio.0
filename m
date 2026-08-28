Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440E3E121A;
	Fri, 28 Aug 2026 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903822; cv=none; b=SBAqdKbhUfPWPu1hvUGUfyDGvC2Z4JQKo3l2iyLnFixqj/6bq8UQ+rcTqBDQ/jmjVxjiwfpq+yx8GpXCAbVFtV7d7pyujfpGt6ZxVnadctAWV5wsTV6FKGEd7quPJiQLgG4FKgSQGett91feO3IsxxcXILjs6cICT70y9rxD0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903822; c=relaxed/simple;
	bh=R70wEeD95Ez14OJnBwZ8Yp8VLg25DuhSysK4YBCSnrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYcDnUM43+Bw5kWP2bmPXJvuGB2EC6NUayMcDCqhWs9Ov0b1cwM47oDUhCz0LniyJP06GcRqafvKcwXnJ93zuortcTB7DNe2tm4JFqa3SGpt+bQ+Bz1Fy/vdvPoTv5vWy3kProoUCgeIaoIj00Wgna6Eo/dlIP4QgTYdshVYlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWtX27jB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWtX27jB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787903818; x=1819439818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R70wEeD95Ez14OJnBwZ8Yp8VLg25DuhSysK4YBCSnrk=;
  b=dWtX27jBx0ceVypPAm1Zw1HcuJ5W4BSG869CAGhXfwhr93rRwqjyGeTi
   5WrltncIhPjs7hnDKEqZWZcEw/AVXFUlsAjhl83ZJFD2+IZN9eMtJOqgg
   8tkWK7t+D2h0Fd+fMiAV9dVsybKDv5I8ZtFPMwne82VcDmnnuU8E0myYL
   Ms8PsTdO3VhptBUg21+Y8BaJT4ouMukK6TDdYwEw/bLN3beXVzY7Z7yr+
   sU83qRNpPwUfG+EaMb+2kwkOpUKZFIp4In4SWyIDPOKKcbvMrcdDnk84+
   ud63IH/B3bBUA+iwUl/QcCzykjZRQMWg3l2PJtT55w/gc6xxJ8LJBiDCj
   w==;
X-CSE-ConnectionGUID: IGlT9HUdS02FIv7AmLNBkw==
X-CSE-MsgGUID: vSUcsTfxSWKcyByJdC1DFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113942893"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="113942893"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:56:57 -0700
X-CSE-ConnectionGUID: L3RfM2LtRR6OaGMFqAQHbw==
X-CSE-MsgGUID: F0aDSmwwQ36hPVZRzKofug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="264322868"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:56:55 -0700
Date: Fri, 28 Aug 2026 10:56:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: accel: kionix-kx022a: Prevent memory leak
 and fix state
Message-ID: <apE_RZJu37iMuWnJ@ashevche-desk.local>
References: <cover.1787901813.git.mazziesaccount@gmail.com>
 <9e4453fcc00df6ec988207df8916226d18aecb20.1787901813.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4453fcc00df6ec988207df8916226d18aecb20.1787901813.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 10:40:51AM +0300, Matti Vaittinen wrote:

> The driver allocates memory for samples at buffer enable path. If regmap
> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
> allocated memory is never freed. Furthermore, the state information and
> previous hardware configuration(s) aren't undone, potentially leaving
> WMI interrupts and buffers enabled, or driver state flags wrong.
> 
> Free the memory and revert the hardware configuration and state flags on
> error path.

...

> static int kx022a_fifo_enable(struct kx022a_data *data)

With

	struct regmap *map = data->regmap;

>  	guard(mutex)(&data->mutex);
>  	ret = __kx022a_turn_on_off(data, false);
>  	if (ret)
> -		return ret;
> +		goto err_free_out;
>  
>  	/* Update watermark to HW */
>  	ret = kx022a_fifo_set_wmi(data);
>  	if (ret)
> -		return ret;
> +		goto err_wmi_out;
>  
>  	/* Enable buffer */
>  	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
>  			      KX022A_MASK_BUF_EN);
>  	if (ret)
> -		return ret;
> +		goto err_wmi_out;
>  
>  	data->state |= KX022A_STATE_FIFO;
>  	ret = regmap_set_bits(data->regmap, data->ien_reg,
>  			      KX022A_MASK_WMI);
>  	if (ret)
> -		return ret;
> +		goto err_buf_en_out;
>  
> -	return __kx022a_turn_on_off(data, true);
> +	ret = __kx022a_turn_on_off(data, true);
> +	if (ret)
> +		goto err_on_out;
> +
> +	return ret;
> +
> +err_on_out:
> +	regmap_clear_bits(data->regmap, data->ien_reg,
> +			  KX022A_MASK_WMI);

in particular this will be

	regmap_clear_bits(map, data->ien_reg, KX022A_MASK_WMI);

> +err_buf_en_out:
> +	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
> +			  KX022A_MASK_BUF_EN);

	regmap_clear_bits(map, data->chip_info->buf_cntl2, KX022A_MASK_BUF_EN);

Which saves a single line, and the followup may shorten the existing code even
more.

> +	data->state &= ~KX022A_STATE_FIFO;
> +err_wmi_out:
> +	__kx022a_turn_on_off(data, true);
> +err_free_out:
> +	kfree(data->fifo_buffer);
> +
> +	return ret;
>  }

-- 
With Best Regards,
Andy Shevchenko


