Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760B3BADAA;
	Mon, 11 May 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507381; cv=none; b=tBkuEwK9bcyLD9Wp/9fRctmKD4ryC5yE7PLrUoU8w1w8kToi08ZSDWLytUf9NWeQKL4rjFzlHljHzbZo1PaiZ2+bLeRlR0r+Ks1UKp1NbKLzQl266xyRKuWuFm0D4sO6zcg3AfRSvnqRpIFRgu345Qspy36ARpJ8SFvKREMqNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507381; c=relaxed/simple;
	bh=y3W9shRCvGtq5AWBbPIN2V9or+m86+44An8YhXFQRFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ179i3JRPknF0vLwP7pDsq3i72VyU7GiUV0jo7LxeSGTAD+8xZjd+nqQFTurUcdqb/c10gq2aXJSOK7AWdwevPXv3Q6paBjLLh4Y4ul1ePXIjdyjZifIaJe2prDInlHBDSh7+8vQfwtmc5s37HSEEaaS78EM3HeET32ThV91dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PT5pHH9e; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PT5pHH9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778507380; x=1810043380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y3W9shRCvGtq5AWBbPIN2V9or+m86+44An8YhXFQRFY=;
  b=PT5pHH9eQm0I4whdawPtBpMIn6JOtIBJrDnYFpEJA4n1LddoV9xGbcZd
   n1UtwyaS9djIY1ek2r8oGjICm0y1HCN4zfhUzyDzVX2h5SkJGUSGL5Wmg
   TtQSbSrKfBdWm+lQWhPNsTL7o69oDzbUq0++3U3dGkR/FPYX60hwBqeI8
   oobmzHoTA79P55ecxssojm6zcKAtJu2nXTAfgKpmYskDphkTNLn8h9Ote
   qYm3pa1qx9x43UVoK+9DPIRFo9PSn/0GMyCoJm1as5FLVmoPuEm6DnKDM
   Y+ZbxOyxAjEvvur84EjzYANhhCvtRaB5rEb0GQ8i2SVtnEb8o5RvxODoL
   Q==;
X-CSE-ConnectionGUID: 1theW1AURvSK4HZhAUma6Q==
X-CSE-MsgGUID: QHx8vCWuSXW0vtMPnIgX9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90493611"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90493611"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:49:40 -0700
X-CSE-ConnectionGUID: OSVj+qF1QAm3jG4oPQtmPw==
X-CSE-MsgGUID: o2/HzVK7RXiudal+UxFNcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="234792670"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:49:37 -0700
Date: Mon, 11 May 2026 16:49:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: wait full startup time after mode
 change at probe
Message-ID: <agHebs-YfvLCtagH@ashevche-desk.local>
References: <20260511062755.30-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511062755.30-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 11:27:55AM +0500, Stepan Ionichev wrote:
> bmg160_chip_init() calls bmg160_set_mode(BMG160_MODE_NORMAL) and
> then waits only 500-1000 us. Per the BMG160 datasheet
> (BST-BMG160-DS000-07 Rev. 1.0, May 2013), the start-up and wake-up
> times (tsu, twusm) are 30 ms.
> 
> The same file already waits BMG160_MAX_STARTUP_TIME_MS (80 ms)
> in bmg160_runtime_resume() after the same set_mode(NORMAL)
> operation. The 500 us value at probe was likely a unit mix-up;
> the old comment said "500 ms" while the code used microseconds.
> 
> Reuse the same constant via msleep_interruptible() to match the
> runtime resume path. Without this, register writes that follow
> the mode change can hit the chip before it is ready.

...

> -	/* Wait upto 500 ms to be ready after changing mode */

First of all, the same comment, put better description on "why?"
based on the datasheet explanation.

> -	usleep_range(500, 1000);
> +	msleep_interruptible(BMG160_MAX_STARTUP_TIME_MS);

Hmm... This returns an error in case it's aborted by a signal or other means.
What are you supposed to do with that?

-- 
With Best Regards,
Andy Shevchenko


