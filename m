Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3713E02A;
	Mon, 16 Feb 2026 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771230913; cv=none; b=ruz1LZGa0EeNckephRRI59FyFILPX2RrB+zoYAngRzopPwBRb96NfdauYw/O95PJH1rRSwCaqLtXTsduZ0HnUVPuzw2j3t1efB2kGXY9VXG5hLgqgmVpUxk2FYglIEC/7COFhZtwfdjpedGRSCMYSpooqMVbR6HHnvoayRrtmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771230913; c=relaxed/simple;
	bh=jcJ6NWtgnQc4pm+hG0xFjepjb0iS46na/v/T2dXMCrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hdgu7YOiN51b89UYYbgnEakKJIoHhqXdetGCUonRNkkcHgaTRCJAzfrbIvX2Uv6CHtcFeNNqY2EBxAlQbdT6Hvtyt9W+U0viVoEZlNiDzc1c764pk/EXssgTFhNIdV83QQAnMspgRyWokMRfnjsPN8JQis+p9igEkbVbb8k3qsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFPfa+df; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFPfa+df"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771230913; x=1802766913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jcJ6NWtgnQc4pm+hG0xFjepjb0iS46na/v/T2dXMCrw=;
  b=MFPfa+dfg22fXMjzsbHASKLC/GBM76mNmjqubWlz9fpDht6CZifZ8BKe
   6HWbjhCblamkeMCRZY+/x0kMJSxTCxGKaWXMpRCc37Qi2UmCYLreFAnQR
   F3EuTSrlq/dTPWU3aP4lCmvL2duVuX/1h80+URq297lDgDoKtXKH9NHof
   VauMMBI2dWwpEROmOJ2QQBac7kZjJbzvPebqczH9mpx6sfkj+GqQGMunL
   NGSdWxQTK2cQQAnfHUscd98kPM0GUnX9DloVjQrz1+g7fDUKegi1kcjDT
   +UxndPWq0WPBz6zyjedZm5+NSA7HJN9JfQUxhlpsGsvsuyFiGyljA5ppa
   Q==;
X-CSE-ConnectionGUID: 3axIJTv5RFGkjKKCF1HJeg==
X-CSE-MsgGUID: vMQ3Vig6SHukGSvDzZrrEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="94939102"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="94939102"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 00:35:12 -0800
X-CSE-ConnectionGUID: 1zW/IR12RFm9kJdqzLcNng==
X-CSE-MsgGUID: uC+F7pUeTICyNAB97zcmLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="212784973"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 00:35:10 -0800
Date: Mon, 16 Feb 2026 10:35:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] iio: magnetometer: bmc150_magn: minor formatting
 cleanup
Message-ID: <aZLWu_7ozsmUZbtg@smile.fi.intel.com>
References: <20260216015454.61836-1-neelb2403@gmail.com>
 <20260216015454.61836-4-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216015454.61836-4-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 15, 2026 at 08:54:54PM -0500, Neel Bullywon wrote:
> Improve initializer list style for bmc150_magn_samp_freq_table by
> moving the opening brace to its own line and using one entry per line
> with proper indentation and spaces inside braces.
> 
> Add spaces inside braces for initializer lists in the preset table
> for consistency.
> 
> Fix indentation of bmc150_magn_scan_masks array. No functional changes.

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


