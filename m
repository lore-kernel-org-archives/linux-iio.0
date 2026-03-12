Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BD346E4A
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308379; cv=none; b=djkhfEGNfqlrJq01pJmk6YQxQBWkKDuR5bsKZ2QtQpeLkTSCv7dgUI99scs78bqe24wEtqv2UcCRwKd7LAVmvnrUISpiwZZf5fQfDcmxxhdzuQgDbzR8JOZEkpjR9H0ZPfqeYjt4MatfDuqiHdc/dce1eK6WtIF17XPCZg2vmXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308379; c=relaxed/simple;
	bh=R0EwGvPeXJeB0Czxbh6w7DVBDlJIq2K3qOSVFx3+5OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deNv805hqioFEE/BWc7MsWAPfugn8iLFMX/gb15POsd1wMwPdSSyklIeRx7C06vpjThsQlv3y9/wqcrkr2aWuRcSjS83nQIhtcAd65ofsP2fnkzbmENbaUil5kJuZxZ8eBT3Pf4VhG7FqvFLBTmlMdy4mNy7XdeXhiPTG9ZVGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=De+PQ8fC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="De+PQ8fC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773308377; x=1804844377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R0EwGvPeXJeB0Czxbh6w7DVBDlJIq2K3qOSVFx3+5OY=;
  b=De+PQ8fCbS8yUDoozBRnCGdelNTD2oiceEQaGR5RReCL+C01jPDrMlLF
   E0Ule0Q5ipUJPp6qnH7LDJPw8ifn9jGPDjOu7feqZO/HtiTLEAZWHC4aj
   epBIPfhFtMsOgODE3ZhZHshYH4FgqQGbhPh+nUFCSR9ZUvs4Hj97JCJHf
   un04lOcuJYBdRj56a055dpNC/sNT+k0+eDCWHjHZbYATi7obgt1S2m+dW
   BAeSNjrRkVvG8rgp0rwuHVIVKUtBmOGdlXLIEwRXpxuTaN9bakftPgVCF
   RJiSUT7fs29Ymvy+I3tZPeSJm9SVfvm8TTAXrIpxMU42nWSRmUb415z+X
   g==;
X-CSE-ConnectionGUID: vtONEqTjRf2s95twpxfNmg==
X-CSE-MsgGUID: TD/5QQeBShiXEYiw+m3+PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85745832"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85745832"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:39:36 -0700
X-CSE-ConnectionGUID: tT1WNh4ERlGsXN6frPCfiw==
X-CSE-MsgGUID: 6L1XRlfWTr2twxN3w9mkHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="219868584"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:39:34 -0700
Date: Thu, 12 Mar 2026 11:39:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: Format block comments
Message-ID: <abKJ06Bjmdmmc7hA@ashevche-desk.local>
References: <20260312080752.48091-2-giorgitchankvetadze1997@gmail.com>
 <abKH2ZnAvJmmI3BY@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abKH2ZnAvJmmI3BY@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 11:31:10AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 12, 2026 at 12:07:50PM +0400, Giorgi Tchankvetadze wrote:
> > Fix block comment formatting in several IIO ADC drivers so the
> > trailing "*/" appears on a separate line.
> > 
> > This resolves checkpatch warnings:
> > 
> >   WARNING: Block comments use a trailing */ on a separate line
> 
> You sent patches as the series, but it does not have proper In-Reply-To,
> in other words it is not chained. Either don't do series (send patches
> individually) or make sure it's an email thread.

All patches in it requires more work, please learn from this experience
about process aspects (email thread, et cetera) and comment style.

And thanks for looking into this (yes, I know the patches like these
are least appreciated to work on).

-- 
With Best Regards,
Andy Shevchenko


