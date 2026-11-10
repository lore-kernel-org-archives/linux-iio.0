Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305844;
	b=0OJWrPViLJQ8/Dc5tQ2lykJRaeKONzWimhp5UybzbhlavUfN5XY68ukY7+1EbxLGd6jF
	 9xvSPJWm6e4otngDK3QuHJzFfgZn4LuIfWF5kb1AduODQkSGWb6WFm6ELQ83GeQVXXLEd
	 DzVFXawIkCZJRaJ8v0Jb4xsg+eOrp+h+JydLF2RWMtVJ1t3gaJTMOVzGxT73HergioSXy
	 TQVEoDOAYKLErVpmFr0SUxpuAUdmm03ucRue1b2R3SZx3Qfwi31Jshe3ZORfYxbcCf+LS
	 lB9yWvNE3jtnp4SLi8yBVsmHUCeePzDKTraCduDnDVzDp5L4/R7iFtQVSebN/gu1QHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305844;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=EiiyUW4LhfhoupdBR6K/6xhO2OGTwywPtZJXF5QlIQE=;
	b=WVDgY+GGKZJRwAciKVS+fSPMIiy7QXcx5xExeeY1vutANKXNnQ0XnSg8KjwnFTkMc0bV
	 pOPtr35jJQ7z8LXDrfFqOcu2wBRtjOEx5U54HfTg6u4RrPoFN2y/3rUPtIl6sbIiilpG4
	 CLTeoBO4GBl3SNpjlojK8RiSCjvPevcVb1m2xG8TAg0htm8s1yrGV9kZVZKYj+MqNW8k4
	 f6quC0s02FBwTgfFaybLbyVyJq4he6lC+YD95HcAf+i8UZn+V7vPILyrh9lZpOwHMuclK
	 VdLeBXvg1fy6YYx5SGxEqP3VmA/Nxdi5wIMj1mSrruLSVVB/wFkpLqiQZJdz8tJvM5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZKA5cNCp;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B28606A31C;
	Tue, 10 Nov 2026 10:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B28606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZKA5cNCp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794305843; x=1825841843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nfRCJYywYAsVBk0ZrF3rtdPYsdfYfXANdK0WmfFSxTY=;
  b=ZKA5cNCpEnmT5K4ITVjeW/anbXqqUF+kbeayUE9AydndcuSA0KOLO/Ue
   3bjoe4LHIqROZyT5GmDVSEQnQtKtpwhTHl5WKrYNxQerj9860Bzc+rLvH
   4wgSg7gnGsury7gEwMSkrGr4Tm/8ch0QWfpV/CfPqEHLzl5Ec9NFSUuPI
   rk4d7wrxeB96mF/Fr34nGZ+DbhfAEInux0vxFB3xgcIgNnEI+OVX6IHsD
   hHHIhoaaZrL6S3ypWAQ6xhOJp81qtk+bIgVT+ldwupgXcapxCLXMxwn9n
   RvuI8Dg3lzt5W1ga9j7b00DHh0kmQhb+f6Bxxn0DNe4EXOGpxqJRve0gK
   w==;
X-CSE-ConnectionGUID: z4lkS0BPSO6Yslp86PVblA==
X-CSE-MsgGUID: 97gqcW+tSM6bDeJT7HUvfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3036364"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3036364"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:17:14 -0800
X-CSE-ConnectionGUID: TfOWLCMdTlW/PctG7Vggjw==
X-CSE-MsgGUID: YM1TXIzlTs6/TrxsyFwXLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7946583"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:17:11 -0800
Date: Tue, 10 Nov 2026 12:17:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: adux1020: fix interrupt clear value on
 SMBus-only adapters
Message-ID: <avLvJK2SmQ5Gs9Xm@ashevche-desk.local>
References: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
 <20261109-adux1020-measure-fixes-v1-1-fe1ba63f28bc@gmail.com>
 <avJcESOPo2nGq5wy@ashevche-desk.local>
 <CAJsKa+6JDCVLtWsfQ0gJzX185ywWiYA_FwbV52q=N7vzgRYDVA@mail.gmail.com>
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
In-Reply-To: <CAJsKa+6JDCVLtWsfQ0gJzX185ywWiYA_FwbV52q=N7vzgRYDVA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 08:12:06AM +0000, Raffaele Tranfaglia wrote:
> On Mon, 9 Nov 2026 at 23:49, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Mon, Nov 09, 2026 at 11:39:02AM +0000, Raffaele Tranfaglia via B4 Relay wrote:

...

> > > adux1020_measure() clears the mode interrupt by writing the inverted
> > > interrupt enable mask to INT_STATUS. The mask is a u16, but integer
> > > promotion makes ~0x00f0 evaluate to 0xffffff0f, which does not fit in
> > > the 16-bit register.
> >
> > Huh?! Where did you get it from? the mentioned promotion may only happen for
> > a signed char which may not hold 0x00f0 in the first place. The above is some
> > nonsense.
> 
> The integer promotions apply to all types with a rank lower than int
> (e.g. char and short, signed or unsigned), as long as int can represent
> all their values (C11 6.3.1.1p2 [1]). For ~ the standard says "The
> integer promotions are performed on the operand" (6.5.3.3p4 [2]). So the
> u16 0x00f0 becomes the int 0x000000f0, and ~ yields 0xffffff0f, which
> regmap_write() receives as an unsigned int. sizeof(~v) is 4 for a u16 v.

Indeed, I missed that u16 --> int, which is signed. Oh, well...

> It is also what I observed: with i2c-stub (SMBus only), every read of
> in_proximity_raw fails with -EINVAL from the val > 0xffff check in
> regmap_smbus_word_write_swapped(), and succeeds with this patch.

Can you give a Kunit test case? Because regmap specifies the val_bits == 16.
See also [3].

> That said, I can reword the commit message to make this clearer.
> 
> [1] https://port70.net/~nsz/c/c11/n1570.html#6.3.1.1p2
> [2] https://port70.net/~nsz/c/c11/n1570.html#6.5.3.3p4

[3]: https://lore.kernel.org/linux-iio/avLpEA6CoZvicvDN@ashevche-desk.local/

> > >       ret = regmap_write(data->regmap, ADUX1020_REG_INT_STATUS,
> > > -                        (~adux1020_modes[mode].int_en));
> > > +                        ~adux1020_modes[mode].int_en & 0xffff);
> >
> > On top of that regmap should limit the value to 16-bit anyway. If there is a
> > problem in regmap to cut the upper bits, it should be addressed rather there.
> 
> Currently regmap is inconsistent here: the SMBus backends in
> regmap-i2c.c (and regmap-fsi.c) reject out-of-range values with -EINVAL,
> while the formatted plain I2C path silently truncates them. If you
> think regmap_write() is the right place to mask the value to val_bits,
> I can try to fix it there as a separate patch to regmap.

I believe this is due to some specific value formatters in the regmap, where
format_write is defined (!= NULL) or other similar cases.

> However, even if regmap changed, the driver would still be passing a
> 32-bit value for a 16-bit register.

Is it a problem?

> regmap_write() takes an unsigned int, but logically it accepts values of the
> register width, so I think the driver should be fixed in any case. From a
> quick search, this is also what other drivers do when writing an inverted
> value to a narrower register, e.g. ad4691 uses ~BIT(chan->channel) &
> GENMASK(15, 0) and zpa2326 uses (u8)~ZPA2326_CTRL_REG1_MASK_DATA_READY.
> Fixing the driver is also the change that can be backported cleanly through
> the Fixes: tag.

Well, I disagree based on the above analysis. But if you make a KUnit test case
(against regmap) to prove your point, it will be well appreciated!

-- 
With Best Regards,
Andy Shevchenko


