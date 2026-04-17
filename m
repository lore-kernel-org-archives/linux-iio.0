Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704635DA67
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412711; cv=none; b=qt7Fxtofo0f53Vf2s+/QTTs1FfbNcn2IN2eDLXuSbQ7Jk3pSUsCzPM1iqiO59hhETpxnmitVe7IW0fbvGuSl0v5uj6cjUIDV0NPyTKx+wdA45byo8dQxdZrmrSPOV8QcBxRmC9MESAAqOSXBpaP8z1a+fe6/tF2wasa574GsOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412711; c=relaxed/simple;
	bh=Swdur0aWcvar8NQhUeCfArcsKJ1EUehgsfoNVr9sGCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih6n01/tJP5lSyf5eT4DD0unix5s/OCd8XlOdi3KrGDZKp0eSD+c/B6FcdHEBgi2vFXKoYhkkVtkhfGqHdDILb9W59xlNjeqdl4r82ZkhjSEypa4UDVqxaoozeOH3bxB/BN3qU+UOricP54hMl8ugEn2dgSz2joFOvnplDlQmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIfxkWeu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIfxkWeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776412710; x=1807948710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Swdur0aWcvar8NQhUeCfArcsKJ1EUehgsfoNVr9sGCA=;
  b=aIfxkWeuK1mx2SGGiiMKsYPOsdFusT42JT+D0NgttEXr4lHbst4FXuMO
   yHcBzTfIB9ZxGuJvfPF6+W39YY1l39hKoNCZlQqBAOSPMeonHwFblIT58
   V5Cn6GI6eY25BBqp4VP1Aqcp6Cafqvwi5XtXGybo3ES65cYPBYasPGJEH
   AvOo1osp5N0g3/SMEWlst+8cDMKB9rafmYwpALxWXnbgETsJWankP6Svi
   FIbzz6csn9IoS4aW3FUmGaIimvSG4lzchf7u7gEkw9LlqXX6C+p26ez2q
   p3Z7K7ruqEOC3TLe95RfSoOtU1AkEODsprHlxD9/qCLpJ6dPcz570+4+I
   A==;
X-CSE-ConnectionGUID: iAfhNWJrRzyL5s0AcncBUA==
X-CSE-MsgGUID: VnTb91goRkyefuhH2m7Ijg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="94993764"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="94993764"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:58:29 -0700
X-CSE-ConnectionGUID: ppZ5qhzkRO+xZ4PSnD+Pdw==
X-CSE-MsgGUID: lRAzGpt6SvOTSfC5NQVw1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="268992248"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:58:27 -0700
Date: Fri, 17 Apr 2026 10:58:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: m62332: Use guard(mutex) for locking
Message-ID: <aeHoIfq00521NwYy@ashevche-desk.local>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
 <20260415230119.17512-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415230119.17512-1-erick.henrique.rodrigues@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 08:01:18PM -0300, Erick Henrique wrote:
> Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
> simplify locking and make cleanup automatic when the lock goes out
> of scope.

...

> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);

This is defined in the header that the patch missed to include.

-- 
With Best Regards,
Andy Shevchenko


