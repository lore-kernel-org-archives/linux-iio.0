Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0863B3B8124;
	Tue, 21 Jul 2026 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666969; cv=none; b=XJO8ksoeNTdhhidzr2hkqkfgHwuJbmYih8seZsuMazY04xaNs9pCSFV2C11XeYvenwMDeSGZjFT37gMdeDe/Zcv1Koa8mwrubUVLTXbyYbgwsGnqJT1bP8HXRhDG4jdqsMxT8WlwMCqfhErgMm1WyXhiMBIWKdAYQZYSIbBADGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666969; c=relaxed/simple;
	bh=uM+1RWNODL3+RMwEZJ5X+vbum4O3e32itlLt7w58ir4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnSAaaYiuCBo3Ng12TMuaOtAA8Zpwn4NNP/TtF8YV2quNKirhwAUy/8lg8Gi/zXRBTLvVIEbfuJWLUdRnYKoLAF7Jo3uTzJmgm36ZqKcwqS5uY+lB6RG9lNyvaGrsSDK66RKJPj+7PgU33nAVXWYbp06Eh3iENav9FcJegkXAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4YZvzeM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4YZvzeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784666967; x=1816202967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uM+1RWNODL3+RMwEZJ5X+vbum4O3e32itlLt7w58ir4=;
  b=F4YZvzeMeJt/VXlURWS46ZtxPo7xWdpvzcqHxeZ9trK/dQHlrIzlsEF5
   osUoWiMazoI68VrWeRZ0U0Kv8VyaJul/cw+wrba76y/Mm+G4v/TB7U6aM
   xcZZyrmHUAZbwFVYa70eLaXs/wHm/JCQ7U1j/FSx2qlrpX+4fKObYvfxU
   Ndun2oIh+MfIfwZQsTRdzcmOQC54oQOncO9PQvZTDasHXRq0MDYKH1zTN
   2C30Z8zIUKKGPNgnwtnoijEzxcv94ngXdleIxPf2h3rsvygHJ9X4ns3M7
   IJ/B+y9ot3/Q44Wp2oxXFrTKiiKo9uPRNuZCpg/U0dVXiu8wKgBgU7pBp
   A==;
X-CSE-ConnectionGUID: ichBVfT/RCKw+ARV1So0JA==
X-CSE-MsgGUID: YV/1TF88S/Oj+RNEp22mhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95651258"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="95651258"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:49:27 -0700
X-CSE-ConnectionGUID: zXVluy4DRvSjigBCDlZ9ZA==
X-CSE-MsgGUID: ioEIDDwHRmK86GzfbSwwpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="258539153"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:49:23 -0700
Date: Tue, 21 Jul 2026 23:49:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Song Qiang <songqiang1304521@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: update email for Siratul Islam
Message-ID: <al_bUWguna_K1n7X@ashevche-desk.local>
References: <20260721150314.24545-1-siratul.islam@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721150314.24545-1-siratul.islam@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 09:03:08PM +0600, Siratul Islam wrote:
> Change personal email to the Linux specific one,
> to have a single and focused point of interaction.

...

>  .mailmap                                                      | 1 +
>  .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml         | 2 +-
>  MAINTAINERS                                                   | 2 +-
>  drivers/iio/proximity/vl53l1x-i2c.c                           | 4 ++--

Shouldn't DT patch be separated?

-- 
With Best Regards,
Andy Shevchenko


