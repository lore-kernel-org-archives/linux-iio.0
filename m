Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB67576ECE;
	Wed,  9 Sep 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962842; cv=none; b=emIhfQ/I3BZv2Y7dvJP4HtTj0Mr8Sw9QlLtEuFYfOQQZDL15ZRcemXlxu9uSMJETILAE2l5mp0JcwHx1eFi1AY7LpswuU93P04cNOyqvMcYhfhReHjlniGXH2eGFpjcXt8Mpg/cbQY7Dh5ArCxZL4SP+QuCR3x450D6XamWcN8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962842; c=relaxed/simple;
	bh=AQPgm2QxMs1hFaWFMUU61qzfY+A67QhNoK8BC3+jiV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUIGgKgZeHRJ8TPfEObGg6HQJlVWN6T/kWsIMSQgyuF7r35UYOEIqo9lVt3j4D4EYfSLUpeS3DSxAQJ24laBwkK+q+o/JU1GRFvsFaBXMwbEnMR7ZT8R9HhW2fHlWTEgkDtPFoU3jRImPelr5HEDrzvrFRAqrceXYJu7Cpt9BBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kn21C2Vq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kn21C2Vq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788962842; x=1820498842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AQPgm2QxMs1hFaWFMUU61qzfY+A67QhNoK8BC3+jiV8=;
  b=kn21C2VqRAQLs7VUY4/noi+PENIm5yE4xAj3VKBwJ0qrwxmUCspzBm3o
   LBGek1V4C59Z+oOU0r+1ZxUkRqjx+yBWpzD86BdrejmySl2jmPH7fWLks
   nSI/xblyKvAULt4ZEoUoRehHdsSL/jnF/k0fhsY7YslaG62a26YYsE/e9
   FxXeb3OOvWHmTV9nPA7RAW4mazSdn8QlDLViuy2B+Yg4U/TseK89g/pfV
   /EFRpTeRLdvMt1gUFWD/kD4Br8tZ18Z84fJBw2e9fb8z+d9LP7zTV8Q78
   /Jzv5SuioxZCoO3K/U0C3MJgSAg4aF/5gCovF1mrGT+OzXc7KZCe+d0pa
   g==;
X-CSE-ConnectionGUID: DRSK07NpRFGSUjsMibRosw==
X-CSE-MsgGUID: yU9zs5gWSZSmGh86Mwm5gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89430183"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89430183"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:07:21 -0700
X-CSE-ConnectionGUID: A6e8MZxvRoevvJTaKRKoQQ==
X-CSE-MsgGUID: keznCyZvQ7uovz6mSSyhiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="275463640"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:07:19 -0700
Date: Wed, 9 Sep 2026 17:07:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads1015: Add support for label
Message-ID: <aqFoE_GKp_hd26eF@ashevche-desk.local>
References: <20260908192036.8503-1-flaviu.nistor@gmail.com>
 <20260908192036.8503-3-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908192036.8503-3-flaviu.nistor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 08, 2026 at 10:20:36PM +0300, Flaviu Nistor wrote:
> Add support for label sysfs attribute similar to other ADC devices. This is
> particularly useful because the label can match the schematic signal name,
> identifying channel voltages easier if label is defined via device tree.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


