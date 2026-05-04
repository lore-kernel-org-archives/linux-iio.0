Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8E2DEA9B;
	Mon,  4 May 2026 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883143; cv=none; b=LaJTYTIPEcjPlxmbZvV3BirwQQo1T2UoBI7xTBDdedzTjBIwNgiWvpxPb2kBl05IsCYRU+jzp+bIoZYj0Y0yUOGFl6UaNOOOr9MsMPqK791nwTRzCXPs04bbtPWoCA5vULOaL61E1LSF7/O4b5XPzqzi+za6gIrZbCFUmNgIDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883143; c=relaxed/simple;
	bh=TR+yREtWhczozeSFXV1B/WURM7Vg5RdHH1s1wSMJ4k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/A4qG/RG3+cwAmol8t/rQ5o3hScNj6oi1T6EjgFxuUaqmIfSl8G11TXc3S9lEBLpoFaCnyV0UFzUcppuximKFPB++tp6LBnWDtt+dfkUPp7TOt2B4tCnQuuloeVcCvRAv4AMGCkuq+HhR6+oxawC2+0mLRJ8FbzcjUGF8TOELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDJewAKs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDJewAKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777883142; x=1809419142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TR+yREtWhczozeSFXV1B/WURM7Vg5RdHH1s1wSMJ4k0=;
  b=gDJewAKsBxvK03xk8JAIYU3uya+azXOTBSopgp/Pa6EwgjQnKUHBcE+J
   UCS+KQBnOAWr5DgzUtqmMbeYvLOc6h460wch9F7h+0BMes/jaoEhSqreh
   q97DOmW+pzKTkcE4OREnv7lhgQpAM4lBh0e81j/Ds4Fjpnegxh6BhLgAK
   s4hdZZStLPqmvahGYGpYyWqTsXwHKKOuJxkU9+OxIeyCH9MKe/WL77UJQ
   RpfGyS5kfnhmQl+qXLrc/Jyq8lmpNMa8GopXwrGFsv7WIlLLeeYOMmd++
   ccVBCIKdi9c94mUToSS7ZiLD8BtfZ4NHSy11LVzfRBL59AEw25QufIUqi
   A==;
X-CSE-ConnectionGUID: ryWSKWFaSIy1v7J2xUJvRw==
X-CSE-MsgGUID: ujiIgHNgRTqfBuBsKE0Nbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101403750"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101403750"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:25:40 -0700
X-CSE-ConnectionGUID: 3E5zm8wgSfWnD4cOmmU5uQ==
X-CSE-MsgGUID: Kl8CzqNiTA+8L3HN5lPTfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235331953"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:25:36 -0700
Date: Mon, 4 May 2026 11:25:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 09/12] iio: dac: ad5686: add helpers to handle
 powerdown masks
Message-ID: <afhX_sf0cB4MqbGg@ashevche-desk.local>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
 <20260501-ad5686-fixes-v5-9-0b2f45488418@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-ad5686-fixes-v5-9-0b2f45488418@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 01, 2026 at 10:15:02AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add ad5686_pd_field_set() and ad5686_pd_field_get() helpers to cleanup
> powerdown mask control. Define AD5686_PD_* constants, like AD5686_PD_MSK
> to hold powerdown mask value for a single channel.

...

> +#define AD5686_PD_MSK				GENMASK(1, 0)
> +
> +#define AD5686_PD_1K_TO_GND			0x1
> +#define AD5686_PD_PWR_UP			0x0

> +#define AD5686_PD_PWR_DOWN			AD5686_PD_MSK

This doesn't look right (semantically). Use just an explicit value

#define AD5686_PD_PWR_DOWN			0x3

Also sort them by value in one way or the other.

With that being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


