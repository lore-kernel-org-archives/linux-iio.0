Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B134751B;
	Wed, 13 May 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671416; cv=none; b=L8V719JInRsqXp4MKJfrPHiXNPrHcPaX2cX//OWMpnDGAgVSBqZd3F1pQk+H177mmBC2k3pE1Xi5I37hUjXFli1prtQ36l4TEewKqzHY0E70VRoN/Gxj5JXPtw1TRE1dnk7KPNnvhCPnWxVyDAmlpq891f4XhAXN/szgVUkSQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671416; c=relaxed/simple;
	bh=K4g/3y563f6GrVkEDud3+ACp9sbKwScRdwQOfLhN3XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6R+H7gwy720yqTwbq4y8uMZAVemlxMC1pox5jKwYH4pKUDHYHS6MJEYlko+CV6pRuBzY8975Y9WjUza6T2S98Q53WFpbNaGIHdx6sydOxmw6sfR7Fv6DVyF2yCufdx1+w4yRFXGWCjoVZP60X04H4RWkOyHPVnJYTysIIe3CvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJ+jjZuU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJ+jjZuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778671415; x=1810207415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K4g/3y563f6GrVkEDud3+ACp9sbKwScRdwQOfLhN3XU=;
  b=OJ+jjZuUaYN17kLvt7q5IppIk8rrE4chds0YelRZ3y4mGTNtw/Zrh183
   2HvU+HR8u4kp36FMPp4XhyI0EFIDJ2bDW6ti2MunfcELECJA5bwA5nSxD
   1UQPCDudIx70Z0w4OaCnqyzgeE8q/hYOGFRNW/K8uavtB1f+1lqgjrQLY
   CFaPgL0leo/eETeMmwh3OSJzxlgMUZts6m06vNtjgjxHTWzjh/FHGKTga
   Wx6ZnPzgzRc5kVbEwMmt4ATeO5xBwe3rLyKFZB3onLAYTvXBAS4wIx0Oa
   BVX+QwwUr43+nuQvgciGBRKE6tSLcKsDjca0g9WnColsmrnSbnmMZyyHs
   g==;
X-CSE-ConnectionGUID: gZis2v8HQLWz0jS5QlUa7A==
X-CSE-MsgGUID: QNqV3ruFRJexhoIPVt13IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83210890"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83210890"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:23:34 -0700
X-CSE-ConnectionGUID: EZLm82NCQoas1P0TXBFzuA==
X-CSE-MsgGUID: pN/hFaZDTbmV+WShNIKAeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231671779"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:23:32 -0700
Date: Wed, 13 May 2026 14:23:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
Message-ID: <agRfMWL9BughLT2x@ashevche-desk.local>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-6-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512223215.25596-6-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 12:32:15AM +0200, Aldo Conte wrote:
> Move the trailing 'return -EINVAL' statements at the end of
> tcs3472_read_raw() and tcs3472_write_raw() into explicit default:
> cases inside the respective switch statements.
> 
> This removes the need for a separate return statement after the switch.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


