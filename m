Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178A21C16A;
	Mon, 15 Jun 2026 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532679; cv=none; b=fNpcopULW9fvriThC0J34/aZq8MIICqIsNovfK9vLBB/3NCHz0J5wKhnY06vfOykqqBAWRKhjlqQkeIgBFwzZmht0rsnsHxAyycn1rud9fRZ/2lHGkmJCEmLVFIVHwPz9ypJ1dJPtciiGu4HJCIp6vvMPTeA3wpqW/3DOQ5zj2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532679; c=relaxed/simple;
	bh=+jfiyocO8vr2wpyUeUWFDPlWTa92nHvjYl+1p032auY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhebvT8RDg1iWbuxLp8KZcbUn8M327Ehgp3kCYKzog23QvxSm07QXVzeYAIiC8CC0RMa3YUSbonQwjf9LyFfg8ylA8mYsw1KKMia6s9TJcbh0HSWw4iUdpTK6sZ9xnMUCAKitmfoO/xOK+bWcitj2vPE8Wuuob7QlJhP/XD385U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=joAlgbyX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="joAlgbyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781532678; x=1813068678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+jfiyocO8vr2wpyUeUWFDPlWTa92nHvjYl+1p032auY=;
  b=joAlgbyXD/FBGmunAyOFf0hhTO8izXHl1gEXpTxntLiJuYl/VuJyAioR
   MWJO01D+nx7eLONJLSKkBEGbAyU3SlfqqlW3f5AgSBb4L7tN7GyBJ9q7q
   qOS/K8Fp8rMtLkeVxjQZXHHDdfYGj3HYvd6KDcudj1sYg+HB2RqqDEa/P
   WVFPvhyXze+yMjTp8VGVG2fppaCvtYYPGU++qoEcoXVBCDx3eXRSu7KqE
   lUrSPcUCoWpzF6RL71uoHCssS0MDMmofKIWKsFh9FyCYHjsuZWVyCpiJM
   1Mde3irGwvxr1/SmOBSElqFKbt3H8d/8BaMmTgRE6ASqhIExHrDaBLXsN
   Q==;
X-CSE-ConnectionGUID: UGflJByTS7KAU/4YVfXhjg==
X-CSE-MsgGUID: 6NtUYwG4TZOtMsHngZhtPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86173646"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="86173646"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:11:17 -0700
X-CSE-ConnectionGUID: 758HNN3QRRKSim1Ta26hEw==
X-CSE-MsgGUID: U2n6ICRjQb2ToPJSQNJCmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="277688874"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 07:11:14 -0700
Date: Mon, 15 Jun 2026 17:11:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"moderated list:ARM/LPC32XX SOC SUPPORT" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: Re: [PATCH 0/2] iio: adc: Initialize completions before requesting
 IRQs
Message-ID: <ajAH_xKO5NXOB3-R@ashevche-desk.local>
References: <20260613005812.160572-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613005812.160572-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 12, 2026 at 07:58:09PM -0500, Maxwell Doose wrote:
> Hi all,
> 
> This short patch series fixes the issues raised by Jaeyoung Chung,
> Sangyun Kim, and Kyungwook Boo regarding init_completion() and spurious
> IRQs. The report is linked below [1], but I will also put it here
> inline:
> 
> "lpc32xx_adc_probe() in drivers/iio/adc/lpc32xx_adc.c and
> spear_adc_probe() in drivers/iio/adc/spear_adc.c register their
> interrupt handler with devm_request_irq() before they initialize
> st->completion with init_completion(). If an interrupt arrives after
> devm_request_irq() and before init_completion(), the handler calls
> complete() on an uninitialized completion, causing a kernel panic.
> 
> The probe path, in lpc32xx_adc_probe():
> 
>     iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
>     ...
>     retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
>                               LPC32XXAD_NAME, st);           /* register handler */
>     ...
>     init_completion(&st->completion);                       /* initialize completion */
> 
> spear_adc_probe() has the same ordering: devm_request_irq() for
> spear_adc_isr() before init_completion(&st->completion).
> 
> Both interrupt handlers, lpc32xx_adc_isr() and spear_adc_isr(), call
> complete():
> 
>     complete(&st->completion);
> 
> If the device raises an interrupt before init_completion() runs,
> complete() acquires the uninitialized wait.lock and walks the zeroed
> task_list in swake_up_locked(). The zeroed task_list makes list_empty()
> return false, so swake_up_locked() dereferences a NULL list entry,
> triggering a KASAN wild-memory-access.
> 
> Suggested fix: move init_completion(&st->completion) above
> devm_request_irq(), so the completion is valid before the handler can run.
> 
> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>"

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


