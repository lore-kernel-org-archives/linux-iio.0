Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F7390CBA;
	Tue, 23 Jun 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244294; cv=none; b=JW3EprkEl68UaUIhFucyHM9zRrRVod++wr8Yn8kHUZ/GZ7+yPheOnBNvt9aXhe/+dC4w7jd83jEOSzIIeOubgrIIqsQqdcXxnokPbzi6JMOe2cKVJIfIiSevbBOsr4lhaw3U8pUHLJGnLwexfXWA50L/VcYcK7r3RB7QrCg1LZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244294; c=relaxed/simple;
	bh=L7ueMmumLNJQBWWa9G7492qxrVzdPDUlpIfufx/09ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfxGH9YT8wea/cQV/UGeZHgx3/2TNLK6GE/bUTnT+2UEGKcjUuZL8ZwTXsuETogs2YlnKkLMzNV9U27+KDtOaXGXvmwzfkUQmnTQm9AxhPar21REMaCibrQzVD9TVmlohcV1UdvuzPyP9pyNQ0iS8Nwf1C6efEIBTtF/iEHQi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrLmH1wY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrLmH1wY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782244293; x=1813780293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L7ueMmumLNJQBWWa9G7492qxrVzdPDUlpIfufx/09ZE=;
  b=lrLmH1wY9VF0eOYkkH+RPoEGWHG0HlT8XeXeTz5PkIdcPEejZ1dn3Jim
   gqtUFQoU2hvgIHT7Huqp3V4lL/RzQ314uBHNmJwuCdi8oePaSCE/IcPs1
   Ml9c463aMYzefDDdqZHcoM/+tfp/dvpSs+GeZwgBJQh8RfrnMPmelWBwu
   JaynJ1T/a+4iZtXn/ndGZ/ubbWfJIOMK1h5DUGuDGDDIktJFV0R7oAbcp
   uETu6AzULFcmgXqRVa/Rgf8NS/Kx/jVBx3oUL7mSeomJecOBlBbZL8VZS
   5CjlU+SAz8jpB5cH8so4ABBQN+mOg5kSSS9ylJkqT3K4y38AXJ+cEFaQE
   Q==;
X-CSE-ConnectionGUID: juvI6D6WS9qYYxd4+QE3kQ==
X-CSE-MsgGUID: 1TTnAWVtSUWqjnU29c/mfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="70513591"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="70513591"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 12:51:33 -0700
X-CSE-ConnectionGUID: K5ME5PnuSDSfVcHEMMkHAg==
X-CSE-MsgGUID: AgZLJ7u5To6S9OVeLhU9pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="273675763"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 12:51:29 -0700
Date: Tue, 23 Jun 2026 22:51:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Shuah Khan <shuahkhan@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	John Ogness <john.ogness@linutronix.de>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-adc*: use dev_err_probe for probe time
 errors
Message-ID: <ajrjv4Ts_qtIF0my@ashevche-desk.local>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
 <f3165ebd-c359-49dc-a46a-0edacedf52d7@baylibre.com>
 <DJCBXHCM2VTQ.1DBAHMPJHA9HP@gmail.com>
 <20260623203137.7c4aae1e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623203137.7c4aae1e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 08:31:37PM +0100, Jonathan Cameron wrote:
> On Thu, 18 Jun 2026 22:22:15 +0530
> "Prashant Rahul" <prashantrahul23@gmail.com> wrote:
> > On Tue Jun 16, 2026 at 7:33 PM IST, David Lechner wrote:

...

> > I understand. I will remove the additional logs, except the ones after
> > `devm_iio_triggered_buffer_setup` for -ENOMEM.
> 
> This jumped out at me.  We very rarely do special prints for anything
> that returns -ENOMEM as that tends to be very noisy on the rare occasion
> it happens.  Note that dev_err_probe() doesn't print anything in this
> case. 

And I didn't check this as well, I though it might return more codes.
In such case this series is doomed because it adds dead code.

-- 
With Best Regards,
Andy Shevchenko


