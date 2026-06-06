Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F63202963;
	Sat,  6 Jun 2026 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728406; cv=none; b=GJ4s1QEtu637GcpwljyQReN1budNM8I1bmYaC0bDdWdDWa5gBnSKacf5UAKFMzfGMXRB4swI54A9KIiMgkjxvaf27MxAAr9dyaU60QkryDoPPsFayzZ7y8FRsax5Ra/k4W3d7nnigaKiigNmKUcPsSpx1XrseKfHgTHAGSbgNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728406; c=relaxed/simple;
	bh=DSxIRnTXK40EJiQzC44uhcd9hVw68raQ06IMzoojolQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM7rhFNNqjnh4wd6riOHjLf1jQgIyPn+fBjSZLCUx0WVItXUhNmcbNQaf3ngmU9WbtBtgXOv+CJ86Fg1GTOKD87L9H15/9vMwg/SSIq/tx3xxBt+KTqr6W/x+CRMXQxmzTEKIEa7/KPdlghev8hTFCgWgsPAsPaHi/LdHK1nZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dk+LZpHv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dk+LZpHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780728405; x=1812264405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DSxIRnTXK40EJiQzC44uhcd9hVw68raQ06IMzoojolQ=;
  b=dk+LZpHvJrJ80lj61xNhPbGqQ/04+eXa14g+9ko6g4vJT1x7fyGos2Ir
   FTnFamrlYd0qorVBoNNEgcSm3cUcsLElJv0AyGeCWcE2+givgh6BbD3Q7
   k1PvUecNKTGRrwJ/0rFC5kRDT4TpzttgMw7AsFYPSNSbAAH4Bgx+T2Ozm
   1+cVS2/MHXwxBBETx6HCavGpFHdQYl7qGhxhTvcUcdDhoIZI+Ej0eALEs
   EkDbmCWpjI27kA0owlSovs29+2iNhUDp6Sh7j3qmcmndTRb++m9DIwZZr
   Xvr7P4EBZ5rDCofxOQr9OfD4k4J7i/8NMfdOkkh/Yb8/sMlpPmESxMgOI
   w==;
X-CSE-ConnectionGUID: GaQPZOnjTSq8XHSnqixUUg==
X-CSE-MsgGUID: I5SM9u4ER52FSKYbSDQPOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="92121085"
X-IronPort-AV: E=Sophos;i="6.24,190,1774335600"; 
   d="scan'208";a="92121085"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 23:46:44 -0700
X-CSE-ConnectionGUID: b+3Z64H6SE6PXSgvrpJa/w==
X-CSE-MsgGUID: JwMTLQe7Q3WEGxDkk49JsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,190,1774335600"; 
   d="scan'208";a="283121212"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.57])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 23:46:39 -0700
Date: Sat, 6 Jun 2026 09:46:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 03/14] mfd: lm3533: Remove extern from shared
 functions in the header
Message-ID: <aiPCTBFGgnfhFgLl@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-4-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 06, 2026 at 07:57:27AM +0300, Svyatoslav Ryhel wrote:
> Using 'extern' is not required, drop them.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


