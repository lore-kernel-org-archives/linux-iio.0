Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127EF20E702
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244301; cv=none; b=eUidGDE0OFJeXUCFXdgXyDpvt0rEr3V74J9HA9R/f12BPf94/LErru+aG+oVEYTZNsjQLiFQIICS5lgQTkv4DBuieMthkffvW+jvFsLk0leWGj1oY/kpJ2e7mf8IF0dfeNVZ9JpbRqBriqvmDkk4M5gmLdoBuxDJrFBRxumFq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244301; c=relaxed/simple;
	bh=XS6M2zDoRR/nDMcZ1IaZTNRShbF5tWuuYopZQJ8kAGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3uVqG2RqhMpyDQu8pszpPTXmiWAM+QTSHwPr1BSB2v5mq+Oz58zDV0hQ8VdcIhZGipzz6R2/1+W8FkmY81YsT9ThMxIhEex3GAYbPd9FApAa+xXkNHnHbX2KXlrNVmO/5uGsUo1lgIwiHMuL4QQCMLuhLMOR2lpCI7Bc7bqTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4P2jjQJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4P2jjQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773244299; x=1804780299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XS6M2zDoRR/nDMcZ1IaZTNRShbF5tWuuYopZQJ8kAGw=;
  b=H4P2jjQJiz/GAbp+FZjNMeXxb8C2iCJuEuC0AQ1mCnaNrpi/EaY7CwID
   DkzsQtKsyUgGY4KJbWEkgK2Dq9wwX2q9npzgI16Pt4ytyWVXYd80dUALh
   zniWw50qZ16QiTjtjslBigzNRf2XuRWSFshL6hwp+nmoHI2zp6y0OVk+5
   sv56T4+rdEsVGqylhHmR10SsrTsr+qLRo526xnrTckvA5RLCz66uSCssH
   QTPh8VVd66y8OOUa23nNojetrN+CG+x2yTNm3bVtoQUibbbpT78XdyDwN
   //YCHbnmFNIoZEDqiHTVItUEXoCp7cDv4cukFPzv5Kl780JPKMTcIBt1w
   A==;
X-CSE-ConnectionGUID: nPLy38mITeiEStlVTZBnUA==
X-CSE-MsgGUID: T381EK5ETQiRYw85ufzNVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74357051"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74357051"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 08:51:39 -0700
X-CSE-ConnectionGUID: /CVjK5t4SyKWhCf/wB2wjg==
X-CSE-MsgGUID: AD4qW2ccSaugKDD3nxnkyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216750506"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 08:51:36 -0700
Date: Wed, 11 Mar 2026 17:51:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4130: Adjust indentation so statements start
 on tabstop
Message-ID: <abGPhYz-5OLeYg07@ashevche-desk.local>
References: <20260311072156.35057-3-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311072156.35057-3-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 11, 2026 at 11:21:58AM +0400, Giorgi Tchankvetadze wrote:
> Replace spaces used for alignment in the struct inside
> static_assert() with tabs so that statements start on a tabstop.
> 
> This addresses all checkpatch warnings about statements not starting
> on a tabstop in this file.
> 
> No functional change.

No need to touch this. I was against that static_assert() in the first place,
and still against it. In my opinion it brings no real value as I can craft a
layout that will have the same members and sizeof, but different types.

In my opinion it's better to just remove it completely.

But my voice here is not a decision maker's one, hence let's start
a discussion (again).

-- 
With Best Regards,
Andy Shevchenko


