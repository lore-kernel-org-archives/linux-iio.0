Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B52459DC;
	Sun,  8 Mar 2026 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773001352; cv=none; b=udbI93ngJ/aWeRSdgs6fGy6v0Mcw10Pgp3iv22A80bcnt/ufG1Ae1Vhf0da1AC0D6heNdEhPulYq6FjPF5CK1khaU6crSlCcoxTs9J691PcfJTuSNtqe4JWWHRV1eXkBGMfBjHwaAJoGNn0wcjtNgHdBWm+x4srOM4BP22qRlDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773001352; c=relaxed/simple;
	bh=VAn6oWZrHgyIqgvS89SU861WBQxC5ZGRiTwga+iIROQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm7dPvZA1pXY8UxlS9wPYI2RHoJiKRpet1kCr5U8b4Mi1IbfajbP57gx+Hm4lBatQotetUzZGPc//rfu9qZA4JTFCjECS/1H3Jx1qyDcZVbhLYm0eEDfFaUg59J6+WoHF7XMvPb5BhCefj0I2wVlRGynyasQLG+w36Ytv8hWp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kz8w9IN/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kz8w9IN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773001350; x=1804537350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VAn6oWZrHgyIqgvS89SU861WBQxC5ZGRiTwga+iIROQ=;
  b=Kz8w9IN/XwZosIgyjMja85LiVxsWKqGx+w5E50zzabRrbajW6SSUZ+eL
   OidlLv1VW3C9Cr003VD0fgt+LaFHUDHfqbIlAKPdOnIk1wepEDlgu6w0F
   itb2ZIPwUcHmR+C3NlBCEmj9eeyyHAHWuRFDaG5yHKhTz3cXc5xIat6SJ
   oshVa+3DYVGaI/HU7lnYDxRZijpNepR3Iu0EmKXPYKvbBpHUiWwVDKpFy
   q0BH3ace812CWySmR80r/s8K3d0L051K5wLJJFT5VJVlU6jW/xNBXJgg6
   zEuTvqOSFsZ/tzan8nZQhEPQbDG99X+ylJAD3qiykvrjYZK6473QmwRdI
   g==;
X-CSE-ConnectionGUID: Xjd1t4A4Thqnb1ik4SxikA==
X-CSE-MsgGUID: 9W7/MvsJSqiRiGWK8XdZYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="96647852"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="96647852"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:22:29 -0700
X-CSE-ConnectionGUID: Favy4h7YRNyvkvzW3YJK9Q==
X-CSE-MsgGUID: x93wK76nTRqe3NHd2gYZsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224494302"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:22:27 -0700
Date: Sun, 8 Mar 2026 22:22:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: Re: [PATCH v2 4/6] iio: cdc: fix spelling mistakes in comments
Message-ID: <aa3agDSPVDjRfbBl@ashevche-desk.local>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
 <20260307104705.49129-5-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307104705.49129-5-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 07, 2026 at 04:17:03PM +0530, Shi Hao wrote:
> fix incorrect spelling in comments
> 
> - becaue -> because
> - reenable -> re-enable

...

> -		/* reenable any irq's we disabled whilst changing mode */
> +		/* re-enable any irq's we disabled whilst changing mode */

While at it, capitalise IRQ, but I think the entire "irq's" is confusing
looking at the code.

> 		enable_irq(chip->interrupts[0]);
> 		enable_irq(chip->interrupts[1]);

-- 
With Best Regards,
Andy Shevchenko


