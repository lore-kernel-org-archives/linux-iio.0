Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426308;
	b=zw7VmZ18g17Qh8MFWmDdnBydo3OISeiohhdSKrBsQPJ1M1CCRyjcsVOgozjmmygcm1Lk
	 nPCFrNY3xhwBjrLpz1mBkmVr3UcKtvD/rHhjlbFM4vbopA5QChBRGHr3VclhxicRJYIYJ
	 V67egu8BYkRwOagY3F+CJW4620h9Mh9+CmbomQZgeaNiljGW8Cd9bA95hv/aJqf/r9/jA
	 JYl19+ZnyzeDMvigDuBVssbbiVe0p1PFymCbTHkQipLSZjr6wHGgun80sTOW4DscFnzhH
	 ytj3NWutsTkhpbLJzIWfDCSemZd5tGvTR7OUontN0M0sExDVv0aBVET8BvUtqDsitdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426308;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=o4c3gw5ayTeVyj4tzoPmy8cMt5RLKRl7oVUcToc0K6g=;
	b=PPbiNonhKc6szZSpXbAsqQhhtRM0Ms9XMXIKT9aq6E/3DzBoBJl3DDNryHlk+7mcL9Yy
	 fQZAqWOOslHRb0u3Ga12DDVXL1fY35Fxq8NHFcasL3QGBCuKSOgXBj8AVGpGzsC2FFkmo
	 MLuFuMHrMQZVEzV1fbWLY34ExTuaM3voXr3JrdWb6DZHJwLGs6xgROvBe+42jVqM0dUnE
	 FE75VNYrarT8/x4glwO0ZGEuF0kkLLKKKKLXG2qMp0QvchsbmI0kR8b+cAVoiS1wT7fC9
	 JW+u7eEVocvKWPdt3VM8hGwNjgrZStYp6+tY+PD1VYBolMb3Tg8LJbamvZa7fQ/HLaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AJZSowtr;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EF606A327;
	Mon, 23 Nov 2026 09:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F0EF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AJZSowtr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795426308; x=1826962308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E2y5GFJ9BPlcQ4pbbpDmSkF+0dOWl7ZmiyJDcKj96mg=;
  b=AJZSowtr/9VCS0aDc+pyEZGRGl4utw1R+tSFbhFKMc9jA6RNnq6IOq2Z
   1CMyCriltoB/sVvlwSijPe9pjYQvIyVqF3U4q8HEd5OwqFZWrZGfKmMVe
   YHWOL7fIwU+uSc+yeDkG1TnzE+XkvAYPAjGuT1CoeNDT1retzmU3mxiAk
   mGLAEWhHciayfdannTW1vRXih3SqqQoUYJz4PLbnwuAuqGCXfKqOOiJco
   9YFlslAeUok8aF8UXfkK6jdvdmEvnJmjqhh3wjwxIsuJiukssUDnJKUKb
   rjxodsZdXovSCJ/s1npuXeXEw6BDLq9c3T4nMqR5TdKPDtrzOcCENcvno
   g==;
X-CSE-ConnectionGUID: GRk/r0QPTXSiLxc/BY4nBA==
X-CSE-MsgGUID: 9LXH+dplSYihqewB592l+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4236411"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4236411"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 01:31:48 -0800
X-CSE-ConnectionGUID: RalA61qXRWWn9SmkXAgNwA==
X-CSE-MsgGUID: O9rcS9HvTJGEA/JvnhVvbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11133388"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 01:31:44 -0800
Date: Mon, 23 Nov 2026 11:31:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
	linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
	antoniu.miclaus@analog.com, gregkh@linuxfoundation.org,
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: at91_adc: fix NULL pointer dereference
 on trigger remove
Message-ID: <awQH_Rr8b_Eu0Vew@ashevche-desk.local>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
 <20261117140510.391907-2-abdelnasserhussein11@gmail.com>
 <avyEb9La1tqS90Cp@ashevche-desk.local>
 <avyEqQEL3A_YNcgg@ashevche-desk.local>
 <20261122002118.723b23b3@jic23-hlaptop>
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
In-Reply-To: <20261122002118.723b23b3@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 22, 2026 at 12:21:18AM +0000, Jonathan Cameron wrote:
> On Tue, 17 Nov 2026 18:45:29 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Nov 17, 2026 at 06:44:37PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 17, 2026 at 04:05:08PM +0200, Abdelnasser Hussein wrote:  

...

> > > >  	for (i = 0; i < st->caps->trigger_number; i++) {
> > > > +		if (!st->trig[i])
> > > > +			continue;
> > > >  		iio_trigger_unregister(st->trig[i]);
> > > >  		iio_trigger_free(st->trig[i]);
> > > >  	}  
> > > 
> > > Yes, but no. Please, rather fix the above mentioned IIO trigger APIs to be
> > > NULL-aware.  
> > 
> > Actually the iio_trigger_free() is already NULL-aware, so make it only for
> > iio_trigger_unregister().
> 
> I'd rather we didn't.  Any code that is unregistering a trigger
> that it didn't register is probably really very very buggy.
> I'd like them to crash or at least guarantee that sashiko
> flags it.  We could add a warn if it is called on NULL I suppose
> but that is ugly.

Can we add a comment there to avoid making such a change explaining
why we won't iio_trigger_unregister() be NULL-aware?

-- 
With Best Regards,
Andy Shevchenko


