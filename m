Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F43A6B90;
	Tue,  5 May 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994525; cv=none; b=ZS5xnMyJ1UPcUooVvw0pAxUx4USKOPtoBsdeyHswHdQE5rzuF7A+MMyWzJFCD0jJQTlLNskt4xhxEK2ArqKj8pxP1Q3+S+ELXD8NjLCdtsLAYmxT7kgglTAtdVbrzUy9i0nqV8wfZPPPOX7QMHSn9+Q91qy6iNJt/hu0q/j+ZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994525; c=relaxed/simple;
	bh=lTx/4yAr1FyW3HfuA3iw91urOlv+p1OG0vqbRL1A+4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJACODfM6KoyPE0P57sU81gWuxd8dTAdgHawShZTsoev49+YCZbxKWiaMWfyCdnR8kRbSDZwpucEROWo2sVTNoKVFtTn/df1O8h/vJQhBR7/gkPCErYtnNYq7uAwZ0kZKbuC7PTbVYGt3WSOEFMhT5AQUGrdrLQ+1/3KkbCMXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDLpvgLw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDLpvgLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777994524; x=1809530524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lTx/4yAr1FyW3HfuA3iw91urOlv+p1OG0vqbRL1A+4k=;
  b=HDLpvgLwQTbdtouDI+hZJ2sOs6dH/YuceOg63TNxrj7EBFcs6j/GNAwZ
   EshrNVmqGBIDiXhl2yOuB3qijLGXjRYtIrP9l7R+ljB08s8w9H/HeZwOH
   s3ymgZ/s+MxATnW9IEien+pgwjovAc+cbMGu7JB3f8iStwj8fUk0qirjw
   xaauGJQb2KtJDazGye3mfx8X0TNukGNNSws0rTW8IC+UIeIfo3GesEvbP
   oZtmCgPF8h7aIgoQFUEcSh2s2+YDSnCTPNrHMefC1ghbvlsIf4eJqXtEE
   8O6PVYo/MNKimGaL42iDQ0+LhuSNS93uzNQJzB9xHrOgx2Q2zcDW/bmzy
   w==;
X-CSE-ConnectionGUID: 4fWsQTE5QAihlXZs7dIFrA==
X-CSE-MsgGUID: eC2jlGhGRBCwBSV8OIR1Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89461097"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89461097"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:22:03 -0700
X-CSE-ConnectionGUID: Iyd4U1YLTw2jyeZGlUwqvw==
X-CSE-MsgGUID: Nx7RPbVPTk+fZxugkbXJ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="236098508"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:21:59 -0700
Date: Tue, 5 May 2026 18:21:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 03/12] iio: dac: ad5686: acquire lock when doing
 powerdown control
Message-ID: <afoLFebe4fgNxXUV@ashevche-desk.local>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-3-c2d5f7be32be@analog.com>
 <afnpkRLOn7ZDzSj-@ashevche-desk.local>
 <a2tm4z5urvnurh3z2ntbm7rddv6eg236gbkvtz5cididtc2rv5@skk5x6kykaij>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2tm4z5urvnurh3z2ntbm7rddv6eg236gbkvtz5cididtc2rv5@skk5x6kykaij>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 03:06:31PM +0100, Rodrigo Alencar wrote:
> On 26/05/05 03:58PM, Andy Shevchenko wrote:
> > On Tue, May 05, 2026 at 01:35:04PM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> > > static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
> > >  {
> > >  	struct ad5686_state *st = iio_priv(indio_dev);
> > >  
> > > +	guard(mutex)(&st->lock);
> > > +
> > >  	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
> > >  				       (0x3 << (chan->channel * 2))));
> > 
> > Why not use ad5686_get_powerdown_mode() instead?
> 
> powerdown mode != powerdown mask. The powerdown mask controls the on-off
> behavior, while the mode controls the possible values for when it is off. 

Ah, unfortunate naming collision (easy to mix up them).

> > >  }

...

> > > static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	guard(mutex)(&st->lock);
> > > +
> > >  	if (readin)
> > >  		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
> > >  	else
> > 
> > Similar question here...
> 
> I suppose the above applies here as well.

Yep, thanks for clarification!

-- 
With Best Regards,
Andy Shevchenko


