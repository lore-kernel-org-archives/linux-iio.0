Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6C18BBAE;
	Fri, 20 Feb 2026 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771573945; cv=none; b=XY/5FPUkAicIVvmSZySFuBAydwxlHKUa0FcsVoDT6sLw15DG3w+Z6cGp32JCvdf68/kgaHvAEr9bGccBv7167alxJSuwsqUtSyulNMtPA77AnMj4a1+UpIyGcKScONVxfoPDoiJGPB6lKENcnjs2/kBxWNAebGdK0qzZ8FBN6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771573945; c=relaxed/simple;
	bh=CTACKERyrLFo7FWUXuOxaDSKmh3CY0L4vT8iY/OmwbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSSmz1WoHvzjAuOorScQvKvNXhElmo4dm5rkNqfOUqvtN8kwNQc4QyM2ERYHzuQQDH3mGdXUh7cVTiUzYHsWUw1yDy8F2a0bF4Vafa0Oxzrx1IbdWMgHuKgaadBfgvpfmebEVe06/brOWjYLFvplkA86rSXL9XJkABnK7Iwd1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HddmBwse; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HddmBwse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771573944; x=1803109944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CTACKERyrLFo7FWUXuOxaDSKmh3CY0L4vT8iY/OmwbI=;
  b=HddmBwsewr5Y12XX/TfaVae+pcF9rbI1FUBRy7/Wg8PuGUxpYoagcL2O
   zdghp+bdjwNQdMJfQ2NJ8HGaUnEzVimJ4Lypy40Lx54HN3XgKoM80RKGr
   3Yu3WLHDFUFuyyg1bBdqldiU/lVHAytiu/T4TP6oSZYHZzOlFTHuMG/vC
   Qzx+wxPea6Zy7/dGghdlQ3sC3ynFHruaODU8OQh+Tn/aVwl2yveDrC5wH
   knipPqjZ5uJqZ+nE8+it/Nmq24rsyOqkAr9RH2tNduoOyAByI4yhF0KxM
   AT3/zA3SBeE7Wp+ef5TiGlv1zV0eR/UQI5gx23kc2oJUli+7/+6FvY3VD
   A==;
X-CSE-ConnectionGUID: EvWt24xtTvKZGhLh1LFMgg==
X-CSE-MsgGUID: 0nPFGhDlTN6BNWOTVWPJ6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76504182"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="76504182"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:52:24 -0800
X-CSE-ConnectionGUID: EbRr2662QLGVe9sRhX654g==
X-CSE-MsgGUID: CGTUPyrOR9SIfNit8Y6E6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="212930068"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:52:20 -0800
Date: Fri, 20 Feb 2026 09:52:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
	git@amd.com
Subject: Re: [PATCH 2/5] iio: adc: xilinx-xadc: Add setup_channels function
 pointer to ops structure
Message-ID: <aZgSseBpdOgoWgsG@smile.fi.intel.com>
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-3-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220053941.611415-3-sai.krishna.potthuri@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 11:09:38AM +0530, Sai Krishna Potthuri wrote:
> Add setup_channels function pointer to xadc_ops structure to enable

Add .setup_channels()...

...to struct xadc_ops to enable...

> different interfaces to have custom channel setup logic.

...

> +static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq);

This is a red flag. Why do we need a forward declaration? Bad architecture /
design of the function calls?

-- 
With Best Regards,
Andy Shevchenko


