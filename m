Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6236C0DA;
	Tue,  3 Mar 2026 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546086; cv=none; b=kMaZ92Ufzu1iomX9hS03NBOz4cqa3ka2op+NXRhuiYZoUZnkNUNo9mbnjQ+6oZdrrrSpJSUilovcuKVaC8EH7mhYeFXxOi4MSQVhGru0WHgdWo4Hu562qDyTjTSvCLi0URRhoEA0ZYim8wGHacuwyBWDfHOrSCAAZZLg9IAEiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546086; c=relaxed/simple;
	bh=uS/DCzxHoGTR9qSmg9QDyDRCApzbAUTMkiMpiY/Y/+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umoODWSuv/+Nb3y8U53mm75QywKzNRkJEH88v0us7cyxcldSZkqMtiEVcKBxxqW0lU5zzlbpUi5APmhb+cEMwf1oUd6YpbYFlEOmBQQhNeb4RRKNOTFhCdpF2ncPUAaZ3fDdl+Lw8ED0mFie9Obh5nYwGYOwqqlZl9VRCLYvz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSbC1IDT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSbC1IDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772546084; x=1804082084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uS/DCzxHoGTR9qSmg9QDyDRCApzbAUTMkiMpiY/Y/+A=;
  b=KSbC1IDT71OPbhR73y3DmcdhHq/+w7sYBYbfaOxNmtVm0HCk+u/dshuL
   Rfzdt3rfoJTCD+4tVEwOaib7PcG5w+8V5PvgwFZmV8uBdh5XYJi8PE5n5
   y/x5+CBSBMcKL1Hq64e9lf2zlmsH5v52maFC8dmKN/HPTSIojuPcvNnPQ
   0onu1OwswcIVK75DK0LIVLa5UVPzjw+5q5hWLipfxsV7ZEId84cox/iCV
   1pE5UKXRGlN8698obmuVoMIIRgVmG0n7vZ5ixK9v0as47xOKFsmMTGpws
   TfcYQr6ouPmK91aypeV7Mzl5KFYSl8d3s18G95sWNUnLj3jvu8D6VCKrs
   w==;
X-CSE-ConnectionGUID: zwhMtwLpQQ2soZRqvtFYIQ==
X-CSE-MsgGUID: 64jHbWx9RAW/HOvi7kwvOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73493558"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="73493558"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:54:43 -0800
X-CSE-ConnectionGUID: 8R8iE0wYR5C6GDTZN4jORA==
X-CSE-MsgGUID: 3OAMgmVOQxeCqKFd6bmi5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="215513432"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:54:41 -0800
Date: Tue, 3 Mar 2026 15:54:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: frequency: admv1013: fix NULL pointer
 dereference on str
Message-ID: <aaboHofKArsITTqt@ashevche-desk.local>
References: <20260303095228.7494-1-antoniu.miclaus@analog.com>
 <aabHFq2PZssgpK2G@ashevche-desk.local>
 <CY4PR03MB33997EEE3782905E1362AB279B7FA@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB33997EEE3782905E1362AB279B7FA@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 03, 2026 at 12:01:31PM +0000, Miclaus, Antoniu wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Tuesday, March 3, 2026 1:34 PM
> > On Tue, Mar 03, 2026 at 11:52:28AM +0200, Antoniu Miclaus wrote:

...

> > > +static const char * const admv1013_quad_se_modes[] = { "diff", "se-pos",
> > "se-neg" };
> > 
> > Taking into account the indices are not sequential, this may require another
> > enumerator.
> > 
> > Ideally you need to list all possible modes and choose only supported by
> > assigning an empty string to unsupported ones.
> > 
> > I haven't checked datasheet to understand why only 6, 9, 12 are in use.
> > Maybe they can be simply 1, 2, 3 with a formula like 3 + x * 3 ? Dunno.
> > 
> 
> static const char * const admv1013_input_modes[] = {
>        [ADMV1013_IQ_MODE] = "iq",
>        [ADMV1013_IF_MODE] = "if",
> };
> 
> static const char * const admv1013_quad_se_modes[] = {
>        [ADMV1013_QUAD_SE_DIFF] = "diff",
>        [ADMV1013_QUAD_SE_POS] = "se-pos",
>        [ADMV1013_QUAD_SE_NEG] = "se-neg",
> };
> 
> static const unsigned int admv1013_quad_se_regvals[] = {
>        [ADMV1013_QUAD_SE_DIFF] = ADMV1013_SE_MODE_DIFF,
>        [ADMV1013_QUAD_SE_POS] = ADMV1013_SE_MODE_POS,
>        [ADMV1013_QUAD_SE_NEG] = ADMV1013_SE_MODE_NEG,
> };
> 
> Does this make sense?

Yes, if there is an explanation why we have 6,9,12 to begin with. Can somebody
study the available datasheets and come up with the explanations?

-- 
With Best Regards,
Andy Shevchenko


