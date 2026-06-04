Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF138911F;
	Thu,  4 Jun 2026 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558280; cv=none; b=mjNw/hVxCHfmxCrFPN9DDx0sXbepVSXrbaudc30rBgqNqJjkUDcXdSva5AT1bsfaAQBtytbYvCYpSIxWJ05Y2o55f7+u2lWsVrueJteibCMY0Imvxh0HJUkVzYiOxlVpXxD5tbquw1ugdcmM4LiafHhpuDJpQlZa4sdXwmOTagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558280; c=relaxed/simple;
	bh=BbMCgd7gPxQEtvcYDDM45IN+TxOa6OR8S5h9npsRGvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLzi3RKiTXBIl7uCuZKtBOma7i5g6Zs8TfXOQ5iD+XRaU42luzzUuiA/1SpXz1KSFxiGfyP5F6E3t0DqCG0ZUTe01OsN2wT6/R0gZAXwuH22/hUeGa06AgVGdyyC0hbyu/yZuGm0VCyd5hxyJVldzChm8pgAm9OHXJ3nMaXXXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knDtHcy4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knDtHcy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780558279; x=1812094279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BbMCgd7gPxQEtvcYDDM45IN+TxOa6OR8S5h9npsRGvc=;
  b=knDtHcy40T5brtUkcjX4+9lXe8tLmxErwKN3aMp0UHpqcmm+1dcbNsn9
   vbyWX+/RTY8nvEX1vq9AC+B+q0FQeqvgTh42fH6XVQ8Kdj88n93p1cSL6
   oUs0iK3Yq+Ze3mB1Ns8nDdp8BD3PqvLU9dKgS8ChmWP4akdyBMKFoUjzr
   BCjvBBcn6KLLbyA5zLHkqJGAhcZEwSIimD0YJhEkubmtA7KtTLuA6eO4S
   n7WR60l/svCjuyfPNUFiE5LctcAL6wVgomrNs8wBZxo5W5vov4iEkV2R1
   FlbhVIcucCAdiVE9g7ZygmgciQZlmXZOEOdN39Hk30HU7L8yDAERvwUjA
   A==;
X-CSE-ConnectionGUID: 8kfcHu1gR+OQHtoRtRgxbw==
X-CSE-MsgGUID: POc+BXi0TG2As9oYYRwreg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85268634"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="85268634"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:31:19 -0700
X-CSE-ConnectionGUID: 1YBLiLpSRQGd5mzwPv+mdw==
X-CSE-MsgGUID: uF3iJNhfS8Cs0GoaJtZdXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="249391499"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:31:16 -0700
Date: Thu, 4 Jun 2026 10:31:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>, Dan Carpenter <error27@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix uninitialized data in debugfs
Message-ID: <aiEpwuKxFfkb9Coq@ashevche-desk.local>
References: <ahP3S9nOYN3pG-Fp@stanley.mountain>
 <CAKqfh0H0Z0xr4bAjctr9h95QTuEUTF1eCgBsRZVHn_KrkZZX3g@mail.gmail.com>
 <ahR1CUxzMkYDwVvO@stanley.mountain>
 <CAKqfh0EEHCGct8F0VP1G+wv_NYUhqT3Bdfjos3NVGGbeAs09qw@mail.gmail.com>
 <20260526192141.542015a9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526192141.542015a9@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 26, 2026 at 07:21:41PM +0100, Jonathan Cameron wrote:
> On Mon, 25 May 2026 15:08:14 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:

...

> Applied to the fixes-togreg branch of iio.git and marked for stable.

Same Q as per other patch.

-- 
With Best Regards,
Andy Shevchenko


