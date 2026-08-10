Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047B3546CA;
	Mon, 10 Aug 2026 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391254; cv=none; b=ZSRdiTGXNjhqS+IVERYtddciU/AuBnYQJLO1SK+03yNWt94Cn+AictBNPgEYHCQvU/9W9wwNH78iQJRy8G46/Q4g8DoKAeR4BBsA/Ika14Dm+Qj2Kp0k6TxBaE7r28O61AGGYT04fg7whKTcbtynw2jHWs8JzvIUHLj1hgTY/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391254; c=relaxed/simple;
	bh=uinQjx8mKrLZkjv/OOe+DZGFi1HszA8AlSeGoPz8RY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i89cnxdtp3V3NgJInoBBKO/g1eJPQaZtrFQZz0mR4ghOuCJqlKVYOtNXpUimXfSK+jQDWMtf69ACBntev4tHIozXw0FtZ8o/VczSC/dpnvLHLPAWDigD62jMzu2BiscpA/TpDsX9cnG7vvDAjHDHADyauwlSNNWDQJVPoGIBJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekJVAzFi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekJVAzFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786391252; x=1817927252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uinQjx8mKrLZkjv/OOe+DZGFi1HszA8AlSeGoPz8RY0=;
  b=ekJVAzFiZobUq37vNtgm77isvfjUf6xLW+CzVmucihfNgpHQY2k6G42s
   v27dZXIddN+5kFyAISqon7OT5t2rS9E+0a30BpKaDDD/JcPi0YTv5PJ/B
   OLO0htO21hbzpedDxgnkXzRNcapzZIlBTNOMyzwSxMD8b50FOxjJLlBiP
   ruLWCRVnJwHAeFwLHXsLIzl5jZbTriamUFA7nOuJlo4ibGQE0OYDgYHeY
   qnsElobpaqKPOOK7Jo3HJH1ZnDkVFnCCIvZzaHLvfdL4XsBLrDVcvPs6E
   MChQTpfcvd+1l86UxpO4Z6iOwXcsSyObGqF8ld+IbYytNLTRqJ6IWe3qC
   Q==;
X-CSE-ConnectionGUID: MNL+CSM0Q6St3streJ8eOQ==
X-CSE-MsgGUID: 7hcCTUbDSGKj5KgQOmP4nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98276487"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="98276487"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:47:25 -0700
X-CSE-ConnectionGUID: xyED+ZblSZ2XYpVtCPQqJw==
X-CSE-MsgGUID: nPmC/GfPRBKLYnM/jXXVSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259282230"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:47:22 -0700
Date: Mon, 10 Aug 2026 22:47:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: accel: mma8452: Optimize struct mm8452_data
 member orders
Message-ID: <anoqyA_nok6AfGFT@ashevche-desk.local>
References: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
 <20260805-mma8452-open-drain-v3-2-6149f406a409@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-mma8452-open-drain-v3-2-6149f406a409@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 05, 2026 at 09:21:36AM +0200, Esben Haabendal wrote:
> Reorder struct mma8452_data members to avoid holes.

Would be nice to have before and after `pahole` (only few lines) summary.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


