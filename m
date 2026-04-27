Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5EA3B3C08;
	Mon, 27 Apr 2026 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283808; cv=none; b=npvfyvJy2f3wtD/swM9DwNkEGwUDnF7iOWH2nBD0Lv0mIWwZRiEbGSXBgyJLzYfxwTSo8cNrmO+dKyHp44AZ6T6E3oACvQKARfSpODFEk4TR6sdjt5krtd6jE6WhxipcSOzQRfrTAzTjtjJqFmgP3iGWjd1MNwcIb0OB9pjAItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283808; c=relaxed/simple;
	bh=KOZzitXMV9nSE7lRwJshgWRgzp8BX8zLULNFHbLVZys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFxgOr6LEtljJvQEMNgMWdpR4MJ/6I10QyTIkK92wjaAbUlKBGT9f86ksI98OxUT/IVgp5VsTIfgb1Lr5DrhGtZEnnCoDDO0neOw4BRL5LzNyaPqMZN6VG4UvfE9v2YM+HHNcTwhi4fqWpOFnmbokiBi32inyrYmJMyy2hBk3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyYTMzeJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyYTMzeJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777283807; x=1808819807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KOZzitXMV9nSE7lRwJshgWRgzp8BX8zLULNFHbLVZys=;
  b=iyYTMzeJTewhCge1AbuuTpK08fJS8keMBtSeWXS20h6phKmqIzu5DsuF
   zmQKoSRTZaZSOdxUuno+XXsdGR+oGwEspg9l08RUSmUmhtj8Po0vWoyVJ
   2eJozYb8bBUG66R6d48kb1cU49POYFLnyPIsh1c2hcx15KbM5YIme0zys
   YHbswT96twRD+2mmG1U9sBWtMhrZ2c9ruVgPoDf1lhMqi1DR/4N0GOhKP
   BiSNRAxTEcf/P+oXERSEhrEGWM7YX9cTf8GYb38xPV3/lJ/nRg3g08uD3
   PL4BeNuy7rAWypX8aeseJSqTCZ84uMi8ROOrR39U5rSK29i/OKMfYOv4c
   Q==;
X-CSE-ConnectionGUID: wYFHOsYmTsa1tsvBjZrsJA==
X-CSE-MsgGUID: L+SQqEb/RTiNBH+nfHjRBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="77192913"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="77192913"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:56:47 -0700
X-CSE-ConnectionGUID: DZZhGMhkQqa6TzuXfQfUSw==
X-CSE-MsgGUID: ezCgu8rRT3aNoBb3q+xvDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="230958351"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:56:44 -0700
Date: Mon, 27 Apr 2026 12:56:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, waqar.hameed@axis.com, dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH] iio: light: stk3310: Deal with the ps interrupt issue in
 PM
Message-ID: <ae8y2k6hZjhv3wNc@ashevche-desk.local>
References: <20260427094313.81460-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427094313.81460-1-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 05:43:13PM +0800, Miao Li wrote:

> On the Huawei hisi platform, if the STK3311-X chip's PS interrupt

Is it officially spelled form of 'hisi'? I was under impression it should be
spelled as 'HiSi'.

> is configured in "Recommended interrupt mode", the interrupt cannot
> be triggered normally after waking from suspend or hibernation.
> 
> In this case, neither disabling and re-enabling the interrupt nor
> resetting the PS threshold register can restore the interrupt to
> normal operation.
> 
> if we disable the interrupt in suspend(), then reset the PS threshold
> register and enable the interrupt in resume(), this issue can be fixed.

Sounds like a fix with the Fixes tag being missed.

...

>  	bool als_enabled;
>  	bool ps_enabled;
> +	bool ps_int_enabled;
> +	uint32_t ps_thdl;
> +	uint32_t ps_thdh;
>  	uint32_t ps_near_level;

Use u32 in the fix and add a new (refactoring) change that moves from uintXX_t
to uXX, and all the same to intXX_t to sXX.

>  	u64 timestamp;
>  	struct regmap *regmap;

Another potential patch (third one), may be derived from what `pahole` thinks
of all this. I mean that the layout maybe suboptimal, and one can rearrange
the members of the data types to reduce memory footprint.

-- 
With Best Regards,
Andy Shevchenko


