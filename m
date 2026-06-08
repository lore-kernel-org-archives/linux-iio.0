Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC43546FE;
	Mon,  8 Jun 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918952; cv=none; b=a5uDop8ecQH/CSSyj3Ng6tYdKgmuMwDMdNfRxT9nPzrjDI9ZWR0xHrt7wQrKFUvGn0MTZCeNIFXZVo+HjekNwSWUB10oqnO409wDMJd5Lrsh1bXPLIN6FjOMXxqQr8ftSICUWHAEcHhh8iCqtneGqUkIs36beTg2lZTZsfT5Qf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918952; c=relaxed/simple;
	bh=Z7XSG2/GyYJcBZpoUSZyjQuP9FS2WMDixqfN8gc7WjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO/RzDUc8goUsHett/nFE64mb13ftoFIS3edvYOt1R7Zc35XT4NEjtHFOZ+/FMIUSu6i0gUueOV+njVa4rQEBi/ox+6e2oEsZge+xihlN/Zzcf0Pv8KSFtb1yNTncOM2JlnisRdqwKTi1LjWECe1TI2wMY8IhZvFsA1uS8yt3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BupYDEC5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BupYDEC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780918951; x=1812454951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z7XSG2/GyYJcBZpoUSZyjQuP9FS2WMDixqfN8gc7WjU=;
  b=BupYDEC539WOku9zhkBttE8IqWuw6OF+Po4pRwLoVQlYJXyxf5iXPBTt
   LyD5rwL/SZeMeQgJ3yO1aYVVe/5T2dUesqrtCBFyi+GjdiEwjUOsWeCoi
   iHIx31d7rRs6EDhBFsilqWWHkUqXGEqu2r0JdpSpbSGOy0i8Fqf1wxbrO
   yfjHzTN9WLlSmsV5KWwDU0xTs1nGlvr4v0eUEu1L2zIR7LUL5tMY8IwIB
   X1FaxTVb0JykSRIiRdxlAoiS4kHNtPgDEJbl/3NuF8o0H5zm78gm1DT/+
   Ynp1go0iTkAtSH+qU7akygx7NJgP8pFuRO9JW5alUVRENXrFTiWdzs8wX
   Q==;
X-CSE-ConnectionGUID: IdeYPAL+TFixXEyFh1wDiw==
X-CSE-MsgGUID: p8DPkE36RDqCXzYZX9fhqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="107091371"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="107091371"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:42:30 -0700
X-CSE-ConnectionGUID: NNSyRtnoRMmamoR/m5a6+w==
X-CSE-MsgGUID: 3w/fzPSVQjiDXlV76mMzMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="243079358"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:42:26 -0700
Date: Mon, 8 Jun 2026 14:42:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mike.looijmans@topic.nl, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jorge.marques@analog.com,
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz,
	wens@kernel.org, sakari.ailus@linux.intel.com, linusw@kernel.org
Subject: Re: [PATCH 0/3] iio: adc: Extend ti-ads1100 driver
Message-ID: <aiaqn5txaYp4CgMo@ashevche-desk.local>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 07, 2026 at 08:35:39PM +0200, Jakub Szczudlo wrote:
> Extend ADS 1100 driver to support ADS1110, which is a pin-to-pin 
> compatible device with higher resolution. This patch also updates the 
> device tree bindings and Kconfig description to reflect the new 
> supported device.

> Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>

You should use your official name and not an alias.

-- 
With Best Regards,
Andy Shevchenko


