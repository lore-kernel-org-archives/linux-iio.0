Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91B42FCB8;
	Mon, 10 Aug 2026 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391833; cv=none; b=sRywgDB8+g0bPk2Ni3hOxzVE18xgVT0thpbGC+szUwzPlVxguYfQqNHIca9wxZ7lqaUV0Ro62ihNOzx62aKynfmZD3mS5alN17KpHtchls8JNPPBZMNobYXsSF9r4xYsj464EKNpXdimZmT7Yaqmd13IzYktahM1aaRcbk1WpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391833; c=relaxed/simple;
	bh=Xl9xNNU9znyqMZcqgHnfjOO7ers+5q9eyWjieiSU3Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTw8jrNzCxyINTAQEZTxxf/LJPBkoHRipllqVQEtd41DgI32hvfYMLFnnRwsyk9MGddK6hrpyrmzmpKLoVrh/iNYDH1TcC9BgBxndSRK14XZVWJr5eHsLse3OW+5j4OqYJRH4fG78TEFXt6ZjpmyBiAYLwS4iTxT281G4yw8fKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARhxPCTz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARhxPCTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786391832; x=1817927832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xl9xNNU9znyqMZcqgHnfjOO7ers+5q9eyWjieiSU3Cg=;
  b=ARhxPCTz6/j9KGIakTwGy6VLtSZOLMOLx2RIgmXOpI9JyYF3ffHLi7fJ
   xJ8xd1dhW8YtjF8vCub205WAUL15VZgx8AYEqINr+omXviFKS+ImuXvHl
   tRPODLfTUHUEOqVrvwCuHba9WkPFWQLdoouoiamLC4r7S4v7c1xiySFP1
   zPJWPYHDtuRM/WyjrtwLvWk9eEPLuOvcvyKQVwJxcrwb8k66ChOtQC6TE
   rasytWacC+4NFC+COgENFJiaeYGJl4ycHCWej9pMIa1YNqhRSvpGH0kzl
   aCVJaHJs+clUyGNcsvJwDEwYbvlKijne+P3IIbh8agIxXexiEE8l2rnUg
   w==;
X-CSE-ConnectionGUID: F9I3Seu1RuCTkIKW0mVAcg==
X-CSE-MsgGUID: YPzm+5csRNq3CcnTpbIDoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="89443708"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="89443708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:57:11 -0700
X-CSE-ConnectionGUID: z2Tb7+NiTRW6mpiRvkuHQg==
X-CSE-MsgGUID: rBWht3/oSOaUedl0eEl/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="301355572"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:57:07 -0700
Date: Mon, 10 Aug 2026 22:57:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	Maslov Dmitry <maslovdmitry@seeed.cc>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>,
	Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] iio: light: ltr501: Add ltr329 driver support
Message-ID: <anotEG6n8AXLXcTg@ashevche-desk.local>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
 <20260810-liteon-ltr329-v4-6-8bd3dfd15280@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-liteon-ltr329-v4-6-8bd3dfd15280@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 09:11:16AM +0200, Esben Haabendal wrote:
> This adds support for the LTR-329ALS-01 chip, which is similar to
> LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
> have.

...

> static int ltr501_probe(struct i2c_client *client)

>  	if (client->irq > 0) {
> +		if (!ltr501_has_irq_support(data->chip_info)) {
> +			ret = dev_err_probe(&client->dev, -EINVAL,
> +					    "chip does not support irq\n");
> +			goto powerdown_on_error;
> +		}

Why making it fatal? Perhaps

	if (!ltr501_has_irq_support(data->chip_info) && client->irq > 0) {
		client->irq = 0;
		dev_warn(chip doesn't support IRQ);
	}


-- 
With Best Regards,
Andy Shevchenko


