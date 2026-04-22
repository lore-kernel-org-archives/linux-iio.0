Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624E337688
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840525; cv=none; b=pbdpaJxuJO3WM3/EVgM2LycE64si0juh7XbxV95BVPQRqOz6v6meJsc2j/Bvdh7wCCP4IbrGo6IJPmAk0KJLuMqRkKxlWU4zUKbjFTTgbgDSH17FgeCRofoKBgcHTiPXVEJTOdkVZntzMA/Vl5h0P72lPV3g2prgHknkp5M4oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840525; c=relaxed/simple;
	bh=hUL8YD6Zo7JFB7SIqxxUq2PQ6VeXXN38la0Y7MoI+j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM7VCK0RGjXrza9dju0FRdwrU3eCSnTIuWQLqywdSE1D4KiRMFg0B7VuxnwArDBBC+zVZ0bFooehlaDXMPgOZmL0uvnCfCcaVBHvnfqmRIBag9LPddzCmXfzIStJaZ3p+vqLxxZUVK3xMK/wPYNlc25ft/ZTA0MXgkaGiSkZpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftHL713w; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftHL713w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776840524; x=1808376524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hUL8YD6Zo7JFB7SIqxxUq2PQ6VeXXN38la0Y7MoI+j4=;
  b=ftHL713wOgHYM6SQa1fttcFy2KqwQRu5F3EGUJUnXsN0QQr10q9tojbs
   oBtH8UXLCozNeHdTp/z/LB/a+2dntqTBS9q6B5s4u474nKJJ9aSmIjehr
   Sm7oIoG8kb7xEyJkAG/CYaCHjKb3eqYfPVxIf/KzsosjSLJOG+a7KC9Wh
   MNkF5T24GueQz01Wg80i5Nh5qbolx2Js1Sw5Lldfx3sHtwse44hIgQ2me
   JnfvQRMBnnwvf3HiedUdkXps2q7j742TwikQ7i53aJ6S3n21MfSMi926p
   Gwl1lHubHSocU4OkNU71/T3+vEwk56YtiEO/MV02DanVGfvbQw8gBQUyA
   Q==;
X-CSE-ConnectionGUID: GlOSIemqTo2oi+7BlVJTig==
X-CSE-MsgGUID: Hhw26R9XSxWhq8WJsK57PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="80374806"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="80374806"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:48:44 -0700
X-CSE-ConnectionGUID: TV93Md6kR32A+0VI85qcAg==
X-CSE-MsgGUID: rEOhreduSfOqoJvUlhFhNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236271775"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:48:42 -0700
Date: Wed, 22 Apr 2026 09:48:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp320x: refactor driver to use bitfield API
Message-ID: <aehvR16BdHsSx9Gf@ashevche-desk.local>
References: <20260420215021.14112-1-gustavo.pagnotta@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420215021.14112-1-gustavo.pagnotta@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 06:49:18PM -0300, Gustavo Pagnotta Faria wrote:
> Update the mcp320x driver to use the standard Linux bitfield
> API (<linux/bitfield.h>) instead of manual bitwise shifts and masks.
> 
> This replaces the hardcoded shift operations in the TX data
> preparation (mcp320x_channel_to_tx_data) with FIELD_PREP()
> and replaces the manual masking in the RX data extraction
> (mcp320x_adc_conversion) with FIELD_GET(). Explicit masks
> using GENMASK() and BIT() were also introduced for both transmit
> configurations and receive extractions.

...

>  #include <linux/mod_devicetable.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>

Add a patch to sort headers first, it will help maintenance in a long term.

...

>  	switch (device_index) {
>  	case mcp3002:
>  	case mcp3202:
> -		return ((start_bit << 4) | (!differential << 3) |
> -							(channel << 2));
> +		return FIELD_PREP(MCP3X02_START_BIT, 1) |
> +		       FIELD_PREP(MCP3X02_SGL_DIFF, !differential) |

!differential is boolean, you want integer, while the code generation will be
the same, I prefer to see that explicitly, id est

	differential ? 0 : 1

Ditto for other similar cases.

> +		       FIELD_PREP(MCP3X02_CH_MASK, channel);
>  	case mcp3004:
>  	case mcp3204:
>  	case mcp3008:
>  	case mcp3208:
> -		return ((start_bit << 6) | (!differential << 5) |
> -							(channel << 2));
> +		return FIELD_PREP(MCP3X04_08_START_BIT, 1) |
> +		       FIELD_PREP(MCP3X04_08_SGL_DIFF, !differential) |
> +		       FIELD_PREP(MCP3X04_08_CH_MASK, channel);
>  	default:
>  		return -EINVAL;
>  	}

...

> +	u16 raw16 = be16_to_cpup((__be16 *)adc->rx_buf);

First of all, we don't allow free variable definitions (only few exceptions,
and this is none of them). Second, the casting doesn't sound right. You
probably wanted get_unaligned_be16() instead.

...

> +		raw = FIELD_GET(MCP355X_DATA_MASK, raw);

Besides wrong placement (please, leave it before if and after comment), this is
bad code for reading and understanding. Use another temporary variable for the
purpose or refactor to avoid foo = bar(foo); cases.

>  		/*
>  		 * If the input is within -vref and vref, bit 21 is the sign.
>  		 * Up to 12% overrange or underrange are allowed, in which case
>  		 * bit 23 is the sign and bit 0 to 21 is the value.
>  		 */
> -		raw >>= 8;
> -		if (raw & BIT(22) && raw & BIT(23))
> +		if ((raw & MCP355X_OVR) && (raw & MCP355X_SGN))
>  			return -EIO; /* cannot have overrange AND underrange */
> -		else if (raw & BIT(22))
> -			raw &= ~BIT(22); /* overrange */
> -		else if (raw & BIT(23) || raw & BIT(21))
> +		else if (raw & MCP355X_OVR)
> +			raw &= MCP355X_OVR; /* overrange */
> +		else if ((raw & MCP355X_SGN) || (raw & BIT(21)))
>  			raw |= GENMASK(31, 22); /* underrange or negative */

-- 
With Best Regards,
Andy Shevchenko


