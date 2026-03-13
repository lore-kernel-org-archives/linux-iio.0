Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C71345729;
	Fri, 13 Mar 2026 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396525; cv=none; b=d5znzfhHlE7YqyhcG6priZO62uUGbcMo2n1bXu89JOeY1gU71PDvNqTCM8u7cDyUiqWfnULeN5pN1GVk5OIj9ecbwiM31MkTfY2lHAxf3c6WtDXHrhId1tw1yRTR3p4HkvCKHcYyBJjFPgDzDBoFDF8dlOaQHqJhJUUzdgLfHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396525; c=relaxed/simple;
	bh=b2hRF1Ae+cNYOQ+zp+3vzd0GVOF9OpTvByNvMFv9yNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAJ3H8itvfEY8bAgrw5BHovsxZpe2hNxJ9j/oKzVmTfjNjo6p4XkfgIAPIg075m0T4chd85dBfnYX//UAjx3gpulNg1iEE45c1Xf4mdXxZLzEQtUr2Ew10TT1pyzlP0Tq3LWOzw8WLdmcPyl4DLhYyL6OrETN4p3bLc99lg+bPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1ZnTn0N; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1ZnTn0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773396523; x=1804932523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b2hRF1Ae+cNYOQ+zp+3vzd0GVOF9OpTvByNvMFv9yNo=;
  b=J1ZnTn0NccebZYF8Fb5tFOvnKZFNTZGrC9jAcWzhdzlSkYT6DUV1t30q
   g3wxeXLA58hXyd381C6eqEcxFnjar5tJzbg0zLfCckrpJ5Q0tosuPwTiq
   s9z/6jfT1lVXRQ8Oxe8oHa2/qPWOMu+jAcdkcHpWhleSnXIPihTFC5YRn
   MdgHuDgRbVN8MtL6b6MBaGRd3XZyK0Zr5eH3AAFuA4p62rZoVB/937+EY
   j68jW9e7etl2hK/jZ2/ECS/KBMktHHfk2CrnYs8sON3mdSM8L1Ctg1P1k
   xefnAKtcZ1o9denuiDKQQqYxNtXswHJphC1uFn16/FI7ok11o5HoxUZ64
   g==;
X-CSE-ConnectionGUID: IdqLq0mMQpy6NU56Jy5t8Q==
X-CSE-MsgGUID: VtbrP+I6TWmwXcUy+aVrkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85202705"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85202705"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:08:43 -0700
X-CSE-ConnectionGUID: 8yQHrP2UTTKqM/tDC1MDPg==
X-CSE-MsgGUID: 8udDjgPLSba2N4bP7KJYrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="226077796"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:08:40 -0700
Date: Fri, 13 Mar 2026 12:08:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	morris_mao@aspeedtech.com
Subject: Re: [PATCH] iio: adc: aspeed: Reserve battery sensing channel for
 on-demand use
Message-ID: <abPiJEOL40C5eR1k@ashevche-desk.local>
References: <20260313-adc-v1-1-7a2edb4e5664@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-adc-v1-1-7a2edb4e5664@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 06:02:16PM +0800, Billy Tsai wrote:
> For controllers with battery sensing capability (AST2600/AST2700), the last
> channel uses a different circuit design optimized for battery voltage
> measurement. This channel should not be enabled by default along with other
> channels to avoid potential interference and power efficiency issues.
> 
> Changes made:
> - Introduce aspeed_adc_get_active_channels() to return the number of
>   channels that should be enabled by default
> - For battery sensing capable controllers, exclude the last channel
>   from the default channel enable mask
> - Enable the battery sensing channel only when explicitly accessed
>   via read_raw()
> - Replace hardcoded channel numbers with ASPEED_ADC_BATTERY_CHANNEL macro
> - Add helper functions for cleaner channel management

Why not series of patches each for the change made?

> This ensures optimal power efficiency for normal ADC operations while
> maintaining full functionality when battery sensing is needed.

-- 
With Best Regards,
Andy Shevchenko


