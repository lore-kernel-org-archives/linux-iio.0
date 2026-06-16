Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D1425CEE;
	Tue, 16 Jun 2026 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605771; cv=none; b=igwNhG+NNkd+G5W1xPeug2mDJ0qvua0Aw4M8jjNPKsyvr/t7Jn9tgLpaXLJzFOQfLC1X7y3t31qMF02iJ6JlL36MyQx9vHNOzpm1EAYYej5R6XTFR4nnMKOoJu413B/gTf/iuyYTZjqYkXyUYQyaZxymm6OCzGB9xKQHLdyLsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605771; c=relaxed/simple;
	bh=ia2P2OC7AAQYxqoOSkKtV7D7+hDtxPaa3ogxt3k4Cw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdFlQf2j8eDshOH3HVUQ2LWzlCEAvdq7FSaina05kBeQTC9DExxGZOCgZkMJpi2o6/iyzigcxUHYVVeddYOw/rVs1+hwDo+cWiTbCxo/Swg0MSSmIZznErHaSYlUSMi+In8aZQ30NyyV9lx/dHaaVGxiGoCSqrVn7Gls5oV2MVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwEKyzpr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwEKyzpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781605770; x=1813141770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ia2P2OC7AAQYxqoOSkKtV7D7+hDtxPaa3ogxt3k4Cw0=;
  b=AwEKyzprUkjnTmqNRD2bfQ1eaitR3NgmrL+voj/BCMlHbrTO0lIKTQzp
   AkJSupO7g2m59pi4QRKRb3/4/drBWZdkN2J5LnDvQI60uUTW878zloX11
   VuboZJQqDKQI2T2dk85MMGmtrrFPWbWRBk1rYOnITQFJRZ6tDchps27uF
   0CwWckbq6Urgy1YmVpAigB4k/REXvxq05kqoIZ0A0JA+RAMwhrDrjYBvO
   tggxOA5DSkzUn/kVnTHluJ+ENre6YApe0NofMEhLxl6w5RbMZpIBLWop4
   SyfyjJo7GezlStjUzG9xNcDYFOMvEXjCwwDqqubV3JcvwGEcyvAb2t5Lk
   w==;
X-CSE-ConnectionGUID: aP77m4PNTTS99UaZ6+llMA==
X-CSE-MsgGUID: QEUxiVB5THmNgpsOESBURQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93748019"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="93748019"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:29:29 -0700
X-CSE-ConnectionGUID: DNuA6ZG3R6GJzvcMdgVfGQ==
X-CSE-MsgGUID: cbyy/BpcS/ubSimPBa6nCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247798375"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:29:25 -0700
Date: Tue, 16 Jun 2026 13:29:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	rodrigo.alencar@analog.com,
	Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 05/12] iio: dac: ad5686: add support for missing power
 supplies
Message-ID: <ajElghg9rnqm5ukt@ashevche-desk.local>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-5-f829fb7e9262@analog.com>
 <20260616113322.00005273@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616113322.00005273@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 11:33:22AM +0200, Joshua Crofts wrote:
> On Tue, 16 Jun 2026 09:21:11 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

...

> >  	st->use_internal_vref = ret == -ENODEV;
> >  	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;

> I'd use a macro from <linux/units.h> instead of just doing / 1000.

In this case we use (MICRO / MILLI) as we don't have (yet?) the
MILLIVOLTS_PER_VOLT and so on. Feeling like you want to add those?

...

> > +	fsleep(5); /* power-up time */
> 
> I'd recommend using a macro to define the sleep time, removing
> the need for a comment.

OTOH macro might hide the actual value. The comment is fine, but I would extend
it with a reference to a data sheet page, table, section, et cetera.

-- 
With Best Regards,
Andy Shevchenko


