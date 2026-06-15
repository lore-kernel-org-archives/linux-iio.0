Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097603DB62E;
	Mon, 15 Jun 2026 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517448; cv=none; b=RYnkCQEuUMrE0NCewetIcWdNmrtc+51/dwh6Tpkh0nlyKijjJHP2eTOTzdPuZ3a/FkQbor6EwG0jSmlyahJkuEPzbooPVyS45ojbVUVcTVdgV1p5OOQYdFvAc8Ga+0XhxkqQKrPHVfRLE6sGg2KzK5TJJq5TPTJFOQXIWHz9eTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517448; c=relaxed/simple;
	bh=udTSSnKrhXMOY6CeQUkrdu3X/stsvprBhVZx6Ma23kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM6ZOymgpMKlZixIKNsbF+JHfiHvuERBMv36EhyBUJVkOzCBEwlh0fyWsRWm0jCBvdiGnfV91xShCht+EDiESzBJvaKJOkgFJ2vC71aAkOFDieOp9cWiFtOxjqeFPxEaskvlbFgJoaXuoCjjraq2LUsBi28XFVPHjduaBCxNE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmDPN3aA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmDPN3aA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781517446; x=1813053446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=udTSSnKrhXMOY6CeQUkrdu3X/stsvprBhVZx6Ma23kw=;
  b=kmDPN3aAQTYzn5nBwiCVLWJEmziHK487F0S5C+usQdXe+PsmJMsGwupD
   l1yHVChdoJ/zi0Lj0xbgZl34RIkaeGmPOarxLQ1fUH31Qel/uey0FucLS
   VTAJG3aefHdCyfNa73uuMNshzABf3JVLU3l48mH8VxLwpjRvQNMgcPiec
   R12/f2kpv2GIzdwbsdifJIwWwrwrjzX7g8odShQkpA7m5EsIaIuV9/c/L
   1Id2N0mADLZxQg3nxhcbgH1KRSU7bPm1wWMg7P6tbaJcOepZrJ9xGnytX
   bmFTVAJ2jFD1iqYItac1gvCl6XceQ8XbE31kgXyd7Ui6qiC0aLRj217ed
   w==;
X-CSE-ConnectionGUID: wlhXrygwTsK8pNr404dDGw==
X-CSE-MsgGUID: XyGmrsQMRGS6KPCGxdwXlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="92925999"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="92925999"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 02:57:25 -0700
X-CSE-ConnectionGUID: 101coR5BSYuI0eYY1pGqyw==
X-CSE-MsgGUID: L1kBRlRbQ36Z5ndKWnHEAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="251705290"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 02:57:22 -0700
Date: Mon, 15 Jun 2026 12:57:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, bigeasy@linutronix.de, dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v2] iio: accel: stk8ba50: Update includes to match IWYU
Message-ID: <ai_MgM_5WGs2y8FC@ashevche-desk.local>
References: <20260615092116.83850-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615092116.83850-1-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 05:21:16PM +0800, Miao Li wrote:
> From: Miao Li <limiao@kylinos.cn>
> 
> Update the list of included headers in stk8ba50.c using
> Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
> and add missing headers such as array_size.h, bits.h,
> dev_printk.h, etc.

...

> Changes in v2:
> - Drop linux/iio/types.h as it is already included by linux/iio/iio.h
> - Link to v1: 
>   https://lore.kernel.org/all/20260603015033.187735-1-limiao870622@163.com/

Put the changelog in the corresponding place...

> Signed-off-by: Miao Li <limiao@kylinos.cn>
> ---

...id est somewhere here. (Basically after '---' cutter line.)

>  drivers/iio/accel/stk8ba50.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Code wise looks good to me, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
after addressing the above issue in the commit message.

-- 
With Best Regards,
Andy Shevchenko


