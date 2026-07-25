Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C84315A;
	Sat, 25 Jul 2026 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785021733; cv=none; b=opTlGwc8ft50vNpXKByrDLgaXDbajojGRT0fG2tG+RyLP8/MFSgqBE1Rg1xdsAc5ypto2iTfTkrmMCbiaq7asYkIxAtSZh5Gf0DLe8qJ+J6fa2ob+PI4Ibth3kTfejRDiB7AyMp157iTB6xb79jJIdBOATDVBn1czvGtkDrr4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785021733; c=relaxed/simple;
	bh=SzVLgUKYaMD+q6mYMWOilW8nqnYRLr7D3gv0LVTRnC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2zBIQ/GSdMNtNiFqUolc1VO066Qw6BbOPCc/3nu5vNSRz6OCyJG8emT1gfU1wAC3nPGgC7YhlEc70jwwhMdwuTmOxsA3aItjSUTAsqIGhlTg1LEQi73qTu460yWdCbTmGZae+B70bmpsircX2u4/GaHMZLOrHJQpPcXp1cbj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP0wmIxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP0wmIxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42441F000E9;
	Sat, 25 Jul 2026 23:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785021732;
	bh=+RBwhLME/iRlsoD3xj/9o1j7XDqnjEXQBMs9cqxKEJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LP0wmIxdY6fl0lRc4GwFXjGdE11rnt9so3UPAb7Nx7b08P6YgdyGmYnxaa+fd1SmV
	 c2N4LJ1VG2o/E6LO0eSPc6f1zM4tTRyPNx4jrqNPR3zAroQyqx1O2KCjvvcKeMhKsD
	 mk0EmEGX/0X/vxkSS8aifYH/mOTZiweXMnxP/E0hwJ13Mynd0QZAqXOxW4dv9WCKVe
	 XfMb3cRwn8+Ta26hrP9MvlnyHEe4H7WzoS615TmmNCqTaFIU5l42PXo5wD4g13fxId
	 dsB+5SxzLVPCdHgaG2pryiygcmmbMIFejqzVTKA6xmMMHKaWxultgXd785/DgdYTAa
	 7gt+npQKoMA5w==
Date: Sun, 26 Jul 2026 00:22:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Amin GATTOUT <amin.gattout@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91_adc: use const char * for DT string
 property
Message-ID: <20260726002207.0ca83c96@jic23-huawei>
In-Reply-To: <3314a217-5e6c-44cb-af8e-1327c375c4dd@baylibre.com>
References: <20260722-master-v1-1-ab0591897e4b@gmail.com>
	<3314a217-5e6c-44cb-af8e-1327c375c4dd@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 14:47:08 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/22/26 2:39 PM, Amin GATTOUT wrote:
> > Declare the local variable as const char * and remove the unnecessary cast
> > when passing it to of_property_read_string().
> > 
> > Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
> > ---
> >  drivers/iio/adc/at91_adc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index f610ad729bf3..0ac74ad92fca 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -988,7 +988,7 @@ static int at91_adc_probe(struct platform_device *pdev)
> >  	struct iio_dev *idev;
> >  	struct at91_adc_state *st;
> >  	u32 reg, prop;
> > -	char *s;
> > +	const char *s;
> >  
> >  	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
> >  	if (!idev)
> > @@ -1023,7 +1023,7 @@ static int at91_adc_probe(struct platform_device *pdev)
> >  
> >  	st->res = st->caps->high_res_bits;
> >  	if (st->caps->low_res_bits &&
> > -	    !of_property_read_string(node, "atmel,adc-use-res", (const char **)&s)
> > +	    !of_property_read_string(node, "atmel,adc-use-res", &s)
> >  	    && !strcmp(s, "lowres"))
> >  		st->res = st->caps->low_res_bits;
> >  
> > 
> > ---
> > base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
> > change-id: 20260722-master-23179d7c00c4
> > 
> > Best regards,  
> 
> Makes sense.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> Although perhaps could be simplified instead by using
> of_property_match_string().

Whilst I would prefer that it 'might' break a bad device tree given
the current code is a match against one of the two values.  If we start
matching explicitly against them any issues would become a probe failure.

So given it's ancient and I don't want to mess too much with it, applied
this lower risk patch.

Jonathan

