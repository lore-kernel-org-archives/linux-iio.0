Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E82D238F;
	Tue,  5 May 2026 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971221; cv=none; b=Ng5cL9bVyvVByT8vToC/t3zAuTPFx3b42pNEcaAvFv+dU9L8VbrTpQzqh+Y8ju6LwjiuWEhov3T9RZFXl2EFzEwYdg17kZS9JTEKZK4O4xKWEFtRQYSZdMxdsgzZ6zOUF1eMpIiAlGBsG6qp3Z1fGpSTDj/hj3QTihWZUoiuVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971221; c=relaxed/simple;
	bh=AoNkdMNTl4T7zUfVwEWtfosV/ahHssB0qVckJHfaHtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig1Oq11zpBlFwXukQtK/2YgorNoCjignXSiNz57btqQBghQYNl4wLHTCyeVAEJw3Dm8Zh/iEqUjoATrBMHG9v8cn3yZbSYY6R4j0eJg9lAh7vmKcNRuXQDi9ZoJ1SXbKsPeCjW4r3IbrgSWo9Y3DkoZMcinhl8acgv7vEAC+riU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rn6fZQh+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rn6fZQh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777971220; x=1809507220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AoNkdMNTl4T7zUfVwEWtfosV/ahHssB0qVckJHfaHtI=;
  b=Rn6fZQh+qZZB+C54+szQff+xFqnDK9aCQsggUW387wH/KGExFmgyh5+C
   sEjjdO7kQ312ZANXoj8Aa+KrTR8rvCfYooCM12UlrKidHz2gxnjCP4S0I
   P9m1hBZz6ulFqY3Mk5U8/dwK9R3I/HYMrHQX08xAz58pyLRhAePvHoyEs
   FRsNgaIm+DVffAlmrC7Q+6aoKrQfIlKxQUAH2dH8kYwJFlR4K77erG9TK
   tpqqsHmRBXcUfqBfIlYVLAJUDVf/QHuPLpJFnJUDi+UGgXYdUWn3hD7+h
   T/s+qtBwylru3SbuG9Qw/f3SZAFLeTwVyGmCUdNj8DNsIW3TbFqXYt+xi
   A==;
X-CSE-ConnectionGUID: zEVAFTSaQpGtlNU5Iv4kHQ==
X-CSE-MsgGUID: tAbMiScXTtmIOq6Vn3zXuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78827390"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78827390"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:53:39 -0700
X-CSE-ConnectionGUID: qdUlhcSLSvyOLyKUKxQJmA==
X-CSE-MsgGUID: xnQrS45RRKCfJZGXjucq6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="232616324"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:53:36 -0700
Date: Tue, 5 May 2026 11:53:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Wang Zihan <jiyu03@qq.com>
Cc: jic23@kernel.org, corbet@lwn.net, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adxl313: fix typos in documentation
Message-ID: <afmwDuq8txfxiWuN@ashevche-desk.local>
References: <tencent_5B3B9283E67523E3CBF9150AEE7AD002AE07@qq.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5B3B9283E67523E3CBF9150AEE7AD002AE07@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 09:49:17AM +0800, Wang Zihan wrote:
> Add missing space in "ADXL313is" and improve grammar for
> "a single types of channels" to "multiple channels of a single type"
> as suggested by Jonathan Cameron.

...

> -The ADXL313 driver offers data for a single types of channels, the table below
> -shows the measurement units for the processed value, which are defined by the
> +The ADXL313 driver offers data for multiple channels of a single type.
> +The table below shows the measurement units for the processed value, which are defined by the

It's now too long, wrap it.

-- 
With Best Regards,
Andy Shevchenko


