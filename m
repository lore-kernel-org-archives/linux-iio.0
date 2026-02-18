Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA110328617;
	Wed, 18 Feb 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422680; cv=none; b=Krf7uHIfcrfULrU1dJpiIHaM3jht0V2LX8/Q/rW6UVMrjlhdJZhPt+ByzYM+n3kix+Pje3qyy4GPbfB3Xyg1moXy5ZsdfaxxTCTnAku9/lGW1Fi8Uv2nEcdnbxLuyrBW1UDSkI5q8h4o+X1QXciK5SVxKSfP6qKMBxHEY42OPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422680; c=relaxed/simple;
	bh=VuhjXbFaI3Meq1zJLwSUXFLnMLGJbhF6SjJfiBaGhe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWaIE3YwIZ62r1RCNgEdjPtdyNYWOfX6k6t79736ANnu8hbr/JS0NL0x7gkdN53zVxyyyxrtySBqTiPWkQ8B16qpczefIYzxp/xyitUw9kawEakPH0coBpK8WHEIlGTuw+6/KSLd5urTt8WeSDSH7j/6zvbOiIb32gjRYya1iI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpDrtAuD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpDrtAuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771422680; x=1802958680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VuhjXbFaI3Meq1zJLwSUXFLnMLGJbhF6SjJfiBaGhe4=;
  b=ZpDrtAuDUp/DUkkmt/msN8oD1AJL9NNj8zpW7ry05IpCxZSO76AwU0Xb
   UPPPYahqOFl27goQESZVpqr798BHAtGdKTTQqJTeJW1Hjyi5/5mNIbVWU
   ACg3U7vBQmZsYWj1cCBD0V7l5NqxEzqGzgqIntIPtujozId57A+76M/ox
   GgGkVbOqDN3uB705ZNxLXzHlTqROpRLwL2BfNCB2v6bcFJByBjWGKT+6q
   vbKqNX4Q9vOAh7thq1UNLGTWgaXZlDELu4OQqBCrY3aMCXI/WTzxU1i5l
   +Jql9to5GxUypoMQHZHGfh6Y7ozq72xAMmE5Uyug7fVNO2hcPM89e+8Y8
   Q==;
X-CSE-ConnectionGUID: HfersVxGSyObeh08bM4TaQ==
X-CSE-MsgGUID: SGhZvn3AROSaBcQIx/9zNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83944122"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="83944122"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 05:51:20 -0800
X-CSE-ConnectionGUID: q0eJNcUzSfSAy1FN7BgCiQ==
X-CSE-MsgGUID: 7O3wrIAMT0yUybwniHgnLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="244790540"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.215])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 05:51:16 -0800
Date: Wed, 18 Feb 2026 15:51:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use
 div64_ul() instead of do_div()
Message-ID: <aZXD0smUd3CRgPcv@smile.fi.intel.com>
References: <20260218125327.21467-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218125327.21467-1-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 18, 2026 at 06:23:27PM +0530, Archit Anant wrote:
> Replace do_div() with div64_ul() since the remainder is not used.
> div64_ul() is the preferred API for 64-bit by 32-bit division when
> only the quotient is needed.
> 
> Also replace explicit casting and shifting with the BIT_ULL(27) macro
> for clarity.
> 
> Note: A mathematical simplification to `(freq * BIT_ULL(29)) / mclk` was
> suggested during review to improve precision. However, as confirmed by
> maintainers, the original driver's truncation via `(mclk / 4)` might
> be intentional or relied upon by userspace. Since hardware is not
> available for verification, this patch preserves the original logic
> to avoid regression risk in the absence of testing.
> 
> Issue identified by coccicheck using do_div.cocci.

> Changes in v2:
> - Replaced explicit `(u64)(1 << 27)` with `BIT_ULL(27)` as suggested by Andy Shevchenko.
> - Kept original arithmetic logic `(mclk / 4)` to preserve behavior.

The place for changelog (and comments)...

> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---

...is here.

But do not resend until maintainers explicitly ask for that.

-- 
With Best Regards,
Andy Shevchenko


