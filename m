Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609908;
	b=lQhLOyHte+szL9bnenK5GwGnGT9n/kx8bHbvsksCN5zMsGo4FKeC9wI+RQvkRpfnsuGG
	 JyDS8HebRi8vm0/JgCzixDnQwMEb52VVu3l5gidjmtE5GUXVvn6bMqNlEpna4ym9CmDuO
	 fefJWSjC6VDS5Zk9Mj6u5wjZgrkwbO5C7ek++zIJdCVC1HDFL0wGEckOrCueXmRBmh6ts
	 YTwYFTDKLakzeKcIBVxXKxZjGdN0Dz40p27pQt+PEnaSGymhd7tLFOg5gsCwSsUieZXd5
	 HyXx1LyP6DXRoDLiluEyucHpr9jIHmJ2TDiTbLrZVjixopaHC0KgP+B0kyz9nvDsj9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609908;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jcf3x1dhlzUjZokJjvUIUNbIn5rpxZvdTwoj2AJo140=;
	b=v/pjHwPEJ42nk1RxsumfacMg8T8RBj89otdZCchr2XLKog0fLHD9gk60jkveF8JXx5OX
	 7RfUodUT7tTR7lj8sLxhH7zjGJ7xlqQnruNfh/wfmOlrMl5smzAfGVbeTVORUk4+iiZAj
	 lnJyBHrXZIUihH0pJ+FeN1ozklxPZc5/sCbaPYykmiVBwsXzk0kXcCVLxQPdEZFWPJ3CM
	 m9qFCs1raQKV6k+5lMvJTuVo82mytOtO8SGsvi66Nww31ZckRWMED3MFOJRQESaLVGJMf
	 6gMA3tufey17+MXEQC7wP6Yc27SPFK5a6tPC8s2/r2STwu2MRSDhYAPqtVXjYGUGiMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ATq/bk8l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79D606A319;
	Wed, 21 Oct 2026 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATq/bk8l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59EE1F000C1;
	Wed, 21 Oct 2026 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792609907;
	bh=jcf3x1dhlzUjZokJjvUIUNbIn5rpxZvdTwoj2AJo140=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ATq/bk8lhTTBWfIXNNTUcs22y/q9Zf+SYKlAv+6ZGKVSzh7OE9TATuqlIbzBU3YXO
	 vh8k2gvJvgTx8kuWIByjdvPYMGwmm8r/InIQGFv91G1WQ8Njhay97eo9zWb6lgWZEo
	 XJ3ZCX7GrZhMRWC0h6/5UM8R1KWexFcGfkv/wKg2/DYEkmqoScqDUJBGQU6pfrOWtm
	 9P0uOtzqF4rne8uGoWVKslvWVnkDgQpaRTSSjrDwykPZgMRpeFJfsK/Q6qhUk6oV80
	 KXi/+i/E7P9SIGMPmpjgbPitdzbAEq8ztBt0hOI+Ydn65b3RZhtUxKZYulI5rv9o6c
	 g09WPuaDqTPug==
Date: Wed, 21 Oct 2026 20:11:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <radu.sabau@analog.com>
Cc: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Message-ID: <20261021201139.721f40a7@jic23-hlaptop>
In-Reply-To: <LV9PR03MB8414F2245D9201025D52136CF7982@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-4-f972d4efee85@analog.com>
	<20261017024110.601d9b6c@jic23-hlaptop>
	<LV9PR03MB8414F2245D9201025D52136CF7982@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 08:48:59 +0000
"Sabau, Radu bogdan" <radu.sabau@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, October 17, 2026 4:41 AM  
> 
> ...
> 
> > > DR_GPIO_MASK stays enabled unconditionally: DR pulses drive the FIFO
> > > controller's internal sample enqueue, independent of pin routing.
> > >
> > > Watermark is configurable via the standard hwfifo_set_watermark
> > > callback and the usual hwfifo_* sysfs attributes.
> > >
> > > Signed-off-by: Radu Sabau <radu.sabau@analog.com>  
> > Various comments inline.  Biggest one is I don't follow why we
> > need to stop the fifo (which is a ring buffer given overwrite can't
> > happen in a fifo!)
> > 
> > Jonathan
> >   
> > >  /* Self-test registers and masks */
> > >  #define ADIS16607_REG_SELF_TEST_DATA(x)	((x) + 0x23)
> > >  #define ADIS16607_SNSR_SELF_TEST_MASK	BIT(6)  
> 
> ...
> 
> > > +
> > > +/*
> > > + * Trigger handler - reads samples from the device FIFO. Triggered by the
> > > + * DEV_NOK interrupt, which fires on any DIAG_STAT flag, not just
> > > + * FIFO_THRESH_MET - the DIAG_STAT read below both checks which  
> > flag(s)  
> > > + * raised the interrupt and clears the latched status, and must happen
> > > + * before any FIFO pop, or we'd pop for nothing on an unrelated flag.
> > > + */
> > > +static irqreturn_t adis16607_trigger_handler(int irq, void *p)  
> > 
> > A trigger handler that is associated with a fifo is usually a bad
> > idea.  We often only use fifos if there is no trigger associated
> > because the meaning of one trigger ever scan is lost so they
> > become just a pointless intermediate layer.  Not sure if we can
> > do that here.  
> 
> Fair concern. I was looking at adis16475.c and noticed it already
> does the same thing for its FIFO variants (adis1657x family) -
> has_fifo = true, with a trigger handler that pops a variable sample
> count per IRQ instead of exactly one. adis_trigger.c backs this up
> too: it already special-cases FIFO devices with a level-triggered,
> threaded IRQ instead of the edge-triggered one used for non-FIFO
> devices, specifically because the watermark condition needs clearing
> over SPI before the line deasserts.
> 
> So I thought that since this pattern is already established in the
> shared library for exactly this kind of device, it made sense to
> follow it here, too. 

The adis library is old + the fifo was retrofitted much
later - I can't remember if we discussed doing it differently
at the time.  We might want to consider making no trigger correspond
to the fifo case just to be more inline with other drivers (whilst
allowing what works today by keeping that path there as well!)

Anyhow, as long as we have the validate callbacks to prevent the trigger
being used by another consumer then it is safe enough to still
have the trigger control being set.

Thanks,

Jonathan

