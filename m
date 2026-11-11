Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408645;
	b=rvozevHpBjY+2i75a1PjFTxw3yPizYrYykePBFhwVApB4+EXJafNth5yUX4VmM1b+Xfz
	 T0l1UoApIWmLiVTXt48I2ahul8yRehJWg/XGkMzqLDDpTOM/kS3llpuKVnw0ND5Ti7doE
	 JzSUtEOAf/NMQyOSbzjs1bGcuINKfHR2QnBrfm+ArBz/V+I387itvjvwDiDhPwFfAzlGU
	 QabEVLRuZQdF9yXn9fX7gfIKj7/u9JvNTY67qtSLudv6axSaMsELAl3CN7cXgZYWhDp/N
	 0gY7ftqGQx0Cv2K+W++xV47O9YkLK9GvpP0QCt76U4EgFieW2RSBTODNJMz4hvSBRNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408645;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=4FWWb4o5SchgDHm5mqCIIXOnj7Mqgj8LASpYet+2SAo=;
	b=wumTJnf8VG5I4YTWRVodtpLmj7fXLyCtJsReRT8R7+ggPdF2oFbjJPePa/dtzrO23kSq
	 xc15vsp2rhrLeTv9fWlj0ftq0d5Duen0nLkyUvosyNsuJH0eKr2W1e92Ou3xXKbKCnc+N
	 w7ojOinFY45Stulu05TNWsRzmI/iYscoUas0H5mFSzDujnH+KUEqj1+gWCtI/48TfLP4E
	 mTMn9ngFq+X8L7+gYYpDIcPVsGjHvmCi44/hp9PxPFY3H7VoCq+go+0tjxFrrZF61F/JY
	 klSMWTRnaNn7KCo+cYcbmIziYXewBgAUpsmlWF9bVv9h7K8qtF7UVLRgPxoxz0EtZ2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eAMtBMf1;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1B606A327;
	Wed, 11 Nov 2026 14:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC1B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eAMtBMf1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794408646; x=1825944646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u+reCr2n3ZGSYWGD5zRemuSnY2HUeSRA/CkUL28YHd4=;
  b=eAMtBMf1VnhSvIXIPBVEupXOLbZoE1sJxQg5pidk4FHtrIIJRQDcTCuv
   sJjWx3rUGSx7n/Ju8MdbQhj2icW9s6+xdEKdRP2jdV8yrFxmLBFvAWK+w
   JPOJWGjq8oTpkL4VYvLbel6caGaLHeG+bTpgFXn3XXCBSTS5NZ3Tx+245
   hxwXPleZx0dmHi4l0ULYDG1EU2ccKClvy8tr076qAE5v/VAfkPItGTHCJ
   QUJvTbeYsBAEVv9MTwPkcCcIv/5nBzzXAunwt/hJSdj9bynQmvf5RXatP
   Cj4IVDGuf1pplmX2/i1zMb9u2wSZ37xxXeWO/iacx4kViP1O1KMLM4XnG
   Q==;
X-CSE-ConnectionGUID: ndK0hZFvRsaWT87WXfyH8g==
X-CSE-MsgGUID: a56FBBcAT6S9FPvEqOPNCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3080810"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3080810"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:50:45 -0800
X-CSE-ConnectionGUID: VNRC6fx4SG6YIVdW7gHtsg==
X-CSE-MsgGUID: PbFGHHi1SzmOU69wxacT6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8249878"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:50:42 -0800
Date: Wed, 11 Nov 2026 16:50:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v8 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <avSAwLDgDAOM-9Gu@ashevche-desk.local>
References: <avQqQ8s3-fkvIiGX@ashevche-desk.local>
 <MW2PR12MB2523036E2E017B5952015D9AA5712@MW2PR12MB2523.namprd12.prod.outlook.com>
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
In-Reply-To: <MW2PR12MB2523036E2E017B5952015D9AA5712@MW2PR12MB2523.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 08:10:49AM -0600, Victor Chernyakin wrote:

...

> > > > > +static const int fdc1004_calibbias_decomposed[] = {
> > > > > +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> > > > > +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> > > > > +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> > > > > +};
> > > > > +
> > > > > +static const int fdc1004_calibscale_decomposed[] = {
> > > > > +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> > > > > +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> > > > > +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> > > > > +};

> > > > Can we prepare them dynamically at runtime? Use global variables and a macro
> > > > from once.h to make the populate function a singleton, so we don't have as many
> > > > copies as devices on the system that are driven by this code. We can probably
> > > > do this later, though.
> > > 
> > > Are you sure there's a separate copy for each device? In my understanding,
> > > these static variables are loaded along with the module, and the module
> > > is loaded only once and shared between all devices.
> > 
> > I started my paragraph with "Can we prepare them dynamically at runtime?"
> > which assumes that the rest of the paragraph is elaborating that idea.
> 
> Oh, I see how I misread that, sorry.
> 
> Here's the implementation I tried:
> 
> static int fdc1004_calibbias_decomposed[6];
> static int fdc1004_calibscale_decomposed[6];
> 
> static void fdc1004_init_decomposed_arrays(void)
> {
> 	for (int i = 0; i < ARRAY_SIZE(fdc1004_calibbias); i++) {

This is not fully correct.

> 		iio_val_s64_decompose(fdc1004_calibbias[i], &fdc1004_calibbias_decomposed[2 * i],
> 							    &fdc1004_calibbias_decomposed[2 * i + 1]);
> 		iio_val_s64_decompose(fdc1004_calibscale[i], &fdc1004_calibscale_decomposed[2 * i],
> 							     &fdc1004_calibscale_decomposed[2 * i + 1]);
> 	}
> }

This can be reduced to supply the pointers to the arrays along with the size
to some helper and call it twice (three functions), but that might be not
better either by size.

> static int fdc1004_read_avail(...)
> {
> 	DO_ONCE(fdc1004_init_decomposed_arrays);
> 	....
> }
> 
> Running bloat-o-meter, the code got quite a bit bigger unfortunately:
> 
> Function                                     old     new   delta
> fdc1004_read_avail                           141     369    +228
> ____versions                                1408    1536    +128
> ____version_ext_names                        406     437     +31
> ___once_key                                    -      16     +16
> ____version_ext_crcs                          88      96      +8
> ___done                                        -       1      +1
> Total: Before=8750, After=9162, chg +4.71%
> 
> (This was compiling with KCFLAGS="-Os". I also tried KCFLAGS="-O2" and
> the result is very similar)

However, this is not about the size of the binary, it's about robustness of
the code and having one point of data. As I already mentioned, this is just
an idea how to solve it, maybe Jonathan and others have a better one...

-- 
With Best Regards,
Andy Shevchenko


