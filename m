Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795226353;
	b=UhAWXmT0TZlEGPIU1zd2c39cy2DbcPRww27DFnGer5XEgvUnMXkmwKyCcxshLxyholMl
	 WOWUMdB9VP1W7xEUlyknnNtfFB/0+t1F0yOV1S7aD1qfWxpfS9GcrPIMsPOn5yowWkRxX
	 mQFxQN8wLHgLyTlOsjVYm9WmrqSxrXPm9YQIUe+onD07Fb4te+CgqfkWZvTgGVtt22QNf
	 zWUeG5o9pfTUl9mxBQgN1OpNGAujpyyJ0cgD/iecpdui067liBjz9kfTTlQdAVNW924EH
	 izsHCrKD4x7oqRfkbJ+3EvUbzsQWZGkASxVWx1qvoBxD3W+LymktPqAauTQ0g168j9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226353;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NYAbhIA7c7MZwjZMstl1hm1bcmlBpCrOMTte7E59bQI=;
	b=NOI17mSWWHuqhQXzv7LlyGjk8ykzsYdMvlKyVwGm7K5v2Rv95hlCo30vrAVU6uPggqbc
	 CernkJUbZUTMpa9OoZFAC8OmjGW2nOXJnggAvuiUT+WwOo6iJftGHOf7L3qFftfYwAKRC
	 brKDmSwdCRk1kxfwyzO7T3Ap1TWdWISxDttt059VqwVpVE3SyP5T1zcLkoOPBLKFvLg62
	 KySvRWExU8BodBYEJQJywDKklpW1LdpHugXPTJ8c7COwLa404cwLhl3E0l2YfMzUp6hGE
	 M7Sodi4OdPBwrUTBTrFY0O6HMmnNpcNo+U5wTQBwphZ/XiqlCAEyR5yxb6fbS28iRLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRbUlSM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83069606A693;
	Sat, 21 Nov 2026 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRbUlSM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DBF1F000C0;
	Sat, 21 Nov 2026 01:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795226352;
	bh=NYAbhIA7c7MZwjZMstl1hm1bcmlBpCrOMTte7E59bQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cRbUlSM1wNWhAEQUGPge+TTmVviFUieJH/19sVIIZjOW+4OoQDLpxQvwX+mrB+ZQ6
	 a92MPn4xFmjQAkdF+c4ot9xNxPtdxdaHRPQrsG/JlRbadA9k0xx9er+B1v7lLuMREE
	 Ag3PzBovsoUOs3kgWBnmH8odMRQ/A7YCvLOFUHZtdcT4JmiywNiIgm/gEkiDeDbfem
	 B0Vecui5mhckt2DgnsLvevT3wOEL6FTGfXOxoFZw1FhYhX+yhGulf+dVyqhFbDwWV1
	 s9j/xPjJ9wgGztWAGfnnITan11HCF7F9EEt6Gw6XUjYQ3T3BZgo2icT+nQpea/SZsE
	 2ZxXDwD+t4T6Q==
Date: Sat, 21 Nov 2026 01:59:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: mazziesaccount@gmail.com, sashiko-reviews@lists.linux.dev,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, open list
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: adc: rohm-bd79112: Support ROHM BD79111
Message-ID: <20261121015904.15215ca8@jic23-hlaptop>
In-Reply-To: <d2d8049d-7adc-4cfb-8e56-3af55c0abe8f@linux.dev>
References: <cover.1795176984.git.mazziesaccount@gmail.com>
	<4be17e339f768da93db2f42abd3cc5a21fea01ad.1795176984.git.mazziesaccount@gmail.com>
	<sashiko-outbox-225147@kernel.org>
	<d2d8049d-7adc-4cfb-8e56-3af55c0abe8f@linux.dev>
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

On Fri, 20 Nov 2026 14:53:32 +0200
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> On 20/11/2026 14:34, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issues to consider:
> > - [Low] iio: adc: rohm-bd79112: double semicolon in bd79112_probe()
> > - [Low] iio: adc: rohm-bd79112: unused BD79112_MAX_NUM_CHANNELS macro
> > --
> > 
> > commit d2b6757018d5ccee4c939ad0350d93a29d26239d
> > Author: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > iio: adc: rohm-bd79112: Support ROHM BD79111
> > 
> > This commit adds support for the 16-channel ROHM BD79111 SAR ADC and GPIO
> > device to the rohm-bd79112 driver.
> >   
> >> diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
> >> index 04084e88984a5..8bbb86098ff5a 100644
> >> --- a/drivers/iio/adc/rohm-bd79112.c
> >> +++ b/drivers/iio/adc/rohm-bd79112.c  
> > 
> > [ ... ]
> >   
> >> @@ -431,8 +458,17 @@ static const char * const bd79112_chan_names[] = {
> >>   	"AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",	/* 28 - 31 */
> >>   };
> >>   
> >> +static const struct bd7911x_chip_data bd79111_chip_data = {
> >> +	.name = "bd79111",
> >> +	.chan_names = bd79111_chan_names,
> >> +	.num_max_channels = 16,
> >> +	.init_disable_gpios = bd79111_disable_gpios,
> >> +};
> >> +
> >>   static const struct bd7911x_chip_data bd79112_chip_data = {
> >> +	.name = "bd79112",
> >>   	.chan_names = bd79112_chan_names,
> >> +	.num_max_channels = 32,
> >>   	.init_disable_gpios = bd79112_disable_gpios,
> >>   };  
> > 
> > [Severity: Low]
> > This isn't a bug, but replacing the remaining uses of
> > BD79112_MAX_NUM_CHANNELS in bd79112_probe() with
> > data->cd->num_max_channels leaves the BD79112_MAX_NUM_CHANNELS macro
> > unused.
> > 
> > [ ... ]
> >   
> >> @@ -509,7 +545,7 @@ static int bd79112_probe(struct spi_device *spi)
> >>   		cs[i].datasheet_name = data->cd->chan_names[cs[i].channel];
> >>   
> >>   	iio_dev->info = &bd79112_info;
> >> -	iio_dev->name = "bd79112";
> >> +	iio_dev->name = data->cd->name;;
> >>   	iio_dev->modes = INDIO_DIRECT_MODE;  
> > 
> > [Severity: Low]
> > This isn't a bug, but there is a double semicolon at the end of this
> > assignment.
> >   
> 
> Both of the Sashiko's findings seem correct. However, I wonder why it 
> picked the device-tree folks and dropped IIO people? This particular 
> patch didn't have binding changes but driver changes. (Well I added 
> Jonathan + IIO-list here)

Currently we haven't opted in to received emails to linux-iio but
device tree folk have. There was some debate at LPC on what sashiko
should do when this happens but there isn't really a right answer.

If things ever quieten down I'll restart the discussion of whether
we should opt IIO in.  I'm personally in favour but want to here
if anyone has a strong counter argument.   I think we can manage
the false positives for newbies issue as they are getting smaller
all the time.


Jonathan

> 
> Yours,
>    -- Matti
> 

