Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9273932D4;
	Fri, 13 Mar 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411781; cv=none; b=fQLW2JsWid66XhbXCyjOzWRKeh1E+ARjc1ToFJ59ZkZ5C4VxnQ33HQ+bUNekYs33p29p6EgAPQdhHUa815t6S4AGneR5j3Mpb4xe/4wWX/sFRwOEaU1MyaTjdGpluf8Zr6U2NtvUFlimKv3ziHKqqW619P8O9cy48Y17lcaeVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411781; c=relaxed/simple;
	bh=H+B1XcW6CRGy/Yk3P4DprxAY48WKykEj4H2wXEpYxTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVEnOwd9beu3uS1FdiuM+jhQ6t7Va+y+RXGRUUQxaZPIrcqFYknvuG6L6odRkiNXnDwtHceItxtoklJUkj+na+K7PKM5zTR385thipm3ws9caiiDyqr7TPumYN+pfRWmVDNMz7o6PMFw7QD4liEhhBMyW3PmcVn+5SL1Hrdq38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6FOkZ9C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6FOkZ9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773411780; x=1804947780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H+B1XcW6CRGy/Yk3P4DprxAY48WKykEj4H2wXEpYxTI=;
  b=X6FOkZ9Csf5gL21BAd5ol7D4DD6edEEDPC7H7EQkWJ0Dnt8iL9EZQO5V
   mytqxmBUDuoTXZ1CNWdfMwwDMa7od8xsnNfHd5eZ1wFbrg1IGwZsS5juY
   yUuZy8dPDw/58L5xGjGO6lxo3hEPK/ma31NMF7aAY+iQDy3WLCJ8i479P
   +vB6z8cuQO3+FW1xa8DmgrfZ5rO2VLqw/IArFTkR+McSAiXbbKxbizigB
   jHV7p/JbilOT2ympK9crdQBObS3ClQuRlK1ax3HwNOIaxs+lx2b+EPiUj
   vAIE7DfcMuDW9pl4fuW0mE7UfpQjFttbz6mrXJLuLd0Zzy+omXmpsQ5J7
   w==;
X-CSE-ConnectionGUID: RF1OZPeURfixsYUUL+dBuA==
X-CSE-MsgGUID: sKOxvIhCTa2IsoVb94poIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74488950"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74488950"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:23:00 -0700
X-CSE-ConnectionGUID: T2Ahm7fwT0mJg+JtSnlduA==
X-CSE-MsgGUID: 9IBaaTmiRVmq/lpM8wPgUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="244201477"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:22:56 -0700
Date: Fri, 13 Mar 2026 16:22:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <abQdvXq9MtIZ0EpZ@ashevche-desk.local>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313115856.87763-5-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.

I am still not sure this is the best approach we can have.
In any case, I have immediate questions here about regmap usage.

- Why do we need to have a separate regmap per channel?
- What is special about channel 0?
- Is it okay to communicate with different channels simultaneously?
  Wouldn't be a nasty race with HW IO?

-- 
With Best Regards,
Andy Shevchenko


