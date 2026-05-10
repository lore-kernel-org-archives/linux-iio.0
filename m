Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AEC336EC0;
	Sun, 10 May 2026 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778408135; cv=none; b=JfNzviYRjpNqlEgMmE3T/WWBZnkHrjE2KQtwwHSAiLgkVR5u/NIt51hcfSSMRJFvDq2SLUbqtzEIw4/mrxaQPQcHS1+xqD039tTPrrTTr1nXdv1MYn1Dfkh5JXDrvJigl9T6Uczyfsyy3LsJ3sRQhaaGmzyB5lkAjzF6eeL30Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778408135; c=relaxed/simple;
	bh=TCoslgYWtFXtVaMKjld4JGo1RWuMBzOg8/d/BqWfKnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkdtYnk7nuFLgepjgj25e1MUUDRJMKbHy2GVyc+cH1c/0zmyhKmTvl5bvoVTmXp6Fd/ui/SS6HtItA/rILFTyIszOM36IGbZhF0MbMbHFvHuVbWdJOFVvJvlQezmAp4IutSYaL7JpzwrkA9TzD0PJ+G8jl766/P3BcPU0MYWcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTEk58Gg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTEk58Gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778408133; x=1809944133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TCoslgYWtFXtVaMKjld4JGo1RWuMBzOg8/d/BqWfKnw=;
  b=WTEk58GgkZLQuPWpswpmVelubPfyXaKDFox1rKqdu2tbRdPYow0KR/VZ
   qww6+OT6Ej4qPFkPEBWGJPthgAq/ZO8WK/ECzgkfMtu4LHCdpmpCBB2qJ
   CHarDIV27FUc7CvhhwMxYdRfpFjcqaIp66wUD9qejSHXp9XZAw7+cq/tE
   aqo2l5v/6u4LpIvz81szl0kjPwvd8bVseZjFEBas1mUMFgFu8G91onNNZ
   xvElmpPlyxcMECtF7Y0a0xXFmoSyG50yKMRc0jdDdQlcK3riJyz+OMktl
   RbSDnrItCGt5vpCT3YB2NKn4PHCCl2djmo6ifxuPmNvd++JgnstaQbvQc
   g==;
X-CSE-ConnectionGUID: aUr70gn0Sm2/U6yGvLK40w==
X-CSE-MsgGUID: DAXOSpceTH6SKIInJ1IGFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="82937680"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="82937680"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 03:15:32 -0700
X-CSE-ConnectionGUID: aKur0x1PR0W9NKnZWiQ0Mg==
X-CSE-MsgGUID: /9Kw6ssNQWe9hTh8TQoTWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239005242"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 03:15:30 -0700
Date: Sun, 10 May 2026 13:15:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: bail out when bandwidth/filter is not
 in table
Message-ID: <agBawCtL8vutEaoB@ashevche-desk.local>
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

Have you checked the mailing list archive? I have a weak memory of seeing this
or something similar in the (recent) past...

-- 
With Best Regards,
Andy Shevchenko


