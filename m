Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCF46AA6E
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448533; cv=none; b=bV3hXsBrJLAntYLPp7JdraluAn019ZKp0howw3nr/3fGR4F7QWsi5VZ5xL7BdTKyzAHcvy6wUoWZ6DbBYvWOFWFZs63wdoJUmivqArG8/GeK9eF35MW299x4GZjBzaF1Gj+XognRPJ3u6zo6HYPKRKY1pbqMEFVGb7E7FgtS268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448533; c=relaxed/simple;
	bh=UWrJZolvCpSLr0s94nHrgU91Sce5C2Kuj5uzI9xbb0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBPdtlVYF8kSxXH7cQzrTAvoNbptshJ3+dREXDRGeeVHOpVo7ttcCD+vUJy0N0WhMWtd3SilUrBIriN0h0FYdGTlz5MD/I9pmZTwp2dylm35Vli3q2zv8LjGwWvZny0fNW/psHaWpzomDDCzH4fDnD46VZ/9rmlmfOVX7onXRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzGIB+bT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzGIB+bT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788448531; x=1819984531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UWrJZolvCpSLr0s94nHrgU91Sce5C2Kuj5uzI9xbb0w=;
  b=fzGIB+bTileKGdkDNCJpxKd3QtW4yieoMvcc7+YkQHRneRQ6EWmryXYh
   sVnrXPXHzRlDAGmccjKTXSFqRbkFA+Hu3Kkk5WdsyvBtFQAegPsJKKoTJ
   s83ZpgjAmJhj+2g1TuB18M+hnqHO8Cv1B5aRS/KU2M2+7UNV9LiiSfEdY
   oG2SPkrNxlwOl+7iUuJfPffaQylMiuJA0ZgZxDTmAOqG7Mr0EPL8huMpO
   I4gF+e9vfTZxKWoS0PumS5ZWr4iMvysaApDAmVYq88j+zK0Rd9aG+VYBt
   pSKuOKRLlvlcFkS/BAC+Ufd03qnFBna/brER6/n1cDctF2NkNx+iOD9lK
   A==;
X-CSE-ConnectionGUID: PzzmIzUZQxqKNh2zazQpQA==
X-CSE-MsgGUID: ZqSsgYUfQ++RcikfHcowIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="111708347"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="111708347"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:15:31 -0700
X-CSE-ConnectionGUID: HWVk1UGyRdGu8YbaucvdvQ==
X-CSE-MsgGUID: 3TbyTiMBRrWoVkQHcXs7+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="273904032"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:15:29 -0700
Date: Thu, 3 Sep 2026 18:15:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Li Youhong <dayou5941@163.com>
Cc: wafgo01@gmail.com, jic23@kernel.org, maxwell@maxwelld.cc,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, Li Youhong <liyouhong@kylinos.cn>
Subject: Re: [PATCH] iio: flow: slf3s: disable regulator if measurement
 restart fails
Message-ID: <apmPDkkOBDYP6eEj@ashevche-desk.local>
References: <20260901025010.356735-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901025010.356735-1-dayou5941@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 01, 2026 at 10:50:10AM +0800, Li Youhong wrote:

> slf3s_resume() enables the vdd regulator and then starts continuous
> measurement. If slf3s_start_meas() fails, resume returns an error
> while leaving the regulator enabled. Disable vdd on that path so a
> failed resume does not leave the supply on.

In the scope of resume/suspend path this looks okay, but let's imagine
how it may work without this change. So, if resume fails, device will be
in suspend mode until it gets another resume attempt, right? Will it be
achievable at all?  If so, then the regulator reference counting will go
sideways. That's what your patch is probably fixing? Needs a bit more of
an explanation in the commit message.

-- 
With Best Regards,
Andy Shevchenko


