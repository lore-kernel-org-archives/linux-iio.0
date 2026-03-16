Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D03ED131;
	Mon, 16 Mar 2026 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690990; cv=none; b=RYcMfPUnItk7BbwokHDACT0E5LzGUKEmvG0sGYKoPPPbHE6C8WUIEeev3GxEMaF3+EIDbWT3NiprsAeZ8rOr62Rl/mD3Ln+SJPuR+zyYIDq5VmcJvX9htRibKlKQsihGppPI4Qp+HW3dMy/lq5SlnFWtwjBvEBvAc7mmoNoqkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690990; c=relaxed/simple;
	bh=cwAItqo5nnRQ/ZopgfRC5MBmaxwacWYXGfXxc9hfgcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p888sT3xGGocU7RHeZ1g+b/q5kCpaGAWUH1VfszAobw2y4Me4tkh0G0RaDOlgnedt2jzLx5v8xwktIsRwgPlKic/FsHFQtf/9k9u8ddMiAx+bB0qf3VLVu1ZKnhrmd+gcY6hWE3jgBJHIhh9DEID35BezwBjqVPIEY120lxwRpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXeZ7dBE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXeZ7dBE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773690987; x=1805226987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cwAItqo5nnRQ/ZopgfRC5MBmaxwacWYXGfXxc9hfgcY=;
  b=iXeZ7dBEyVebHmUsrOjtRTfq9GxQhh+sem0NxB4QTVen1ea8+YhlcqER
   do1rSRe3r91Pha2n9p6mc+BaXKCFgMWrLkVB62NervTZ8OGMMj/YHIIvR
   2dt1rKy3MNQEX5APDMxJ9BqeIvheQps0cqcfAge1Nb33t6Yp7avHEcaSS
   AD3A/46bfhmKhc27PW3IxMSKNyEQBAtHRhVkeKkSbpwSzKZZpdWoY8vx/
   5HLZnylIEDg/0UuYvewGGSUiJSaDnB1hYEUQMRQcIR36B6HKPSq3cCJh5
   AFjDw6dbQKGsqyBbxN3o1RwBIKU6yAlaf3t+uMmRchFCx9mOrpLsyNVM3
   g==;
X-CSE-ConnectionGUID: 5TVe5gbqSMmlYZe3wMbXnQ==
X-CSE-MsgGUID: /AlxYkDTQQa/kP5ZWYQ+wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85344492"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85344492"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:56:26 -0700
X-CSE-ConnectionGUID: gmEmB0/SSOiECeKwAka1nw==
X-CSE-MsgGUID: thRG2SuxQJK4Rl4YpcG+3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="218235598"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:56:24 -0700
Date: Mon, 16 Mar 2026 21:56:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Atharv Dubey <atharvd440@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] iio: adc: replace deprecated
 iio_push_to_buffers_with_timestamp()
Message-ID: <abhgZkJu4ERvmS_S@ashevche-desk.local>
References: <20260316172735.11430-1-atharvd440@gmail.com>
 <20260316172735.11430-2-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316172735.11430-2-atharvd440@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 10:57:26PM +0530, Atharv Dubey wrote:
> Hello ,
> 
> The helper iio_push_to_buffers_with_timestamp() is deprecated in the IIO
> subsystem. The recommended replacement is
> iio_push_to_buffers_with_ts().
> 
> This patch series updates multiple ADC drivers to use the newer helper
> API. No functional changes are intended; the patches only replace the
> deprecated calls and adjust arguments where required.
> 
> The goal is to remove usage of the deprecated helper and keep the
> drivers aligned with the current IIO buffer interface. 

You need to do this very carefully.
Besides that your email thread is broken:
- you have sent 2 time cover letter
- the patches 10 and 11 are detached from email thread.

On top of that there is wrong indentation in many places.
I recommend you to choose something less tricky to begin
with.

-- 
With Best Regards,
Andy Shevchenko


