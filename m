Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3B5237B9;
	Wed,  9 Sep 2026 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960033; cv=none; b=k81MxJPU6Yaf1V2/XMrShRaHc40eejw/IrMK3jkYrScCgRccRoFZAqHwFxuRUd5+h8ciiFJCMuqWBgI/2GZe+AT5WxmWG3yjN9xrL/VHsP9kJxG2M79g6pL01JBEscepH5geDK6rkFUyyAI0IQrp+XbNsciuyOhrKU/KLEwfzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960033; c=relaxed/simple;
	bh=a9xwEoqisLjUyYt72a9JUCd35booJM6VKKF6kbIjuGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkG3M6hy//Z47W7VD5ejtOznL8CAidTEdeNfdDE1Drm2pQYH4TWLD9wMTOaeVjVEsSVU3AJaFj/2qe2y8wZNA81JhDYyuHA5RT50Zy5l+Ixvv5KOLBY/XvJIB4uM82tAy+GJbp6GJ8eUgapXAoWR5NE+X3/EgX1+ZVaIp3WOjPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOQsbwPV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOQsbwPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788960028; x=1820496028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a9xwEoqisLjUyYt72a9JUCd35booJM6VKKF6kbIjuGU=;
  b=XOQsbwPVISuUjL/kyhcLg2U3TqvyJWLYubHZhM+8DmT8mlwdZJMKsEpp
   lVBLQrVO89WUWMlT+ZgjyrrgYXVhTLu2mlAAD+BnXLlDgApX/4dk4z4ZH
   bIKtI9InmQKFu2lzxj//Yx7+8Xwtj1wJ83so2BPvLCPSOd1DbNCTgFzn+
   kFFDh9RG4bUekjzIPQIxQcSjnZezG1on0an52zF9y3YmO1eTmla3L+Lqq
   gH6pSwMbrS6LhhNx6l5srcMcQpRCd07oNOVYTVc76dQSy5K1Sj8t3Mf1k
   aVEZBwYR1AhrbtXopqr/EhyPtgVlsmR2S8aVLlKQRXZIR2zW1FVCo9Lu9
   w==;
X-CSE-ConnectionGUID: BllIUPOyRSui96n/Mun8Uw==
X-CSE-MsgGUID: 0WCqIAtIRX+ztwpQj+Nanw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89416468"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89416468"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:20:24 -0700
X-CSE-ConnectionGUID: W5dVsgoESWKVYyPV1g2qAw==
X-CSE-MsgGUID: HSc1w0UZQfiNP+dXSFcLNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="271798898"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:20:21 -0700
Date: Wed, 9 Sep 2026 16:20:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] iio: adc: bcm_iproc_adc: convert to devm-managed
 APIs
Message-ID: <aqFdEiBzwIAuqVhp@ashevche-desk.local>
References: <20260908172359.30003-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908172359.30003-1-mdshahid03@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 08, 2026 at 10:53:53PM +0530, mdshahid03@gmail.com wrote:

> Changes in v4:
> - Move the ADC enable error-path cleanup simplification into the
>   clock conversion patch.
> - Simplify the ADC devm cleanup action.
> - Restore the blank line after the copyright header.

Cover letter is not only changelog, it also a summary of the series.
Patch wise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


