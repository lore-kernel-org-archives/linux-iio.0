Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1943E5588;
	Fri, 17 Jul 2026 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275822; cv=none; b=bJu9newGXsff4gt4Fw1T69h5glm4J1ARkwsWAELQKVGtqO0Bb4hjN5+oy4NZ7RD/18Qx8eDj/NiGEyPovib/LghdjlRYONo7N5GdScRx67vppGyxNl6TAY5ZK8lWKjVlbnwuZnzPLU3KT0lD0MddMQEu057bvQoTey3wMtErWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275822; c=relaxed/simple;
	bh=ysULjp5Oa3WR6QmXW6R6eigN81Bfk4tp2aEjStsfe6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvEVmo8OqaSqPaLZpt1FE/IrcBp0cbvS5rNUGnK5BE80fX7TdlxvcJC9AxsoueIs0UGn9j+bJGfd6dzak3obZ4zmIDEURQBzomD4R8I7wmOOB4UZlKZnPRWKyv4xvlDVwd15nWKY1FWbchqOYOj6p5YMmRo7AOVGkGG4WwX1AX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDZdChyu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDZdChyu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275821; x=1815811821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ysULjp5Oa3WR6QmXW6R6eigN81Bfk4tp2aEjStsfe6k=;
  b=kDZdChyuCMhPk5V441Q01IVg992OOYaQaltuu7++tvXdgy5thQNRkqzU
   YaCZf4SgUkozrEnJTSgF8fahq48KrsREyLbEW8KjqS/vBmWb+SsH1EVI9
   ZVnf0CdBBWUa/5uT6V+4oPmnQv3EmykzBht88VvyWW8tDvXCJ/eXKyH6G
   ZjpxTqB8R/jnqUgy/8zhCxjghd7/D2qWVK21H/XbM6HS9Lmvx4qwoxXLG
   LHgk5BMZwwWRJep6xPBTFsU2hT8sPYhtTN0fxGcAm2QzxmfNNuDMF59RY
   snq+s7jpiSCHNnQHlS1NdApKeJ8+o9kN+kVwI2NFmZFsiSN8GVtfM7Ppd
   w==;
X-CSE-ConnectionGUID: 2FKfhbaTQDeP+qIjjVmHMw==
X-CSE-MsgGUID: Bu8t+EFgQD2ea7iaM+Zz9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85061322"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85061322"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:10:19 -0700
X-CSE-ConnectionGUID: ydegRNYhR2KUPMM83pWnWA==
X-CSE-MsgGUID: inD9YyoGQUWfAlZtvfPSfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="281173130"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:10:17 -0700
Date: Fri, 17 Jul 2026 11:10:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: [RESEND PATCH 00/22] IIO: Clean out superfluous I2C checks for
 single transfers
Message-ID: <alnjZ1FuitIPJUYe@ashevche-desk.local>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
 <5e9b7479-ed16-48aa-bd4f-26abc09e690e@metafoo.de>
 <20260716162053.00006f99@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716162053.00006f99@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 04:20:53PM -0700, Jonathan Cameron wrote:
> On Thu, 16 Jul 2026 07:55:32 -0700
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> > On 7/15/26 5:57 PM, Jonathan Cameron wrote:
> > > Resend to include linux-iio. Sorry to all who get it twice.
> > >
> > > This came up in a recent review and I realised I have been giving incorrect
> > > review feedback for years. Both i2_master_send() and i2c_master_recv() plus
> > > the dma safe variants only ever return either an error or the full buffer
> > > size.  Short accesses do not occur.  
> > There is actually one interesting corner case. If 
> > i2c_transfer_buffer_flags() returns 0 i2c_master_{send,recv}() will also 
> > return 0, in which case the updated drivers will now read uninitialized 
> > memory. Maybe i2c_master_{send,recv}() needs to be updated to translate 
> > that to -EIO.
> 
> That's indeed curious (and I'd missed it entirely!).
> 
> So ends up being either the master_xfer_atomic() or master_xfer() callbacks
> returning 0.  master_xfer_atomic() is novel, it's a union with xfer_atomic()
> and no one ever sets it via that union element but given the types are the same
> all calls will actually be to xfer_atomic().
> 
> Could remove that complexity whilst here but there a bunch of related callbacks
> (e.g. master_xfer() in union with xfer() where drivers are still using the old
> naming and I'm not sure I want to chase that through various subsystem trees
> right now (though for fun - and maybe profit) I had claude work out a series.
> Was fun watching it write a semantic patch and spend a while debugging it.
> Glad it has as much trouble with coccinelle scripts as the rest of us.
> There are still a few hundred instances and I haven't touched all the callbacks,
> just this pair.
> 
> Anyhow, back to the question of whether they do return 0.  Yup they do :(
> 
> https://elixir.bootlin.com/linux/v7.1.3/source/drivers/i2c/busses/i2c-cadence.c#L1153
> 
> So any defense against that case would require hardening further up the stack.
> 
> +CC Andi and the i2c list.  Would anyone mind a patch to do something like:

I am fine with the approach but return value conversion needs a good
comprehensive comment on top.

>  static inline int i2c_master_recv(const struct i2c_client *client,
>                                   char *buf, int count)
>  {
> -       return i2c_transfer_buffer_flags(client, buf, count, I2C_M_RD);
> +       int ret;
> +
> +       ret = i2c_transfer_buffer_flags(client, buf, count, I2C_M_RD);
> +       if (ret == 0)
> +               return -EIO;
> +
> +       return ret;
>  };
> 
> Just to avoid the need for special case checks on ever call from every driver
> so that they return ret if negative or else have to check for non 0 return
> value and return -EIO or similar.   Maybe somewhere out there is someone using
> that 0 to mean something magic, but I doubt it.

> > > This series (also my first upstream series prepared by poking claude)
> > > removes the redundant checks from all IIO drivers.

-- 
With Best Regards,
Andy Shevchenko


