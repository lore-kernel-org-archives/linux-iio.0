Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C133F368;
	Sun, 23 Aug 2026 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523098; cv=none; b=OmgSLm8GXrbAgbAVBlUj6LcySlFeX0L8lX9AX8Ls9E8iyFL5EITy9UQ65ywZl05RRzuHevPeMxALCR840f1saGU5XJbIemMhFwN8wAVEIqw7wjFkqnMr0NRnZ/dPYq+kJLqtHQIni7ez8T4Au0iisg24aKlec/o3Wmqmbp/yv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523098; c=relaxed/simple;
	bh=f3kzzOsSLoN7Mivi2J26DBYSTIx3tQMfep4Vi915nVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5u35m1dvUopoAU9Kk0N08ueqsstavUUe61xsl6pEUem+FoGbdCYyrKXabvi6RWK4Hj3X0fNwcw9z/+9OgwrrtdDte4jAzBdcOKKea7/pYxPIATHBD2WOE+sXdPvc/Ar+gh2RFYMRwxPdQXPDEKVcFO0rtKW3ex5QR2vDuU1KcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNTVIHJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNTVIHJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFCD1F000E9;
	Sun, 23 Aug 2026 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523096;
	bh=8Hi52ZeraJfeHID8tmYvHF9THiuOhYYQdOnQOHQrORU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BNTVIHJ60cxsI5KIHtU1imgz1/Fkw2wh8iJWkEu5rq2d94Jwb3eyEkUqzojLbg74d
	 tz3TR/XXa+8j+h4ieb2Tja2lBIG0btzHJzk8gC4r56970IqxulfjJaveuRq/nb0j3q
	 5hNaogw9/cZhNMwutOshiN+hEQwqxgOiGy8iQpub5nrXIJ76gwOYEkvrcJiBU0o1dV
	 nxGVDMRTD/JRkS9K2eqDgBeGos53+q0Wcuqk3QcasQghdbssyU9Ir4x0Rejt8S0KDT
	 dehAm6/xwW++0ZAktP9FH8TlFufTLgdqvWTeUZo0yxXmRgle83xaZkd/5pRxR52E9K
	 x4NC/qJwag1HA==
Date: Sun, 23 Aug 2026 23:11:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Danilo Krummrich
 <dakr@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Dixit Parmar
 <dixitparmar19@gmail.com>, Keerthy <j-keerthy@ti.com>, Samuel Ortiz
 <sameo@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, amitk@kernel.org
Subject: Re: [PATCH] iio: adc: twl4030-madc: read MADC_CTRL1 from the
 correct module
Message-ID: <20260823231130.3a70e451@jic23-huawei>
In-Reply-To: <20260816020607.1f35a5b2@jic23-huawei>
References: <20260805123201.219547-2-giorgitchankvetadze1997@gmail.com>
	<20260816020607.1f35a5b2@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 02:06:07 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed,  5 Aug 2026 16:31:59 +0400
> Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:
> 
> > From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> > 
> > twl4030_madc_set_power() does a read-modify-write on MADC_CTRL1 but
> > reads it from TWL_MODULE_MAIN_CHARGE while writing it back to
> > TWL4030_MODULE_MADC.
> > 
> > Fix it by reading MADC_CTRL1 from TWL4030_MODULE_MADC
> > so the read-modify-write operates on the register's actual
> > contents.
> > 
> > Fixes: f99c1d4f94f9 ("mfd: Add twl4030 madc driver")
> > Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>  
> Whilst I agree this looks likely to be correct, the register
> map for this device is crazy, the defines not named in helpful
> way and generally it is hard to be entirely sure what was intended.
> 
> So, can you provide some background. Is this a problem you ran into,
> code inspection, or AI looking for possible problems?
> 
> Have you checked what is in the register that seems to be being
> incorrectly read?  Basically I'm looking for more detail. 

I'm going to mark this as changes requested in patchwork given
the patch description needs some more info on how it was found etc.

Thanks

Jonathan

> 
> Amit is listed in the original driver and is still about - so...
> Amit any idea?  Was at least 12 years ago (I got bored looking
> beyond that) so feel free to say you have no idea  :)
> 
> > ---
> >  drivers/iio/adc/twl4030-madc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> > index 0ee7e16b5e24..1156e68ebd91 100644
> > --- a/drivers/iio/adc/twl4030-madc.c
> > +++ b/drivers/iio/adc/twl4030-madc.c
> > @@ -718,7 +718,7 @@ static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
> >  	u8 regval;
> >  	int ret;
> >  
> > -	ret = twl_i2c_read_u8(TWL_MODULE_MAIN_CHARGE,
> > +	ret = twl_i2c_read_u8(TWL4030_MODULE_MADC,
> >  			      &regval, TWL4030_MADC_CTRL1);
> >  	if (ret) {
> >  		dev_err(madc->dev, "unable to read madc ctrl1 reg 0x%X\n",  
> 
> 

