Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC661EFF8D;
	Sun,  2 Aug 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785691213; cv=none; b=PkSN5SeBrFO1Q781FSKARDS36Ni5sh6mFAtKqzACs6z6JW1PALx9ZsJw2q9d7vUcf2G8COkCvfbi0vRgdOkapzDuGU1auRAr4sEg7vE+HrdBgTml8wNzhMmBHh/aTAv8jJuHG3tmeIk+SDbZgr2UQJbQE151CNy6ZXUavHbwde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785691213; c=relaxed/simple;
	bh=e7egtbVJvt3W6WK50mjwooxrC86vQpNye1bWxT3HcKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STg91LCyMSG4IaYkAtlTxvjP7h7Z0fypEUVWVyivh68b3it3Dvj+SFpDZBxASiVrY40h5rBnCzohX9ZKP9LEIEM9MfegzdSz+mSrZHUsBnD6pbRVO20Jfm2Yn7+c6KcCd4xfr/GOnjs/WeDFO36HqVYMnsrTcHfeiUHgAbKH4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS8V0x/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS8V0x/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676D31F000E9;
	Sun,  2 Aug 2026 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785691211;
	bh=TtFKY9tlREPJCcadsF6YiRwrg4UX4kRMx1CrYAQF59w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YS8V0x/VVbTxFVkzD4lODlzFMrsQGBxsFhlXTBsMpkcPs+8zfYTKrJc6vFdSCuZBS
	 gJgKQLK1dTrW1OLtviQ+7awLB1IcbusiS2IeK5uEMaIYAJd9i9V729BWnyzyqaNGDN
	 TT+FF7UjP97LDgdMECEpSGZQi/DLKsEs/808T3ZQfpvHpyVDSfjoqO1t7k5LzovAI/
	 5VBqKYuuEzN0QKDn8o81pf9ullnY9kdd3Wh1yfRkvcmL9c/JjncNgmsdcf1b7joTgg
	 xcMXEA3bSl8RIqPJ8nvxpKSUHBY8Q7xIJ3jC9028km6hrIZSXn5/rc81AUXT2sXp8o
	 R+0IPCkmbGwaw==
Date: Sun, 2 Aug 2026 18:20:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Wadim Mueller <wafgo01@gmail.com>, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 maxwell@maxwelld.cc, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com,
 455.rodrigo.alencar@gmail.com, Rodrigo Alencar <rodrigo.alencar@analog.com>
Subject: Re: [PATCH v6 3/4] iio: core: add IIO_VAL_DECIMAL64_FEMTO format
 type
Message-ID: <20260802182007.7ebc8847@jic23-huawei>
In-Reply-To: <cfb955b4-0843-48aa-b201-fa60aceb03f9@baylibre.com>
References: <20260728214943.29820-1-wafgo01@gmail.com>
	<20260728214943.29820-4-wafgo01@gmail.com>
	<cfb955b4-0843-48aa-b201-fa60aceb03f9@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 11:01:28 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/28/26 4:49 PM, Wadim Mueller wrote:
> > Extend the IIO_VAL_DECIMAL64_* family with a femto-scaled variant
> > (scale 15), following the existing MILLI/MICRO/NANO/PICO pattern. Both
> > the read formatting path in __iio_format_value() and the write parsing
> > path in iio_write_channel_info() (via kstrtodec64()) already derive
> > their scale from "type - IIO_VAL_DECIMAL64_BASE", so the new type only
> > needs to be added to the respective switch cases.
> > 
> > This is needed by drivers reporting very small SI quantities where the
> > existing pico scale loses precision. For example the Sensirion SLF3S
> > liquid flow sensor reports its volume-flow scale in m^3/s, where the
> > SLF3S-0600F scale is ~1.667e-12 m^3/s: at pico scale only a single
> > significant digit survives, whereas femto scale preserves the full
> > sensor resolution.
> > 
> > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> > Reviewed-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  drivers/iio/industrialio-core.c | 2 ++
> >  include/linux/iio/types.h       | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 37cf2817b3d0..767a7794624a 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -715,6 +715,7 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
> >  	case IIO_VAL_DECIMAL64_MICRO:
> >  	case IIO_VAL_DECIMAL64_NANO:
> >  	case IIO_VAL_DECIMAL64_PICO:
> > +	case IIO_VAL_DECIMAL64_FEMTO:
> >  	{
> >  		int scale = type - IIO_VAL_DECIMAL64_BASE;
> >  		s64 frac;
> > @@ -1032,6 +1033,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
> >  		case IIO_VAL_DECIMAL64_MICRO:
> >  		case IIO_VAL_DECIMAL64_NANO:
> >  		case IIO_VAL_DECIMAL64_PICO:
> > +		case IIO_VAL_DECIMAL64_FEMTO:
> >  			dec_scale = type - IIO_VAL_DECIMAL64_BASE;
> >  			fallthrough;
> >  		case IIO_VAL_INT_64:
> > diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> > index 924ac9dc6893..d8944c9e5e90 100644
> > --- a/include/linux/iio/types.h
> > +++ b/include/linux/iio/types.h
> > @@ -42,6 +42,7 @@ enum iio_event_info {
> >  #define IIO_VAL_DECIMAL64_MICRO		(IIO_VAL_DECIMAL64_BASE + 6)
> >  #define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
> >  #define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
> > +#define IIO_VAL_DECIMAL64_FEMTO		(IIO_VAL_DECIMAL64_BASE + 15)
> >  
> >  static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
> >  {  
> 
> Would be nice to add this to drivers/iio/test/iio-test-format.c too.

Good point.  I somehow keep forgetting we now have tests!

That can be a follow up patch

Jonathan

> 

