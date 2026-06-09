Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652336D512;
	Tue,  9 Jun 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007417; cv=none; b=j/VydRl4RejrZUw7HhiFrtEhMZfp1maGl3C7AkQ8+yV14E3NNMSeUacbSJh6+lXfwuHN7tWJNyPybueRtCZ/UqQzg9cDPaNJ0/7NJx/V+FDorgPz0FXOnN/0f7ewPjWrZOcRbQW6Co52augb7H+KYsFdSiR/9X93gs1YBi2koA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007417; c=relaxed/simple;
	bh=1uJZuPCqbZHOmgERE/HNzkbZIJLXb93gq7WzyTeq9qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPxc0LWgDnDxbO31vvrOPIVkDi0Y7XOkXcQ7E8oR/GWMbeUKOEUh/FZMOh3CV17vSXpWGuwW57blf9ZnRlAuPSOx9kruI2/5a8KPKvKN3mzBN59bhtwpLf1kOOw6nzm2cG/FlmhhArBblTty0NAwNjxGTsr6PsxQjAhqWBitCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+C0Nu/p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+C0Nu/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781007416; x=1812543416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1uJZuPCqbZHOmgERE/HNzkbZIJLXb93gq7WzyTeq9qc=;
  b=Y+C0Nu/pty88u3Ps1qu7xu0rPCJTDfIWdiU8EQUb/xYk6/00awnHAnO0
   jYGlUk6SQSt3HVH/M6Jnr0YKbR8HcogJA3l5t8ON0xppccvJmquJDuQCc
   ZIFHccT42rFJ64IVgzT1baIGoQuQDZ0RwFOt5rYtNFMssjvnrdRBwrAa8
   jORER5WoBcGxnlyaQPwU7KabW29U/syJMGExQ+JRlFK1AafH15PDTRFUj
   QdiC6tSFITMz0ic3eLanJNxckJdtkR6pQaeFIJ61Bzf1DuxxmqmNyU8Pu
   HMS7Gp/ooYVr2HygPH8BdEsMNXGjpScghvkeg9FFuCbakdnVLeMciyZVT
   g==;
X-CSE-ConnectionGUID: +ThjumlASfqlinLwsjwMoQ==
X-CSE-MsgGUID: JtVCZxQ+RAiNz2fnJq+Ubw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92871847"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="92871847"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 05:16:56 -0700
X-CSE-ConnectionGUID: ToYxhu46QlusaS/ymPr+8g==
X-CSE-MsgGUID: RsoJHozmRx6JcaXVCFkSIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="244993173"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 05:16:54 -0700
Date: Tue, 9 Jun 2026 15:16:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, Dan Carpenter <error27@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aigEM0mV4nBbhcRI@ashevche-desk.local>
References: <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
 <aiFWg6vC2cVbONTK@stanley.mountain>
 <aiGRzFrSU6QUL4R2@ashevche-desk.local>
 <aiJo1kjN3_XDUdBc@stanley.mountain>
 <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
 <da949cdf51727f74d1f0f5b3e8248d5dc34e2219.camel@gmail.com>
 <20260608165138.16b88dbc@linuxescape>
 <aifJtgLkM2m3KciV@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aifJtgLkM2m3KciV@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 09:10:14AM +0100, Nuno Sá wrote:
> On Mon, Jun 08, 2026 at 04:51:38PM -0500, Maxwell Doose wrote:
> > On Mon, 08 Jun 2026 21:31:14 +0100
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> > > On Fri, 2026-06-05 at 11:28 +0300, Andy Shevchenko wrote:
> > > > On Fri, Jun 05, 2026 at 09:12:38AM +0300, Dan Carpenter wrote:  
> > > > > On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote:  
> > > > > > On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:  
> > > > > > > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:  
> > > > > > > >    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > > > > > > >                              ^^^
> > > > > > > > Uninitialized variable.  
> > > > > > > 
> > > > > > > s/variable/data/.  
> > > > > > 
> > > > > > With what I asked in the previous reply and what you explained there
> > > > > > (thanks, btw!) I still think your patches are not fully correct. They
> > > > > > will require to atomically write all or nothing. If we want support
> > > > > > partial writes we need to go with that differently (reset ppos when
> > > > > > we got enough or more than enough data).  
> > > > > 
> > > > > Requiring writes to syfs and debugfs be atomic is pretty normal and
> > > > > works well in practice.  These are very small writes.  
> > > > 
> > > > Perhaps. In any case your patch will break existing partial writes, right?
> > > > I'm still considering that resetting ppos is the right thing to do. Just
> > > > need to find where the best place is to do that.  
> > > 
> > > I think anyone doing partial writes on a debugfs interface like this one is very
> > > unlikely but it is a fair point, yes. But can't we be more relaxed on debugfs? No
> > > userspace app should be relying on debugfs in order to work (though I know that
> > > actually happens).
> > > 
> > > Anyways, this is one of those interesting edge cases and easy enough to get wrong. I
> > > guess we should either:
> > > 
> > > 1. Improve simple_write_to_buffer() docs;
> > > 2. Or come up with a new simple_write_once_to_buffer() helper?
> > >
> > 
> > When you say "simple_write_once_to_buffer()" do you mean a wrapper
> > around simple_write_to_buffer() that also checks if *ppos is 0 and
> > returns -EINVAL if *ppos isn't 0? If so I can start writing that
> > function. Though I guess we probably want to ask Jonathan about it
> > first since obviously he'll have his own opinions.
> 
> Yeah basically not allowing partial writes. Partial writes are also very
> tricky to handle in terms of concurrency (assuming userspace can do
> whatever they want). But I would not rush into writing the helper
> without understanding how people feel about it (at least the ones in
> this thread). Might not be super beneficial.

Yeah, I would expect a pushback. So, documentation is an appreciated updated,
more — depends.

-- 
With Best Regards,
Andy Shevchenko


