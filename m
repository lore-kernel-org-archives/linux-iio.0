Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701597;
	b=DFxtKK2eu/i/3q68A8m51SoJcWh0JaxZ3A1vTAdaPTrAVHzanvPeOo/QEOJurMbk7t5S
	 QFVIkYCy6+BeBT2xl8QRqi8oF/54jO9QJOUTxlANvJ6QP8T0tTJZRpdRpnoXNebT6jPTf
	 uM/WbFpk339eNSS/eoQIfl5TyDZ8zexonUMf9vU11IF+1iH8T08WZZv8KEANGecvwEnEj
	 AfL14v1gxhO2bhqarVN8EN7HywQfLTCg9fJAWbZIQJcbehavcsdKChurSoZRkcpRb1sT/
	 OCL24qxi9suUJLFb8OXUj0h/FufSI0ivVLl1MBW8MzVxKNY7ds5qk7PumFdJ6/hxCIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701597;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=5x9Rr11HrEdahap39TQfO8SwszqIjV/38s8cyXHT6vA=;
	b=sw70SZ1ab4c/xfAYU1VUFNrWh6/tzBkNRWBEAF9dPbGxth/zT0D90VsxrSyAWOhfZAhn
	 zKBop4jKLI127CAZrbKYnkDuEC9kC6slzpA4SDbMO3U/zneRyHimotHmf1+mH59N9zFUG
	 1nvFUIP5rmUtVnpt71SXCNVmDPm2izMpA9ow15Kd8cE/t7GUkZNnAVD8h6xMd3JcfhMuL
	 ATdvcAyaPPUSlnE51cE5Z2UOoWsEMwmhCXrktTOMcqUW5mHlIwmoxRilkvp0VqARbK394
	 /vLs1EoOBC4SvDxunhK2HEt9NAcH6HrpFmaFcLj5OXexm0357Ohx1ieOGmaMklRg71Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W6A5mNJm;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02724608361E;
	Tue,  3 Nov 2026 10:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02724608361E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W6A5mNJm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793701597; x=1825237597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bDZlbjutl0CIXovVxFWrgtRRTllYWh3L1VKIu+Yky5E=;
  b=W6A5mNJmlYHlgneQl8KKu96VW7f2ZefFavWVrSEO3hSec5RMMj5UTYlB
   eTXKvXlgTJHZnPz6QzEflJsF3qCyy2ek7kNESrxomrA1ffWLOvSMftKuy
   Z/CIbwmp6j8zt+qkWVNdukpOceR9JtU/GCWD65yigsHpLrRj1FepgJGID
   ko2nHT60OppfaQW3DX5+YsKuyfXhTkqF76yN0jg1X/GW1qAK9OTsvHWUR
   B5Ar4IhGqSaXhwHlp0t4XW/5au48EGJOKeI4LQdt91wfmdOOjdeoKg4nV
   Pg8LKobV+MDjAROoQNLkcvmZM2PH8g48P5bXED5IKzZa14L8DsFg4CioR
   A==;
X-CSE-ConnectionGUID: Cwk3PyR8TZOxmM+nbxKXBA==
X-CSE-MsgGUID: OSSw0HrtTbK/dSDvqAmI0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2300019"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2300019"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:26:36 -0800
X-CSE-ConnectionGUID: PmdpG4SRSkqCLrH8eOOXTA==
X-CSE-MsgGUID: nsp7e0D/QtW5NyU2kB/Gtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6479190"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:26:32 -0800
Date: Tue, 3 Nov 2026 12:26:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: jic23@kernel.org, Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad7405: Add support for
 ADuM7801/7802/7811/7812
Message-ID: <aum21cmseqtOEs35@ashevche-desk.local>
References: <20261102121352.23741-1-pop.ioan-daniel@analog.com>
 <20261102121352.23741-3-pop.ioan-daniel@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102121352.23741-3-pop.ioan-daniel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 02:13:52PM +0200, Pop Ioan Daniel wrote:
> Add a chip information structure and a device tree match table entry
> for each of the ADuM7801, ADuM7802, ADuM7811 and ADuM7812. These parts
> are handled the same way as the existing ADuM770x devices and differ
> only in their full-scale input range: ±320 mV for the ADuM7801 and
> ADuM7811, and ±64 mV for the ADuM7802 and ADuM7812.
> 
> Also list the new parts in the Kconfig help text.

...

>  	depends on IIO_BACKEND
>  	help
>  	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
> -	  ADUM7702, ADUM7703 analog to digital converters (ADC).
> +	  ADUM7702, ADUM7703, ADUM7801, ADUM7802, ADUM7811, ADUM7812 analog
> +	  to digital converters (ADC).

This doesn't scale. See how the latest drivers reworked this to make it
flexible.

>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7405.

Also, do you need to change help text in tristate?

-- 
With Best Regards,
Andy Shevchenko


