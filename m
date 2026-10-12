Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D42BFC7B;
	Mon, 12 Oct 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839970; cv=none; b=tlfvYnIl10ndnd/UVuoBJI3ysufWSwdg1uRJdxENzwqTOTsJWRWRHTn1d2RHLfiMEWqP9uHlOQrv06UD3A1hvqkqJxmnuY5W6X8F9+bHzZuEYw6yDMFFGSXNpXXHS9CyeYSa9faD48K/2f85k/jPp9P0yRjCYolKyE0vCHldECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839970; c=relaxed/simple;
	bh=e65YEVn51bit6H6IUDBgpIfn0iLdlP8g1/U272AdULg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2EG3tgkiZFUckFb9789QOrwfinq5H7IFpVB71q/n/x5TyUnTYoDvjalvLvzfSEZ6N9aropK58gxC376wpqgjjFOZesLfxsS+JdiqSHplHPtz17YLYr5K2St1Kh8GBruqyBcU8Cq1FdWKJsFqMf3JWPGlldruIaQ3te/kN/gRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJp722XR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJp722XR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791839969; x=1823375969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e65YEVn51bit6H6IUDBgpIfn0iLdlP8g1/U272AdULg=;
  b=mJp722XR95FPMftKn6rM/N0ZB/YCU6UIVu2OpMMcTU/tN9N7Zj8e7vpD
   Zy51zSPeB0SII/Gt91VlVvk6A0iQUdaesXxMjz3kI3NlZVB97FsYtvLa3
   etiHEkeK69MsPqA/eLrg4uxTwJNp32MADshdLpYXuDTHXCubpVIy1Q6mY
   cA8zURCyfpBnD4YvaI9Tvb2UwDi28AmWdrJ4xi4vtQSU9YXAr4+IqR/Wk
   ZEw4ZXD5SjgW5aeT1qk4FtEgUTbZbSRfbuLyGoibmyTr64k+1gMOus0XR
   Gleqdjcz47O2an6taYQ4Y/5a05NND3Leld27lrTTtP/kfE6OXY21uhp5v
   Q==;
X-CSE-ConnectionGUID: /hOyh5NKTOy9EBkUBU4bng==
X-CSE-MsgGUID: KcbQag7iReic6/i1QjZjBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="435926"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="435926"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:19:29 -0700
X-CSE-ConnectionGUID: oUbowdnuR0mhF9Th+myUjQ==
X-CSE-MsgGUID: pNCUC0+ZRxWrMtmNsE74gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="2766590"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:19:26 -0700
Date: Tue, 13 Oct 2026 00:19:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux@analog.com, linux-kernel@vger.kernel.org, jan.sun97@gmail.com
Subject: Re: [PATCH] iio: dac: ad5529r: Clean up definitions and regmap
 configuration
Message-ID: <as1O24cxJRhcSmPO@ashevche-desk.local>
References: <20261008-ad5529r-review-followup-v1-1-84a98e0e27eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-ad5529r-review-followup-v1-1-84a98e0e27eb@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 08, 2026 at 11:19:15AM +0200, Janani Sunil wrote:
> Use fixed width register literals matching the device's register address
> width. Rely on SPI regmap's default read flag instead of specifying the
> same value explicitly, and remove parentheses around the channel
> initializer.

It sounds like a three patches, but I don't care much (up to Jonathan)
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


