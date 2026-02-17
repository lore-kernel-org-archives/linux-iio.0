Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34113AF2;
	Tue, 17 Feb 2026 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314560; cv=none; b=Ldml6x3vxSBYjsgeisSZJhmOndb0TCFXv2KHwAbMIr5zq4IebTPjFKM5qmSjl2rObKYrZc1Ak6DAjbbBuxeWlA5UXV9LW/3LDOmSJVWGd2rinZvbqHPDVUwxQPcKQHYh7fj0dVBsfz46ogKpt68zi0LJrrTxAVmYMJEH6lPbJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314560; c=relaxed/simple;
	bh=BWOw4zr6uW3cI7jgXvHmTlxLMbpQHnpj0syvdwH3a2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAgR3S3eYUKzDIwccgH5feQpOn89zbd/D0DepxVfaNZNE/iBqC1QQzeS/O6gUbOdKe+8nyIQNsoq4LBvUwjSCnxsld/lB57w3M90M8yvYCbgeudgYBsmC9qXTm7m3NerYwk/Uh4BIGPlyFBQoCFaLG6BTWI4sFZaFUZK/6gTOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDrh5IXI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDrh5IXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771314559; x=1802850559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BWOw4zr6uW3cI7jgXvHmTlxLMbpQHnpj0syvdwH3a2c=;
  b=HDrh5IXIRjDJ2S0+hCN5BSq+8wFGAYb5TQ3/OWU7yGO35hOGakcFnhP0
   zzYDFWfhJcDawnh8vy+092AFXr1mqz3N9Lvn/XGsSDAaD7C8ErlEaTkny
   JxuWjGjhhy5DfzuII2FUb/eYD7eU7lXmUWc4hxmp0K527y9mvLxkHZK2p
   s1aPXrXWcYuvyt2qZld9nY0Si5lFxq81KWAuF7TktYtZAHqJmwU7unDuC
   EfJ8h+kTr1uMCMPNTlIJXFzOZ7e9fOglkLoTecLxm+xenx5qgxsiU+urt
   mfbUWcApxuIW3Yw5+q5yMQrLW6hFH7HZL2WyueRWvXykhqJbyHnyCFFkf
   w==;
X-CSE-ConnectionGUID: xST4qn6RQleAer95YhrRnw==
X-CSE-MsgGUID: /Wsg0nutSeOe6+6G2CBWOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83101814"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="83101814"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 23:49:18 -0800
X-CSE-ConnectionGUID: CFGoUJGjTxuGIxyF0Fe0NQ==
X-CSE-MsgGUID: hb6djyB1TVOwFlZvAa89wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213641218"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 23:49:16 -0800
Date: Tue, 17 Feb 2026 09:49:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] iio: sca3000: simplify with
 spi_get_device_match_data()
Message-ID: <aZQdeejX3ntHFWdM@smile.fi.intel.com>
References: <20260216095110.1062611-1-harshit.m.mogalapalli@oracle.com>
 <aZLrb943-fnkyB7s@smile.fi.intel.com>
 <74d31a2c-d515-46d2-90f0-46ff816ee3a0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d31a2c-d515-46d2-90f0-46ff816ee3a0@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 03:45:34PM +0530, Harshit Mogalapalli wrote:
> On 16/02/26 15:33, Andy Shevchenko wrote:
> > On Mon, Feb 16, 2026 at 01:51:05AM -0800, Harshit Mogalapalli wrote:

...

> > > -	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
> > > -					      ->driver_data];
> > > +	st->info = spi_get_device_match_data(spi);
> > 
> > > +	if (!st->info)
> > > +		return -EINVAL;
> > 
> > This is a dead check. Just make it a requirement and drop dead code.
> > The support of a new HW will be assumed not tested at all if there
> > is no driver_data.
> 
> I agree, will drop the check in V2.
> 
> There are a few commits like this which added NULL checks, so I was not
> fully sure.
> 
> commit: c5d8facf107a ("iio: adc: ad7192: properly check
> spi_get_device_match_data()")

Nice catch!

That change is unneeded churn that adds a dead code as it looks like.
Nuno, can you elaborate the motivation behind that?

-- 
With Best Regards,
Andy Shevchenko


