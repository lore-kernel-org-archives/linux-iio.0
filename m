Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0B34404F;
	Fri, 13 Mar 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394330; cv=none; b=bHsuT0nDxWqSXiR91ZlV2BCC3Czxn4TyFCNBBFXoe7Q3kOTAHYWIUIKDrqYrdoM+NDh27iN4EMDtZI+yaJ7N3Lu//ou7psUQJRfqhx2d1pXZ5Ba8p6I6JVTfw2YwIjyWF0n2CSU4vHwWmOAoQzZ2qEzPjO2neNq8mAy8/XnS39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394330; c=relaxed/simple;
	bh=nppF1ad9T9XazH1yCnKiKJ8QR0oAlqI2g7/jhh/8t+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ7J61/V8AYfegfBxrrrUgGMZIfQARYsS8VsjqVFJKgAg7u9PS7ni3AQ5/Ee2ji60sTkQEDnIoHHxWNmO80Z+Pi1aY2YNTiBWZhYrKPWPyFnVJYm37ORL0AWC/p1Sm2tl4+9SVjbnSOyIK910HIQo1QIQLj+/ymfECykf3RdRlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGjaT3Hi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGjaT3Hi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773394328; x=1804930328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nppF1ad9T9XazH1yCnKiKJ8QR0oAlqI2g7/jhh/8t+U=;
  b=iGjaT3HiTsUB4o7gOp/wnuoFhPqoDkHNK37mxPcyQHzNtVTT7KV8Nnxq
   AjFReEYhlJFI3H9LPL2Hm2NwyNE5l+z9DF/6rxP1lRff8v8/Q2t7jbJ2r
   nzGm3ktPBBoxUtS8G4QhITrKSfe0lnHN/KmX8Hv3RgOn5ATCzTlFhJ6pv
   sQqI8M0EzRzfblgZhfUYPzGpbAjckqp9Ke85QSSPDLhnRbQRrEsC8FW5I
   vnt5+Tr+SJV0+oUxWzhJ72k/7Ps72mRNJ+s3L+FH4ij0MZV/7h0iNIqN0
   v0lITwkckZNJbNS4xclZrqWxuwf8chuMxwGejUcLRmzjj6kAzcHftNrik
   g==;
X-CSE-ConnectionGUID: aG9mWBoMSByuYD7ZUX3LaQ==
X-CSE-MsgGUID: gt0/85coQuGO/t/lr1IpAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74394797"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74394797"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:32:07 -0700
X-CSE-ConnectionGUID: NP6vg9yORXaGSdK0VshM0w==
X-CSE-MsgGUID: gAA72zLVTO2mDXcG1uOzlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="217135271"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:31:58 -0700
Date: Fri, 13 Mar 2026 11:31:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Peter Rosin <peda@axentia.se>,
	Marius Cristea <marius.cristea@microchip.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Benson Leung <bleung@chromium.org>,
	Jyoti Bhayana <jbhayana@google.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Ariana Lazar <ariana.lazar@microchip.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kurt Borja <kuurtb@gmail.com>, Waqar Hameed <waqar.hameed@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	=?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2] iio: cleanup: uintptr_t to unsigned long
Message-ID: <abPZjEE82AIxSgB6@ashevche-desk.local>
References: <20260313013435.25731-1-tomasborquez13@gmail.com>
 <20260313071014.2102-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313071014.2102-1-tomasborquez13@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 04:10:14AM -0300, Tomas Borquez wrote:
> Linus has been explicit that uintptr_t should not be used in the kernel.
> 
> The iio_chan_spec_ext_info struct uses uintptr_t for the private field
> and in its read/write function pointer signatures. Jonathan Cameron noted
> this should be cleaned up in one go across all users [1].
> 
> Update the struct definition in iio.h and backend.h, along with all
> drivers implementing or using iio_chan_spec_ext_info callbacks.
> 
> No functional change intended.
> 
> [1] https://lore.kernel.org/linux-iio/20260111122034.174c754c@jic23-huawei/
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>

Please, really, take your time and study process documentation!
No new version, especially that SPAMS so many people, in less
than 24h. You must give a chance other people to review.

This version effectively ignores all my comments I just gave against v1.
So big NAK again!

-- 
With Best Regards,
Andy Shevchenko


