Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602629;
	b=BPlbqAgGiiwr/TLcm4mZ6fRPC74P0gwVagubjh+mTRw0AV6Nn0gZXCAWlZwrE6Vkzuqb
	 gqAyArPoetqp7g5MgmAKkF0Wl3mbl9A7YNpi/5oI0SdY6K7BqbPfzfrDpe8Q0DShSd/R8
	 /UJjnF57uM+UV9bDof4+niskfpqSKNW0FUXx1MDU1IFmqVHVRYIlnGyjo3uHT0Ykd6xnf
	 CveACJ0BGBM59rO/WbLLFjKlwYkkrAfv8ZeOSPh8Ut4xOZy/Br+3jL3ILMth/X4gX8YBZ
	 GKWDOFEaGW9a/msw30Rf2aIdKGgOFlR2WNO/kxVh9jNvZNfBZVO1vbSfm3yPaB18RCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602629;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=13EWy1gq3cw9Pc+BxsLwH9JEP8KM4thNiGWvmWXU0/g=;
	b=KkSLCUegDzqzQYc1YJSshqz8besKFOIUIXeRJJ7KnGCLgA2Wrqkl9/UrpbxHu1fCUdSA
	 EYugBchkxXaEBvN8GzXruLS0/Z20D9ydMiWGCR27L4cC7kjclJLJRgihU2LmYD0gN+gM/
	 sde85TZvSfJCgvxnNonfNcdtcZw173Mfzqs4azty35lS3NX9Te/piag7rDcHNQRHSKN/Z
	 UncKx7xBI6os/oQdCFEeB3AytD+LSImkI2ffeH0I29n5TugAc2bL6v5tdFKusYv2IP+3W
	 jZtiZfBR7UDvKKKoZFK4eqvEV/iXh2fN0b1m5DhnQurwROs4qRLXC8f2XmPFMhWU5Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lmkHGQXD;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D5606A32E;
	Wed, 25 Nov 2026 10:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 375D5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lmkHGQXD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795602630; x=1827138630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=As7AKphILF2n3TF7M9sQSV93g0Ojj8ri92xWsKyZM50=;
  b=lmkHGQXDBg7AcLg3pIJ/GIu7rRt5z++W0GuxJn9ybMX1S58chxv2eSjy
   tf1ujpfc82T8M6O+qJUsuNQ0S2mQwjcn52YxHK6bVNUNCgaziyC5q1Fkl
   mK0OvtxkLfGKTCoZOOnpT5KyHdMvAVE6qoYCdfZ1U1LmHAvny3yai6wZz
   tTIiuS1Jv3LUF+XdmyHIZBhw20Avo+dCD9Id+N3hPiv1xbxan8c8wzo87
   23uZKpYJczu8pJQ9X2a5SpL+UGGc4PmteD4O3OTQe6rKaQFjKGg2ns4Z/
   oHbI70ZE5rSrx85xeGaIWvIJtcsU/jpsd0iNAMG/bQmTa2+aUuHZsKQFy
   Q==;
X-CSE-ConnectionGUID: FZ1lEkHuRAuEAQzBqoHzRw==
X-CSE-MsgGUID: DpbsqK8USQCU2i0k6Jch9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4352037"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4352037"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:30:26 -0800
X-CSE-ConnectionGUID: FPHHI0kUTZKX4Q/yNoVrWA==
X-CSE-MsgGUID: 2LSCDKVZQp+V30aVCv/Hog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11813497"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:30:23 -0800
Date: Wed, 25 Nov 2026 12:30:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: pressure: dps310: sort register field defines
 low to high
Message-ID: <awa4vTlfPs640DPh@ashevche-desk.local>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
 <20261123220649.36887-2-zoone.rupert@gmail.com>
 <awVHFUVYPE6W4izB@ashevche-desk.local>
 <20261125075036.37378-1-zoone.rupert@gmail.com>
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
In-Reply-To: <20261125075036.37378-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 09:50:36AM +0200, Rupesh Majhi wrote:
> On Tue, Nov 24, 2026 at 10:13:09AM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 24, 2026 at 12:06:43AM +0200, Rupesh Majhi wrote:
> > > Some field defines run from the high bit down, others from the low bit
> > > up. Sort them all low to high.
> >
> > Have you checked which change is less invasive? Can you do it locally and
> > provide diffstat
> 
> High to low is less:
> 
>  drivers/iio/pressure/dps310.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> Went low to high as David asked for that, but datasheet lists
> the bits from 7 down, so I will sort high to low in v2.

Okay, this argument is even better! Thanks for checking and confirming this.

-- 
With Best Regards,
Andy Shevchenko


