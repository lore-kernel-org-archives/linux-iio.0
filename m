Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445863FAE11;
	Wed, 10 Jun 2026 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089019; cv=none; b=tc+iXS6NzqDd0W5l9MDI+PXjGg1B0w5obtrJ5s7g2kBQPvi09UGI0dzoc0ey5JFwtEX/WHY+sGqWAQUZsR4D6HZBakHv/ZlycNJ1ydm2T9oBV0Ke4TswGpmFmyZAYzl333rRzYm9RoDYqvT1EgVZ7IHsPAOLM3TIfbDYlam71UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089019; c=relaxed/simple;
	bh=U/cHFGZpCrUfnA17UtOqaUwDem4mMSP2UVMOp+D1ln4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lprQGUDHMT1K3qFFLVk0uqfEUdNUNQxq1zb+N49pAl48J8D0LoNrdZrQtzPyCXcb8IBcBtIPrJJasYv4Lk5qgKe9tMq0f6Ry53CZqRutJHo75huaBealuVeIw9PGKH3iyYECjn6y2cQ2dG8wESoqMxcx8rEnDwuw358ULel2imE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+kgQOWE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+kgQOWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781089015; x=1812625015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U/cHFGZpCrUfnA17UtOqaUwDem4mMSP2UVMOp+D1ln4=;
  b=O+kgQOWETGwvWwSpVSJhO7lzVUNx6D2VRqc2UbDYqw55cwaxB8ozDtiG
   LxyINFWbjilzGe+j1meyBRRbidUVpoSilNrwK4e1sjjUS2Skp/A+ddtB8
   QaRvzkEGM9V75c7GtiW0H6p7CFtVbn7pgjkte1CkLfVo43YhNf/80q9Df
   14Z7Wpb/YOY1j3EqPVC18MTNhCEu4Vp3AEZBaX42bYsvIuP2ZTed9d2Vo
   nISUCzGffvQXFqdiTc71VdSydc3C43faBn+QN+X8W3OQhYlJxe+RNk/EP
   jQWfKcktrHhsn9hnWWd404kv0YTpshJgJVwu5lRXkK6iK9l3VX+lduHbH
   w==;
X-CSE-ConnectionGUID: Taotj1nIR6quu/E2Zs4AJw==
X-CSE-MsgGUID: ovAOKy8NRSeoG5QJjRgSgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81727035"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81727035"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:56:54 -0700
X-CSE-ConnectionGUID: mGK5qcDETcWUOIfZImK6bQ==
X-CSE-MsgGUID: IoQ0sTyCTcGJW91RnLWTPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="269822075"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:56:52 -0700
Date: Wed, 10 Jun 2026 13:56:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
Message-ID: <ailC8uhCen4dQNF_@ashevche-desk.local>
References: <20260610042418.90308-1-dennylin0707@gmail.com>
 <20260610042418.90308-3-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610042418.90308-3-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:24:18AM +0000, Hungyu Lin wrote:
> Replace open-coded bitfield operations with FIELD_PREP() and
> FIELD_GET() helpers where appropriate.
> 
> Also simplify bmc150_magn_set_odr() by returning directly from
> the matching table entry.

...

> -	odr_val = (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR;
> +
> +	odr_val = FIELD_GET(BMC150_MAGN_MASK_ODR, reg_val);

Same comment as per previous few versions. I don't understand why you haven't
addressed it. Did I miss your reply on this?

-- 
With Best Regards,
Andy Shevchenko


