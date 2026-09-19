Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA6257827;
	Sat, 19 Sep 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789826695; cv=none; b=ua+BZ6fuRdoklLh99DaDLSIi8GNvAWUdyOnLPIyObrQJWsjgnkaKfPoY4N5iOfV49B5uYFRwNfV9h/xcCxFRjp8TpHh+lmuTS/sm1gXc68gYCiVVfjUix09IEyB3j2lHNiqkRnQk/bBPVlDWfktf5cRiDc5SKFJ2gK4reEaNnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789826695; c=relaxed/simple;
	bh=pDpewoF6uZP+FjjoVbhOjMsV0p3wE2880W00V1QzUU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0U+Q7dvv4KgLuhcX3ns1wqRei/k/fYfFcPa8GIe4q944fSl4jxB8adW4DjD6iTBFyctU441UsVj6/oKs2DYju+0cu4yzyoYrkhTlwXiMJHTiPr7zcGM/TvhdiVVOTCIe4JGdpehFURmixm8eEIuxL/uKJMRLcAq6tchHJe+7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXd6XPqM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXd6XPqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789826694; x=1821362694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pDpewoF6uZP+FjjoVbhOjMsV0p3wE2880W00V1QzUU4=;
  b=hXd6XPqM3AOKo/7o48I+P0y6jBQEMr/wyCez+YhNeFgVxcYLDjfOsteh
   NrTq0Ykd7hViofDlVvos8rd1Y38jNKt7u6ilFkBiYW4Rmg7Ii4n61U3yA
   +StKM3jN2SRYmSiJtit/WqDnGN47tElxXdB1AUh+jm62HizEFSINd7/x4
   KD4JvjaKooBk4q7Gg8fFMCuRUqWGnbQFw8TgoS7WT82fRN4VIr3GqvH+O
   7dAM/OGT+nEeB7qNO/RUR28gJMKbntaB3cLgUNDYj/iopTvdL/dl1o/iA
   yZ0IH0T9+UU3PdyTtUn73pdP0eCgjUt+kcEEI3x9ec7FTOj7KUtfUc5pf
   g==;
X-CSE-ConnectionGUID: sRQmp0IzSMSc7fnnCFsnmg==
X-CSE-MsgGUID: 3xyZHNcQRFKmQQcwL9GPpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="92857028"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="92857028"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 07:04:53 -0700
X-CSE-ConnectionGUID: 5DHOE2bwSGSXIdIWQBqnEg==
X-CSE-MsgGUID: gh7ZuU4lT8SYJ4TxBECuOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="271124892"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 07:04:50 -0700
Date: Sat, 19 Sep 2026 17:04:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Ivan A. Melnikov" <iv@altlinux.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Francesco Lavra <flavra@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tools: Use proper macro to detect _Float16 support
Message-ID: <aq6WgPxpeEMrEkW_@ashevche-desk.local>
References: <20260918161305.1161852-1-iv@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918161305.1161852-1-iv@altlinux.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 08:13:02PM +0400, Ivan A. Melnikov wrote:
> __FLT16_MAX__ is an internal compiler macro. GCC defines it if
> _Float16 is supported by the target in general, but the support
> may depend on the exact target options. For example, on i586
> without -msse2 I get the following error from GCC15:
> 
>   iio_generic_buffer.c: In function 'print2byte':
>   iio_generic_buffer.c:141:17: error: invalid conversion from type '_Float16' without option '-msse2'
>     141 |                 printf("%05f ", ((float)converter.f + info->offset) * info->scale);
>         |                 ^~~~~~
> 
> To fix that, use the public macro without double underscores.

What about clang?

-- 
With Best Regards,
Andy Shevchenko


