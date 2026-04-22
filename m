Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B93C1410
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849207; cv=none; b=Vpb1BL0CbKgQ3L3v70hLgrRdHFmDYEYFSfCtd2fpym93LhHIzhQ6ucuM/4djRXwNReZ2Jp6Aw/BmJ/SR4QRLv5WyFnHYwYF9MiTbAOO4O8deWeTOs2V9jSX7YD5TAvBsNQOPY/6Smgoeeb/pLWrkQcEe+TCQH6jOWhVP2zKuqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849207; c=relaxed/simple;
	bh=H8EgEevnruvj2RLFIyZUp7dFmXpdC9HG1vs8SRzqGw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTg4cwvemAfvcVVb8pAY2pnWQzY9Aytss+fwLVVgRYqJgo2gFuTRRkFhUFyfFtdFZRzrAtgX2GiSxaGKiGq2Mzg8gPCubFOxEEkPgWFnzXtzm3jYeIcfWic59E1u4MeA2spxiMNodui6yWEqQGHv3NwMOGaI7xG5i02f2qk7olg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky9cyGic; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky9cyGic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776849206; x=1808385206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H8EgEevnruvj2RLFIyZUp7dFmXpdC9HG1vs8SRzqGw8=;
  b=ky9cyGicfBTc342Ll2GWV/LCVKX3QpLSrJw7Pc2zzZq6MvXwH0E2Bvte
   30jqEHh3JjQigoVZ6kMIvnJgpwWVTbM+lvZiQZzsPxL321D3fNSHEGIde
   WrQL3wC0N+f0J/r81kZ0clY8ZfuZzp/KtpGgAaAhEK7jxby1R6Sab43Ks
   s8U45INsIWdR/1ln6p4kozbV6OKnk649NjEkraWnpZ8gSpDpic4Yor/6W
   MsHl9AQU9A/E1vPEhtOxKGeQoWE1gSOwTaezSBRzaqyhvaR3G8y5B9M/u
   SvYnZQDv2qszTNdtRaueZpouD3EmWb1y0fec66RTKG76qXytvS6bEepxZ
   g==;
X-CSE-ConnectionGUID: HyZKxwsXToiX8cNN7vdCzw==
X-CSE-MsgGUID: o31nBJTHS32az6Xh0TrxIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="80384353"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="80384353"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:13:26 -0700
X-CSE-ConnectionGUID: U0tOqYuER3CiGWQzVhF2xA==
X-CSE-MsgGUID: MFtU8Bf6SDqC07Y/tzEvKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="237343549"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:13:24 -0700
Date: Wed, 22 Apr 2026 12:13:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: mcp320x: refactor driver to use bitfield API
Message-ID: <aeiRMWNgCbJ-NYN6@ashevche-desk.local>
References: <20260422030846.45317-1-gustavo.pagnotta@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422030846.45317-1-gustavo.pagnotta@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 11:56:54PM -0300, Gustavo Pagnotta Faria wrote:
> Update the mcp320x driver to use the standard Linux
> bitfield API (<linux/bitfield.h>) instead of manual
> bitwise shifts and masks.
> 
> This replaces the hardcoded shift operations in the TX
> data preparation (mcp320x_channel_to_tx_data) with FIELD_PREP()
> and replaces the manual masking in the RX data extraction
> (mcp320x_adc_conversion) with FIELD_GET(). Explicit masks using
> GENMASK() and BIT() were also introduced for both transmit
> configurations and receive extractions.

...

>  #include <linux/mod_devicetable.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/unaligned.h>

This should be ordered. Ideally add a preparatory patch that sorts the list of
the inclusions and then this patch puts new ones directly into the correct
places.

...

> +/* * MCP3550 Data and Status bits
> + * See mcp320x_adc_conversion() for details on when these are used.
> + */

/*
 * This is wrong style of multi-line comment in
 * use. You can refer to this comment as an example.
 */

...

> +		       FIELD_PREP(MCP3002_SGL_DIFF, !differential) |

Please, use ternary instead. I already explained why.
Ditto for other similar cases below.

...

> +		*val = sign_extend32(FIELD_GET(MCP3301_DATA_MASK, get_unaligned_be16(adc->rx_buf)), 12);

It's even longer than relaxed (100) limit!
Either wrap, or use temporary variables with meaningful names.

...

> +		raw = FIELD_GET(MCP3550_DATA_MASK, raw);

I already commented on this.

-- 
With Best Regards,
Andy Shevchenko


