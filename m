Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10130274B46;
	Sun, 13 Sep 2026 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789287651; cv=none; b=lMPU2xWdxdFNby2BTl9ZmYuPFtr4pD0jjm1QprEv5xEpCCXKhgIlri7ZkYg8kr9hIRU5+29MavTKAavyoF7uS1PAkVSDJb9yAGuS6D8vugD+oK/wrcuMbxOCbr9dx3+TXWOCWaEDV7ZpF9KTljhsRMBgjjlUSw8KdtTckDAhJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789287651; c=relaxed/simple;
	bh=SrTpzxPAmfDfyp6nEqRVjHRq3/IdHCzeCJjs0O4ehso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElW61f04niyFqLG/QSKmDTusgdAdmkHnP+0zC1vBjnxbcWSg906LWP382aoJuocBgZ2uGSGSb8ubBKncIsrd3odUzEVEVG/8EkfTvXaFCx8eP4mQDarGM+Rul49lEhPvAuBmzDflZK7/t/ymiaf25aUt15qHuqMbpjkPqWY/WTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grkhJxoI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grkhJxoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789287650; x=1820823650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SrTpzxPAmfDfyp6nEqRVjHRq3/IdHCzeCJjs0O4ehso=;
  b=grkhJxoIPVMmYjYjoysZlMEr5OAnBlcrJ65nDSx/HaJypqzqIcaBdUJs
   bfHIDlL0t3v4klgygyWg14dbUEnbsHJqk/LN2J22rvhVGJTwKHmeupcKW
   E/H0qKz3XC6vfxnnBQgttv1SGLTW6GMuZi8yG9eazTEy6OCE2b7LgOjAa
   v2DpoqtbGrXALPrlEE3eCUhlrHO2UI/cdGQgn4cEqo7vEJnzwRvzo/3zK
   esYZcaK/ZRym3+oIuigvyHhbwk++HyIWxKjGUYxOfX8R5aOH4GXztgB/v
   LWmlfJzxd0kzSwB8heTBh1ffXypLV9Nkf82Y6jbZvg9vOYy5zv4YcpNlA
   w==;
X-CSE-ConnectionGUID: XnaB4MG4Sv6en1TFfeuqdg==
X-CSE-MsgGUID: 022UmeGYRUGj5lOPAt2/8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11903"; a="100278232"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="100278232"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 01:20:49 -0700
X-CSE-ConnectionGUID: 6qY+Km4kSv+rH67L9HMUpA==
X-CSE-MsgGUID: 8FtHbhXyT5eRMK9S5EDDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="295835377"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.0])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 01:20:47 -0700
Date: Sun, 13 Sep 2026 11:20:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 2/3] staging: iio: adc: ad7816: Serialize SPI read
 operations
Message-ID: <aqZc3LR0s0I2S27b@ashevche-desk.local>
References: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
 <20260912132517.55686-3-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912132517.55686-3-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 12, 2026 at 04:25:16PM +0300, Abdelnasser Hussein wrote:
> The ad7816_spi_read() function performs a sequence of GPIO state
> changes followed by an SPI transfer. If multiple read operations
> occur simultaneously, the GPIO state could be changed by one thread
> while another is in the middle of a read. This leads to a race
> condition where the sensor state is disrupted.
> 
> Introduce a mutex to serialize the read sequence, ensuring that the
> GPIO toggling and the SPI transfer are treated as a single atomic
> operation.

...

> struct ad7816_chip_info {

>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	struct mutex lock; /* protect device state during SPI transfers */
>  };

Is `pahole` happy with the chosen layout?

-- 
With Best Regards,
Andy Shevchenko


