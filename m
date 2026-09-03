Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B73CB90A;
	Thu,  3 Sep 2026 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416575; cv=none; b=Gv9KvAbGT4re06B7OJUio52DCv+b5dopCVd/762rMEhqsTe9fs2nZ82DAwDRG/j/ACgjvVIKzvEnOuoAqUnUZBut2rk8EuFvoNUlz+uEPntDWIPWhsVWOwExupnKo3VxuQ1m94gTiggDGa3SCsPQ97QdBibRFvkpkggJx+YViys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416575; c=relaxed/simple;
	bh=59ix3QFGUTTfXXlWlM5VJlIV0wiWTBUYF1LiPPudgzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTym2u/potme2U1B2I1+qSZ/4kz8WIk+scfCwZxRGwS+J1WKpxIvu2KTbYSu3KCmabI/+VmM3kL1c/LfamPM6MMkf8ECzhxAdPvxT8Yh/w4HEBWDjPSHZx43vV4lF0ulQieymZXr/LomANU/MVm7aGdadFDaUrK/4Yfxj5Iow68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bjqg89bo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bjqg89bo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788416573; x=1819952573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=59ix3QFGUTTfXXlWlM5VJlIV0wiWTBUYF1LiPPudgzY=;
  b=Bjqg89boBCtZ9A9sJ6XRVeZJDzNv67fNTyVLWc+pH6CMoF6TVwpNdomP
   yjowozkFDqSxjeaPwl4HbeNJu0C0n3NdWNIJDM8MWQWWrWAG0mX92mNZh
   qa0XoJ4JaF7fst4dYzX47t3OmZpluD5A2g8B8tS+kp3zAFIrhyS2FUuY+
   4jwfsmOFJj3yvmRMYVqlOP8LhBw9dnuI/OSHuRCivx0A5hoV8Nw9WT27L
   rfB/D2OSD3+A3rjxwx9xJJH0kiK1ZDXn3Z+T06CkHkHM6JFIqzggl75Co
   RMj0nFe2zdqIqwJVWnHDibLbP2vs1rd7Bgazbyz/G+nyeKIww/CYP6+9F
   Q==;
X-CSE-ConnectionGUID: UCytBYRyRIaXpAnwXuC+yQ==
X-CSE-MsgGUID: PaVm4p2pQXyRo/JNIwMMkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106406701"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="106406701"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:22:52 -0700
X-CSE-ConnectionGUID: eGdfNlSlSyOqx6QlxLqQ/g==
X-CSE-MsgGUID: Z5FyE2Z9Syq2BVJ9LIhTwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="263450736"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:22:49 -0700
Date: Thu, 3 Sep 2026 09:22:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 01/13] iio: Fix typo in vendor name
Message-ID: <apkSNlQuQkjdNKvx@ashevche-desk.local>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <e508718734a06f005704051b8bc3d3d7a1a3b48d.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e508718734a06f005704051b8bc3d3d7a1a3b48d.1788368334.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 02:21:34PM -0300, Marcelo Schmitt wrote:

> ---
> Now
> find drivers/iio/ -type f | xargs grep -i "Analog Device "
> finds no leftover occurrence of such typo.
> 
> Also,
> grep -nrIi drivers/iio/ -e "Analog Device" | wc -l
> and
> grep -nrIi drivers/iio/ -e "Analog Devices" | wc -l
> both count the same number of lines.

Why not `git grep ...`?

...

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

But you also want to fix possessive suffix usage

$ git grep -n 'Analog Device[^s]'

Documentation/iio/ade9000.rst:7:This driver supports Analog Device's ADE9000 and ADE9078 energy measurement
Documentation/iio/adis16475.rst:7:This driver supports Analog Device's IMUs on SPI bus.
Documentation/iio/adis16480.rst:7:This driver supports Analog Device's IMUs on SPI bus.
Documentation/iio/adis16550.rst:7:This driver supports Analog Device's IMUs on SPI bus.
Documentation/iio/adxl313.rst:7:This driver supports Analog Device's ADXL313 on SPI/I2C bus.
Documentation/iio/adxl345.rst:7:This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
Documentation/iio/adxl380.rst:7:This driver supports Analog Device's ADXL380/382 on SPI/I2C bus.
drivers/iio/adc/Kconfig:108:    tristate "Analog Device AD4130 ADC Driver"
drivers/iio/adc/Kconfig:124:    tristate "Analog Device AD4134 ADC Driver"
drivers/iio/adc/Kconfig:136:    tristate "Analog Device AD4170-4 ADC Driver"
drivers/iio/adc/Kconfig:167:    tristate "Analog Device AD4695 ADC Driver"
drivers/iio/adc/Kconfig:182:    tristate "Analog Device AD4851 DAS Driver"
drivers/iio/adc/Kconfig:350:    tristate "Analog Device AD7405 ADC Driver"
drivers/iio/dac/ad3552r.c:699:MODULE_DESCRIPTION("Analog Device AD3552R DAC");

-- 
With Best Regards,
Andy Shevchenko


