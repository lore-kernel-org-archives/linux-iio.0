Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E14AC167;
	Fri, 25 Sep 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345931; cv=none; b=pXQQ+eNLPs1D3EJzlulE7djnHQpnpT74YTDuxsWqgTIneAF2SpVqQFRqGYdh/eootMr6pSnXRe9Z5d3RkY5hthVsLFpmCLNdrhwVROhZxsGK3qyTy4C9ehKvaojQEYczbXJjU2CxnDuKhLHOna41U+XcE50ZeE9e55cyN6hzWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345931; c=relaxed/simple;
	bh=Lz7S9hRPMrOiw1jmTn397ZOfa1r7jmlgvAOidvR5GXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPzujfqfETeCDCX1PtHmNJkBIoDXEyOcZEU3SKuYx6eYY9SLxg1by2oh8U0eNkp0t9E6ad5gkFe+qg6hL661vTqfMLX2vCu0zCX3BSM6+p0uFF4dn46ALhHGwvG6jvBxly7rRlCyrUmjZ3PXmFfRfyjdl1BA3O9MiWdOjUAa3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAyG4tzB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAyG4tzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790345930; x=1821881930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lz7S9hRPMrOiw1jmTn397ZOfa1r7jmlgvAOidvR5GXw=;
  b=lAyG4tzB6o4ZpRGdbie/M/MsZ/YSvCs4Akd0xIArLXPUy6gmSrPT9vYe
   oaTAlMk8rhZo5rgOpvXuFEsm1Z/JI7WTYfq5olxzG8ptnKGXWccJg3qpL
   wMTsRZ0fgnrSxonXqxQsaADPj2BArABWQQNwcjx6F07327vbAVvzOO8R+
   QSk3qEdFs8R+BlGrUyaCuR/3x7DKQ2mi0gbOyUEAKPHogJikA28SpRQdJ
   uEV+ReJMjemOLwmq7SZD5VslqKcn6+5TsNkoW8wLt06gSJd1M4/txE+hH
   bUwAxR5KHg5pAtFtAu0psmZnfQ6M1omtgS+HuB9mqfGiV4Ou2RvNE9JXs
   g==;
X-CSE-ConnectionGUID: FHSQyCS5QpW0MVIqOnSjBw==
X-CSE-MsgGUID: +u1rlyI1TiePtJwPHLkcbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93849263"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="93849263"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:18:49 -0700
X-CSE-ConnectionGUID: KAiusXl3RR+WUdvO5Lye9g==
X-CSE-MsgGUID: miQA4zCQRo2QAFzrdJjNpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="273897144"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 07:18:47 -0700
Date: Fri, 25 Sep 2026 17:18:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Siratul Islam <email@sirat.me>, Maxwell Doose <maxwell@maxwelld.cc>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: kmx61: reject duplicate event disable
Message-ID: <araCxIGnZK0zuUSS@ashevche-desk.local>
References: <20260925141006.2255067-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925141006.2255067-1-yaojiale02@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 10:10:05PM +0800, Jiale Yao wrote:
> The IIO core does not filter duplicate writes to the event enable
> attribute. kmx61_write_event_config() already ignores repeated enable
> requests, but a repeated disable request still calls
> kmx61_set_power_state(data, false, KMX61_ACC), dropping a runtime PM
> reference that was not acquired for this request. This can underflow the
> runtime PM usage count and trigger a "Runtime PM usage count underflow"
> warning.
> 
> Return early when the requested state already matches ev_enable_state.

Same comments as per previous patches of the same topic.

-- 
With Best Regards,
Andy Shevchenko


