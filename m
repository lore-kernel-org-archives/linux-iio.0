Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599D352C4E;
	Fri, 27 Mar 2026 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604679; cv=none; b=F0xszkA0vnSw/dN7wSrp12zCbIYC+9XhAcpEuK4XODF2AOuPH3+rwu91dRLI3F85tpFi2tZNNrvVwzZQQQutwE+ddsbcjoWnUVqllXtqj/CxgF12yIUW7bB3sQNzjV7qXSISsZdzlmXoqSLqBRzKp+bImK1hUc9WM/l6yaG4XaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604679; c=relaxed/simple;
	bh=yxw2kq1Ywb01LwkIISp29kDIqSlbhJmZSLTX47njR54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtu2NZYcuFun/1IgqBRT26jslC+udzqnEUJCk001fp8FAMoPBtNns1JNRXQUnDkGpZ9AqWtLu5g+MZA+yUw6ViocvZnoUAGZPPAA5bIrIKwIAYVWVa3mdcpdsCUpTMPYXVfjwtkBNv/8VUKq/Q1sMMT7mKy9ggqrD8VP3s9IPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oi+4a6mn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oi+4a6mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774604678; x=1806140678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yxw2kq1Ywb01LwkIISp29kDIqSlbhJmZSLTX47njR54=;
  b=Oi+4a6mnfMJN3ZHZdcGXyzXj9fPCQ4XAYFbn3Cs3kRah9G8onOzzgchJ
   RNx3LcxapHbfmurGVqAVXxgsq/nrv3VEpnqZWNEBSqKhKR7Q662byCE+B
   xH2k8z5ZwvgKezeMzEITPepYqaxfYywBfdVRsRBZPhvzO99GI+03DggbR
   vuPvza7m7MOfPlxlOekp8ogYOfmdRtCAiDIkNu5oi7LeUpQDVSFu+gJcO
   mNdPuJZmb5utlWqnc6rFF2+omwpSKHqaLPvqpkzV++XuVEnIPkmfzkrMJ
   rzfwdeUL/W7svlhVfMpkjFwgdZTYIlZC8qdHcfFAYdqi2n33aHIbW44pF
   g==;
X-CSE-ConnectionGUID: 3gS3mLg2Qn60KUQfmkKeZw==
X-CSE-MsgGUID: 4vLkG0thQSaW2RC+GI9yLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86295698"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="86295698"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:44:38 -0700
X-CSE-ConnectionGUID: BT2qHgoqRhSwkIWpy3VmrQ==
X-CSE-MsgGUID: B+q5jlfnTBCXqmj2Ikie3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="218649466"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:44:36 -0700
Date: Fri, 27 Mar 2026 11:44:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: kernel test robot <lkp@intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Message-ID: <acZRgSH2Vvmm1Usg@ashevche-desk.local>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
 <202603271734.pnWuSmNr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202603271734.pnWuSmNr-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 27, 2026 at 05:13:16PM +0800, kernel test robot wrote:
> Hi David,
> 
> kernel test robot noticed the following build errors:


> All errors (new ones prefixed by >>):
> 
>    drivers/iio/adc/ti-adc161s626.c: In function 'ti_adc_read_measurement':
> >> drivers/iio/adc/ti-adc161s626.c:87:24: error: implicit declaration of function 'get_unaligned_be16' [-Wimplicit-function-declaration]
>       87 |                 *val = get_unaligned_be16(data->buf);
>          |                        ^~~~~~~~~~~~~~~~~~
> >> drivers/iio/adc/ti-adc161s626.c:94:24: error: implicit declaration of function 'get_unaligned_be24' [-Wimplicit-function-declaration]
>       94 |                 *val = get_unaligned_be24(data->buf);
>          |                        ^~~~~~~~~~~~~~~~~~

+ linux/unaligned.h should fix this.

-- 
With Best Regards,
Andy Shevchenko


