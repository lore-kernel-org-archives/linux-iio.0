Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700648;
	b=FzFM+6w6F8nzOx3uOfqxZ5HJV64uRnvY/qMDgyGBXenW0rnNCWpFyc9kcF/UJfFa66a9
	 DJMD1SdXHurWNCR38rUy5tkLBnR8RgPcfD0btGsOZdS7+ljJlldUspZed31q9XAq1vgdA
	 vkejZioCJhtSXz3w4jSZKuu7Qr4tYDX1sLtST464iSYQ+KkhDjFnv+1laWH9FNbD1vFRG
	 OmZgEXijgqm6wwSeWH+w0fdWRshpzQTztqJRDpiCrasRughlXgfc89vRK/9b6OEdYoQQ7
	 tv9F1QRMVn7a3rsqWZDco05g67Vhk3HwkJPvZGUuKHq/atn7DdE+EuetOcFx4IWOeRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700648;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=f2Q10uyThL33lTmRU4VfofIoTvnEflRRbcrQcK/9sFw=;
	b=ukZpaSUqwdXaucw28tCwj3m8zgu7Ll1AJHn65f7uIWgAl9D8hJRDNLswlzgRf4SWWytD
	 3wWJd1OJAbcERw72thVaoQMJIGMpK0ijFCfZDpdyrVTShdLggLlkFuVubMFIdX6OMHKcN
	 o2pW1JmbnuXitSLCwTY+YlFYlssiwPG2rvniyIcM5I2irktBXEFTWGlTu2zeZOdpfnSjk
	 LO2/i04up2FjpR5rrHFPmBaevp+SNyorKauHh0hNqMJs0Z+oR0z/XnVYsJNAVbC59ZlGI
	 9zfFEXst9gbhcPiispiT2Qfx+BGLkSnlK69YBRKGUUBXpDmKlAfnF5cvdrXKt31VzIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EswyD5ht;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29239606A31C;
	Thu, 26 Nov 2026 13:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29239606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EswyD5ht
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795700649; x=1827236649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aUYEe3XEohVRDEzCSSJ8bh55/EvWMs2MyrgjwrKmSi0=;
  b=EswyD5htbgo7X1lwz7N95gD0FxYCZUOLy1FwaSOEX5vcJDpa8wJ7h8Ny
   acUIUeXEBArkvMoDsugyAb5l1i46YWirNlpJuL4SkBsGnbsggo5iojlv/
   ikXdwFkMd3XhZS8JMKrvke+kxYsMAZBTVtxvb3/kDbxR1XYspQiqtZy6g
   YH0eVZHm2ujvUjwPtq2CqoxVc+TJxmPET3tuiuSV5SmzlQlSkQB3CbZJ0
   W3R+quq41clUSPpTEJxWPaUNK9QJLvlC2F7aPC/ugD8/iv1odPP2L4CDo
   TeWUvh9WWHWHckn8HIxzailOGLvFb7dKpUtUckBQxk5NRnltT9MRZJ41w
   g==;
X-CSE-ConnectionGUID: LiQVz426Re+ZmpyncKm+Og==
X-CSE-MsgGUID: 00pazCtOSzWXk0ah7yRsNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4566335"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4566335"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 05:44:08 -0800
X-CSE-ConnectionGUID: EH2Gw2pnSn6xxW/wvVAtJQ==
X-CSE-MsgGUID: zyfgfmPcSLai/TnyYU2lPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12402382"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 05:44:05 -0800
Date: Thu, 26 Nov 2026 15:44:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iio: pressure: dps310: use min() instead of
 min_t()
Message-ID: <awg3owGf3-7pZTkz@ashevche-desk.local>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-4-zoone.rupert@gmail.com>
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
In-Reply-To: <20261126121331.10438-4-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 02:13:26PM +0200, Rupesh Majhi wrote:
> min() accepts s64 and int, both signed, so min_t() and the cast are
> not needed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


