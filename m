Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10CF1925BC;
	Sat, 28 Feb 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772284728; cv=none; b=XIuUCQoziAKQwl/0ax3fxr5xfic1AHyH5k9VqTzqDnBsCK8pVMKP79xFVLuzRgXwxxThFLNSozT1gSGLeRQC3ly+iF4+25oocq29tfNzDtKr92d2AnOSOtcxsEl5SOpD6BZIOIGd2UK+rTW9v9BIUh4xS6I7TBWPhJfDHCKBVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772284728; c=relaxed/simple;
	bh=SA9cIL0f77Pz/kKvKvuVPWXe4KkPtcSzlIph+GQfX1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isGGBhQ++nJfkniSFv5i+7CPSp7qWO073gnDnuiurKp1N6jeBTXJalcjfVqmIYQu4WP1faZSQ5rfX0Yet3fH373E+s0P/6dylQgEFLhS/q/rawlNzibTCZCHHioELO4l8kJZhPn5uONRGc5ZCAtBUqTfmlq8LTsKiavGVH5XbN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n28e74sm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n28e74sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651ECC116D0;
	Sat, 28 Feb 2026 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772284728;
	bh=SA9cIL0f77Pz/kKvKvuVPWXe4KkPtcSzlIph+GQfX1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n28e74smDaOuiwY7tYKfHvIDvHusUt3WCbZ+Via1fXiW86igglff/fTWJdaPWh7rM
	 OwLxdbU7MISiFR9rpIrZoVIJjSv8xxmxGgt0h37Dqu//ppY+31H3gWXmyHfJqSMaeO
	 6dSpj77Lo8krMQ9WcF/h3ZtctwNAeANHUge5oumIbF9w6SnCB+PF+vXxdf/YybLW1I
	 AqaDUTTouG8Bp4XrLJEQIt5CopAMkpgD29wL+jYvBnNBfmR+6miyzQzhEe8O184Uxe
	 8W/p8Skv5YmJ2oIgplRD48Pfdy/bTXpgnXnb5baQGymXYxnfmVOILhaxvX+P0Xh9sT
	 nje9vNFprbnLA==
Date: Sat, 28 Feb 2026 13:18:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ade9000: fix wrong register in CALIBBIAS
 case for active power
Message-ID: <20260228131838.64d36016@jic23-huawei>
In-Reply-To: <CY4PR03MB33993FA37361E61ADD3522B89B73A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260226140700.481317-3-giorgitchankvetadze1997@gmail.com>
	<CY4PR03MB33993FA37361E61ADD3522B89B73A@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 10:01:41 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> > -----Original Message-----
> > From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> > Sent: Thursday, February 26, 2026 4:07 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > jic23@kernel.org; David Lechner <dlechner@baylibre.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Giorgi Tchankvetadze
> > <giorgitchankvetadze1997@gmail.com>
> > Subject: [PATCH v2] iio: adc: ade9000: fix wrong register in CALIBBIAS case for
> > active power
> > 
> > [External]
> > 
> > The switch statement in ade9000_write_raw() attempts to match
> > chan->address against ADE9000_REG_AWATTOS (0x00F) to dispatch
> > the calibration offset write for active power channels. However,
> > chan->address is set via ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT,
> > num), so after masking the phase bits, tmp holds
> > ADE9000_REG_AWATT (0x210), which never matches 0x00F.
> > 
> > As a result, writing IIO_CHAN_INFO_CALIBBIAS for IIO_POWER always
> > falls through to the default case and returns -EINVAL, making
> > active power offset calibration silently broken.
> > 
> > Fix this by matching against ADE9000_REG_AWATT instead, which is
> > the actual base address stored in chan->address for watt channels.
> > 
> > Reference:ADE9000 datasheet (Rev. B), AWATTOS is the offset correction
> > register at 0x00F (p. 44), while AWATT is the total active power
> > register at 0x210 (p. 48).
> > 
> > Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
> > Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> > ---  
> 
> Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
> 
> > v2:
> >  - Added Fixes tag (Andy)
> >  - Added datasheet reference (Rev. B, p. 44 and p. 48) (Andy)
> > 
> >  drivers/iio/adc/ade9000.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> > index 5dcc26a08970..1499fb1c718a 100644
> > --- a/drivers/iio/adc/ade9000.c
> > +++ b/drivers/iio/adc/ade9000.c
> > @@ -1123,7 +1123,7 @@ static int ade9000_write_raw(struct iio_dev
> > *indio_dev,
> >  			tmp &= ~ADE9000_PHASE_C_POS_BIT;
> > 
> >  			switch (tmp) {
> > -			case ADE9000_REG_AWATTOS:
> > +			case ADE9000_REG_AWATT:
> >  				return regmap_write(st->regmap,
> > 
> > ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
> >  									chan-  
> > >channel), val);  
> > --
> > 2.52.0  
> 

