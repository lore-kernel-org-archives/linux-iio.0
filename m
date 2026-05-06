Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAE175A6E;
	Wed,  6 May 2026 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055473; cv=none; b=RDPCUhs7jd141vk87rfgXz+QX+mG7KyzHLUdHLo/VPnPXyOVa+wE7p6w+QYzgv0ClQ4HYbz/adjzalsIIn3h8IsfRRtf7hRFBAaoROBf5zpkeIHXa7FbVOVLQh08PKrjUJuZmCfz1ae44YA8UjaWsnAkCFJpDoPPtMA5c4OS6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055473; c=relaxed/simple;
	bh=hkPOo8tgnWae47NVOD1ShCMTWm/tPOC9bRlEdta+aaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLIDxaai4yaev47UW0GvAhrFYFysXzJCKe79Pzxc3XqIc4JwenEi5meEL9Vy4gea3L+KvYNixwlRn6YoI5axTjRHaoHNH1eXKveTn/yD5V8yj5NUA0qgswQzarS1Sk2Mz4XoZcmE340uH37qh+OH+uz0cbJDfcQ231vL2tnfP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4dB2VLC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4dB2VLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778055472; x=1809591472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hkPOo8tgnWae47NVOD1ShCMTWm/tPOC9bRlEdta+aaQ=;
  b=S4dB2VLC5x9CVqu0OowMvcljwKMbEtrZ5gNduNAIz3IJ8caHRWHQ62GN
   Kd6HxwTas/c34hDcVtB4r0GqD+hQbi/KsiOsaGWAr9KUnIJQVTnRvPwhu
   +6Ots2IkQv9KbnD2/ItZJzj2V1E6Sm+p96RGLFFIn68mpCZuQ9fJXEH8K
   z/TeIk2jslXrheFhlya1ESzCWQePFgzmrMjSSpwubZl2qJnYxXLMI5yr3
   cFiC1bq/ojrW8keHu9nBxeP5FZjaRTUYQuEj9hs0GUhId4EYvEeLvQW4R
   vp7rmTkXSDEcqvskzoadE/Yi66s6mMraJlRTnQ6F94dhQZ+MjcENWuCK0
   Q==;
X-CSE-ConnectionGUID: 5klYO3CUS5+GMEB4YhmazQ==
X-CSE-MsgGUID: PIqefJHTRv2yAuRclgvSIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82846785"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82846785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:17:51 -0700
X-CSE-ConnectionGUID: a2XO9Zd8TUC3fAzfSCJ9tg==
X-CSE-MsgGUID: SJAAfa4nRCW7EGzXPGb69w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="240058735"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:17:50 -0700
Date: Wed, 6 May 2026 11:17:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: lmp91000: fix probe order and cleanup paths
Message-ID: <afr5K9aEfOKUJm4Z@ashevche-desk.local>
References: <20260505194624.98520-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505194624.98520-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 08:46:24PM +0100, Salah Triki wrote:
> Fix the initialization order in lmp91000_probe where the immutable trigger

lmp91000_probe()

> is set before data->cb_buffer is initialized, which would cause a NULL
> pointer dereference.
> 
> Also, correct the cleanup labels in the error path to properly unregister
> the trigger before performing the triggered buffer cleanup, following the
> standard LIFO (Last-In-First-Out) resource release order.

...

> +	data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb,
> +						 indio_dev);

I would go with a single line here.

> +

Despite being in the original code, please drop this unneeded blank line.

> +	if (IS_ERR(data->cb_buffer)) {
> +		if (PTR_ERR(data->cb_buffer) == -ENODEV)
> +			ret = -EPROBE_DEFER;
> +		else
> +			ret = PTR_ERR(data->cb_buffer);
> +
> +		goto error_unreg_buffer;
> +	}

-- 
With Best Regards,
Andy Shevchenko


