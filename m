Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4F19D065;
	Mon, 17 Aug 2026 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933146; cv=none; b=oNJrOl2k2W2U7ReUEbNoe7BhmAs6+NOKjVvU3FiHQoId3s26EKyNVW/Mynh+gzXgBGl1BeF+XytpTBpv2V5Fexkey8AvWTSXNAuJL6HYx5S/6xwdsOzgwInA77cxrldZj39eXHlbQpxLR2IKZo6JgyNfIovfjKMghs4+43qG0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933146; c=relaxed/simple;
	bh=/Su4aawtFNWR2y+pzMi40ljiCa3aKN7WknKYdx6vWmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOzvxiKcg+B+vredhm+7Pni4AD+6DdUx70hI8o1gdHOSAhEKjTc03vfwwq/vmk7jLSmJ8uM3J7+yNqlhthctR9NpLseUVpr/pmVRwv13jjv1nuEZ+m0EMuHZZM7jTgJZFdE019vWJAytoC4WLxqtKalgJqoJ0qcCDNSrk91j0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDOikprP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDOikprP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAE71F000E9;
	Mon, 17 Aug 2026 02:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786933145;
	bh=zh5he2Ug5qoM+jVaBV/zHHembW7rCop8VvPY2b0FbFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GDOikprPvyUV11FtPBaBtyJy176v/XOd1C8XK/L8Ys73vciH/a6anPGLzqj3qRcLW
	 xoZuIfbgAb44lQOEDnZQnb0YMo9SORYWsuhi60UztCtLrxep8ngrTcg9b1+Vn7jm5w
	 h+EQZuzyOTmuWlu1R+r8M0LHua6lG+rxHBBWHgFdyAkz/K741uKmqje0duXTZvZMcS
	 gkh2WxIIkGS5JZrurxKlBCIvczg8ZW/nWL0GA7ExDnD66+sm22D3Y620yDtNue1Tzd
	 HxDpZdicsYTk90m0hWcYIPVYDbfv+wJpaBKauS9Fj2U4hWmLZPYZhBD4QEW6roWdTR
	 nw72cQZW7HUDg==
Date: Mon, 17 Aug 2026 03:18:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, Jean-Baptiste
 Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v4 2/3] iio: imu: inv_icm42600: log whoami mismatch
 instead of failing probe
Message-ID: <20260817031859.31212035@jic23-huawei>
In-Reply-To: <anoqWLNK9_MzU1YP@ashevche-desk.local>
References: <20260810191157.125550-1-jorijnvdgraaf@catcrafts.net>
	<20260810191157.125550-3-jorijnvdgraaf@catcrafts.net>
	<anoqWLNK9_MzU1YP@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 22:45:28 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 10, 2026 at 09:11:56PM +0200, Jorijn van der Graaf wrote:
> > A WHOAMI value differing from the one the compatible implies aborts
> > probe with -ENODEV, which prevents a register-compatible part described
> > with a fallback compatible from probing at all.
> > 
> > The devicetree compatible is authoritative for which part is fitted:
> > log the mismatch at info level and continue. The message keeps a
> > breadcrumb for anyone seeing an unexpected part change on their device
> > versus the devicetree; tmp117 takes the same trade at the same level
> > for its fallback matches.
> > 
> > A whoami of 0x00 or 0xff still fails probe: SPI has no transfer-level
> > ack, so those values mean nothing answered; this is the same
> > no-response guard inv_icm45600 carries. Otherwise the probe outcome on
> > mismatch changes for all parts the driver supports.
> > 
> > Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
> > ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
> > and matched as icm42631, probes with the one informational line, and
> > accelerometer, gyroscope and temperature reads work.
> > 
> > Suggested-by: Conor Dooley <conor@kernel.org>
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>  
> 
> > Link: https://lore.kernel.org/all/20260722-creature-volley-0f083b904c1d@spud/
> > Link: https://lore.kernel.org/all/20260728222015.6a62b287@jic23-huawei/
> > Link: https://lore.kernel.org/all/20260801032310.18f5f16d@jic23-huawei/
> > Link: https://lore.kernel.org/all/20260804-scarily-hacker-651df3eafea9@spud/  
> 
> What are those links for? I haven't seen references in the above text.
Yup. That needs tidying up or the links dropping.
> 
> ...
> 
> >  	if (val != hw->whoami) {
> > -		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
> > -			val, hw->whoami, hw->name);
> > -		return -ENODEV;
> > +		/*
> > +		 * SPI interface has no ack mechanism.
> > +		 * 0xFF or 0x00 whoami means no response from the device.
> > +		 */
> > +		if (val == U8_MAX || val == 0)  
> 
> This is strange to be here. If hw->whoami happens to be 0x00 or 0xff (let's
> assume some hypothetical future case), this check will become invalid for them.
> 
> If it's guaranteed to be not the case for any HW (including the future variants)
> this check should be outside, no?

Hmm. This one has both worked in favour of finding connection trouble
and bitten us in the past. I vaguely recall a device that indeed
had a WHOAMI of 0 (though it might have been a hardware bug) and
tripped on such a check.

Personally I'm not that fixed either way on this. If the device isn't
there we should know the moment we try to get any data anyway.

> 
> > +			return dev_err_probe(dev, -ENODEV,
> > +					     "invalid whoami %#04x expected %#04x (%s)\n",
> > +					     val, hw->whoami, hw->name);
> > +
> > +		dev_info(dev,
> > +			 "device id %#04x is not the %#04x associated with the FW-specified device (%s), probably using a valid fallback compatible\n",
> > +			 val, hw->whoami, hw->name);
> >  	}  
> 

