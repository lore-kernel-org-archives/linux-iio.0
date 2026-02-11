Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8F350D78;
	Wed, 11 Feb 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800035; cv=none; b=E3OSzN8nkx1dur/Unj+EaDf/0CXETzgn9kKzUb8rs4w+nuQnSNK59kmNkb+X4JTLs7qBA4iAD6T6HG/rqfOw5dsj1G0kdCRLuX5Ir1yXuCzfuLhzEGpDjLgvo0bEXSmND179eyU77I20cyS8zq3rU9du7Modh+jG9tZn74qzMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800035; c=relaxed/simple;
	bh=d0IcTBDQtWjFGCyRJUk/HboharjexEM40KDCgEFaDB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDHGCi+gzYivVQ8zubqzTAmzheN5fZ5rochdRu//fea2MwSlGgouz6z1cL8ddoS5ZmNDG3cML1rqHaa26DLC+F5FtwFcArRmrWzFJHGNqbeDQhgKnw2UJwyAbcsEO2dLQBfV3AHv+rhoj4BSRpKRgIkCqhXIGGuNNmKMQSmI5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWZcYntt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWZcYntt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770800034; x=1802336034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d0IcTBDQtWjFGCyRJUk/HboharjexEM40KDCgEFaDB8=;
  b=RWZcYnttn1/k1dddBfwwpNM0ViZMnDUTCOf0jjwcbIMedyPpRY5ZcSQe
   +KvylFU9c6Vd2uv+ElKAQnVNnBXNLtRqACQXWpjr+fOmzhj4rkEoVUqAx
   3EBrBQrCQU6H871IyQNAWmjVtSOBtJT7CgghBA6K0XukEHJF31Oh9kq+7
   Fe9ELzcsamGrgdOXaAtzHXsbTobyHLFFK3LT5Uc+yZ81Yqr8TilNEqsku
   YFfD1PnImlXjDqCYuQDGahkUTkDCL1sWrGyKAI36uiNytJd0G0c1bSYXq
   IXcPC5w9FXzAlZhxrD2MKtKC+El7WWmT+5sd2N949V4ZSD0dr54LOv5md
   A==;
X-CSE-ConnectionGUID: eVv4w1cNQzyONdzwiiCOUw==
X-CSE-MsgGUID: 3vZnX+dOSAiVwvG/Lt7AxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59510644"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="59510644"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:53:53 -0800
X-CSE-ConnectionGUID: fu+YF55vQNewD3czdgaXww==
X-CSE-MsgGUID: wgqRTewhTme7ZO+qyMPsCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="249829695"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:53:51 -0800
Date: Wed, 11 Feb 2026 10:53:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: si7210: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <aYxDnAsWLqIWEza4@smile.fi.intel.com>
References: <20260211081837.8169-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211081837.8169-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 11, 2026 at 10:18:28AM +0200, Antoniu Miclaus wrote:
> Simplify probe by using devm_regulator_get_enable_read_voltage() to
> get, enable and read the regulator voltage in a single call.

One nit-pick below, otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  struct si7210_data {
>  	struct regmap *regmap;
>  	struct i2c_client *client;
> -	struct regulator *vdd;
>  	struct mutex fetch_lock; /* lock for a single measurement fetch */
>  	s8 temp_offset;
>  	s8 temp_gain;
>  	s8 scale_20_a[A_REGS_COUNT];
>  	s8 scale_200_a[A_REGS_COUNT];
>  	u8 curr_scale;
> +	unsigned int vdd_uV;
>  };

Haven't noticed, but I believe this is not the best place to put a new member.
Does `pahole` agree with me or with you?

...

>  		/* temp -= 0.222 * VDD */
> -		temp -= 222 * div_s64(ret, MILLI);
> +		temp -= 222 * (data->vdd_uV / MILLI);

Just a side note: Here is a possible loss in precision, wouldn't be better to
have it as

		temp -= 222 * data->vdd_uV / MILLI;

?

Note, if you agree this needs to be checked with the datasheet, etc. and sent
in a separate patch. For now the original way seems okay to me.

-- 
With Best Regards,
Andy Shevchenko


