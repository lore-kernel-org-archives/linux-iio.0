Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C1396B8C;
	Tue,  2 Jun 2026 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427690; cv=none; b=BnGX3kMdzBbt32h1J046ebjFXDNJq4m5hY35OSn881UxrNh6l60CCNZugaln2YkSOaU2MTigU7zruiQmexFvJy1HQbcXt0jsDeK+LdRlxxHxftWTviMy0egUnyJ/2FPbD+UU6SuvAWqtqt731KKUR9KM9M3FwORQW100hiLbbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427690; c=relaxed/simple;
	bh=XHMR1WRsNRtzpxelI/uop7Z1ecZpmNjxeeGWWA8nPaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1bNTq16HtX14Zcnh23X3K8AZx3rh+dCaIwCmtdH3jN4XkLFdDhaiLROpo4RE2gpTfleAhmVTZHq+MWJcahIZeVm5IZqMEyri5Tfv1MFjSEtuuaF4xmWlBVuScOM/7j4VJ/3GhdqDJkm/h1wxfDbhDCmjsrxedSnT9erV7To8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNqgJiiG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNqgJiiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780427689; x=1811963689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XHMR1WRsNRtzpxelI/uop7Z1ecZpmNjxeeGWWA8nPaU=;
  b=PNqgJiiGYDLFhi3s+MhiuNplzQxLsLF08NgWynciZ/45lx6b7WLWSE1X
   9TEUIt2Knq/5MxkJCo0ujXigGBeO1N0OBlmiLC6uGpPL21iQLqA2h2ChJ
   ChTv14/9zBjvlIoMK7cLAoJ6Vlj7smnnFnN2rnLQYedcL6RP3/foH+Eu3
   OyaMYitt5AGPKOBDrOjibagPQ0RzhSn6r2dXesLCgRUfIwW+axBAbUWcO
   C05KrO6h0cxn4uSYThEwsSdReNXa926sfAjDYKvAhQDXfcpUd+XxXlxhv
   aZ9yxMEgmsj1rz+8BgkFUT0/zPHQqVeUGWt72Bf43Oul8tOcG/b+oJAHG
   Q==;
X-CSE-ConnectionGUID: /mrYNZyeR8ibwVMNWRsxqA==
X-CSE-MsgGUID: 2dDNuWONS6aS8xnnAYpKGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="98790324"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="98790324"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:14:48 -0700
X-CSE-ConnectionGUID: ZTBfWtr8TgGMl+iuNTt0gw==
X-CSE-MsgGUID: pJ2vD7pRTRyEqMbbG8sS8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="282099428"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:14:44 -0700
Date: Tue, 2 Jun 2026 22:14:42 +0300
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
Subject: Re: [PATCH 09/12] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <ah8roqGqZ_VhAPaa@ashevche-desk.local>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-9-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-ad5686-new-features-v1-9-691e01883d27@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 05:33:56PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Use of local SPI bus data to manage a collection of SPI transfers and
> flush them to the SPI platform driver with the sync() operation. This
> allows for faster handling of multiple channel DAC writes, avoiding kernel
> overhead per spi_sync() call, which will be helpful when enabling
> triggered buffer support.

Why spi_message_alloc() can't be used instead of manual handling?
(Seems no current users, so you even can modify it for your needs.)

-- 
With Best Regards,
Andy Shevchenko


