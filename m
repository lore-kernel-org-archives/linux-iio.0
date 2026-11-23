Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428237;
	b=ncJgnT+61Ctpy8T8zsk7tBLe8h6Rk3poiKnPumozRMeFleQzOdy+S667Sh2rPo5m9Qrx
	 1L8XJ+lTQ5jlpgjbNr21eceq6aTc8TIVRkAlLcnB4+eXHLSD6u+wT+Gs1JIPNFYyH5KCv
	 a6Qkg8q+FExDIdyKO6GU3eVayVFiwl5xNClvugHul/TOUgD8LgUO1b9R+4rNGkxk+kFBr
	 L4P1AZnVLsMBzVdD6E4PTRpI4Rq0CqgfW/AzLBwRZd23mCAXOecXoe52NHyjWKzKyGILO
	 gUATEpfmPrgYv7iGpK2AbsoABXmlz/cNu56h6plUe7ocLspuheKTFu9az+mKoTJitgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428237;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=tY2SpyuPdssWSThVnpPJYj27PoJlqJ6g+T13oSL+a+4=;
	b=hh68uMS79DIsaxpAHqfRSZHbPsYQhsL8sa5d1plT8gZ5oYNFua+e4hjzEUpYZXvbNDqo
	 Mlyeiosq0SruFXHOs1XQmc1QYAi/5prSr30tC686wE2T6+NvtC/zBdeWbhdQUpse/uXrI
	 PgMgu1CGlwPtkDsqAPJxIJhfEtf1JDlmMRwVcRat6LZoDpsvXxhJoXL+nz6d3ctNRgUgl
	 M0YiwPX7OpNTM3jTZz0/w8/Sj/j8ZlEZWsoxNpqei6na2Lf9XCFN+h0bI/y33RqsuQVoP
	 D0//SvRMZzgLr6UvqFiVrOQ3ssMrezPy5t+lCoM8xmuRQgyNVcvp3pj+pFUSKZkQK9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AKj45xFs;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60081606A327;
	Mon, 23 Nov 2026 10:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60081606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AKj45xFs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795428237; x=1826964237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=neK3HTToqVnQ1UB3GnpwKbB37DgyPWqMw7JZiDGo6R0=;
  b=AKj45xFsbsS3DKVn0sdAFnCEdK1X6EtUSJibS2gDnV6+i00egl60jbkj
   kgiGnXrX9d0Uijo0ix67MoOyY3xCp+nHWDsdsRylaxsIc9xSrZhExKXNZ
   LK464wRXvGaw1saj7JfPw4ygEo7KHizXqlkyXrPlANTpJ98sjTl37V1Eg
   Hit4xIBUX2kePaYFzvp6LbNaIZz5EcPDNSe4w7KSfbe503JjcqqT0S0n0
   rW2vys835SJ+9h/T9uRX2cZNFUh2lK5yxu9iDtj2XD6y74mhv5DelDOPJ
   9fM6KlRM3detOPLB2K4zqF3alNlaAClIsbPJ8Txi6LjJa9e3HT43U2M+8
   A==;
X-CSE-ConnectionGUID: AimD4FFBR4mTdW6v+MA7bw==
X-CSE-MsgGUID: oh2/f8/7QliqKyXGafz9Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4317852"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4317852"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:03:57 -0800
X-CSE-ConnectionGUID: lN386rJOS6WEacrgahraBw==
X-CSE-MsgGUID: 8ZkK7dl8Qoe4qq9WEu4MbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11565818"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:03:54 -0800
Date: Mon, 23 Nov 2026 12:03:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
	antoniu.miclaus@analog.com, gregkh@linuxfoundation.org,
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/8] iio: adc: at91_adc: use local struct device
 pointer in probe
Message-ID: <awQPh4P9u1Dtuh0_@ashevche-desk.local>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-6-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123070101.53868-6-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 09:00:58AM +0200, Abdelnasser Hussein wrote:
> Introduce a local struct device pointer in at91_adc_probe() and use it
> in place of &pdev->dev and &idev->dev throughout the function.
> 
> Also switch devm_iio_device_alloc() to use sizeof(*st) instead of
> spelling out the full private structure type.
> 
> This is a preparatory cleanup to reduce the diff noise of the upcoming
> conversion to device-managed resources.
> 
> As a result, messages previously logged against the IIO device are now
> printed using the platform device being probed.

Yes, but part of that may be already done in the previous patch as you touched
the very same lines. Here should be just a residue (of what has not been touched
by previous changes).

-- 
With Best Regards,
Andy Shevchenko


