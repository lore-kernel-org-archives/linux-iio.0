Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6363ACA6F;
	Fri, 11 Sep 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114816; cv=none; b=IjgduLGuyMplakbQ3bBCD5rGMEaF4FxM3j77uYXxg5D3nVT1l0pGHp4pB850cl3+6XEmQNc2npQ1+SyuCVMG/aN6Z4VxhXaqzyfJWuLk+cG8pKfK+fN/ihDCer1SXUXQbW9Ca3QrSIFYr1itARAXXbLQEPjfnp6nx279bxeX95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114816; c=relaxed/simple;
	bh=/zA56y1fvAgdywhnNAXTuxycLUscsg/29D14NK7JluM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJTq1goXG/XgtIx/2tkjupZ08yuxjxeuJCjgiBs+l3+UrcJvha+A6irFSkMe3l2wSEqrZpXMXrWaD7iSWJhfJneLu8Ph+mARheLusTMNJO8HWDgwkp4uLvy5q0BH/7AwUH1WLSjnVUijvySVqdoCVyj8sUICD4PViwP1lLjJ6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JN9nrM9f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JN9nrM9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789114815; x=1820650815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/zA56y1fvAgdywhnNAXTuxycLUscsg/29D14NK7JluM=;
  b=JN9nrM9fOYfiW+OaQuhh0wqQJC0WUFpcQ4OoVCX5PCQAMqpDqsAt3k5C
   8trc3hZkJU2G1vseEwE3WC4TaKiJ4bdA+kNKodtTxO0leGtcEEBznegDN
   AHvTvbOaAVfNB/uZJKHJd4iLFkTH8Moc0l2pjc/mVT15l0sdDKT/6bsiN
   PtK3jEtvmJadQuZGvgkYhOqOHQatlh0PQyRcjfW1OGWXfr5DYW1cqfjss
   cF1kYlWd3XeoD9US8eNQr20PGpT0l4PZAvq0YJrM/J8VSfEgdQ9yIdkmI
   U0DOMucu/+cjvcX6ZhLiW/kzLshFhpbeH+Q4gnxj3N+Oh6z5dMm+FoPxV
   A==;
X-CSE-ConnectionGUID: Uwf8Dms/T8mhCU133nBgwQ==
X-CSE-MsgGUID: drRTr4fpRgKIrauA/OcbhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="92085937"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="92085937"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:20:14 -0700
X-CSE-ConnectionGUID: 6fVBvY35SbCKOAXIMBobbw==
X-CSE-MsgGUID: Z4MAMKiKRbum2+sO/EfJfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="295339356"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:20:09 -0700
Date: Fri, 11 Sep 2026 11:20:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v7 06/17] iio: adc: ad7768: Validate master clock rate
Message-ID: <aqO5tjtQsPB47Y75@ashevche-desk.local>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
 <20260910-ad7768-driver-v7-6-7f70b07627e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-ad7768-driver-v7-6-7f70b07627e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 07:36:24PM +0200, Janani Sunil wrote:
> Reject master clock rates outside the limits specified by the device.
> External CMOS and LVDS clocks support 1.15 MHz to 34 MHz, while a
> crystal requires 8 MHz to 34 MHz.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


