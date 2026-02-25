Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A89329C71;
	Wed, 25 Feb 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035172; cv=none; b=DcLsytqQj/xhxeZvnO/b8GFI4RsW+srM84gd+U72RaAAEc1k17qN2Nydfi6D8XZXUJQ4bygfGpVFKsIo+5iReRTUV6+Y3WupWjGym4fmoEFoIRoAXR5ODEj+QzQd069PEftUdrfdYwfjRYmcOan7gFM4git8Zs4Rnb/Rse9ya/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035172; c=relaxed/simple;
	bh=zwtLDkamjL2ShwzDV0gZDbIYVASjKVD7NjFTCsssOas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG4k2pBKM/Oa+MxcB1Rksrlfh0GNNKr8/negS4/ngbRlpVtc016Jh/wingEf6ZW6/0DlgvOofYKl/lZLq9PJrX7fFt+weNARkb918HRgiwVdsoTnBabHVoYaAo3NWfPiHrCoxzJy4ae8hZjxwfkqqVTFetGcOysPWKgeIlIpRPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCXZL/fv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCXZL/fv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772035170; x=1803571170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zwtLDkamjL2ShwzDV0gZDbIYVASjKVD7NjFTCsssOas=;
  b=UCXZL/fvawjla5Q453hpyeuN4hrWPVNdeZBJFTEH6B/qLiZdhnmHlqy+
   g6rye3jj+OE1i+irI70eEqt6yDX4w2AwEVFsD0VQNAW6dC8Vad6eNN0V8
   YdhhZXWwJM9VvuJ2dTsIX/nMwK36Ao7cDChj77IHoNSpDAVmeGntF68tF
   A5v8wNGwEr3IrndFjAL3wCIwDUr+KSIU67wGkQ0ScQp5yGmMZ2Aygv0h5
   a9m2MqCeYgUb/ZJ6n1632yQPuAv0Vz+rqKhTtBmhJYxCNZBvWNCA/WUdr
   4tP++N1WdNTwO0vFs4DtrSxMsbExyWxSKYaO20q65fPizKy9pOrrW4WWp
   Q==;
X-CSE-ConnectionGUID: 8IQ8JgiYTEq3IpuDy1htmQ==
X-CSE-MsgGUID: 5j/hHXZMSmCOQnW1xlhWfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73054486"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73054486"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:59:30 -0800
X-CSE-ConnectionGUID: sfFvyR6vRxSYKIOjCQEY0w==
X-CSE-MsgGUID: E3woId9OSEWApLPqviclog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="239279357"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:59:28 -0800
Date: Wed, 25 Feb 2026 17:59:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: Fix mutex used before
 initialization
Message-ID: <aZ8cXbvj7KcQNvp3@smile.fi.intel.com>
References: <20260225-mcp47feb02-v2-1-4792dc3942d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225-mcp47feb02-v2-1-4792dc3942d9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 10:48:57PM +0800, Felix Gu wrote:
> The mcp47feb02_parse_fw() function uses data->lock, but the mutex was
> initialized after this function in probe path.
> 
> Since mcp47feb02_parse_fw() is only called from probe(), remove the lock.

But is it called early enough before anything that may trigger access to
'data'? Exempli gratia, IRQ handler in some cases may be triggered before
probe finished (is it the case here?).

-- 
With Best Regards,
Andy Shevchenko


