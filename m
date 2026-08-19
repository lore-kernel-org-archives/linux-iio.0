Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A3345CA8;
	Wed, 19 Aug 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147780; cv=none; b=Z8+elIj0fGU9b3tvOSB330wICdXS/BoD5Ui44B70ZzH3JyBV8AS2MMcc7/camrL3ikJ/S2LjhwHq0G2JDFySLnXmT4KTRoz/cXOV466wVJ8wq9r6cW7IZlY3RHH2u9SrCvMZNfRQzuOSeJXoqPlACEEDeApTNJ5xL7hg+Y3X8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147780; c=relaxed/simple;
	bh=CdFPMdEUtBafCWSNlCxZgg3cgLT9VI+uW20xwVR/JAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT2LxyQmEk2CPS/bWQCf3WDb6h/JhHZfYhD9iYUJZBG2+2+ufEkv/22K73xc5OSlX3sEDh0De+wFKFVtwlx1gEdj4W/ea412C5oXL9YcKjBYCJvJFfCHniD27IGB2L82WppGepSdMuRIpTMNK0mbTpykmMHleRunYEf4RX8peXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhAs1K3n; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhAs1K3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787147778; x=1818683778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CdFPMdEUtBafCWSNlCxZgg3cgLT9VI+uW20xwVR/JAQ=;
  b=OhAs1K3n2lSXYqfQwwwRcyoEZUsUwp0BMnpCaxwq5bJcbkcgsKZK0CSp
   LC9stg8GExc3BAJZ5EdUjF6PcrritiGzSXr9k3U1mfhlWPiaMjx8Sh1tG
   BZRq2aVPhSASq+Ju0i7m064C7h+0pbP4nsVX7sKyWj7rakyfzn8Ezx0f5
   giQdRypQxrUXNZ/4TsPCyrhBlyIeFwx/IlIFrsDpxywtXxeUVgtdldG8m
   D6c6oJitI8jiYyBlQn/MRG43zoG25F4qfu271wSGtUXCqayU3E7o3QiYM
   RH0x7KijZZOyU7vLrXTAtpcJEGPQIQjt2Yjkz5P/j3paEH8xiwON7ZIfO
   Q==;
X-CSE-ConnectionGUID: O2KHbrIVR0WP+e3ZjGJFiw==
X-CSE-MsgGUID: y+UTB+4xQK+Wi+krBllbFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98823296"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98823296"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:56:16 -0700
X-CSE-ConnectionGUID: a+bRP0P8SSaBoMfA4Gsd2g==
X-CSE-MsgGUID: 5qsL6sLCTYGTZGOnYz5Xzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264237821"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:56:12 -0700
Date: Wed, 19 Aug 2026 16:56:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 6/6] iio: accel: mma8452: Reuse existing dev
 pointer in mma8452_probe()
Message-ID: <aoW1-UgGuG_9Z4Fh@ashevche-desk.local>
References: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
 <20260819-mma8452-open-drain-v5-6-d8aa590d7c36@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-mma8452-open-drain-v5-6-d8aa590d7c36@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 10:15:33AM +0200, Esben Haabendal wrote:
> In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
> struct device * pointer was assigned to local variable dev, so we can just
> as well reuse that throughout the function for sligthly more readable code.

...

>  	data->chip_info = i2c_get_match_data(client);
>  	if (!data->chip_info)
> -		return dev_err_probe(&client->dev, -ENODEV,
> -				     "unknown device model\n");
> +		return dev_err_probe(dev, -ENODEV, "unknown device model\n");

I would also move to -ENODATA. This can be done in a separate patch with might
be unified with the 'dev' use.

-- 
With Best Regards,
Andy Shevchenko


