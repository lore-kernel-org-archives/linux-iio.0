Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97AB3C1F5B;
	Thu, 10 Sep 2026 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020772; cv=none; b=LJaoNs+yfc9k+Y8fCs40mBOSiLQHRK2Dx7GmIe3hEkKC4fLmUVxtH1f+8O069eymnEsY+3GJyMfy7y108QPj32TCFLwpKs+FdvjGxgAkB30KMCZ4wllF/cU9xsmpuB3MSTwKknj4FG97u8lJ1mV1QGamGc5JnNi8um4+j22MiE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020772; c=relaxed/simple;
	bh=KobOE/h8JrfDHgAwD+CS5A6vwB7noAIfgQFcvdDu6JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8nAb7nqTnFicoCxyiqrc+2NBXEb8F4RNH33s+eXkcHfpnDwrYkRcX2LSVekBEb/3HuKs8WO6gf8ikMmeSF3EwSgZAq7kaXVfy7Wa8FuWEE8Z0X1sxmHIRdqbsWljhoplrbM9ZP+bF8hBTFnCXM9eDamwIAKH4xA1vkEZCQuDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqEMEu63; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqEMEu63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789020756; x=1820556756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KobOE/h8JrfDHgAwD+CS5A6vwB7noAIfgQFcvdDu6JA=;
  b=SqEMEu63LUp6l+yaiXHcjefO3JsVdV2pMAEKT2fIyZHgC18JkB2IFTdF
   NJ3FEAQL3dayompJ4rclPuZR36RIZ3TdUph4qV3qQ6l8qDakseIRYOf1H
   UJRNGFIVBhAl1ROva7JvrqQVmeFXHWHTaEtbmzGnr6C9CITQ3BaWzs0lN
   ITYFwbQrLIm4aYJwSQrVOsq0yT0FMZFTp0Dxakv9oyUSZemxcQ3giiwcu
   T6YhmZmxCAT96Q8yzmOFQ3teQqCx6gZbyCRRphLFDAhNqluMpbsy7VXpo
   VM3rOtUuQO1ANyQ+88gBRd454Lu0bvSgARB7Qz0x0GQ4C97VVdZxI0tbt
   g==;
X-CSE-ConnectionGUID: iCe8fzzkQBKVx5RfEPysow==
X-CSE-MsgGUID: hrxdBnLiRZKKz6OwowsL3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89224761"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="89224761"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:12:32 -0700
X-CSE-ConnectionGUID: RJoLa3dgSPiHts8DSjba/g==
X-CSE-MsgGUID: 78+5gUQdTOuNqszUdDNe5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="301435425"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:12:29 -0700
Date: Thu, 10 Sep 2026 09:12:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 05/10] iio: dac: mcp47feb02: Avoid unjustified probe
 failure on missing label
Message-ID: <aqJKSjET9wLNeHDm@ashevche-desk.local>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
 <20260909-mcp47feb02_refactor-v5-5-8b67bcab93d1@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-mcp47feb02_refactor-v5-5-8b67bcab93d1@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 05:18:48PM +0300, Ariana Lazar wrote:
> Fix unjustified probe failure on missing optional 'label' property by
> replacing dev_err_probe() with dev_err(). Correct %pfw usage by passing the
> child fwnode handle directly in the error message.

...

>  		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
>  		if (ret)
> -			return dev_err_probe(dev, ret, "%pfw: invalid label\n",
> -					     fwnode_get_name(child));
> +			dev_err(dev, "%pfw: invalid label\n", child);

Why not leaving dev_err_probe()? And why error in such a case? Perhaps you want
dev_warn_probe()?

-- 
With Best Regards,
Andy Shevchenko


