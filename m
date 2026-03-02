Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A52EBB8D;
	Mon,  2 Mar 2026 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471721; cv=none; b=Crh/U3sxHqLmHp5B7hmEJzywXT2wsmqGakBgzOd9q5by9rf5qFdXeHm5wKDGcRAA5SWgnkb0PBm1jiHU5L09mQ87WpMQwaFVGFYS1n5QLM6N0luLaIpOXawd8rULIB5pWdgy1atNRQZgobs+U4Xkn6ce9DcMz6hO6jBisa50qLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471721; c=relaxed/simple;
	bh=WFYUbTN5+acb79bEkEGDIpCA/Buv7HeWi4P+yeUW2zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPoEdTW9Uxjjcp+rdbJ/UdChG4KtR1mwNsw8H04914PvLa+HkfZ0AOIhXnuoLoazvwWO/wIkbaB225ALlWo7Qh3yCfa6Y2QwRN7AIBDbXRz3BkUB4PQribFaJZw/10OvI2DqH/Z6iSv+ORSiDgbN36aIdq17Fxd8WwccW7Rksu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdnJxQ+t; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdnJxQ+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772471720; x=1804007720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFYUbTN5+acb79bEkEGDIpCA/Buv7HeWi4P+yeUW2zc=;
  b=SdnJxQ+t70+c91hNgaZHwduDLZpMU6ZA2tvxbbJneJxUEwBHqS3BdBJP
   XOf1WZwoo1MP7Q/xSJ8W42RJekM1a+dsBZlhvlA6hA/huYAhitla1ZSCx
   iYL6xRNlYzk8L1W15oeZCbGWHEnIRTz67H0EjRCDI5/03THWgkmAPXob9
   YHiHrfHDlzizVSRfLtJU2D2wyjz8QMipe70vU+GAJ9R+66lXVZssCPqU+
   pBIKiwElpIRe1PL0SCJ4i0vXy2FiPV0rTO/JiSPJ2Pb6ulCHnAkS9iP8K
   bC/dcN+E1Xy67w8RXaYA2+Abdqkm7xCmt4keJBZZThwcZl5AYx7Cz5ehX
   w==;
X-CSE-ConnectionGUID: OhJfkiSKSsK3Qogz4tsDSg==
X-CSE-MsgGUID: hBqf8+hLSK+wu+byexphtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="96101542"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="96101542"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 09:15:19 -0800
X-CSE-ConnectionGUID: wfKpcBoETDK9d+XYV8jq5w==
X-CSE-MsgGUID: LRr3k11hRDe1gwjybl99Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="221861491"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 09:15:17 -0800
Date: Mon, 2 Mar 2026 19:15:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Drop redundant error message
Message-ID: <aaXFopIcpsWGjzX7@ashevche-desk.local>
References: <20260303-ti-ads1119-2-v1-1-19d31e69ec7c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-ti-ads1119-2-v1-1-19d31e69ec7c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 03, 2026 at 01:07:29AM +0800, Felix Gu wrote:
> devm_request_threaded_irq already prints an error message when failure,
> so the error message is redundant, drop it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


