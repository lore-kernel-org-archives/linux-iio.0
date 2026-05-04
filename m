Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0113E02A;
	Mon,  4 May 2026 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878233; cv=none; b=o6QRxzp64/ZUrDkafmaHPw0/s51SeIjKq2dQhi3CMW0KOFGJDcDMvXr7NmPLS4q6sb9EMP2hbl8hr+sIESoJkSidyHCQ2EoX+nGqOSiOwEsFnWRKtkJ9LX3A8521Mk0tmgxlxOIc5DaHcgnwCQLLFCuwciUkV075NorUnCtuDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878233; c=relaxed/simple;
	bh=DYnN+2hnA+3skVhfBB7Zyw2PVdxOq6riJg/R5XFKtDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg3nlSHjxk+CR6DxpEkzvA7QiW68nuqn8t04hpE5KUnrWLu8kfHbOZwmBMXLUyFsN/A7mwQdEjqSbr+Yv6DSfE/IvH3+xK7ieojOTvPvDj6UY8Zhwod/u5zXrZBCJh2xq9PslwtrgNWIFA+W0ViOTjRdyVy7PvCLTVDT4nMUcsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwHXZn+Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwHXZn+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777878232; x=1809414232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DYnN+2hnA+3skVhfBB7Zyw2PVdxOq6riJg/R5XFKtDo=;
  b=ZwHXZn+YDNs1cmKWI+GpzMB6FKBzDtXSDmmcrjwuPhUPq3VvqL1uVi0a
   4FOBKPB9/cT+W3vndIFXBKxYSSCljROAXMvykANmE78jeS7rMno9W2heO
   VFkatTxiCogkiWH5X1ax+ZE8GWzI6waeGNfE2Dr20hQDdWyrCU9LUZJOH
   X0ze2wiEUmhgqDkN4+IE6rWYcucwypDG5qBYx8U0+HhrOWBaVpFP7gDpT
   +F9oiciZ2UQEx19EQ0trriT8b4D9YquH872qpLDaPpDXsBe0diEt/u+OO
   l9AGiKxv5ysA3RT/cRdacrXDoXnTWtfboU1Hi1qJXQRcvkqX0vaIu0xkT
   Q==;
X-CSE-ConnectionGUID: xOGLMTIlSZ+vdyGBY1Cm0g==
X-CSE-MsgGUID: SsNBsDWLQlmte8D8l6ru+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89835348"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89835348"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:03:52 -0700
X-CSE-ConnectionGUID: uAt0FEHJSuiy3vkA64ykRA==
X-CSE-MsgGUID: EzLD2b3FScqJ/vC/m3vH3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235495008"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:03:49 -0700
Date: Mon, 4 May 2026 10:03:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] iio: buffer: hw-consumer: fix use-after-free in error
 path
Message-ID: <afhE0sMkaaXfomPB@ashevche-desk.local>
References: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 30, 2026 at 09:29:06PM +0800, Felix Gu wrote:
> In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
> was using list_for_each_entry() to iterate through buffers while calling
> iio_buffer_put() which can free the current buffer if refcount drops to 0.
> The list_for_each_entry() loop macro then evaluates buf->head.next to
> continue iteration, accessing the freed buffer.
> 
> Fix this by using list_for_each_entry_safe().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


