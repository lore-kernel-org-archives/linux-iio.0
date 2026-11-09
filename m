Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268183;
	b=NrCRViL3skO1x2ty84Jq1gGLdd1xgRjU1E9Gu8n8DIgcZ5RKoRu44HmC7DP7/JuFqh8h
	 CyREi+gRCKBiQrO8nRu3bEiC9H83Mb+jI8rtrDxsVrrbVy3hgI8IeXuLFtKtKeR326w9R
	 bQ4q+88Pjs86rYiV49/U7SE8WDVpOQCOE+nIxUCx6D58Mhf/geMrHUZX4ikSSZtgq3LZO
	 Nh0we+T43AUs72JGNQEGP71GjCUhXbpXuHO9jBSzpa0cY/+1Be/iuczbj0xyJynYlYBXm
	 zYu0PhqEoTWSyia9faRbWUoOnFBjXBO61asRMXKkyJ7V1Fa8zv2in2sVh0yyY/mvWAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268183;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Jj40YZQ9cVoJSVmwJ5VvTTa+BLK2O7tycUOVE2dxpto=;
	b=ZW2oSLmJ97XFZWINc3OsaXj5Q9ww2s43C6pjK24bnIK2S5sXqr56SNK2EWr4b2KOzvCv
	 Luy5ZwOlMQLAbdsEXnq/mTo8x2+/7kb0wf8GkM59vHzsqsVXLnwF4/IgnuLyl/Bd7wODo
	 K40dCttdDpOwCzoCnlrKBz+mpGA6kVyrEEAlVpkOEshav22DLQbGQHKICddC4PcsxmC+7
	 NQoYgUPNenrs+CXBhmLCNlPBqXs0YHRt04+d/OHJ3G7GsnqAik2VoF52dhhNAlIqqJm2d
	 HhFpVqSk0pibJlOS1w+9l1IuHd0W8vTKZUi7ItUYvVWLd9rux93PrPRZ5jeKY1SOXMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y8TlR4PE;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77D606A31C;
	Mon,  9 Nov 2026 23:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E77D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y8TlR4PE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794268182; x=1825804182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JwrY6mPbucJ9MTS6HGIQYNNMZV2qvKzQRfFVtze/HFs=;
  b=Y8TlR4PEnkyWCXmwZR+fMxxJorRbWoEOsxRwql+Ee+jV8sWSKr2dIrwr
   p6nMC+WE8dW1ldTr1WuUBgqPP8EnKLufo6vKMj43AnZnPUUgVw1eYTvhd
   m2kDzXAxDDL80tQlXV81vedNw700JPr+6A2R/rjkB/2bI8jXq5fbU4E3d
   L4DkNTsnE05HaKWiSf5slOlubkYEp5zrIBnRiE7GfDR2pj20jCYrD/Dm7
   unlEMhogur8wcD86xQG/PqLFSQ8pw81I+I5DjdUIFoXcUW87KLec9htwG
   Orlsp3WWhwd0Q/3HUaZEstMTNFVxlm2iT+GTaattf/MEzE77CJcfSMb4e
   Q==;
X-CSE-ConnectionGUID: DbXJmKAkQn2Eu3WDBZLQRQ==
X-CSE-MsgGUID: sCP4N26GSQ+QSGbHUYkKFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2890674"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2890674"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:49:42 -0800
X-CSE-ConnectionGUID: uwmFmPSZTweSXoMhoi7mng==
X-CSE-MsgGUID: 1IXFqebVRJKUUA3ki95l6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7987234"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:49:40 -0800
Date: Tue, 10 Nov 2026 01:49:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raffaele.tranfaglia@gmail.com
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: adux1020: fix interrupt clear value on
 SMBus-only adapters
Message-ID: <avJcESOPo2nGq5wy@ashevche-desk.local>
References: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
 <20261109-adux1020-measure-fixes-v1-1-fe1ba63f28bc@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-adux1020-measure-fixes-v1-1-fe1ba63f28bc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 11:39:02AM +0000, Raffaele Tranfaglia via B4 Relay wrote:
> 
> adux1020_measure() clears the mode interrupt by writing the inverted
> interrupt enable mask to INT_STATUS. The mask is a u16, but integer
> promotion makes ~0x00f0 evaluate to 0xffffff0f, which does not fit in
> the 16-bit register.

Huh?! Where did you get it from? the mentioned promotion may only happen for
a signed char which may not hold 0x00f0 in the first place. The above is some
nonsense.

> On adapters supporting plain I2C, regmap formats the value with
> put_unaligned_be16() and silently truncates it to 0xff0f. On adapters
> that only support SMBus word transfers, regmap_smbus_word_write_swapped()
> rejects values above 0xffff with -EINVAL, so every proximity read fails.
> 
> Mask the value to 16 bits so that SMBus-only adapters send the same
> 0xff0f that has always been written on plain I2C adapters.

...

>  	ret = regmap_write(data->regmap, ADUX1020_REG_INT_STATUS,
> -			   (~adux1020_modes[mode].int_en));
> +			   ~adux1020_modes[mode].int_en & 0xffff);

On top of that regmap should limit the value to 16-bit anyway. If there is a
problem in regmap to cut the upper bits, it should be addressed rather there.

>  	if (ret < 0)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


