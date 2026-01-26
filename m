Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9B2C08D5;
	Mon, 26 Jan 2026 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421082; cv=none; b=qHMH4oZ1dNYOWTBy07DaTelPwtNOOZZXBWYl+sT9A6d5xZpTtX6NYmJRuOjiRnUNMouHlUmiV5zldEKSMzBRdq9kxcTTENYBbugm2ua5HQJahFYqqj1i/rQ06wsbumdCLAILB4YOw0xZSrRQpTpJpb52x6+XVRIKAt/NPLc1Vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421082; c=relaxed/simple;
	bh=0B+ki7zm3XlFyUpJlEmR6BoipBh4Fb3jpboWMAe4HL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goU3PQ1j0VeQVVXow4ARgp94C9CGwu3LLMwQU5luwzXEE8fDN95OpXtHNx43PD6/B0z2lv6/YAb3l6lhurYDnna3oVrz1HEGx0DJq4n6ZBgu6XtFTwWZLi/hhs2cXtF+defYO4kYCDlVtYb1myKBNqaVxDaeRQkEHtlqrK3QX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBmruUHJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBmruUHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769421081; x=1800957081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0B+ki7zm3XlFyUpJlEmR6BoipBh4Fb3jpboWMAe4HL0=;
  b=OBmruUHJ7h1XRN9ojCsVicjupnWe1h8lYUTgg8iZmLXSxi6SDLEdI2m6
   tUtMEYYwwh8jqK5OHgJ1IzhIIadVijfuKBEa4zYQCWuQfLTJfcG58DlrS
   9xsOvRu98tbH/tddjp1zizX4WF8zITTTrkYtCdTrosl5E47H9jc4OlLSt
   jF1M8nCS8R4x2Bjp4YEKpyIAU0c8rfTVhGIptU1A1Pp9oZ4goPOlfIuW9
   nnp/HkPBKymPXk5JU7XNTe8rXmJd0E3tzU6oayjSCmyK0sZ5JN5i4UpvV
   76lFlYe5aAH99uooJk/MbFDCGeYj4hKCfTEYlgpaLwnsEbT9E55Ht5uWH
   A==;
X-CSE-ConnectionGUID: XsZWEbHbTKSTlnj0v+iyBQ==
X-CSE-MsgGUID: DxcoA85mQK65cHIjZON1jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="74437917"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="74437917"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:51:21 -0800
X-CSE-ConnectionGUID: GuPCQ1lgSm6FdVtZjTBqsw==
X-CSE-MsgGUID: 2SFYT0vIQs6qbvwryJBCgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="245249365"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:51:15 -0800
Date: Mon, 26 Jan 2026 11:51:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <aXc5Efu-PlLNCxkk@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
 <20260126081510.jr8Rp6R7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260126081510.jr8Rp6R7@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 09:15:10AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-23 16:48:54 [+0200], Andy Shevchenko wrote:
> > On Fri, Jan 23, 2026 at 12:37:04PM +0100, Sebastian Andrzej Siewior wrote:

...

> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > > Cc: Puranjay Mohan <puranjay@kernel.org>
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Cc: David Lechner <dlechner@baylibre.com>
> > > Cc: "Nuno Sá" <nuno.sa@analog.com>
> > > Cc: Andy Shevchenko <andy@kernel.org>
> > > Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > Cc: Kent Gustavsson <kent@minoris.se>
> > > Cc: Gustavo Silva <gustavograzs@gmail.com>
> > > Cc: Nishant Malpani <nish.malpani25@gmail.com>
> > > Cc: linux-iio@vger.kernel.org
> > 
> > Move these...
> > 
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > 
> > ...to be here. This will drastically reduce the unneeded noise in the commit
> > message. The email will have (if using git format-patch and git send-email)
> > them.
> 
> Yeah but if I have to send v2 then they are gone, aren't they?

I didn't follow. How? What tools do you use?

> So I have to move them for each submission. Or is there something I am not
> aware of?

Make them in the tail of commit messages locally with a delimiter, they will
always be present as long as they are in your tree.

I dunno if `b4` manages the Cc lists separately. At least I see no-one using
`b4` *and* putting the Cc noise into the commit messages, so I assume it
behaves nicely.

...

> > > +		ret = devm_request_irq(dev, st->irq,
> > > +				       iio_trigger_generic_data_rdy_poll,
> > > +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> > > +				       indio_dev->name, st->dready_trig);
> > >  		if (ret < 0)
> > >  			return ret;
> > 
> > Interestingly that this driver ignores the flags from firmware... Seems to me
> > like a bug (not in your patch, obviously). Ditto for other drivers doing similar
> > things.
> 
> If the irq-chip is level or unknown mode on boot up/ default and the
> device can only operate as an edge-rising then I don't see why this
> should be a bug.

But if FW says use "level", wouldn't this setting override it?

-- 
With Best Regards,
Andy Shevchenko


