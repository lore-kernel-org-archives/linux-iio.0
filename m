Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639643093DE;
	Thu, 19 Feb 2026 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487521; cv=none; b=JV7qpfihIZISfI30O8iQJv1wFHN6f7MFd+F6HIlCkMpJJoHZV47rsxe9laX77wPt7ajo/V6uqPLaocWMdLSfgUvwDnIgL2O9EHeZj/h8V1QN3kcFMJktbE4XcpSdVMBDh9I2No3Q/UXd41Allk1NDqhMIWCzQH/MKZVlhOfr2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487521; c=relaxed/simple;
	bh=TufajdXiMQuR/SqoAVtUOhXrE7s2yEQP8uIjTxaCB/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+bRxL4CNXvEGf1HJ23Ji8d+W8X4LZCKhZSYzfJqcm5mslITY0AqwnKY+TeWBP7bUgl0WY4jtdrP254wc4MkCtZNPk/Gt4AwMO4KTGGFQaglVj9Ibi/rMUxJDyj7eqKjK+uKO/Eu75hr+PcPGTI3qZbO8tlgXh6rD2oT2sMjO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4pHv1vr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4pHv1vr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771487520; x=1803023520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TufajdXiMQuR/SqoAVtUOhXrE7s2yEQP8uIjTxaCB/k=;
  b=R4pHv1vrsY8mTq3oZUpNDSz8MsX7UHHtao8TVMLV0Q0WTSr2Eq4N2afA
   E+xyRQqCclGU4+PnxyKVN95/hE8TsIYV7nZMIqTi7SIHaEh1vOqaXRPrc
   sO90/8kSLz/eXTd8ygEWB/dozqknThzaXyKZo4Mpj+HlGgBEhB8mkM+/5
   vf2+yOm07z9uAMsGof7bhv7rG8qkHfO5+sa8M4A4JlmQ4R77PhmmL1Dea
   Kyan1JpTqvTwe6rYoyhu2MbnYedTo6QA9bHfhecddWUTDqC5MruIsa72j
   pHGvVeUOncG21ZtuU6rYuAWMpocZqhEyadgMVhGXF5eYB/IXbWsBXilEf
   g==;
X-CSE-ConnectionGUID: IP8CfvwBR7igA1+A76KmIw==
X-CSE-MsgGUID: jj19aPdnQyi37Fza0oJ6mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="98030033"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="98030033"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:51:59 -0800
X-CSE-ConnectionGUID: 9+Y1DJrTT6yTuSgNaTAIzQ==
X-CSE-MsgGUID: luJYbTxQT7KpVvmrNPtxFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="213681158"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:51:57 -0800
Date: Thu, 19 Feb 2026 09:51:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: switch to using guard()
 notation
Message-ID: <aZbBGomQi0l84An_@smile.fi.intel.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 18, 2026 at 06:29:27PM -0800, Dmitry Torokhov wrote:
> guard() notation allows early returns when encountering errors, making

guard()()

// strictly speaking

> control flow more obvious. Use it.

I like the change, but...

> Also variables that now only hold error codes (or 0) are renamed to
> "error" to make their purpose clearer.

...this does not belong to the patch. If you wish to rename, better doing
it separately. This, in particular, adds undesired churn in the change making
it unclear.

-- 
With Best Regards,
Andy Shevchenko


