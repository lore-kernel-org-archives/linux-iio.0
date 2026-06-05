Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2F390C8D;
	Fri,  5 Jun 2026 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683405; cv=none; b=RADLb2+YF6zQ5ug7GkWY48vV1ZgJa2+IQV6b0G50P+bxjuD6QeOrAZFJIHN+Iez+Sm2KsS3f0T1Uw7WO0L6XawahmJeTo/lzkn79MGa8aa4gTHmoqoXOLcoDEeyqpK59r19OH5X3yXB9KLRe5t6Olb6RVQog7qAo0MmsW+/Panc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683405; c=relaxed/simple;
	bh=Czu7M7stp84IueL4PgpIZQSP3xMQW5xUrpR55Dpa0hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRoNrKER2RtSyeQ8RIZmPFkwJHrO+nl7hOOgEy9JeVWDODO0Ik4m7Prn9GOK0GSkNjnEwR0WTzmkmOvsT+N3d1yBfU79D3Mf1oty1Tz98ox4UDW33teqx4vzW5nM8fD7KKLdpvRBkpSIe9hGysjtOY+oVIQQhRGyNR+z7M4nEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2ujLPrn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2ujLPrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780683404; x=1812219404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Czu7M7stp84IueL4PgpIZQSP3xMQW5xUrpR55Dpa0hM=;
  b=J2ujLPrnTAFdSSi3ftxnUKs8DsoBaIKLVeA5q3M9PZsqjJfy5qNCxjQp
   LnnNgFZs5Nr/YOkGVseV40TQmRjFSf6cWL0EMByddQty9BV3wB3cGihmI
   NltPLkyw4tepkwXjc76UUTPkQxmJVLHYy3+2DlF6/6KRy36nK0qYmsER/
   /DRL9ULaaK6qHJxm1T+vky0r1U/6Sx12d0spxTX2RmpXuRL0cqJ2YILwF
   px0XNoMm3VFFgARcy4EyMc+xg2oC+1L85t/PxH09KJcC/yRXscJNoD5xx
   H8xeGcLCcBUdRZKMnxncfpTQ/+TYnZz2RKmcMFHy+wdxc8EPrht6b5LyW
   w==;
X-CSE-ConnectionGUID: Ntde4AFuSbGboZQ9PEyicw==
X-CSE-MsgGUID: qzfR19uDR763gJlgaT1KSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="104183174"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="104183174"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:16:43 -0700
X-CSE-ConnectionGUID: +UtgzMglSRypY9K2M6LwNw==
X-CSE-MsgGUID: F5ESppPXSWG8lsSCPSFTag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="241928990"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:16:39 -0700
Date: Fri, 5 Jun 2026 21:16:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Subject: [PATCH 0/3] iio: adc: Add Axiado SARADC
 driver
Message-ID: <aiMShZhp7iUL9n4_@ashevche-desk.local>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 28, 2026 at 01:10:22AM -0700, Petar Stepanovic wrote:
> This series adds support for the SAR ADC controller found on Axiado
> AX3000 and AX3005 SoCs.
> 
> The controller is a 10-bit ADC. AX3000 has sixteen input channels and
> AX3005 has eight input channels. The driver uses SoC match data to
> select the number of available channels for each compatible.
> 
> The driver supports single-shot voltage reads through the IIO subsystem
> and uses the reference voltage regulator for scale calculation.

When submit a new driver always answer these two questions:
- why do we even need a new brand driver? (No existing that can be extended?)
- where can we get a datasheet? (URL? Other means?)

-- 
With Best Regards,
Andy Shevchenko


