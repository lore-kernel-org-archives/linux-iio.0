Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3831DF963;
	Thu, 26 Feb 2026 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116602; cv=none; b=BEHjiHTDwhtoWR8DNCamxZLW/Q8pr1kq1Hhggx1O+2rtWEc4/+1FjlWWNL0bP8nZ5T8ISO4xjQ5UBqRuexD3NBHR7MCO+VY6We/eyUoigSTmV2qmO08BImWplcgpsuNMZX2QbVACyapDB7CCW1qzTxFQxN1p+ndCxIS476jGfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116602; c=relaxed/simple;
	bh=dAu2W7DNKyck4n7dOCBcLUCwJWVgj/2a36NILm5gTnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYTvf3oePFS1QIcNh+SITmspHiJJioByeomruQu0u3uuGxIXDaWlKOpYxCsnpGV6880uob6mXQ8ZOI0q1bf7PSIDtXThrOqcUjy+5RJiK0PEa/tX7uNVO+Pfd2hP1X1MK7O2ttyD1btjr/EsnzFgubbWwhhayf1FlDeTemOni2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NF/zvtX3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NF/zvtX3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772116600; x=1803652600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dAu2W7DNKyck4n7dOCBcLUCwJWVgj/2a36NILm5gTnw=;
  b=NF/zvtX3+ZtQecAVmPA3epG6v+diLORfdfqarkC+t8qgJbgX61mkXd9j
   gTVFz8VmpMNCHQL1f2LoO9Z/zSU6/Y9m/ib+Hs85rGo4B7Z+OnNy7abex
   rb1YVdKmBl5nzBaSA5ueJ228JT1BGrEdkwGHTozP5yZcAck0n+J65bb/m
   Y42AR7OgxqovuRsHi9cT+O3MU4KCwkggeAQ1cSM5o6IVIl1kt32hN4qCK
   b+8dKnNJT8moMA/nIpviQc2Tc4AuOrfztKfjeF3upFSV6WQ53MNPvHD95
   dsO8s6ARI/92zB3d3r8PMynfVJY3XCH6ut7QCwc6vaxDZk88goiXVcefz
   A==;
X-CSE-ConnectionGUID: XbfeCmM1RJaVA6pEzUiikg==
X-CSE-MsgGUID: CN5GKDEzSyaphMwUYjeA9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83809746"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="83809746"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 06:36:40 -0800
X-CSE-ConnectionGUID: wc76YI4hR4623DvHCUgztw==
X-CSE-MsgGUID: NduOSgeeQ5i/85jyhRENAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="215816792"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 06:36:38 -0800
Date: Thu, 26 Feb 2026 16:36:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ade9000: fix wrong register in CALIBBIAS
 case for active power
Message-ID: <aaBac7SCMEOrom6Y@smile.fi.intel.com>
References: <20260226140700.481317-3-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226140700.481317-3-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 06:07:02PM +0400, Giorgi Tchankvetadze wrote:
> The switch statement in ade9000_write_raw() attempts to match
> chan->address against ADE9000_REG_AWATTOS (0x00F) to dispatch
> the calibration offset write for active power channels. However,
> chan->address is set via ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT,
> num), so after masking the phase bits, tmp holds
> ADE9000_REG_AWATT (0x210), which never matches 0x00F.
> 
> As a result, writing IIO_CHAN_INFO_CALIBBIAS for IIO_POWER always
> falls through to the default case and returns -EINVAL, making
> active power offset calibration silently broken.
> 
> Fix this by matching against ADE9000_REG_AWATT instead, which is
> the actual base address stored in chan->address for watt channels.
> 
> Reference:ADE9000 datasheet (Rev. B), AWATTOS is the offset correction
> register at 0x00F (p. 44), while AWATT is the total active power
> register at 0x210 (p. 48).

Please, avoid sending a new version earlier than 24h after the previous one!
I think the best who can review this is somebody with HW. Preferably
one from vendor company.

-- 
With Best Regards,
Andy Shevchenko


