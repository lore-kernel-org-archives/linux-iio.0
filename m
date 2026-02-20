Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AD34C12B;
	Fri, 20 Feb 2026 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596849; cv=none; b=rYgQ7nOjKTXI+MVfkxEnMKnXypI78KdDC7NeKqZgH1dyP/s5ggmnzn1SZS1rhbaGyUuoii6T9Ol1Gniq49YHPPN/50Pn9ZoDPJd22mzWXUXLdGgZCYQxL0NTJtAvqC0VxrbPnQT+i//nEYUyRuPInhu70E6z0AhovhgkIeq05To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596849; c=relaxed/simple;
	bh=yhDyiIKVfrMKyZHvZ2VsvHhUIGmvKGJAGyXX8UzwRB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKbis6KxDSijcJmOUU5I/vYvGc1ujMP88/N0wJwia3v6OqepaNFokmkKvWAFiVAlmyUpyasTrcvqasfyMBeO/xFfFrQZypDVR0PxabsjRdAfK0ZRO2UUUV5SrtEfUnsXoSdiMtz/27k0U7o0GDcJmtf7JJX8sRg/Ot3gs0hpfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmtlvZ4v; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmtlvZ4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771596849; x=1803132849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yhDyiIKVfrMKyZHvZ2VsvHhUIGmvKGJAGyXX8UzwRB0=;
  b=AmtlvZ4vCpFNoZ7mwW1oW/zMG44EFuCNVq2Zpjn89EDCkXH0dA1fqto5
   Yw72mvo3V0Ndvki6uF/ySkgp3ucyrrc8cVB+PrFiah8Be9JUjfdM+YA3C
   0iDN7x9yMUUyILlbGYF6t8864SWW2/muXt+skbmh0mw52gCglC2bm5tzI
   BA2GFqXC0F6HXA3gt0CHu1TZ7WOCKgQ4C5c8bEUzk8TRk47RGzIRIAdhR
   sFwEgDuEO0hTAS+jRSFlei3ptrvLmUhuOMCJHT8AMTpaXaPujWD/fNZxA
   X7Ulz/0tb08l16R1GiBSc6R5jYF8aEQdsi8FG3M+Ne7oCs6QrSx+faDd6
   A==;
X-CSE-ConnectionGUID: buVMI/c4TdimGELCCluMrA==
X-CSE-MsgGUID: cgN4PrSUSpmO6ADy+68WOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72731302"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72731302"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:14:08 -0800
X-CSE-ConnectionGUID: NcYskI7yR3+ZmyNFGSu/mQ==
X-CSE-MsgGUID: 6IFziOU+RluidlfuzoiCnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="218994987"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:14:06 -0800
Date: Fri, 20 Feb 2026 16:14:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: filter: admv8818: remove redundant else after
 return
Message-ID: <aZhsKwYr0ugd4lI6@smile.fi.intel.com>
References: <20260220133337.85216-1-antoniu.miclaus@analog.com>
 <20260220133337.85216-6-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220133337.85216-6-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:33:34PM +0200, Antoniu Miclaus wrote:
> The else in admv8818_init() is unnecessary since the if block already
> returns after calling admv8818_rfin_band_select() when clkin is present.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


