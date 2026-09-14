Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359563F327D;
	Mon, 14 Sep 2026 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374115; cv=none; b=B0g+LovV0BG2ClEL8yPs3UBjDXMx4h3+sGRkl64y9e2wZqkU9drQ6Tg0X58TeQEcHCpb1dH37tJqWQlmiDki5eyJPhB2EkubLlOkfGDSa1/yjsXTFEU7QDyznuxc8Jo3mHaoPkF+n9sgLEkf64CSZWZQBeSmuKK/8D2iVLeJRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374115; c=relaxed/simple;
	bh=h0ZDlCIpMnn4plv/EFe5DgntsyKiPCy62D+ewDEunGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku0tePxuQCN33lIu764kwn3MrxQ34omZImUCior+DxSoT0zbfUIRx/+caCz1ZqSXjaB+AVwdvit/PkFTXFKzG2x4NUW9uSePyrAo4Kn9Go8r4OFHE103SZuLE7MLMLJSRODgsL7Y6SJAHATt3sx6WkH6ESA0grrLys3WzDdf0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoTRunH5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoTRunH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789374114; x=1820910114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h0ZDlCIpMnn4plv/EFe5DgntsyKiPCy62D+ewDEunGI=;
  b=GoTRunH5b7c15sZI625TBu+zKDzRFgZqY0dQWt2CKFEaVvMbMR5c+hzk
   w4+UEYczUiCWaDbzp+fSuhremDk5kzExxjIgfiigcoL6XmsC4y3Eu2k9A
   XIZ0RfdwL85Qe1IOTbBq0Rhrcn2cwa2wxAX7YPBOPZAEqdVYzqobfD8nO
   RQp6jo16eIDFziobK3qEUlps8jM0wDXCWkXQRDmvTpsAVpUVTdvMyYXed
   ZkOMToJLXqqA2B8DjV5JzaPbgBat2Cal4nC+jd6+5Uc8mR9PTzcUe1c3d
   CCYx15EG+wf3vwtt6MD30JZhtQY9axdymUkYfa3kafSBdNZZH4vgawLld
   Q==;
X-CSE-ConnectionGUID: vrtIdsMfQf+yXDjONfPHsQ==
X-CSE-MsgGUID: c7ztubwoQialkALNeeuPxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="107096466"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="107096466"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:21:53 -0700
X-CSE-ConnectionGUID: CS5J1K11TlOhsEkDhiRgYA==
X-CSE-MsgGUID: OE3KkhNuQJKXw3zNuDo7pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276097317"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:21:50 -0700
Date: Mon, 14 Sep 2026 11:21:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: accel: adis16201: add ADIS16203 support
Message-ID: <aqeum_w6AnMnuDsI@ashevche-desk.local>
References: <20260913085307.13846-1-shehryar.amd@gmail.com>
 <20260913085307.13846-5-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913085307.13846-5-shehryar.amd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 13, 2026 at 01:53:05PM +0500, Shehryar Ahmad wrote:
> Add ADIS16203 from staging to mainline ADIS16201. ADIS16203 shares same
> SPI protocol and register addresses. Differing parameters are handled by
> adis16201_chip_info structure.
> 
> ADIS16203 specific support includes DIAG_STAT_SELFTEST_FAIL_BIT, which
> is supported only on ADIS16203, and a separate channel array.
> 
> Kconfig is updated accordingly.

...

>  #define ADIS16201_DIAG_STAT_REG				0x3C
>  #define  ADIS16201_DIAG_STAT_ALARM2			BIT(9)
>  #define  ADIS16201_DIAG_STAT_ALARM1			BIT(8)
> +#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT		5	/* ADIS16203 only */

Two issues with this:
- indentation
- useless comment (we may kinda deduct this from the prefix)

>  #define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT		3
>  #define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT		2

...

>  static const struct of_device_id adis16201_of_match[] = {
>  	{ .compatible = "adi,adis16201", .data = &adis16201_chip_data },
> +	{ .compatible = "adi,adis16203", .data = &adis16203_chip_data },
>  	{ },

We want to have the common style for the terminator entries. Perhaps you need
an additional patch to fix that.

>  };
>  

(this blank line included).

...

>  static const struct spi_device_id adis16201_ids[] = {
>  	{ .name = "adis16201", .driver_data = (kernel_ulong_t)&adis16201_chip_data },
> +	{ .name = "adis16203", .driver_data = (kernel_ulong_t)&adis16203_chip_data },
>  	{ },
>  };
>  

Same as per above.

>  module_spi_driver(adis16201_driver);

-- 
With Best Regards,
Andy Shevchenko


