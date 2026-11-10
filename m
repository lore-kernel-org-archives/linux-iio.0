Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328185;
	b=cXuPqiSYmecXoBT7DVrY7Cnz6mBm6c1/zFBSxwrljYVEoaBAil6g4u51nFwfGo0SoD8p
	 fItbmb3Ksy8jkGIQRIM7+qCh/nJfQq6fzDwLkBm+PQ+N1+aKAc3lDn/9pcPVZjL/Uvfzz
	 tr9ONFIu/xRXwvW8zcBi3dEidxEz3qLWWZCs+RUqIXnuX8RboCYT8GrS1jk+YqUZLmx6o
	 qO8JpE8wkaKETADtLz0iXj1+hgmT+sIK05IL3rgBYigroz8mE6rWJpDiQYqAFmeQWVzjb
	 BH5u9cVY4R+DeE708/B2z291x18mVUGLydbcgeuu8pcqphptkh9pGgX01Zhl+MUcuJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328185;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eSliAbjh7RZqlvKIXCr1lf7kB+SLn3Ee8ByU0n0PH90=;
	b=Z2PncI4erhDz3B0+dK/c8e/o3PGgqBHSDWLL+USy5N0fJPqIWlafSMDC2icSpDrWo4NO
	 p9brufWuTlficjzsKYN6zsaESCpKjGV7sIhOrLf7+VMnL/n1vDdsSZ8VP1C5z3qtwejLd
	 36boFzRwQq8M4ptUV/S6tWEeC+dv27l1umyd1S+LRSsinydEnE/8oQvskV0q8O8ZqJUwp
	 WcVQECp/YfA7UQHmRmZXFvZyb4aYbE8TVQEgHlMzRjk6OrvHHMhiq4YGX5fSGbkuJt/s6
	 WyIPjkwQjFtXdQBXVEgNP/uORgNeYDKB9vDJm4aAZ06YlsuxQehGkl6odSbLa7MXeug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bcyXhzEW;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6760A6F63;
	Tue, 10 Nov 2026 16:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEE6760A6F63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bcyXhzEW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794328183; x=1825864183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fJlR0bo8pnYc/LIMgKmawcndi2oTRuM9VysMmlsls1I=;
  b=bcyXhzEWdqdVKXUJni+XQxGQrQ0nj+I3c1D5ob3qiMpkecqK81MdAshc
   IzX13UzcWwu/8IN+cD6dUgCsFonYMCjbKIRGfCa4W2idx5uLjFaX6xoDV
   3Q3q3BwU1cwBmKLsap29is4SjZWWUYnIGPah2wNWXwL9jK9IkScWLLOsR
   jmjuCQuEAemR+2SXahalptNl4Dzx4KUc2qs0dbNhrWq0GQptNCGODBZyp
   7Eq+6NuclvvfbWpzeeb/imEdD5QsbqJt6sq48XPTlK7krBnAwvMJ2pvlk
   Hs4X6qtnxQwzNNGJOO/O75nXkuZk5fz2JyMx+qgj5VVSpMbsEXTzHB05v
   Q==;
X-CSE-ConnectionGUID: gDWygFMcQ7CCAK1Bzb+7Aw==
X-CSE-MsgGUID: vZIS1/PzQsO7guTt+zw2mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2986939"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2986939"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:29:43 -0800
X-CSE-ConnectionGUID: MiXN/1QDQnqyJU4w66cS4Q==
X-CSE-MsgGUID: P3r/DpS6R9WNXmCnTfY5LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8063104"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:29:40 -0800
Date: Tue, 10 Nov 2026 18:29:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 14/16] iio: adc: xilinx-xadc: Split driver into core
 and platform files
Message-ID: <avNGcpcemoeE3J7O@ashevche-desk.local>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-15-dileepkumar.nagavarapu@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110050201.1850399-15-dileepkumar.nagavarapu@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:31:59AM +0530, Dileep Kumar Nagavarapu wrote:
> Split the xilinx-xadc-core.c into separate core and platform specific
> files to prepare for I2C interface support.
> 
> xilinx-xadc-core.c is reorganized as follows:
> xilinx-xadc-core.c:
>   - Platform-independent IIO/ADC operations
>   - Channel definitions and management
>   - Buffer and trigger management
>   - Device tree parsing
> 
> xilinx-xadc-platform.c:
>   - ZYNQ platform (FIFO-based) register access and interrupt handling
>   - AXI platform (memory-mapped) register access and interrupt handling
>   - Platform-specific setup and configuration
>   - Platform device probe function
> 
> Update Kconfig to introduce XILINX_XADC_CORE as a helper module selected
> by XILINX_XADC and update Makefile to build the split modules:
>   - xilinx-xadc-common.o (core + events)
>   - xilinx-xadc-platform.o (platform-specific)
> 
> Reorganize the code with no behavioral changes.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> ---
>  drivers/iio/adc/Kconfig                       |   8 +-
>  drivers/iio/adc/Makefile                      |   5 +-
>  drivers/iio/adc/xilinx-xadc-core.c            | 690 +--------------
>  drivers/iio/adc/xilinx-xadc-events.c          |   1 +
>  ...inx-xadc-core.c => xilinx-xadc-platform.c} | 818 +-----------------
>  drivers/iio/adc/xilinx-xadc.h                 |  27 +
>  6 files changed, 72 insertions(+), 1477 deletions(-)

This is weird statistics... I think it's a bug in Git. What it did, it copies
-core.c twice and uses statistics on each file after that without duplicating
the *original* amount of lines.

-- 
With Best Regards,
Andy Shevchenko


