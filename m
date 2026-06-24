Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5825B0AF;
	Wed, 24 Jun 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300419; cv=none; b=SvA2HWzBz7qYZsM4zGRG2OfHBynGtjcs0QVjJt7gITiEmPhtqQzT3i2NTKoPl2wSpgHaul4nvArMQUivEpCX3W4lji+Nsbru0Drqn22BE4squ4YNUQhsmXdbGYnfICrU67a2jCode+H7dWBmoGtVX3hD0Ppe8BC8FkJJMiXrtko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300419; c=relaxed/simple;
	bh=7GUqJlRMN6O8eqdlbPt2PVVp9u8tc7Jjc+XYqLUU4Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaaOsCFSxBtMbwSMrU39vNPYmuVDrX8nTlkOj2aTGRv2d5i9AMo3kFeaJsH7L0/DHycwPoPyzLoBYJTwGSNJi89eiqXJqQ6YHMMyeCm7HJoWqZyy90aWyIyFA5b8Qu8B2UvWs5crHRLNRMWLpsF+Zk2eXmq3Fl+/t7DaKQwrVXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgTUABwu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgTUABwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782300418; x=1813836418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7GUqJlRMN6O8eqdlbPt2PVVp9u8tc7Jjc+XYqLUU4Co=;
  b=CgTUABwu6qAFV4m5wgvw1+ZywvkpDj6FHWf6ybvQ9viOFJrl0pcyrMoS
   p34CdTb0jufwgU+keriqaZA2O1TKzkyya++gZBxbO9sak/axHotXOgKgJ
   8s6FPrQCSMIitRum0CNWq/1jdqpLH0FSKzHlSgPmrk5f6LoGb2WihzdEJ
   2whzdOaE9siIusa3ABGL8b7dGXm6wit0Jdxl7TAE3xwWoQk3QjzDQFpVu
   g4BTVYGzFCllIIHace2JpWlDtiAfmwhnrAMYQfFt6a0pOFazBVuUdhW0S
   dRaAePbQimstEtMUjvFY84ZJagVmB029gVMzXMA80sin89j8hgztdSgsl
   A==;
X-CSE-ConnectionGUID: 6iixoEarSHaNmEZWT3RVFw==
X-CSE-MsgGUID: gSSVju0/R+yqgbmeM+Yy4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83108780"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="83108780"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:26:57 -0700
X-CSE-ConnectionGUID: 3Zl/ea7FSgmVN7TwvgPpwQ==
X-CSE-MsgGUID: QJzf/xn7RkamxYcvwwVBFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="243439450"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:26:54 -0700
Date: Wed, 24 Jun 2026 14:26:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prashant Rahul <prashantrahul23@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup failure
 in probe
Message-ID: <aju-_HSz6jNkR_NM@ashevche-desk.local>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-5-prashantrahul23@gmail.com>
 <20260623203636.69a7429a@jic23-huawei>
 <DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 03:43:44PM +0530, Prashant Rahul wrote:
> On Wed Jun 24, 2026 at 1:06 AM IST, Jonathan Cameron wrote:
> > Why this particular one but not the devm_iio_device_register() below it?
> > Both pretty much only fail on driver bugs.  Or out of memory for
> > which dev_err_probe() doesn't print anything anyway (on basis that
> > is normally pretty noisy).
> 
> My apologies, I wasnt aware that dev_err_probe simply ignores `-ENOMEM`.
> Looking at drivers/base/core.c:5096, it is pretty evident that it does.
> 
> My goal with the patch series was to change dev_err into dev_err_probe,
> as my understanding of dev_err_probe was that it's a specialization of
> dev_err for probe contexts.

Jonathan, actually the triggered buffer setup might return not -ENOMEM error
code for the surprise. After all this series does add not a dead code, but
a quite rare to be used one.

https://elixir.bootlin.com/linux/v7.1.1/source/drivers/iio/buffer/industrialio-triggered-buffer.c#L57


-- 
With Best Regards,
Andy Shevchenko


