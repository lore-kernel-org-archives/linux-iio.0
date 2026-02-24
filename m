Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F325372B32;
	Tue, 24 Feb 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927509; cv=none; b=nftKPBJCyd65q43xiCYK/EZvbCZkvKbJd0t2fTNEVv09JcxffPJRFF5hCSv7jXkyQSky7FrAOOmyuor9QNky0Xu1hNCErlJzZp5t/VlpFqImJqAcSNKgCMDicA/M4RUW/IJ6e5Z2cwS+pgeWXnUnsq1akS7643KuwhsCvZ6Pm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927509; c=relaxed/simple;
	bh=iyW2B8JA942odpp1ocGGejLay0tcDvx1XWrIXavAHLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ9F5KZ58L2G+SOhGywZXPQTpJ1AONJGxL1B5DQedHVI8QLyOxwVXVi2yR+0kPVNbwOdMnevt92ygkwNLHenuwEgmW8j6P/xy3bNSb9ERFl0mxzHXEObjyy5WT/MvFNIhEV7VFQC1gzFWqSpVp2BOc1gx28VEfxXgedImmArbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzORQMT7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzORQMT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771927508; x=1803463508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iyW2B8JA942odpp1ocGGejLay0tcDvx1XWrIXavAHLc=;
  b=MzORQMT7+7CtkjSZeBDxzeXfSx8p9+z+Byq2Wtrwz2LLWtx9d2DsRM+D
   5yQQwpvT+t+TvkATcMt62TJuWDQc+7iEtCUyCuQiG9+5aGASw73SxSeJT
   e1YCr+31kfvvkXyKNCGPvVnGRIxCFWzY6HpOX5kHdaC+bnQU2Hjoi/I8A
   OWxo+C9W/mlwCjB3mQHSz/NIQ5Ed4IBJ3AMYds6NvCR3VAGzt7uf+/TIx
   MISZ/tTfviFbW6Gx7EoCNXqO+Eah9RMDWbfiI86CQZ+ZxEm30dJl1oHWY
   nEVzRDUw8cAOntGlhpVEYIu5ri5Fq4iiVXSfAY3Aj26ICj1U/mv4757hX
   A==;
X-CSE-ConnectionGUID: jbNJh1bqS/yyUdvThxAxkQ==
X-CSE-MsgGUID: mUs2Wwo3S0aECak+iUG8cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72910894"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72910894"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:05:08 -0800
X-CSE-ConnectionGUID: BL4iOq18SAinVh97B0KqvQ==
X-CSE-MsgGUID: E1OGFn2DR5m8owIQdoJfGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="213132455"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:05:05 -0800
Date: Tue, 24 Feb 2026 12:05:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: gyro: mpu3050: Move iio_device_register() to
 correct location
Message-ID: <aZ13z8QCVAGmTEV7@smile.fi.intel.com>
References: <20260224023511.274038-1-ethantidmore06@gmail.com>
 <20260224023511.274038-4-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224023511.274038-4-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 08:35:10PM -0600, Ethan Tidmore wrote:
> iio_device_register() should be at the end of the probe function to
> prevent race conditions.
> 
> Place iio_device_register() at end of probe function and place

at the end

> iio_device_unregister() accordingly.

...

> @@ -1231,6 +1225,7 @@ int mpu3050_common_probe(struct device *dev,
>  		ret = mpu3050_trigger_probe(indio_dev, irq);
>  		if (ret)
>  			dev_err(dev, "failed to register trigger\n");
> +
>  	}
>  
>  	/* Enable runtime PM */

Stray change.

-- 
With Best Regards,
Andy Shevchenko


