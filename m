Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C5372EDB;
	Wed, 22 Apr 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843978; cv=none; b=jM3YpS1qU4NPBrPTUt77yR2pNjByvLyKIqy/TfNgg40Xzwgl44YvkxUfOFsboRQcxjPBhwC39YdEMEzVLobqVQ7k4oVNCQbn9nuPfVsBF+oFhcn3h4TpIhuiHoJtVh1VXuKoiiaDNLZLr/WRb+MWKD+RXclZ8yAGxDYVxpH+45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843978; c=relaxed/simple;
	bh=qWdJWQLUMfZ7Z7HtKDHfNTDUxXFo9qplq7+iRQM41hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNJKpE0ljaVtKfjVRyDt03AB7o5yRwvOnXgAzFcEK+4xgcy3uJVn572bMH1Qsq7n9cM7MvnJPzchkgojTil6CVEvXG2MGn9SOR/3M8ibIkJNxfrgVkRK14eo7YVMBj6BhyKQmfVEYrsp8e2S1JRNjB1XByUowy5xyoHyZbLcwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpuChDs3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpuChDs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776843976; x=1808379976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qWdJWQLUMfZ7Z7HtKDHfNTDUxXFo9qplq7+iRQM41hs=;
  b=DpuChDs3ooOyUlCPAzUk3pvhYbegLxTJJf8iJHAVSAU4oMsL1b18Lbwm
   8CUcVtA3KwNosO2W/gw2RbLNVwr4gBElckUMB+Yan1uOOROLtSPUx9Rbi
   SYTHnEOxrFGSaZ56s4hbXugE2ccZCgyMAczp1psl1e0HdysLSFKWh+pqE
   ldj1+la9hhG9WghrH008FRofQydXvw0l6vxgElZh4W/mOHzBRBh+0SHJw
   +yd94TF5P8MvwRaPjkdmYaGCZ64LGTjvr1NHmVUXFcu/kSV3/A4VK5A3h
   iyr0TIiAkRDUDBaSES8xEqWa0xHGo/mrOhaYoGjNOIrSmZ2ecSxI8Oh3Q
   Q==;
X-CSE-ConnectionGUID: DJHz4IM4QT6oGMmbXeBB3Q==
X-CSE-MsgGUID: wxezAZkIRGep57owgIe/+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77910719"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77910719"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:46:15 -0700
X-CSE-ConnectionGUID: YF7P02cwTseFZ9wFcPdmwg==
X-CSE-MsgGUID: Ff6Un7LmR+S2lb6j31et7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="255762783"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:46:11 -0700
Date: Wed, 22 Apr 2026 10:46:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matheus Giarola <matheustpgiarola@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	matheusgiarola@usp.br, arthurpilone@usp.br,
	davidbtadokoro@ime.usp.br
Subject: Re: [PATCH v5] iio: adc: ad7280a: replace mutex_lock() with
 guard(mutex)
Message-ID: <aeh8wfWGGkWppTe-@ashevche-desk.local>
References: <20260421190855.24132-1-matheusgiarola@usp.br>
 <aeh8Xu90pyUBBzj5@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeh8Xu90pyUBBzj5@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 10:44:36AM +0300, Andy Shevchenko wrote:
> On Tue, Apr 21, 2026 at 04:08:55PM -0300, Matheus Giarola wrote:

...

> > static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
> 
> >  	unsigned int msecs;
> >  	int ret;
> >  
> > -	mutex_lock(&st->lock);
> > -	ret = ad7280_read_reg(st, chan->address >> 8,
> > +	scoped_guard(mutex, &st->lock) {
> > +		ret = ad7280_read_reg(st, chan->address >> 8,
> >  			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
> > -	mutex_unlock(&st->lock);
> > +	}
> 
> Not sure if we need {} here (as it's one statement body), but the indentation
> now got broken of the second line there.
> 
> What about
> 
> 	u8 devaddr = chan->address >> 8;
> 	u8 addr = chan->address;

Just checked the second one s/addr/ch/ as per ad7280_store_balance_sw()
implementation.

> 	// ...or use existing names in the driver for the same things
> 
> 	scoped_guard(mutex, &st->lock)
> 		ret = ad7280_read_reg(st, devaddr, addr + AD7280A_CB1_TIMER_REG);
> 
> ?

-- 
With Best Regards,
Andy Shevchenko


