Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2D1E98E3;
	Thu,  2 Apr 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118014; cv=none; b=aTCllQb96JRrcRx8Q+bxiNTFsyVXzOUF3qfSRdtc6tVtw8LkLJtyOmGmpv17E1mOiRGQuGnuU7XA6r0fIe91Dh2yiJ+MUTejNpvdbgLn8Xbf2sfqAfX9Rl16yC0mOAm/ex5KewsIQ268ZLrU3mPOTQ9R6lKMiX5WVurtEhNLkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118014; c=relaxed/simple;
	bh=lHW0CKlh/b2ueG3jqhemgQzCjDgV/9qh2vFUfRX5aZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMPhu5A0HjhtHfmMonTjf0BN6isthlH5aVnJOAHMRRYIAKrCNma/cqt+DqPeS3bKsixlgagF3QUI0jOZ1OgS8bQkgtpez4OJUekDKnmeeOGNtBI/+jDeALmaoOjQHmMAuyhKcvGS5O98cUzDKFS5mTe3BGmEYaL/tNQBWEx79qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFsHXNG8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFsHXNG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775118013; x=1806654013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lHW0CKlh/b2ueG3jqhemgQzCjDgV/9qh2vFUfRX5aZQ=;
  b=MFsHXNG8RBQKYfA7ctpXGcc7gy2ugnb8axYk0nIz5ds0wx2eHJw7AW6f
   i2tN7+TZo1pNY/eMK8rU4pr66JVqdyIYm8L7XzHKe7M2EtGwDrTkn/dv7
   LySebJtJ10f7NAWZG0fhgTRDvbYxo/FMQ/TNFUj5RPF/NIeY/zZ8CkYVK
   UizqNe3VeCDda23SIJgwj55iL7L0/pvZz5bZc1HFJ0K/aQXyzWcmOw29m
   Fo+4DJYvepJvzDA57WsSx1XNfEsZjUfzBFAy06/tPcuMofG67WwPfzx9i
   o2N2pA+miGegMR02uPp+iBFxi8826qwbd8CMrtTDQfVxBGCwGrc2q3djY
   A==;
X-CSE-ConnectionGUID: nHITwzNER9umv4dNcB38OA==
X-CSE-MsgGUID: iu9wtBx5Rvqc5bpP/ze/tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75209743"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75209743"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:20:08 -0700
X-CSE-ConnectionGUID: WXlWnL07Q8K/pILKqCHnEw==
X-CSE-MsgGUID: 2HD5IKcLQIqXwsIg3SPAgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="264850697"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:20:06 -0700
Date: Thu, 2 Apr 2026 11:20:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: light: vcnl4000: register an IIO device with a
 device-managed function
Message-ID: <ac4mtHHvS_k9xCAI@ashevche-desk.local>
References: <20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com>
 <20260401-vcnl4000-drop-enum-v1-3-ffd201f0c848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-vcnl4000-drop-enum-v1-3-ffd201f0c848@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 01, 2026 at 02:22:38PM +0300, Erikas Bitovtas wrote:
> Use a device-managed counterpart of iio_device_register() and remove the
> redundant iio_device_unregister() call in driver remove function.

...

> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret < 0)
>  		goto fail_poweroff;

^^^^ This goto is sign of a still existing ordering issue. so this patch is half-baked.

-- 
With Best Regards,
Andy Shevchenko


