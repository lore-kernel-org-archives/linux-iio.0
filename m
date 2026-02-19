Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E26280336;
	Thu, 19 Feb 2026 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531224; cv=none; b=p7VITWIZvuLa+UWxPmZ+/FBmfv6EaUmQSZfTAEQf3taf75WBF492DHrR3mDk+KUqbIUwxDU5MLFa6YoELeIB+gO15K/PCygqizwphP0QaLQxMwffMqpsY5NSOQAR8EiUNuotXAF2KrIQoyib0gIWADBJS3hJ9ODsoBgm0v5D588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531224; c=relaxed/simple;
	bh=EyJk/kgd0d5BFToXc2vCXn6y89e75By6Y9sGCSZa38o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1i7ju0PKiZRJF6FREKIwodY7Lt2dNv6IwKrnvVgaCgxe3cT7WU6iL/sUNKXI7B4PpSOVqAf89ToCfnB8HvgRxQcRnDtqJjCOzJ4mna4QWZ6a6FIAvU7KykRoifbm4v0tzZo7cHIAt1DnxGoKaAqCqrLqXGVf/8qLChIvl5ybVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bE1P6Ahw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bE1P6Ahw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771531223; x=1803067223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EyJk/kgd0d5BFToXc2vCXn6y89e75By6Y9sGCSZa38o=;
  b=bE1P6AhwDXx1PjESl8p24f3G78f83ESQx62OQkaD9XILDjo31QrPk5il
   Y5LqeResYWp9ndtI7U5zz5pJJ3QGjLXmx7EF9rcY29jg77nhGozcA7Nyy
   zd7SgCLtSKiGlhR4mjMgc7q+a3L0hT3to889YRnRQ+ueevDoD6PJmrjgV
   r2L62CBgsOoo0CqGJGjVDNst64B74NjnerTcX/58nH4ZXqJQi3pcNY6jQ
   yzwtSf8kgDMSP5Nl/k2y00icGa58sCv0UAxYjIVDThK8SP8DtD1MgTUB0
   A44jFcGGrogrK5IH0mxwnm2CCDXpya9ak1h7teRi9fP59JZpLrR8CLgv/
   w==;
X-CSE-ConnectionGUID: rYibxSyfTtC0SMNiMBQrZA==
X-CSE-MsgGUID: Lz8O+dA0T9qls6Fzkj+JEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72691040"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72691040"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:00:22 -0800
X-CSE-ConnectionGUID: hC46u1yLQFSkhTUHI5pNyQ==
X-CSE-MsgGUID: /Q/3CI86SJGp/L25J63BhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213869912"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:00:20 -0800
Date: Thu, 19 Feb 2026 22:00:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] iio: light: gp2ap020a00f: Return directly from
 the switch cases
Message-ID: <aZdr0TyLmLfkcdzp@smile.fi.intel.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
 <20260218043728.609659-6-ethantidmore06@gmail.com>
 <DGJ6T7SUJBFE.1BHJKFRV7IPTT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGJ6T7SUJBFE.1BHJKFRV7IPTT@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 19, 2026 at 01:32:20PM -0600, Ethan Tidmore wrote:
> On Tue Feb 17, 2026 at 10:37 PM CST, Ethan Tidmore wrote:

...

> > By doing this, it appears to have fixed a preexisting bug, the variable
> > err in  gp2ap020a00f_buffer_predisable() is only checked once for errors
> > after the for loop is finished. This could allow errors to be swallowed.

...

> >  static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> >  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> > -	int i, err = 0;
> > +	int i, err;
> >  
> >  	guard(mutex)(&data->lock);
> >  
> > @@ -1400,15 +1378,15 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
> >  
> >  	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> >  	if (!data->buffer)
> > -		err = -ENOMEM;
> > +		return -ENOMEM;
> >  
> > -	return err;
> > +	return 0;
> >  }
> 
> Looking over the code again it looks like 
> gp2ap020a00f_buffer_postenable() contains the same bug you mentioned
> where the error check should have been inside of the loop?
> 
> 
> 	iio_for_each_active_channel(indio_dev, i) {
> 		switch (i) {
> 		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
> 			err = gp2ap020a00f_exec_cmd(data,
> 					GP2AP020A00F_CMD_TRIGGER_CLEAR_EN);
> 			break;
> 		case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
> 			err = gp2ap020a00f_exec_cmd(data,
> 					GP2AP020A00F_CMD_TRIGGER_IR_EN);
> 			break;
> 		case GP2AP020A00F_SCAN_MODE_PROXIMITY:
> 			err = gp2ap020a00f_exec_cmd(data,
> 					GP2AP020A00F_CMD_TRIGGER_PROX_EN);
> 			break;
> 		}
> 	}
> 
> 	if (err < 0)
> 		goto error_unlock;
> 
> Just wanted to confirm before putting it in the v5.

Good catch! So, these two should be split into a separate change explaining
the change in behaviour.

-- 
With Best Regards,
Andy Shevchenko


