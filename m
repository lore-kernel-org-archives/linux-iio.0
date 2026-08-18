Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC41EB19B;
	Tue, 18 Aug 2026 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028223; cv=none; b=PU+A5uKDVsgEsMFdi5hiddb5qQWFM3+Y+Nd+JHY62piv2SypecYRB28h5WN4PHtwXIPa9lqNPNPZsixcfGubhBLn4rOe6Mj4I1r2d7jSy+HcohXdFO9KklmRJc1pmx50QOFaMq0fjDB1ATjC/6JfcakSkfsAqytBo8Utcg6EjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028223; c=relaxed/simple;
	bh=BeHj4YLG3s5SkoY6KFxjGbwB48Fz5do24Lu4wDXieok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uydUZEL8AfSWnjl6yDiJuozh/KDih/CA4oR5gPAOv/mH9e0S7hMuqOb45a0EXwVENn+mu791h23LnAp0ESqFjg08YAEredyffyZpwuDEX4TNz8uoixufHcN4oS/jGqpVT8MFKw8tRD+rpAshsqDw8wR/k9oIfNSmRXxtHEn/TCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlpMmhRz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlpMmhRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787028222; x=1818564222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BeHj4YLG3s5SkoY6KFxjGbwB48Fz5do24Lu4wDXieok=;
  b=LlpMmhRzYTaqcQ+zv+w9zhImxoYUlPXUbDgFQxgiwiQUdpPdVyejl/Qj
   rGfytzfvca+Pekb0ehV3kQGMBQB9Y5+6buTyjUCZb4Z3xSl5kEzGV8OHL
   SYn4oGgdpSZlHukXNLOOVRfRMp2H+kHhUFpaNWqxx7qjEQiJj5wesM692
   vHbGlhQKVUBMNIwJI8PAmiwgTPRq9gyVOEUhBJbd/VfBgEIUngcsR+lt8
   qdempIV3vp5rm+g3RG8Ef9NMEZrRIFrWEGjnkMGNFkyp9N8vrY5b8vrgM
   RhLTkwdoXs85R1KV1Y/6nlr8kQF8rLBWC9KcoKvnXK9OTrbp+9zc8h/tM
   g==;
X-CSE-ConnectionGUID: kIliK5x0T5uZtDgD1Yh5JA==
X-CSE-MsgGUID: +TMw9IbbRsGCxaWBycs2Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="110294940"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="110294940"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 21:43:42 -0700
X-CSE-ConnectionGUID: lv1TYxJfTA+rJOGgGKQUIg==
X-CSE-MsgGUID: xnG7vlrNQZWSXbH3ij77Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="295040323"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 21:43:38 -0700
Date: Tue, 18 Aug 2026 07:43:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iio: dac: ad5504: Align headers with IWYU
 principle
Message-ID: <aoPi90sc5rhNGW6P@ashevche-desk.local>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
 <20260817211118.21833-3-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817211118.21833-3-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 05:11:11PM -0400, Taha Ed-Dafili wrote:
> Update the header inclusions to follow the IWYU principle and ensure
> they are sorted alphabetically:
> 
> - Remove <linux/fs.h>, <linux/slab.h>, and <linux/kernel.h> as they
>   are unused. The driver relies on devm_ managed allocations, so slab
>   is not required.
> - Replace <linux/bitops.h> with <linux/bits.h> as only the BIT() and
>   GENMASK() macros are used.

> - Add <linux/mod_devicetable.h> for struct spi_device_id.

Not anymore, now spi.h is responsible for that.

> - Add <linux/errno.h> and <linux/types.h> for error codes and data types.
> - Add <asm/byteorder.h> for cpu_to_be16().
> - Add <linux/array_size.h> for ARRAY_SIZE().
> - Add <linux/kstrtox.h> for string to integer conversions.
> - Replaced <linux/device.h> with <linux/dev_printk.h>

-- 
With Best Regards,
Andy Shevchenko


