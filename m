Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC82D7392;
	Tue, 17 Feb 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314859; cv=none; b=GhR5WZwr2Gku4Gz8y6gVHdRIQBYSLg4mGSGyigd8k85uBLUrYG6g4TJflF8+NmgQc78m5BscofCXU0RZdE/f1TrVhq+Lr5M8oYzafHbKaoNWp7B6QFkBHUzuKDsEHCEajEenPm4sSwNp6F7lLPw/79eCUGFbiKZxzJcVuwT/vW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314859; c=relaxed/simple;
	bh=/T9s6SgDIcUJ77yD7qCEjbsPbIBB8hVIiGK9LLe5g+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXSInzUONx4yxPdzfhRIBRSYBH1OYny30kCydvAF5Fl2d7Acdfpz17V5lmZhi2tk2U9H8x8llyuH5Zdlm9nk8qK9Yf8nAmt2syAcbTcQZrVa0KSwkxSumUipK56FVo4Zb+UGDBDhpMU+Ro5J4X06X35bBP/0WhBG4U3F2FFkYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXHxOA5t; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXHxOA5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771314857; x=1802850857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/T9s6SgDIcUJ77yD7qCEjbsPbIBB8hVIiGK9LLe5g+c=;
  b=KXHxOA5tdorklsU+gkGOc4Y5mOaz2YfKZ1oZMROyxnE1XwxGVf5qSrus
   zxTgn7Nbn2z72n+fD6ttTdf/ojeUZDiUX9t4q8/jVJwFsi5B6vUcFIUtJ
   1iaLH/U9Fq8b1yZuDFeiEs5cHYQPpM6GZBQR2B763/CLIMQBtxXiulsAw
   W9vj0T/Azgg0L3mK7ZFhcaPKW4UUnIFwXXMXALXQoBQzd88pULjJxR12O
   sTf3jTIyESrH1mwoDBIVf121dgQPUZMVpItVC1NnPnikCObp20mtvCejY
   dmxHTQDdYaD9H8S/zweD7XBfBAGqZmWPA3CecK5a3qUq/Ok5E3B+CXRSm
   A==;
X-CSE-ConnectionGUID: tg53sXOvRPOwL9JzgDhYQg==
X-CSE-MsgGUID: I1/AWXL6R0u9lblYQzSw9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="59946718"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="59946718"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 23:54:17 -0800
X-CSE-ConnectionGUID: v6Wt1x+aTFS9Rw+LMuFhAQ==
X-CSE-MsgGUID: kUF5bsJnQyid8FjHFw25dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="212044800"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 23:54:14 -0800
Date: Tue, 17 Feb 2026 09:54:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana.Lazar@microchip.com
Cc: dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, jic23@kernel.org,
	andy@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Message-ID: <aZQepHXptVvBsQuL@smile.fi.intel.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
 <20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
 <aY3m5V05FOH5sut6@smile.fi.intel.com>
 <f8e45b0ef7af336dbde04ce53d117c6e47d2190d.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8e45b0ef7af336dbde04ce53d117c6e47d2190d.camel@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 02:29:19PM +0000, Ariana.Lazar@microchip.com wrote:

...

> > > +static int mcp48feb02_read_avail(struct iio_dev *indio_dev, struct
> > > iio_chan_spec const *ch,
> > > +                              const int **vals, int *type, int
> > > *length, long info)
> > > +{
> > > +     struct mcp48feb02_data *data = iio_priv(indio_dev);
> > > +
> > > +     switch (info) {
> > > +     case IIO_CHAN_INFO_SCALE:
> > > +             switch (ch->type) {
> > > +             case IIO_VOLTAGE:
> > > +                     if (data->phys_channels >= 4 && (ch->address
> > > % 2))
> > > +                             *vals = data->scale_1;
> > > +                     else
> > > +                             *vals = data->scale;
> > 
> > Actually, if you put the scales as
> > 
> >         int scales[2][2 * MCP48FEB02_MAX_SCALES_CH];
> > 
> > this will become as simple as
> > 
> >                         if (data->phys_channels >= 4)
> >                                 *vals = data->scales[ch->address];
> >                         else
> >                                 *vals = data->scales[0];
> > 
> > OTOH, I am not sure if it can be always as
> > 
> >                         *vals = data->scales[ch->address];
> > 
> > which would be the best approach.
> 
> I am not quite sure I have understood your point of view. In order to
> remove the channel parity check, I would have to declare int
> scales[MCP48FEB02_MAX_CH][2 * MCP48FEB02_MAX_SCALES_CH] (int
> scales[8][6])
> regardless of device's number of channels and number of voltage
> references. This will be quite a lot unnecessary space allocated
> compared to using only two arrays of [2 * MCP48FEB02_MAX_SCALES_CH].
> 
> Another way to avoid these checks is to use a dynamically allocated
> array of scales. Each member points to an array of [2 *
> MCP48FEB02_MAX_SCALES_CH]
> and stores corresponding scale values for each channel, while allowing
> to allocate the actual number of channels the device has rather than
> the maximum.
> 
> Please tell me which version you prefer.

I think something like a second variant. But as it seems going to be an
agreement that this driver is not needed and rather we need to refactor
existing one to add the support for SPI chips, these comments won't make
much value.

-- 
With Best Regards,
Andy Shevchenko


