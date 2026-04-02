Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6936657D;
	Thu,  2 Apr 2026 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118130; cv=none; b=AkUfMT4IMI+qTYPe30Tk002KilubDW9l6xpdbEQ1HGfY/fXQ/Mrla0MLXlPIUc1+y1Pxl7KN17Fw0zMQQirCQEBO8FIYCJrWvnbFSMpWNcMMV15+BvuyM0mAq3gY6QHCMBOIZdL32UVBGxNgLrO79bH1rLwq3/gJ5edAlTbsZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118130; c=relaxed/simple;
	bh=fJQXioHPd77/+8KiTRh0XjzlbGFrPQwQJ453Bk5dL7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4ucWngqoVziT3vADQx87kHzLdVUkEP4FHXS3TvjFXh/Su3Mtdob1yVYWSflLmfvcoWlhIKh6eN0aUWrtinboIi5/N1fKKAPcM7qq3njzfrU34IqnazOxB28rymqzbmj/z/1jFUcTUTHUwoP6dpVMDN9qiom8R3uXhsq/9+wxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CV8Lk3fJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CV8Lk3fJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775118129; x=1806654129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fJQXioHPd77/+8KiTRh0XjzlbGFrPQwQJ453Bk5dL7M=;
  b=CV8Lk3fJ+kdZJjfWoawL51YsjT4/xk4QA0edHVzg2uIyJSxi8kzpyUhn
   0XOEJtZPAtfY/yt+lnqn8AURl4QqpPTxPhIfq3UCRuRIIYjqGBx8EyOcD
   8iGvfTrFPyOmaSiGBHsX3EM7Gr6y12iHq8Nur51PnjDUoZ8g0/AI0NgE3
   9Re87dWfE76oirJS/Gf46rmghEEsX0chjdsoi9tiAlAGG4Q4vdNgJLfQD
   JJx1/cyiy5oaAHAsx2mk5SboGpuHo2HIc57lDSx4IXzv/nTrTOyabdmkB
   62kbQqFp511GQRA6Q9MauL5dnFtKyPnhF72eCSfD1Zgr5JcOo1i3z6c/i
   w==;
X-CSE-ConnectionGUID: jYnsBEBWTO2co9mt3nKRlA==
X-CSE-MsgGUID: mWuHwTMOSVuVpK4cnh2ceg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76230664"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76230664"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:22:02 -0700
X-CSE-ConnectionGUID: qyPmxen+TcqkS49mVyfqnA==
X-CSE-MsgGUID: LotaKC9rQAaK64fbr/BXww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="227182123"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:21:59 -0700
Date: Thu, 2 Apr 2026 11:21:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: light: vcnl4000: drop enum id table in favor of
 chip structs
Message-ID: <ac4nJcb-w28ih7mK@ashevche-desk.local>
References: <20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com>
 <20260401-vcnl4000-drop-enum-v1-2-ffd201f0c848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-vcnl4000-drop-enum-v1-2-ffd201f0c848@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 01, 2026 at 02:22:37PM +0300, Erikas Bitovtas wrote:
> Instead of creating an enum table with chip IDs, store pointers to
> structs directly. This drops the association between chip structs and
> enum IDs and allows for easier addition or removal of new devices.

...

>  static const struct of_device_id vcnl_4000_of_match[] = {
>  	{
>  		.compatible = "capella,cm36672p",
> -		.data = (void *)CM36672P,
> +		.data = &cm36672p_spec,
>  	},

Also can be collapsed to smaller number of LoC.

	{ .compatible = "capella,cm36672p", .data = &cm36672p_spec, },

But I fine with current approach. If you want to collapse, it's probably better
to do in a separate patch.

-- 
With Best Regards,
Andy Shevchenko


