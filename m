Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61F3E765A;
	Mon, 12 Oct 2026 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840216; cv=none; b=UmdGBOyzGrHYhEeRwia25s41cQOHfqRzFm8ngeoenQFTRs0Sp4+MzAea8Nml+4S5Z6l96w30XhvIfZyaaAsz5fd0Zr5AFQGTa+2RL1QR+YuyWO2u79dTtCikX5mS2bK37MpO1UfZ2gsouVM2D0Uk+nkZbDPfccm9LxLdk6lqiMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840216; c=relaxed/simple;
	bh=KUczX4jpK558q6RHAa5mchMozzm+YhrdXtyOjC6D/NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/K04z7wZY0i/8ilnQuMfmVvEKMGJjXMsYp/j3NknMJIRAkW9wgtBjTg4zCMn8v+0kuIrrVoMbiJHB4b5YCZkipYtwIKb9jnROtcpcDpcw0kQoiYThHxVDcWCuRaeVq0iqvZ1k48+RmuUfJ2IuaOVsCs3dyFbqYdJN0sBx1MmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VB2Mk1gh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VB2Mk1gh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791840215; x=1823376215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KUczX4jpK558q6RHAa5mchMozzm+YhrdXtyOjC6D/NY=;
  b=VB2Mk1ghodwari4COSMmf1IoWwFhKmquyh3HFpNwFbmTeiRwAiYi+Fga
   jQxkETy9z3bOrjhN7WXLWspmj8SSkADuFMLiRvCSRu9R0MInFIl25nGat
   pABoFueGXbd2zsQmpcVOUDB0fTZiDSX9Myjr7v0c/NlKC+vvOjlSVqqHK
   5r/JgsONK9YjFH1Q3csW7bm0hmchtClHyAMN0zt4BBrV462xe/ALkkb5u
   Y+kdwZT71fy8xWh+piC3eiBDMO9FROmfIJB4Qh1j4VlJIBZ4BjDgZQtUH
   xLaO5+JH0zb2JWarZ9BaA3aPyz2R10m42eQSGSwqwl8p4ckBNJg+alMvr
   A==;
X-CSE-ConnectionGUID: K6aV3dj0QkGzKdfa+aUF3A==
X-CSE-MsgGUID: taKGQrhiRPeMMH4E8+8Tfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="552684"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="552684"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:23:34 -0700
X-CSE-ConnectionGUID: cFDH0kpTT1u4IMi7il/Idg==
X-CSE-MsgGUID: 387CSCXqRfCplcYH0JhEEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="2749081"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:23:32 -0700
Date: Tue, 13 Oct 2026 00:23:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: and.amer@gmail.com
Cc: Peter Rosin <peda@lysator.liu.se>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: afe: rescale: always expose offset
Message-ID: <as1P0ipISgbFztGo@ashevche-desk.local>
References: <20261012-iio-rescale-offset-v1-1-14ed15979ff2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-iio-rescale-offset-v1-1-14ed15979ff2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 10:28:53AM +0200, Andrea Amer via B4 Relay wrote:

> A rescale channel advertises IIO_CHAN_INFO_OFFSET only when its own
> offset is non-zero. A child rescale therefore hides a source offset,
> and consumers apply raw * scale and drop it. rescale_read_raw() already
> folds the source offset in, so expose the attribute in every case.

...

>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_SCALE);
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_OFFSET);

Make it less churn by not changing line for _SCALE.

-- 
With Best Regards,
Andy Shevchenko


