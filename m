Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91426B764;
	Wed, 15 Apr 2026 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244491; cv=none; b=jJfy34zohQVxlTJ80EHhJY++q00OehTyV9wIc52+UNkBRl5J+0mtqH3+0zpVdFIwqMFFFQSSeT3OBBG6qNsUlzLE/nWFs6uNSY9Af53RDCTB6v1KSNvC/k1VhzGSK3bvs8laE6TS4IjL+vMQKXpjsgERBjwpv+/RgLAjlUT5MPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244491; c=relaxed/simple;
	bh=YG3qsucY75PaYolkdLl5Z34ZgRN3bLfsTCuGSHgPxxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iulQxq+NVucaJdLT+0cv/Szsv5ANoSncKGYvT/82L3wFKIA+k6JNrmnq+Nr//B2owjvHoBEnPUJeVwEGTyn6vJByaOylAuRKXDHhSnnjxaHQAnHjHVzG+h78FEaQR8eF9/tR+6fmWt2K4vlHhTzC8Yj6odB3BIXeOJkUxkBmkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EX+0GVth; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EX+0GVth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776244489; x=1807780489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YG3qsucY75PaYolkdLl5Z34ZgRN3bLfsTCuGSHgPxxg=;
  b=EX+0GVthOgJDohCzmDuVYROT4YUmKUjlHk8yvXMTa7vgIwbsAntGtOWC
   eCZ/rezNgmvRaM3Olo/rFH0rgb17fq9pF2KyBE6A3bdAPNJ41l51C4IUl
   U1AKHB08ADCB4H+PNRuRJan3RCS7X41iwjCdGGFrtgv+5p7VIODkPu0yf
   zwxayEdM1x4FYo7vEU1X+KW+ARAstZ2pqvmAVPGFBwdnNpb98e647fCUp
   vAN4CuwuM1Eeo4WnbCggHCl/w/ggPs+EfaRpflHwVo6mdF0vvaC55TTAF
   PopJIFkxSjARtZ7SeFvqtt0AJlf6hEfVPxyMWra/FYaBaQDKOl82fA+A2
   A==;
X-CSE-ConnectionGUID: RRH4qOC3TO6RP/Ay4YHYkA==
X-CSE-MsgGUID: 81zuFrmgRWSQS8YIm9Rszg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88295178"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88295178"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:14:49 -0700
X-CSE-ConnectionGUID: EFdSGAjPSJ6vvigbXnLwHg==
X-CSE-MsgGUID: 9GVienvYTB+9BgeKHNAb2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230591949"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:14:47 -0700
Date: Wed, 15 Apr 2026 12:14:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] iio: ssp_sensors: cleanup codestyle check
Message-ID: <ad9XBFb_xCw3mShv@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
 <20260415050749.3858046-3-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415050749.3858046-3-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 10:37:44AM +0530, Sanjay Chitroda wrote:

> Reported by checkpatch:
> FILE: drivers/iio/common/ssp_sensors/ssp_spi.c
> 
> CHECK: Macro argument '...' may be better as '(...)'
> to avoid precedence issues

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


