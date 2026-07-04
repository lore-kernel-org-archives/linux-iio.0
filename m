Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331926CE05;
	Sat,  4 Jul 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783184264; cv=none; b=fpY9iKRYXBMp/Hstm6O+BRJ5PhgK+7CWrNBHRRNGDydYND3ha1QHW3y+BskduSgGeFaWpeXPDiSiIKBqW30alqS7k8xtPEDbTvqoTNvQoxgFKC1uOoZeEEHPuz+50ZOa/rfOXBpWgpqpBHkZeS3V9zAvWoWiMn3/1qgJ6/KxU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783184264; c=relaxed/simple;
	bh=uI6sNykF6fgvMPlCnufo/Ga5W8+SubJlDotJwLbOuzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma6OTtmi9M8vuMgAZhx4aIrGHSQxoa/fhMOkeKm32mSTSOo2zPvFxuBqIrUeW0RmabA4HcCs2KoRH6OLonS39f8NTSGvcRCbfVGWCgCWZ91uDb8RDIN6RNGTPQrFLpoW5DuQ1fdwxM4g1W8gSGdduh1hCHN1fSnu92znwb33uco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MD7emZqI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MD7emZqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783184262; x=1814720262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uI6sNykF6fgvMPlCnufo/Ga5W8+SubJlDotJwLbOuzU=;
  b=MD7emZqIp/yEuqwDJ1nwW83LZIdGdOuUZYvcFyN9rPo8j41w1Dj2D3lP
   3LJ6tO7hK60GtkoEbMjIw3CDAYZGamiaq9ynwuxEJWVz/y8KYS2VlHlHw
   GI8IfM4aRCcV+e/O7ysB/x1rWWWW0gyGLEqGBispcwSFnw7jm0mfUEMT3
   yoYXZtvZuZTOa0zfHYEv5Bn4u13LbwifCLbRxJF0J47brgEnc9OALhDIQ
   FqKF7C2w0/TjC/nlwIDY7gW8htzBgFxEB0iln+x4MZwA+Xf1Etz7W6kRV
   2qfXAyjkkQm0UG3C5lNK7gUyDjK8WOZTFpJtCa/vmcBydDjHNES36XFVg
   A==;
X-CSE-ConnectionGUID: G9OTBqTOQe+jTeQ4NKi7Eg==
X-CSE-MsgGUID: MK5PWewnSTKpp9+SR6M4NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="83935237"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="83935237"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 09:57:42 -0700
X-CSE-ConnectionGUID: VO+v7J3sRbiGT5haWnNLOw==
X-CSE-MsgGUID: j7SwIhl1SX2yjHY7mFiBzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="251602948"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 09:57:40 -0700
Date: Sat, 4 Jul 2026 19:57:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1241: add missing MODULE_DEVICE_TABLE()
Message-ID: <akk7gf51LfKbIuur@ashevche-desk.local>
References: <20260704151633.38517-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704151633.38517-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 04, 2026 at 11:16:33PM +0800, Pengpeng Hou wrote:
> The driver has a match table for the spi bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


