Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682260;
	b=dYrtemFy835VUk3TCG7zdaXcLQGqoOT1djJXaUmt1+a1w9kSY1ZfFhJTDNATbUR4Fpzf
	 euHu0lUB+EQ86GfcUu8L0HjZ6BseksSk1sBG0dSw7wjUWGXaMc0phoIU7Kw+3kuztGJiR
	 oLCrtApfI3hK/PoMqTRQJlYneIduk1+ijmZUwMdvVOaNB53rg9DkM08KKMGAkhjeDLzET
	 fagblts2E54Tvgw+dCgsd+suKZa8sQOi+OdWb/UJ/u/z/H2GXMb3zb4/S24WQh7NhQjca
	 MTecQzqtbwqv4eKmto0r/TPPZMxqAKlnbQ8p1w3kqd0GUqk45dHK0FnZ/WA7Dc0ZaWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682260;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sMXrHsolRG3J/I2nE1oI1F3DJZKjH3O2j2E6lRmGAtI=;
	b=N1J72bmZiohbAT6uEicY+mu1a337nDkXkhojjtgXONmWkaJRDL+i7I1VZwTrwvbLICGd
	 in71SfmXpvANoQRUtgw4NjGRFM8V2ZrqpI+/tx72Rj4ff9CtVvfrG/BFtmHSXRBnTrRdi
	 duWOHrKwOTiV6Njz2qczPZhVv3FYVhUYwtUekbKugMuAO/ww05zODjHF/sDVTvhhrmrC8
	 Wd/dNEDimrwp6z/I0oHm0C8UwFla1Ef5u3B9ErDDRjpW+L82Qyli2GDSbYig6gfj9ppjM
	 yR1zAI1Db3yp4Gr7wHiJuBo+m++yaKmIFbefnnqfqsqOpBSI5cRfMEgmQFw8eOVzKMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlsSzBI4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E96606A329;
	Sat, 14 Nov 2026 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlsSzBI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCB71F000C4;
	Sat, 14 Nov 2026 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682259;
	bh=sMXrHsolRG3J/I2nE1oI1F3DJZKjH3O2j2E6lRmGAtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NlsSzBI45RTY2QD9JZZw15/cPFKHjhMg1sEMEBxkV8amdg1yO+DFVQ8AQqHYY0z5L
	 jLO7hZiQS0cqtBZ68PLHxfjCWzE7EJAJHPFzXQx63FHzG0S4XE6FZ4grX2dWC4Ih5f
	 rvcGcgSTx6Fs7qzSYnN+fiGVYf997qz9wsTJFwqspOPNZI5xchKyzHRea03RDyxBUx
	 ZV8pGBQREZ5dfECdGUF/1oOF7pOed9HxTfJ5JMRvWaN73lIXS/Jdw1fm/FldNWmZrZ
	 JtH6Ok24KutZDvWBMjCZuXBj25LaiYExQ04VwC7l62ECsPgSZocMAVi/fgXZweQn7Z
	 +fNbHAAymlQGg==
Date: Sat, 14 Nov 2026 18:50:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "=?UTF-8?B?TsOtY29sYXM=?= F. R.
 A. Prado" <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] iio: adc: mt6359-auxadc: mask conversion ready bit
 in mt6358_read_imp
Message-ID: <20261114185050.1aa08612@jic23-hlaptop>
In-Reply-To: <hAkgxe6jt5EJW-8bHBs53r3CWCxKxjjzGm6u-l-RzYaGedsBunJrv8nOB48zDSLaMD_jJqtC1Xt1wlz0zDdGF28li-clCdIjUzE9xSbh7Hk=@protonmail.com>
References: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com>
	<20261103-6768-6358-fixes-v1-2-2a868a33152b@protonmail.com>
	<20261103234540.46cc8c1b@jic23-hlaptop>
	<hAkgxe6jt5EJW-8bHBs53r3CWCxKxjjzGm6u-l-RzYaGedsBunJrv8nOB48zDSLaMD_jJqtC1Xt1wlz0zDdGF28li-clCdIjUzE9xSbh7Hk=@protonmail.com>
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

On Wed, 04 Nov 2026 00:19:33 +0000
Roman Vivchar <rva333@protonmail.com> wrote:

> On Wednesday, November 4th, 2026 at 1:45 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 03 Nov 2026 18:32:08 +0200
> > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:
> >   
> > > From: Roman Vivchar <rva333@protonmail.com>
> > >
> > > In mt6358_read_imp() the raw ADC value is returned directly without
> > > masking out ready bit, resulting in incorrect battery voltage reporting.  
> > 
> > Can you add where the ready bit is.  That might help someone
> > looking at wrong values and wondering if this is what is causing them.  
> 
> It's at the end of mt6359_auxadc_read_adc() function, which is included in
> the commit message. Do you mean include the code part too?
> "*out = val & GENMASK(chan->scan_type.realbits - 1, 0);"

Nope. I mean which bit is the one that will be set and shouldn't be.
Is it Bit 15 for instance? 

Just having a note in the commit message may help someone (or these days
an LLM most likely) find this.


> 
> > This one is pretty glaring as bugs go (given I think this means the
> > top bit is set?) so any reason it wasn't obvious to anyone testing
> > this device?  
> 
> I can't really tell if the driver was properly tested. As far as I understand,
> Chromebook devices use some embedded controller, which likely manages this
> kind of stuff without PMIC ADC. There's no in-tree mobile SoCs with mt6357,
> 6358 or 6359, nor fuel gauge or thermal drivers (yet), so maybe that's why.
> 
> > Jonathan
> > 
> >   
> > >
> > > Apply the mask to strip the ready bit, matching the behavior in
> > > mt6359_auxadc_read_adc() function.
> > >
> > > Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
> > > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > > ---
> > >  drivers/iio/adc/mt6359-auxadc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
> > > index 951d236f972b..09432d0974cf 100644
> > > --- a/drivers/iio/adc/mt6359-auxadc.c
> > > +++ b/drivers/iio/adc/mt6359-auxadc.c
> > > @@ -502,7 +502,7 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
> > >  	mt6358_stop_imp_conv(adc_dev);
> > >
> > >  	if (vbat)
> > > -		*vbat = val_v;
> > > +		*vbat = val_v & GENMASK(chan->scan_type.realbits - 1, 0);
> > >  	if (ibat)
> > >  		*ibat = 0;
> > >
> > >  
> > 
> >  

