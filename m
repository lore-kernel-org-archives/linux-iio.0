Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD652B1F0;
	Tue, 13 Oct 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917371; cv=none; b=B8hyu6qbxYN0RqmOMNeDtIygWEUFTp0bxi/MvC3edbHtYj6t08JIvk/CCWHfuGRfFXrBkBorEjFvivsNZRZDC3z7pCcYGgApHFke0TtSnyy9XdaZitLJlgXDwQ/ydtUiXsoZtnTPaVNUemQvWyClWVpUwPzphgdCYwSasCKRkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917371; c=relaxed/simple;
	bh=GcgTGTUKLZsBicwTKKTvC1tAzZpQbTxTHC2mXGx8u50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evUQYQvVs9NhN0+EZ0g1ROQHTtoCG/QhQdc8+L54ePUq7VpQvgf4iTW9F4FmgQ1BQrWQLC0WEtlis++y6i9Gs+mGLP+ULAOJjVIEjKvgR0s0kMeSvmSkwIxgOYgNWypuqdFoY6G4O3RUJS+DsvFuEENAWKtR84No9kFGl/tRpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/hYYL0m; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/hYYL0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791917369; x=1823453369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GcgTGTUKLZsBicwTKKTvC1tAzZpQbTxTHC2mXGx8u50=;
  b=L/hYYL0mXUSyuZ+GADYAOLcBeBMGA1bhrhrkt2QRpOXFRnADS303W7C6
   cwUYYwiwo//zlKO8PN6e64KElhiJ33x+xo7coWi5ixqsehhl1tWENu5yL
   jDGInvikY3ijE5Xs3X04WjXOPo5gcI5yFWA155Lr5b0aBvbAPkYzLmkBJ
   HKYHMbsi0QoJU2tR1Of7xC9SMyuhls7mEFcou79nCFNYoHP8QEY1TSbC9
   qt3f17xR/unbHxjfOp3kB4eQgANT9X71nfTLyEef7s1/V52h9QxMJUvOg
   uSqJxfy36zMThVBwG1x0hwv996k0yHJFcyqqiQa+OtJnVCgdX6dBepKh0
   g==;
X-CSE-ConnectionGUID: qAUi5msWSWW6AyoGoUXGpQ==
X-CSE-MsgGUID: hM/vf18MSu+T0pXnDQN65A==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="647880"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="647880"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:49:28 -0700
X-CSE-ConnectionGUID: CIKezkIdQ0WeZ0M8NropCg==
X-CSE-MsgGUID: +R+yUuQ1Tna+whYr5+JBQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1122609"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:49:26 -0700
Date: Tue, 13 Oct 2026 21:49:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v2 2/4] lib: test-kstrtox: add E notation tests for
 kstrto[u]dec64()
Message-ID: <as59M3m-Xdc5RDBg@ashevche-desk.local>
References: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
 <20261013-e-notation-v2-2-d4adb5e193fc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-e-notation-v2-2-d4adb5e193fc@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 10:36:45AM -0300, Rodrigo Alencar via B4 Relay wrote:

> Cover E notation parsing in kstrtoudec64() and kstrtodec64(): positive,
> zero and negative exponents, upper case 'E', an explicit '+' sign,
> truncation of integer digits by negative exponents, large values, and
> failures for overflowing and invalid inputs.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Always a green light for the test cases.

-- 
With Best Regards,
Andy Shevchenko


