Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5763914EB;
	Mon,  4 May 2026 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909982; cv=none; b=iExD1Bbaa9PHdxImash1Jr+yBk3TeiPgmOJmVvT1NYHYiExbGSTfxOx161aqDVwvwegrmIgIRQ1v9AS/lKxUqCGOQsjtrLlLvDeuENdby5tTonHcptbWCYvFTsMbM8AbsKUewbAktJx+AkmWgFZd20649pSVsI79hiJ1lBwK8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909982; c=relaxed/simple;
	bh=59jsf7SXwxeXk/Iumk79kw5/e8QlcmE0LMTDPwzHTxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMTCPmAlwXNZtrs0muUR7Uq7M9PTyL9vSn4+QIojHLdWgZYa40A4EUTTU2k4AEDkoESubUYXJ7FqSw10i/SnbUlpDNA0ir/d3Qh1QR+SoNpKBWUm6OOxdEdSJF+Uf+iLF3wP/3WJIqoIY7X7Lgjzbmiup5EA7zkomVbvgjZUPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hempGlIh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hempGlIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777909982; x=1809445982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=59jsf7SXwxeXk/Iumk79kw5/e8QlcmE0LMTDPwzHTxQ=;
  b=hempGlIhfIyUW2sQCvrc0Qt8eWFIf6nmkx4u4BbRMUL1LpdkJzxrUL1L
   xdYBaFjD5nxdOs/mj4U5TdkSRXee9/pMNERzyM6VKP17IJgA8fqv1wE4/
   prvqCyZHN8O2nhJKibXvZS3NuwxjfbAL3CFAd9/OYT/79atd0tcwOiuEm
   ns2B+GGa5pvZtI+k6HTPLdz5jonoJApj+dNGdEjFu8543KfBATRMEPL0d
   dGY68hsHDbTSvAO6VtOcVxd74xsGXGZ6MreBBB1v3g5jOkVg2Yoig+IFE
   54CCqAgQ7xXvAkNtsFS9NHkntuYp3BLQCe2/HnoFkYZeRuf/zfqkPDTFP
   w==;
X-CSE-ConnectionGUID: VXqhSHDmTcWyRACu+zzdhw==
X-CSE-MsgGUID: ynEuTKCiTOujljlDSgyA6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78473818"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78473818"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:53:02 -0700
X-CSE-ConnectionGUID: OFs81rm+TCWZjt2lfnc/qw==
X-CSE-MsgGUID: LhAFpIXuQGmX6wtN9vmSnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="239845364"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:52:58 -0700
Date: Mon, 4 May 2026 18:52:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <afjA2EItdQIWfY9u@ashevche-desk.local>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
 <20260503120949.80292-12-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503120949.80292-12-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 03, 2026 at 05:39:40PM +0530, Piyush Patle wrote:
> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but uses trailing PD_SCK pulses to select the active mode.
> 
> Model the HX710B with variant-specific channel tables and IIO info,
> track the active channel across conversions, and use the fixed gain
> value when computing scale.
> 
> Also update the adjacent Kconfig text, file header, and module
> description so the driver text matches the newly supported variant.

...

>  	/*
>  	 * triggered buffer
> -	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> +	 * up to 3x32-bit channels + pad + 64-bit naturally aligned timestamp
>  	 */
>  	struct {
> -		u32 channel[2];
> +		u32 channel[3];
> +		u32 pad;
>  		aligned_s64 timestamp;
>  	} buffer;

Maybe it's obvious to everybody, but me, however I find it difficult to see if
there is no ABI breakage. Can you add a comment explaining why this is not a
problem?

-- 
With Best Regards,
Andy Shevchenko


