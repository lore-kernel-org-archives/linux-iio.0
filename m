Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464195;
	b=xZNM8k2XO2FUs0MErAe0Ulg4PCFLHpQrJjSABkLBYu7pLChgqA0UMqSIs9CGjGpkuZgf
	 rXcIbLPE132k2R0nGmfa+ZHSfKSm46kpedYzGCw6R/GgQPMu0JFYVVhzNWtDQpveYpHPz
	 ZX2lUnmhi+MPrk4lsU8UdXocvoaXzyx//BwQbZC686Ey4YkNZbwAnZYcYtfDCPZ8OOWF5
	 2fcbRRMGMO5rFGGj2JLjwwrphuNzOCV+o+3Ninadk+TlHqpw/gL/5cGPQW1hakwUJ/Tx6
	 suGXO2rnpJD7lDoPxcv4IMTw/UIsxIV6KhPV8sBr0SIE9NC0v+HNHIHsB9a0eu6qorw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464195;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=vEdCKoQwce5XBiPvrfeIjFy43hwj6OR1hxIOa4L8trI=;
	b=LK9Ds900mERI69N1IH7fAMmn101vkSGwpVX0PCUJOrqZqEJdbfyVIQzjVU/aZeofyF+N
	 iE0Q30z05hWCWbPhs3cO4PrDzV5VDSVmnikFvTf2aIqA7UpFchU8U+DWUlghwWtvLE71T
	 VQRbUw7UbLkno4uHL/+vnopXNX9/TeFtVMtLTIcN3Dd1HTnAJ/zTDSEyDbFWHdcULC/tL
	 N08jZS4oXYqbYU11bHjKKZoFC1FstmqF1ScOVhf/iAyF9KlBJoXW0J/icooBTacThqSg5
	 r1591vidsNYCinqBQwEf5x8QnxfEgvsEi+71DnhUuQ+sZ3mM0dAW2rIUyAWVtsDb1bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GpBZ5p42;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3B606A31E;
	Mon, 23 Nov 2026 20:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B3B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GpBZ5p42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795464195; x=1827000195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f3nYcE/IyeafUCxFLD4l0I+/LGzzsA3qbg9Hw/NuljA=;
  b=GpBZ5p42G6BwDcQYeuy36mTeaFIbd7BRXqarw09euFwYkdM/+peJuYvp
   HKBGmEkFfVB1C5JH3CD7HjJfnzLXmOWuKs1UT/e3iUXt0cKxKtCxAzdpT
   02KNJyKOynKlfVLGDSj77UQglZVGDZZLy7roV/CkrNbpAfWTeamR9j8xX
   Z+1EpdskQsvFmZWnKqrP9ww3o1Y9ZoNTiveAbSP8xMEm9jeOI9qlGTUnm
   W2L6aN6K0/6JxpnseSpvTey6Wy3+9uylCaD3kiVL5BBWGqYMQD8jpamGB
   TfoUzd6ih61U8YYBq1EeWkgeSbf4qmQvgPf/l0KK2CjPhYTLucVxpOJug
   g==;
X-CSE-ConnectionGUID: VQ5bjysxQ12Bzeee0D+acw==
X-CSE-MsgGUID: fD+4rm7bQHWjFCq1BoT5YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4196999"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4196999"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 12:03:15 -0800
X-CSE-ConnectionGUID: RmeUroL9ReapMKJIfq1yvg==
X-CSE-MsgGUID: HKOp4bezRfqSrGJM/MjycQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11942945"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 12:03:12 -0800
Date: Mon, 23 Nov 2026 22:03:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: magnetometer: mmc5633: Binding, supply and
 mount matrix
Message-ID: <awSb_WC5q3rX79dP@ashevche-desk.local>
References: <20261123194943.57601-1-gerard@teslabs.com>
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
In-Reply-To: <20261123194943.57601-1-gerard@teslabs.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 08:49:39PM +0100, Gerard Marull-Paretas wrote:
> The MMC5603 and MMC5633 are listed in trivial-devices.yaml, but boards
> need to describe their supply and orientation. Patch 1 gives them a
> binding of their own. These bindings are also used by PebbleOS, which
> is where the need came from.
> 
> Patches 2 to 4 add the matching support to the driver. I have no board
> running Linux with these sensors, so they are only compile tested (W=1);
> feel free to take only patch 1 if you prefer.
> 
> Changes in v3:
> - Reference the datasheet timings tOp and tSR in comments, with the
>   tSR one in a new patch 2 (Jonathan)

Right, but can you also add a pointer to the Datasheet Chapter, Table, et
cetera in the same comments?

-- 
With Best Regards,
Andy Shevchenko


