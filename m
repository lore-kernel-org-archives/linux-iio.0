Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA692E7623;
	Sun, 12 Jul 2026 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783839804; cv=none; b=SH/SOxll3sE0aiB1yvVgmiC/s/1ml0On6/WAeQK3lYQM47amrayBZrsas9Osbcg++W2ByHSQxvGVuiSJpJgBbssk865wc5SISmZGiTGYi8a0vXCY1BRTzYj8uFY0ds7luq9dlfnnGECaGVgphf1Pl7AoAZP06oPO5qKffecb+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783839804; c=relaxed/simple;
	bh=bu5KEPQ9ViMyoM5pTozLEUGY4Tn5bOg+F7I1Ww8lwA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv30SqYtTx3OiU3bdzdorKDymneGmzV9djMKTTqBqHzhlP760H2QTQQg679I/ud+/hCa0KxNgVBcguR7cXz0bfTP7ndrsIufGJkKh1ZnKxs8K9QvYao+8kICvcSOqz8jJm0KPWgFl2129JPTdS84TXNJFcogts0Xl2BRVx7dRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQZfW91+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQZfW91+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783839802; x=1815375802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bu5KEPQ9ViMyoM5pTozLEUGY4Tn5bOg+F7I1Ww8lwA4=;
  b=EQZfW91+jnYV/FF0IajK/2MQZI75OH/WyubP87ZpaAbZDKJ5oFkSvyr5
   rzBfYZCEyhGSpAml5tvi6K0wLuSrZTzv8Z6jEwl2fv+ioGOBuPUww5BCT
   EhH/+zWVMBjBbBqYV6FLnmqONJbiBA5ASRzI8mW1b57WJcyfF9jgrZHf6
   3T4888vaPtH6PLCxlJRoBYisoOyRRaXw16iToNX1f6aSTbPhrAU6sWWRo
   H52h3aUsoVjco1EY061pgZfgOzgwCR0ydIbN3OcSmsY0AAtdeMlseg0k4
   UEC1ChpmHVBfJDBBGANwI0VxsWUmFzPiOgCMupQ27YOiJUoHuxsEBjfZj
   g==;
X-CSE-ConnectionGUID: DNE1TSPaR1+HxbEXSO15Fg==
X-CSE-MsgGUID: Yu3Rqq/oQhiHlGN8imiWew==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83463502"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83463502"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 00:03:21 -0700
X-CSE-ConnectionGUID: 6fOw1vwUR4Kuzo345wbGvA==
X-CSE-MsgGUID: I00TToQ6QJyxgzl57nln/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255905361"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 00:03:17 -0700
Date: Sun, 12 Jul 2026 10:03:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 4/7] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <alM8M78O9-cRSxR-@ashevche-desk.local>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-4-1bcc8c280e4d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-ad5686-new-features-v7-4-1bcc8c280e4d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 10, 2026 at 12:20:48PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Use of local SPI bus data to manage a collection of SPI transfers and
> flush them to the SPI platform driver with the sync() operation. This
> allows for faster handling of multiple channel DAC writes, avoiding kernel
> overhead per spi_sync() call, which will be helpful when enabling
> triggered buffer support.

...

>  int ad5686_probe(struct device *dev,
>  		 const struct ad5686_chip_info *chip_info,
> -		 const char *name, const struct ad5686_bus_ops *ops)
> +		 const char *name, const struct ad5686_bus_ops *ops,
> +		 void *bus_data)

Can't you utilise the dev->platform_data for this? I believe it's exactly
the case where it suits.

-- 
With Best Regards,
Andy Shevchenko


