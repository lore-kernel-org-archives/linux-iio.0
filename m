Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89134B43F;
	Fri, 20 Feb 2026 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596372; cv=none; b=RWII0TK/doI9PFsPOFJYcqGxxjYaFcQLRdm1ER+f6pJgz8P8Sou0a+4bsceMCdWKXHQC+LwXuNXuunHTeMyTj8evua/GcNHk0F7lhJCKll3ho4TziHLEcRUAulP70gSvzQGp/eG01UhMrGpCRsccuNovn/dyI28qmwXgysELn0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596372; c=relaxed/simple;
	bh=0gME+fs5o0hxpgWbxEMjhQjeBQIhN8QXzTQusiKjVCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZHWoR+81Z3gWf9MkvELTzHCppvBQ+ORNyxcVhW+ddZoy/aa6LKA+5G9RHHzdm7bMy4EvYEcInveBIAGW2u17L0DVn93ZTH1mK5y2xfbdHIkA6uINonqaXgX5H60C9QKLtGJakaWtVC06zKuUbiWO+vc3Lb16/NM80n77axsIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZhLxZog; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZhLxZog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771596372; x=1803132372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0gME+fs5o0hxpgWbxEMjhQjeBQIhN8QXzTQusiKjVCY=;
  b=bZhLxZogty5XQpD+b6X1wjLehR5em1p+wskmG9JsnypdTA2K4gnFx6uR
   kBo9KjNq+agqUhOqRS12EiUhE1rpKN/my5EvsH/BY1q+ycikJIWcsChXW
   tmPq2TAFQK4r/wyxtzF58D84ebUhbdGN/IcoQdAyHMImMzv/wRcN+j41u
   0dwuE7glKJDB6V0VdgEL/zr1iQrRnxBMXAD5q4v8dlTJnr8gv6WmZsyhY
   ggVO3BnM5AMj4Mkxf857eGZpzPxaF3AsXWYq8YjMXDWeqGH+sUDUPM2Dh
   va4/GXiOGQkbOPnxdNF+l+OLcRcRyzExwJ/SLfUyesUz6VOzn5uUbSwgH
   A==;
X-CSE-ConnectionGUID: uUUiNC0VRTm+QyP38Wv6mQ==
X-CSE-MsgGUID: bIUolUOaRf6ZDA6W/7mmvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72567431"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72567431"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:06:11 -0800
X-CSE-ConnectionGUID: hY0wLfsHSdejVnlcpXMcmg==
X-CSE-MsgGUID: CBitizDgT9WPNfO0F0rqQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214866558"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:06:07 -0800
Date: Fri, 20 Feb 2026 16:06:05 +0200
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
Subject: Re: [PATCH] iio: imu: adis: Fix NULL pointer dereference in adis_init
Message-ID: <aZhqTRQTLwcdSMkF@smile.fi.intel.com>
References: <20260220-adis-fix-v1-1-9fa10cce812f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-adis-fix-v1-1-9fa10cce812f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:36:17PM +0200, Radu Sabau via B4 Relay wrote:

> The adis_init() function dereferences adis->ops to check if the
> individual function pointers (write, read, reset) are NULL, but does
> not first check if adis->ops itself is NULL.
> 
> Drivers like adis16480, adis16490, adis16545 and others do not set
> custom ops and rely on adis_init() assigning the defaults. Since struct
> adis is zero-initialized by devm_iio_device_alloc(), adis->ops is NULL
> when adis_init() is called, causing a NULL pointer dereference:
> 
>     Unable to handle kernel NULL pointer dereference at virtual
>     address 0000000000000000

No need to wrap backtrace lines. It makes harder to understand the trace.

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000

>     pc : adis_init+0xc0/0x118
>     Call trace:
>      adis_init+0xc0/0x118
>      adis16480_probe+0xe0/0x670
> 
> Fix this by checking if adis->ops is NULL before dereferencing it,
> falling through to assign the default ops in that case.

...

> -	if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
> +	if (!adis->ops || (!adis->ops->write && !adis->ops->read && !adis->ops->reset))
>  		adis->ops = &adis_default_ops;
>  	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
>  		return -EINVAL;

Personally I wouldn't mix these two, and do rather

	if (!adis->ops)
		adis->ops = &adis_default_ops;

	// Actually the below check seems redundant to me, I would rather
	// expect that be absent in the first place.

	else if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
		adis->ops = &adis_default_ops;
	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
		return -EINVAL;

It also adds a flexibility to only cover missed callbacks in the future
(in case if we need that). But also see above comment.

-- 
With Best Regards,
Andy Shevchenko


