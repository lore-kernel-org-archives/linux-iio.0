Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A02FFDDE;
	Fri, 27 Feb 2026 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176112; cv=none; b=uuIakGnIJzuJ86A8rXEsBWRVHHryCRl6nKGQBAvohL6IIHsLDF+43em9R8dRouQHtVePBR57V8jzd+rN5uYK/1VREHGaawnefEpISEfUFP6Xn/34UfNOQ/8L1Zk/9BNkh9duFDEWKsK2Kvl1Rk+9MGj2l3uWLXTAxpLBlrvey2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176112; c=relaxed/simple;
	bh=oNkOsySLZXtWpxHHlPJZlC+CreYb5zYlLRF9pwDRJBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgKhqzTtvh1v2vz4urUP/cfnyk3iBvWiQlJFnJX3WEpzyHCQXO2MJPqXKsQmrJxepHfETuc0wtKSmGE106jAHtBWCoIIK4ZFBGZmgYrheAykTseVPXQRKMQnx6CdCCp4radLp68iW3nZcVPpEwoFUjzvQxL4mUhkB6dkxya0qII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7XYmFqf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7XYmFqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772176110; x=1803712110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oNkOsySLZXtWpxHHlPJZlC+CreYb5zYlLRF9pwDRJBg=;
  b=V7XYmFqfcLIX7ARZDmsMmeyqU+gTjxJnqCivd+OeS7S8MnhOkqer6+9Q
   XMztb7SwAfBvy7dW7ddpWqVqRZ1wsIECIppToEjvFoIvOWXpHOf9njSwg
   mUMmYatsJ2V9XQcG1XEdNQsXRLcj/HBU4W8/b+O5PwVBiL9gtnnJ+PvUE
   A+IrH4d57CYeJfyRRZGzA9GxPKCgpDnb2OCe/B2PjAud6H4LD4ks0WNa5
   qbq2w23QZ5DIYH8IeAMiMMNwD7RCHZli8NH0Tf1sHFi/8iq+0TjPuinhd
   ei9x7FhrlQfpZCnKEfVc9LsFL+P6FU8IaHLRFpwNTUwDBKanOd324A1ng
   w==;
X-CSE-ConnectionGUID: +NKg4tccR9qvXbiODgGhpA==
X-CSE-MsgGUID: xGhKalBSTYa6LOImhIgIyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73319668"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73319668"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:08:30 -0800
X-CSE-ConnectionGUID: hVOGkOlpS828j0hcPu/85g==
X-CSE-MsgGUID: gEuNhcOmSuOwmfSG2w6Nsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="247338117"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:08:28 -0800
Date: Fri, 27 Feb 2026 09:08:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: filter: admv8818: Simplify locking with guard()
Message-ID: <aaFC6XGKFb49rmHw@smile.fi.intel.com>
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-3-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227061424.1135505-3-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 12:14:23AM -0600, Ethan Tidmore wrote:
> Use guard() instead of manual locking to simplify code.

...

>  	ret = __admv8818_lpf_select(st, lpf_corner_target);
> -exit:
> -	mutex_unlock(&st->lock);
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Why not

	return __admv8818_lpf_select(...);

?

...

>  	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
>  				 ADMV8818_HPF_WR0_MSK |
>  				 ADMV8818_LPF_WR0_MSK,
>  				 FIELD_PREP(ADMV8818_HPF_WR0_MSK, 0) |
>  				 FIELD_PREP(ADMV8818_LPF_WR0_MSK, 0));
> +	if (ret)
> +		return ret;
>  
> -exit:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> +	return 0;

In the similar way?

-- 
With Best Regards,
Andy Shevchenko


