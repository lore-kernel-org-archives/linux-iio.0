Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386506;
	b=pUcWeQ3r6Lb8FBKOj8oL3qjOzrrHie3mYiZK5O7E5zQOasFfe68H5FMWdz7UPOpfjc19
	 /DSG7TbMlnZVgKFgWePM8VnVIP03+8J/wbCgjah04+7XQLrvwvAA7ezimUpvW6NwxBl2m
	 52sx7xem7Amw5kXFpZZHhXvZled39e7gSZ/A7pIcZACnuCewRg7pLpR2o1r+qyZKzSiff
	 TIHM5h/HsHd6/P5FRsw8Jav7JS1TgLi9sUohjkqTxzK1LDvBJE83X6peYU3/PAivpdJkB
	 +eALKJQrqg+vd9RW2dcEkFpP0F1Fw5yq6ETrqn1JAglI8w7eV7t1G0YoGYkYo3B1/9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386506;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Z9LfUtXUIH0h9LuWEMESz7PfYddMA6xbpQRbaf34nzQ=;
	b=XJv/vbAYkD66XvYvNMsYBuYMKvXJH6Hb7awGRbgE6/hSwbYWwwevqtKuhyX7De6UQThg
	 z0FEEl1mndnHOyOmRaXtW1U+f6WhDIV360LS5/FG6OOnZyb8MowfMawRan0czHARXmNse
	 mYJorzXmZdEPTP3EbTQ9dgqXlaUvZNlh1uK69M9O70JU1YATNp4o1/+WhQYqC7f04jRgk
	 ILvp7tiuBC2MR5WaYB1d3Ox7nz5DBwZYyI68/1P5tAsRp33pXMM5XzHg6ejeQN+fpruVj
	 OH3NWhdlDVeqPdnwfHgDtZfBMMYFWyxwhNMPgcFPmZYTn7TuJG9V+wErOVjubnPyv8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m8CYrk6G;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B861606A31C;
	Wed, 11 Nov 2026 08:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B861606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m8CYrk6G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794386505; x=1825922505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/XOELi0xXFCVMEtPO8EZ8t4PWPLUJNKHA9Qs/A4IDM=;
  b=m8CYrk6GBUBGbL7sT0jWeVpd1cLOnFei0Cmp0jI6+b8tWKghEcGufO+R
   6mjH7ivVKWebxbbPI3ehfMGCRunaNjmBBpUyTmDoipcYRn3rnWgacIWeP
   S9omnROiL5EFQlcrsNI7TVIPL1D/G/EIZ3mNr9a6Iaq5dK5deZqB0Wbtr
   VcZF+G2+XqkrVH2z6jVkfwvYc3d8gBD2pqkBKdh91/Nk+575fQNxtubut
   3te8zlNTTWRoEiUsjf1x6oxUAj6PhMLikhcz91fxZRDSGqDUnKJA22sb1
   SwACZMZYARsLlL6kbigLnckiwrvrflLkGMG5K/H0375bfoi0PjMZQtMMK
   A==;
X-CSE-ConnectionGUID: lz9Vt/GFSg+UE0vvSM4WNQ==
X-CSE-MsgGUID: tH4IhHvESkW7Lbh5AUMSYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3049158"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3049158"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 00:41:43 -0800
X-CSE-ConnectionGUID: bnats4KYRiuBX5RMJ/YMhA==
X-CSE-MsgGUID: Af5AvszQRWGa6J8xSAUotQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8442906"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 00:41:41 -0800
Date: Wed, 11 Nov 2026 10:41:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v8 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <avQqQ8s3-fkvIiGX@ashevche-desk.local>
References: <avOKDbkkDwqhHEaC@ashevche-desk.local>
 <SN1PR12MB252866C4690F808A80429926A5712@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB252866C4690F808A80429926A5712@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 06:18:16PM -0600, Victor Chernyakin wrote:

...

> > > +static const int fdc1004_calibbias_decomposed[] = {
> > > +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> > > +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> > > +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> > > +};
> > > +
> > > +static const int fdc1004_calibscale_decomposed[] = {
> > > +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> > > +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> > > +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> > > +};
> > 
> > Can we prepare them dynamically at runtime? Use global variables and a macro
> > from once.h to make the populate function a singleton, so we don't have as many
> > copies as devices on the system that are driven by this code. We can probably
> > do this later, though.
> 
> Are you sure there's a separate copy for each device? In my understanding,
> these static variables are loaded along with the module, and the module
> is loaded only once and shared between all devices.

I started my paragraph with "Can we prepare them dynamically at runtime?"
which assumes that the rest of the paragraph is elaborating that idea.

-- 
With Best Regards,
Andy Shevchenko


