Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE381AAE28;
	Mon, 10 Aug 2026 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350350; cv=none; b=P79CdScu+ezRKhFeXVAoPAgugLajBsdtIUV/gcrcXkb3ptXRhZVatMeKHb1K+/6pCskMNTdwCsQWoZTdhug7frjhe0QybJH0cZ2P46vuVOtmg3rNBVOIxuXppfyoQoNsNUAW3C8zvaMCMWMhOXvPyYYolSeE4Avixjt/3BrTYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350350; c=relaxed/simple;
	bh=jJ/9TlLP8y1Es2atfj4khaOE6GTnMAWPN63aLAZe4VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVk3D28QlAuYdhg/fWBbtl+PyCCFecg7KcwGUeugpFJTlQAQmwb/YKYq6TwSXZN84CAc2ACs9RtKGV4y3glJeyxFRxp74jTTc4pPPh90wqSqtc0tmg7Y/xI68acIBlHg2ltceJrXsb0NYEVA00wFjXNgC/nUxSCwfbEnbgpL1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWhhv/Ts; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWhhv/Ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786350348; x=1817886348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJ/9TlLP8y1Es2atfj4khaOE6GTnMAWPN63aLAZe4VI=;
  b=PWhhv/Ts8dmZYC/g9d0tyxeZXr5B8pdw8yO6ZptIKJg+lIzIyOP9CoF9
   e/iPQs+7y7PELIDwTAU7i2YQRxHUwuzoslelY5V74CMj0yFrUYL7GZoeF
   DpLlbSB+2v8kCVhRy7ZzPtoA8811fk7Ws9dKdkSxmGQ9ug3gWRTvX2vVT
   E27l3eUo123m9woPOZL5ZTRft6Zr9J4h4/H8ENBhcVIkCCe2fI9OixyTu
   SXWylABYWiHrW19XWrVz76JTNfWYfzsIovLdBE6Q3VRRiqHtwl+1jzEzG
   +IFIn2derSWss+UKWoMI2bVVQo2R6Dz8LyHaUOQisfe7T0sTgU6Vvx3+A
   g==;
X-CSE-ConnectionGUID: gv3IrudoRx6gDJqOiLcoPw==
X-CSE-MsgGUID: SkjDJpT7TIS5Wpm0iU9Hzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97512369"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97512369"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:25:48 -0700
X-CSE-ConnectionGUID: +CVtWkuUSqeoufOw1Ie0fA==
X-CSE-MsgGUID: jl3+KhifRv2Ych2rhCw6Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="267224372"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:25:44 -0700
Date: Mon, 10 Aug 2026 11:25:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] iio: adc: bcm_iproc_adc: Remove redundant probe
 error messages
Message-ID: <anmLBVWpzRc3Qtk6@ashevche-desk.local>
References: <20260806023902.8608-1-mdshahid03@gmail.com>
 <20260806023902.8608-2-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806023902.8608-2-mdshahid03@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 08:09:00AM +0530, mdshahid03@gmail.com wrote:

> devm_request_threaded_irq() already logs an error when the request
> fails, making the explicit dev_err() redundant.
> 
> Similarly, iproc_adc_enable() already reports failures, making the
> additional dev_err() in the probe path redundant.
> 
> Remove both duplicate messages.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>


-- 
With Best Regards,
Andy Shevchenko


