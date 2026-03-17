Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C752D5412;
	Tue, 17 Mar 2026 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773731705; cv=none; b=KHIs0amkzUH5IZzbOgESnctHzbIbL9rMHQq1buARs1q6c6btTYpbz88o2radliwXSF0kNBsR6amZAd/DUGCIrjrBcu69Nvv3PwJ7bToFz3vZ47b9+c4Mtye4x/YoOpX9Gyy5RROVGGjCiFfGqHr3Z2nVDMt1PgxO9v3bgnYl2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773731705; c=relaxed/simple;
	bh=1lebFPh4RhO8Qy06ZmuK66Tp3ok4Y0HozKFLykZJTsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLGXKwLjLNxj3NdTQ46rW+DfbQ9SQnTDMi+iIe8K+lX6+CrrhhWVBknIuwC/uQi1ni6eU0Y2CT5xZIOif7Or6uVh2Etgygv6wjR+bPcInZwIwMcMJFXtHq/Tufqm0dzP61PJDbtMHQNEdwFh64koLRWylhZsBFoCR/zRQFBaDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThuZQZ5d; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThuZQZ5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773731704; x=1805267704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1lebFPh4RhO8Qy06ZmuK66Tp3ok4Y0HozKFLykZJTsw=;
  b=ThuZQZ5d/XGe1v/LiTPFYGkIRqXzeOlyKcwevFU3CvfcEXYWUokzWWfO
   m3eWXtyC+2y4C+yQ4rHY6bD22oUGYjlbCFViSQVbqai/qS7hRcrCrYG7K
   I4OZdHly88LLJ2CdPVOshcjNVyHghlbLd/AeB5hIrXjlBB4pTDcv8KpGr
   Rgdx1Q7mlqffvC+kddqpEBRUPuqu7XqmmsF0bAcGsHIQV0wk8p1KMsQEJ
   zuGpjXAaBWAndAkc/vnxsLlRkjDrUjIEabAV2ZLV5c/P0GJoJkfKB8Xxa
   DAkH5XBVxoI+3zbX9WhvGgRN6Qxrm0c92jvLs2ZLb74Hvh3JHrhRBidMg
   g==;
X-CSE-ConnectionGUID: AwlYG7zFS/imLlZdOf2NvA==
X-CSE-MsgGUID: 8d3lpMzeQuWccV0b9YFctA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="97365659"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="97365659"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 00:15:03 -0700
X-CSE-ConnectionGUID: Sm8E5Ky4RmSke+9uwQCSmg==
X-CSE-MsgGUID: jmgSBTLzTSGaxmAGEdXkog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="245201576"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 00:15:00 -0700
Date: Tue, 17 Mar 2026 09:14:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, gustavograzs@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: use dev_warn for unexpected chip id
Message-ID: <abj_cmDnF1vUXQ9P@ashevche-desk.local>
References: <20260316232007.22887-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316232007.22887-1-rodrigo.gobbi.7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 08:11:48PM -0300, Rodrigo Gobbi wrote:
> An unexpected chip id read from hardware indicates a potential
> failure for detecting id, which needs a more appropriate level
> of verbosity.

I have no strong opinion here. Whatever others decide.

-- 
With Best Regards,
Andy Shevchenko


