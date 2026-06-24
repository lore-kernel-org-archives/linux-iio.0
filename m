Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6D12C534;
	Wed, 24 Jun 2026 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299427; cv=none; b=hI4dY7ooMw4DIFck5t00TXUtlOmJfsK4wXdf3aku6G5C7dTA/jGi+5baRZ32vCUNDLNV3LTWeOsmBgDcBjKzN99PxNzcnGNriVYkPaHSmVNE74vbKWKUARjvPcmEIlHFqVnxeg7bXjuMamqTn+sIt3OKd9eaCSFyyMtrko3inE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299427; c=relaxed/simple;
	bh=OQW+QNxMNH7lIKb8i2cDF/KHWOI5CpORL0BtX8KUEos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqqZIIQev5J2z/U6fOWqSwgJwIZf5bWW87B7K7fOaY9Uq4AdK3803FRYcGSwXumTBaFTMrHpPQJjSj10y9ACoE2CFFs19SHdg1xxfKUW37mW1hxt3kbayv3pNJvdjT0PNY3QO0fbmAJQT9IunILC93Kvohy6xYes+y2xvCbBv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHnlJHpr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHnlJHpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782299426; x=1813835426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OQW+QNxMNH7lIKb8i2cDF/KHWOI5CpORL0BtX8KUEos=;
  b=DHnlJHprOzQmdLtcDLXay3kvX3Lt4yxU5GN8J+4UBwYOKnKmKBOZqnYO
   SNrg/x45iwtlMkMkXty021Th1mS1kupeTtyfHdDl5V23itGacVgO+Xf+h
   XdiRi15V7lyCLeG2qsnhCkUhKN3+LxZg8DtGlcdtbbRnL84VuQOCXpwi5
   eip5aog8nKuMHb8ixGUEMLIlQ/HiNtAL5MUG62/+iS6Xl2maHgax9162c
   Q7qKbuc7KWe4WWbcTJetIMlvKXs++OHkNKy5tN6qA/KFcduAH1z/a3poK
   n1cTgUdzJkNaEtyfVoPMU9NBN6JJzO62nGA0f2j8Xc02DSSWSgb7q6Uk8
   A==;
X-CSE-ConnectionGUID: dyEpmbLgRL6stWOzorPAVA==
X-CSE-MsgGUID: 2Yp3uKa0RyKg6Gqw/Fhpiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82827478"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="82827478"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:10:25 -0700
X-CSE-ConnectionGUID: Tleb+pMgQ0q3x25e7PXIog==
X-CSE-MsgGUID: kqV70I/WTkiq0lDRhGXamw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="254786460"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:10:23 -0700
Date: Wed, 24 Jun 2026 14:10:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads124s08: Return reset failures
Message-ID: <aju7HbkcRBr9zcH9@ashevche-desk.local>
References: <20260624055325.32388-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624055325.32388-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 01:53:25PM +0800, Pengpeng Hou wrote:
> devm_gpiod_get_optional() returns NULL when the optional GPIO is absent,
> but returns an ERR_PTR when the provider lookup fails.  Probe currently
> logs the ERR_PTR case and keeps the error pointer in reset_gpio.
> 
> Later ads124s_reset() treats any non-NULL reset_gpio as valid and passes
> it to gpiod_set_value_cansleep().  Return the lookup error instead of
> retaining the ERR_PTR.
> 
> Also return ads124s_reset() failures so probe does not register the IIO
> device after either the GPIO reset path or the software reset command
> failed.

Not sure about the latter, but the GPIO case should mention deferral probe and
hence it needs a Fixes tag.

-- 
With Best Regards,
Andy Shevchenko


