Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A719E96D;
	Thu, 12 Feb 2026 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893912; cv=none; b=AOoJXJ+o7uD+BYxWIdooLqzAG6zp/Lk8i/n1X70fvCI9QXV5rz/GuiQQYHWsJCvP3SCiu87CWMFKO5pcnvrU4aN2KP6ROxpZjtstXxO3bEXD1W/ocH/VrZI2TLlwtiaveIkg2AFndeerCePhEC30UJ0n/fAabz152K1WsxQPpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893912; c=relaxed/simple;
	bh=5SfEf5qVZTqMrlbVfhdOBJTgKKuRHDzhux5enBNzHEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFHaANDSzqui82tsRiHoKIXq24A7omQpu+r/EMNMw0vuzCDEEBelSm0FTt0/0gJG/4HcIN0l+uMgiSHPBzMXvtKrE2XKNyDc88iw4qXY/hAQDrdxxdxiW8ZWh4G0WNoe8birEabeU3nrrr1W4wLfG3kmSlD/CigkyBAc9swcvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wph1nrjq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wph1nrjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770893911; x=1802429911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5SfEf5qVZTqMrlbVfhdOBJTgKKuRHDzhux5enBNzHEE=;
  b=Wph1nrjqLrNX4n4bKiMPN4n3jq9IIz3Zo4n+iunGJsJsb03ByQlCcglg
   yPD+5RdMK7qS2L0XYqVv1THTwjwh3nk7+usyWtC5pmiv90HgzVLKL2fGE
   H8hBSf0+GYHxUs9gWXP0RiZSeqACJ+r6LsGcCCWFzrq2X/eqMYkB1TTSZ
   U4++MQlgcBxmHWzwhOVnYz7kM4s0D4Wx3ryeMFuwZQaWF8d/85rKUG4bO
   ymaE3WipbW0unfNO0C6BnrrD1IIdcxyh2IeN5QwfX/s4jDCF07stySa2D
   PjM0S+/ZFErZMPX0jp0FyNlt0v7WzIIYkcnvf7KkTYBZaVHYAWEzhBvkO
   A==;
X-CSE-ConnectionGUID: 0pRa13TvTYCR8S1MvoyJKA==
X-CSE-MsgGUID: 7tck6PraRQ6H2KijKUojMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="59633331"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="59633331"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 02:58:31 -0800
X-CSE-ConnectionGUID: ErfP1ZewSUuLhXtDdLPQuA==
X-CSE-MsgGUID: kRs91ezsQeeaX66NoAlEiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211396706"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 02:58:28 -0800
Date: Thu, 12 Feb 2026 12:58:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: proximity: hx9023s: fix out-of-bounds access
 when copying firmware
Message-ID: <aY2yUbORnGDEzaU5@smile.fi.intel.com>
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
 <20260212-upstream-20260219-v2-1-2b28fce5d09e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212-upstream-20260219-v2-1-2b28fce5d09e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 02:26:52PM +0800, Yasin Lee wrote:
> Initialize fw_size before copying firmware data into the flexible
> array member to match the __counted_by() annotation. This fixes a
> potential out-of-bounds access that could lead to a kernel crash.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


