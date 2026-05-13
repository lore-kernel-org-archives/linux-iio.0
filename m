Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F13B7B9E;
	Wed, 13 May 2026 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669637; cv=none; b=jjp/kDZ3MV1xma6bmOyG2tSatTtL4iyDLqu5ih3fJM+f/77wJYgi1tkERfQ+vt5/JJj1h+9kMNUypig8neixSULewIFNG4G27CHCFpH5JipKczchCGv/pW5PhEY/qSEGWuITByBORMX1Rcnv5S7qdaE8lgwk7+7lSXQLLg2E7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669637; c=relaxed/simple;
	bh=1AxrIZee8mUjA5ewU8xipjThvn2WeWg0jk/1WI0ykVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmRJf3tBR6VYK2+zoM5tsqn1lVapkcbHMQks4Sw4YW2RoHUuSfyc0V3tf/s4n3m/zLCwBQP6lImYppgtwu1QnNhRUIXdMedEY4IYsckubNpFiLsPtrUCywF1i5LuvfYvJ6n3APj6+ZCRnTw+ErmWkKbI2KhgygOkYuFSPKpAs8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQddftd3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQddftd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778669636; x=1810205636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1AxrIZee8mUjA5ewU8xipjThvn2WeWg0jk/1WI0ykVk=;
  b=JQddftd3UdHADdVVAGu4HFvqcSDYeZKSh/1ICbIQ6hEZrdBQQybDn/iF
   O5xnO4U0/Wa+YpYxlEZT6kSjqBDiHINZH6VkyOVNHc9ZyK/tpTj0hoZBR
   oFwCl9UmfT3lT+ddIpqZG50kwNDN0RAIHh82xcx5OHfOvNY5KIJtUmJeZ
   TmiP3EwI0ojDGc2c4NFIjlEJIKUFIY0e/WavXPxguJdJ4HBNyv7b5Oo2n
   LYBnQPUujThtJwPjlWVvKQFzrEggKkdEzBeGTJAEbNwZwNCj+zz7j1XS+
   2hQHbHwRB5M6u5P+K48PtLXDnIASnDxFv2NAh9gXLmA6WSHD94WDj1Rv9
   w==;
X-CSE-ConnectionGUID: l+WGcak9SceKoCf2kGWrxw==
X-CSE-MsgGUID: LTHKgbpAQFWpRW9zAjmUaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79449518"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79449518"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:53:56 -0700
X-CSE-ConnectionGUID: XPRGVeq3Rmy5HvACLGK81Q==
X-CSE-MsgGUID: ayfzuQmoTYq7p7cJC1RroA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231665666"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:53:53 -0700
Date: Wed, 13 May 2026 13:53:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sun20i-gpadc: support non-contiguous channel
 lookups
Message-ID: <agRYPp5JQ3CyCQHJ@ashevche-desk.local>
References: <20260513-fix-sunxi-gpadc-sparse-channels-v1-1-6c21e290bcee@mmpsystems.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-fix-sunxi-gpadc-sparse-channels-v1-1-6c21e290bcee@mmpsystems.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 11:51:31AM +0200, Michal Piekos wrote:
> Using consumer driver like iio-hwmon which resolve channels thorugh
> io-channels phandles will fail for sparse channels because IIO core
> threats phandle argument as index into channel array.
>         eg. <&gpadc 1> will fail if there is only channel@1 specified
> 
> Add fwnode_xlate which maps DT phandle to the registered channel whose

.fwnode_xlate()

> chan->channel matches the hardware channel number. It allows sparse
> channel maps to be consumed by drivers like iio-hwmon.

...

> +static int sun20i_gpadc_fwnode_xlate(struct iio_dev *indio_dev,
> +		const struct fwnode_reference_args *iiospec)

Broken indentation (I understand the motivation to shift left, but I leave it
to Jonathan on how to proceed with this).

> +{
> +	int i;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++)

	for (unsigned int i = 0; i < indio_dev->num_channels; i++)

> +		if (indio_dev->channels[i].channel == iiospec->args[0])
> +			return i;
> +
> +	return -EINVAL;
> +}

-- 
With Best Regards,
Andy Shevchenko


