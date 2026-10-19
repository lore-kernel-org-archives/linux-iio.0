Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27F48DB27;
	Mon, 19 Oct 2026 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399593; cv=none; b=Dm0I4P1iFJ2QZ1OIlkgj/prDkKPyXzEbv1SWWbgGY8qNkeSDazyuzSAiiiNDibV1ydOquJGYGEdkYbVWNMx8Cic6yuvwpxpIrOZcrMasxd+FvEwBybWZlXSAYi7vxF4pRckT4kL1sfRFRe3Q6oLjOpB8jr70V4QaDztoX7a0eEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399593; c=relaxed/simple;
	bh=SoGd/ETgqCPUGBixFFzWc8lWVqcbreDxgQWOaVajhKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoJOo90jY4Z0HqliPvgXYc/heJKUSRXUq7aM/4gGFJNfud9dr/VrdBLFKSF9Cd9cxkpYdOVyaqAM8tcY73F37wQulv+Ri/biyKSxbdbQk63Ihl1GmZMtk7dt2/szpp37WZJZSDnKQF/YnJfcVFgJYzvDJBNTnZXnD/KOj0wPFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8qRvSpe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8qRvSpe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399592; x=1823935592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SoGd/ETgqCPUGBixFFzWc8lWVqcbreDxgQWOaVajhKc=;
  b=Y8qRvSpeWwQGHom+X/UrSux+qznET+K9kayTrxf9sbUehxovFVLVPX/q
   TSrnk91CXPsdaT7j2LaRhnEy58PHPDUKQzbggUpJn8XBXLZ+9mf/XpGii
   EIXmpKfT4CQufcF6O6EcBfNsqzEiXPAIVhVy2YnzAwWaI5p17LUl1oR3g
   aSm3DOYzeX3831/FqW9xR1Hxp1+0GA10d8G3oVv6/i9c4MUS0pzatQZ9v
   /ntoGFkejZlcnmIKOKgiGIAs9BEF/1EztOvzUSbed2aDvaw00dNiZJ4Ki
   PiVym+RXw2+3pvZFyIdAQLSMG2im2rjWVUQ6KdZ/w7IXFWsqGxItdL17n
   g==;
X-CSE-ConnectionGUID: 2JoJUma1RWCxVE3p52YbrA==
X-CSE-MsgGUID: HvCy7/EMSXa/XwlkFfFXKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1179967"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1179967"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:46:31 -0700
X-CSE-ConnectionGUID: gMge9sjvRnirRa1OS1IUDg==
X-CSE-MsgGUID: pnL85SkuRvSd+RHPnrnX5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2799107"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:46:29 -0700
Date: Mon, 19 Oct 2026 11:46:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: bruce.tsao@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: dac: add support for AD5413
Message-ID: <atXY4kLEXxmG-tnk@ashevche-desk.local>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 17, 2026 at 03:23:52AM +0800, Bruce Tsao via B4 Relay wrote:
> This series adds support for the Analog Devices AD5413: a single-channel,

Why in a brand new driver?

> 14-bit, serial-input DAC with software-selectable voltage (+/-10.5 V) and
> current (0-24 mA) outputs. The SPI interface runs in mode 1 and carries a
> CRC-8 on every frame, which the device has enabled out of reset.
> 
> Patch 1 documents the device-tree binding; patch 2 adds the IIO driver.
> 
> Tested on an EVAL-AD5413SDZ with a Raspberry Pi 5 and an NXP i.MX93 FRDM
> board (probe, voltage- and current-output, scale/offset, powerdown/resume).

-- 
With Best Regards,
Andy Shevchenko


