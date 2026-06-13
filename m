Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2037283FE6;
	Sat, 13 Jun 2026 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781357967; cv=none; b=O3yXozmel5LVN3Naou/FKDboNvijcoHgBtCIngR6QC4pcNqPWlT7SYBq26TBymRdavhsJlNUzcFJgSDsadDCGH1C4Uv8jvsI6JjrTQNqd6qPoUI/nsQVZGEns/O1/bs/gPCwXUZQgImGDHRCZ8jqVm9Z1aCsITnS+00Ht8ixGj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781357967; c=relaxed/simple;
	bh=OI66FUDTDYvCeY10NqbQgLoYEhrOPd1Kya/AaT9RDHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsFVPs9hIrcUB9GBItSFTLEG2NMND4oGbPFlXhhpUfeo311XnAemhv4qLAOMzT845aVF5gJZPSqmlMv2XAGpj2/k76DN8Hw/NnHSJwbi1kJhy1KBVya+/9zgCkVqCUjQOHp8/WrgZM/jpDeeCARNu1XDGmCJ8zltaS6/xDFpwC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkq8667l; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkq8667l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781357963; x=1812893963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OI66FUDTDYvCeY10NqbQgLoYEhrOPd1Kya/AaT9RDHA=;
  b=fkq8667luX778UAbqQKqWsSvGH4r4Ul5KRS7nAt0L2KyzPDH7KrE/chR
   UTTHaR+sLP0HrCm/zYJYUjelF4ZDccYYLN2+drl+/iLDCVhNcKNkExZwB
   C3flYFydH1LndFpwSdQToGoTZ8UDC0SRyivTl7Fc40XXpjLYrGzfpJngu
   oTAt52+JfPe1wJXWxBVoUSb7tPYOXoc8PU9HUXQ3VOJ6EUx8UKyDaKhU4
   jaAMuW+7Qd7eVzKtUGzB/HE+dVQTZvs8MlnAk4NF/fXMs0ti+xoCZP93w
   Iwp5vDSQEQM7TtJ6tq2jcD2EY9JCeXPa2L+8XRTrU+yCMjErR/20ZUNWd
   g==;
X-CSE-ConnectionGUID: aMATMqr+Q365p09j8bhhiA==
X-CSE-MsgGUID: FFoLBR0FR1OVc+LVFertEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="93660872"
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="93660872"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 06:39:22 -0700
X-CSE-ConnectionGUID: DZu2Tr2UQe2k7vVP5XQbcw==
X-CSE-MsgGUID: uswYLJDqTHKcATAC74pTNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="277251883"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.184])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 06:39:19 -0700
Date: Sat, 13 Jun 2026 16:39:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: stm32-dfsdm: Treat flags as booleans
Message-ID: <ai1dhJWb9vKqxEEe@ashevche-desk.local>
References: <20260612215151.1886851-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612215151.1886851-1-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 12, 2026 at 04:51:50PM -0500, Rob Herring (Arm) wrote:
> The "st,adc-alt-channel" and "st,filter0-sync" properties are
> documented as boolean flags. The legacy parser read them as integer
> cells, unlike the child-node parser which already checks only for
> presence.
> 
> Use presence and boolean helpers so both parsers follow the binding and
> the property type checker no longer reports the flags.

For the patch
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

However one interesting remark below.

...

> -	ret = of_property_read_u32_index(indio_dev->dev.of_node,
> -					 "st,adc-alt-channel", chan_idx,
> -					 &df_ch->alt_si);

> +	df_ch->alt_si = of_property_present(indio_dev->dev.of_node,

I believe it still has another (serious?) issue. We usually don't use indio_dev
for device properties. It's not a device that is described in DT.
It seems the only driver in IIO that does that. Note, I haven't conducted any
deeper research, it might be (however I'm quite in doubt) that this is correct
use and one device registers a few indio_dev:s.

> +					    "st,adc-alt-channel");

-- 
With Best Regards,
Andy Shevchenko


