Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10B34D4CE;
	Fri, 20 Feb 2026 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597521; cv=none; b=eaRmAIxrP3R2Ld3SxLLINd9HiKLngmjO2bImX9mU4kfX6ojUq4Gd5zrl5Qhu0abhf/bBCkoxtDQRxLJxR/PwksqwoAVc5lUBv9f2YmeljGF89gx3ReJyXRSiKNLUWtBfptr+poheDUnE6aAeSqM64CgwPvvfTBkJ7kDD2LfhmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597521; c=relaxed/simple;
	bh=R9rjh+XKbXO+nFSsRhb1NyABSBqSkWkVk9xLr3276j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLkrqfsWzcodeHguVdut+fnh5DMn9D9R91rv0Qfr5NUrDkqCJSDGLm1HycEpHQ2jOWkRNdhYZ+qPJw8ZZBLWcAct07VEXuQWEI4PlDIAfFwRbBkmph/Ww9kSIE2dxJgYosWmE3devGsBfjOWydKeuGx49YYfEmIsUAdlT3EN8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbJT3eKG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbJT3eKG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771597520; x=1803133520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R9rjh+XKbXO+nFSsRhb1NyABSBqSkWkVk9xLr3276j8=;
  b=fbJT3eKGgDLC4Jh8MlfAjL3njYltjP7Vd65cj1XiFd3nY4TZ32bA/Iv7
   wPqCUJ+rpLuUtErmfkn+c1q61UP6IB5biLRV3L37Jag6DpIHjdWLbJDY0
   2hsiDp2sDVs40UGPSmQc1Z/XMktmqKhRP6oNFfXZjLxkae7HvpuNKmev7
   uxjLpHrIRqjqMXWQl3QOCRiO/qekk04QFQQ4LQch5TE562TziOcPdUVbx
   QWodJoxYBgtntYwNucKWtVukPzvMSLyHx7d0d0RH/KPkDZcireULVPh7E
   C8mDqkPUDqLZIctiFAv49iZguLQUgJztUfKocd+aO1F9t4d9rVCWZEbNK
   w==;
X-CSE-ConnectionGUID: VIWpKGeBTva+Jbrc9Bn4Mw==
X-CSE-MsgGUID: fNMjeke1S5SB/MnjLgP7yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72865700"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72865700"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:24:46 -0800
X-CSE-ConnectionGUID: KY1g1FGsS8uZoAlgDgJ31g==
X-CSE-MsgGUID: ayKxMDgIS4+0FN1WZjClSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214715465"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:24:44 -0800
Date: Fri, 20 Feb 2026 16:24:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Robert Budai <robert.budai@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: adis: Fix NULL pointer dereference in
 adis_init
Message-ID: <aZhuqJuPuBHSyGLk@smile.fi.intel.com>
References: <20260220-adis-fix-v2-1-4cc24a261306@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-adis-fix-v2-1-4cc24a261306@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 04:16:41PM +0200, Radu Sabau via B4 Relay wrote:

> The adis_init() function dereferences adis->ops to check if the
> individual function pointers (write, read, reset) are NULL, but does
> not first check if adis->ops itself is NULL.
> 
> Drivers like adis16480, adis16490, adis16545 and others do not set
> custom ops and rely on adis_init() assigning the defaults. Since struct
> adis is zero-initialized by devm_iio_device_alloc(), adis->ops is NULL
> when adis_init() is called, causing a NULL pointer dereference:
> 
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>     pc : adis_init+0xc0/0x118
>     Call trace:
>      adis_init+0xc0/0x118
>      adis16480_probe+0xe0/0x670
> 
> Fix this by checking if adis->ops is NULL before dereferencing it,
> falling through to assign the default ops in that case.

Don't throw versions too quickly. You missed a tag from colleague of yours.

> Fixes: 3b29bcee8f6f ("iio: imu: adis: Add custom ops struct")

...

> -	if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
> +	if (!adis->ops)

I hope you have checked that this is indeed the case and we don't need this
check anymore. (I would be glad to see it being replaced as in this patch!)

Assuming this is confirmed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Collect the tags and issue a new version only on demand, and not earlier
than 24h from previous one.

>  		adis->ops = &adis_default_ops;
>  	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
>  		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


