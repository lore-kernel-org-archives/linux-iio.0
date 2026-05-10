Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C57263F44;
	Sun, 10 May 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778417586; cv=none; b=P33uJgVcEaM4pscX/CfGzLv5DNqQXMNt6IXEKltjzCzTa3q5+BlqlBFoHjIHo2LMYQS3CH4goLVk6SCyZm0SziGrBFKyQ386WqhiQjeJGYDY42JEWGSqINJyNf4DS+e2v5qX56pGcbzDni3O7BhP/8JWNrLGFgOhLE0S85ID7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778417586; c=relaxed/simple;
	bh=I8wANrlY/2Wbh+rBRBI1lUzRgYCso2HzE42f3NzyYts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjixg4+k9q9fyZZGkH4a+//SFpJxOhH/UtwZStlk1kudK+LbzLORhgm7qN0/Hu5I6aqnkGK+JO1Zq+mt4XZsK0QgEwKD/NioS4gI6C1eqwaa7Fj2GCFXjUeP5XQ/cnbjc505PM+hJPVhRyuHv/1xa27WCsMUWdOflbVXe8Ovq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQgRuozR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQgRuozR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778417586; x=1809953586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I8wANrlY/2Wbh+rBRBI1lUzRgYCso2HzE42f3NzyYts=;
  b=UQgRuozROEgZBtZKaViMFgnVKrQiVZK+wQETArGwgtRGXHj+e7z4Prkk
   5OAL/wd7tE0IBwN7/fvb9aniuCNloVJaQ3S7iSEhOmkrfmxH9QChsoWAl
   88u8Us4l+1ZwSOYaVXxm8QkERF5byQYP1YVyXSDr9JzQfkCRq1tpiyFZq
   njpHh3Vocm8p7oeJhltFueN1zHxVcrdFZA7vdX7cQxUpgx9uKwZI+wU4A
   Zmo6zdNkCV4+x0ngwg8IYRL7plsH5Byl35sTpSJYMevtkpS3kPLU+Uy83
   u0ZCbCXVb+g+itB4i2Y/ldFc+56HHpndmofAmNTQLCGQfTMPkmlwuytr1
   A==;
X-CSE-ConnectionGUID: QDrd/cRkRE6HDYUXS+VFyQ==
X-CSE-MsgGUID: 5CeXgTg+TbSL3NgPeHXSrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="66859060"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="66859060"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:53:05 -0700
X-CSE-ConnectionGUID: ufJqHpAqQcmBRKMu/SG55g==
X-CSE-MsgGUID: vmua/lA9TY2/z4ARVlHwxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237312772"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:53:02 -0700
Date: Sun, 10 May 2026 15:53:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: bail out when bandwidth/filter is not
 in table
Message-ID: <agB_rPw8fO8o3TPf@ashevche-desk.local>
References: <20260510023500.61036-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510023500.61036-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 07:35:00AM +0500, Stepan Ionichev wrote:
> bmg160_get_filter() walks bmg160_samp_freq_table[] looking for the
> entry matching the bw_bits value read from the chip:
> 
> 	for (i = 0; i < ARRAY_SIZE(bmg160_samp_freq_table); ++i) {
> 		if (bmg160_samp_freq_table[i].bw_bits == bw_bits)
> 			break;
> 	}
> 	*val = bmg160_samp_freq_table[i].filter;
> 
> If no entry matches, i ends up equal to the array size and the next
> line reads one slot past the end. bmg160_set_filter() has the same
> shape, driven by 'val' instead of bw_bits.
> 
> smatch flags both:
> 
>   drivers/iio/gyro/bmg160_core.c:204 bmg160_get_filter() error:
>   buffer overflow 'bmg160_samp_freq_table' 7 <= 7
>   drivers/iio/gyro/bmg160_core.c:222 bmg160_set_filter() error:
>   buffer overflow 'bmg160_samp_freq_table' 7 <= 7
> 
> Return -EINVAL when no entry matches.

Sounds legit and proper behaviour in this case.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


