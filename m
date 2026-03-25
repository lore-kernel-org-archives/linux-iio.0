Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346861A262D
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774404034; cv=pass; b=f2UG20RbND0H+1tK/c+8VkikF40R/JPUj1URaz2c96GmkWm2ZKP2SN0J3Kf+By5zovJ0tmhVjd+G5ibpTIl45OfO26eQpDDk5vjFj2BgS3DmBeCA3KgcS0Q9q6c/vNP6Z7cddcHNfTLvZzdSV7yF36a6g40OeVO4808rVhno2qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774404034; c=relaxed/simple;
	bh=QY+rzemyPmh6LMA8O66BXTsOH7YdfHPmzTbktSy7Zbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNjQtXHSPhQBgJ6Tv+EQh4Qw2nUR1t4cfhk4OnNJgOTFrqNxd2JP42aJ4tt+SefpvAcibvArYPtZsPQP2CzPWt/zOYw6kyoHhz5JYd2nCR2ntwbRtlCYEsn5rmG+dSYiIOGVRIaEHd7g5dQd2o7gcQ38UT0h3dGCgtZy/ddRzgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPCAnbWy; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPCAnbWy"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56cf45deb45so1275244e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 19:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774404032; cv=none;
        d=google.com; s=arc-20240605;
        b=JegZ91d2LfPeaBMD2bdy8/0+NB2Xky4RNCZ5ketCPVESu+jGHyf021pMTviv/+sLP/
         stNss0hSJF0QHBF+Ww/9r9/Rb/6UzM7JQ5oic7KaMiILM2Fix1XK6Km4gTDKc+vE33Bx
         tc5mAtu6aoqlrxXCn42HmRl9BkxarTwwF/PhLwUUlCJTsdE2ftjRfUPYnky/wFCYY5+f
         hNIAdGVJee/sHB7Kz60cnfc9RlyjbsXrdxDqRArpC7MfTJdEw9yghi4Ue3qRjQZdizfn
         nR5e1vxqk857sebXk1ntjBZPX5GOat6dwe+3s7Lv2KRiOmXifKgiH/oxrl+wvS8qtOjo
         4oEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WPFE6/dRCTDV9VmECkpI6GoCeCw4eygyemSJ43rKzrU=;
        fh=dm4qp0gBfi2rmJykpUFxj3rzlqRCvLqQtMIH1IcTcZY=;
        b=dDvj86fZVT132R2bMSPoDVKLqBfe3krwuRT6uaWz8srQxJtN/6iHgEeS9oztOLjzVq
         D3T29sR6QuDr0UB5Fd9T+dq7g7mPh3iuIYnkQ7xH0Hk9pSL7ki+yVby3eAPsifgM+7sO
         /T5QzNY18HX1kaDjJGLyrSfOuudm3FFX9kVf0BPMqtMlVXIKuN6793Z59VIg/gJ2x5Yr
         Kv/q0NwiKWqbwiML5tJaf7ONwEiRsRyLE8CZ+ORJdp8Vbn2dU7RCgC2YGelrJSmuQ1ep
         S/K6s9V0NYPJOTNR07IJwmayutYRqv4ddD6MmpsrQQJn13iuKKa4WmUhMCXg3t0RTLEx
         M8dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774404032; x=1775008832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPFE6/dRCTDV9VmECkpI6GoCeCw4eygyemSJ43rKzrU=;
        b=YPCAnbWyi1p6j268ZpLzQ6coXdv4j/5TM3FOOcRUFjhzrLX6WntRcBxsLv9nLmJtDh
         MBPlNXbXlupMg+KkDuf61behGWZBvzoYr8v3yrjTfRDv1ZWkfefpK9XcYfuhFJcJQYyD
         IuOPGG/X9iV8K1EGBi4PuKwRbeRkxMSpNkpCQ6BQnzhEk1cjjxCWYfLOOmL1xLtXTtGf
         5lypcEleWbFXVkOCKL/PZmXknFLkdUJ4o7GSb0A4n/NxSJoQZZFp5/vMwqeYmT1ed4bu
         gQe9tuK8JpgO9fE2r24LjDR/YlTZMIUOH3rZWvBss1oFGSJsfAJ0o/ZiaFh58+Ff5bbA
         YcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774404032; x=1775008832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WPFE6/dRCTDV9VmECkpI6GoCeCw4eygyemSJ43rKzrU=;
        b=pBIXZkKAuYUnLLno1U5jvOnQaitsKMlw9YCrzUW36K2yvmNd6LbI5B2yGdnYixgVMo
         rleRFyPqA1L8NkA+J7QCuwHsHBVaPfHOZiQvM1dXY5BdIMOqiW2iJMFVisD9C3q8SX12
         RmKlj/qgyjXLjVkz+ybVk9VADxD3wZUnKDWkhNGNwA90EYjxwGwMuLuRH+nWRdIYhDbo
         lo9fY0vgMO5AB1xqgzKJ2/wbC47Dngc72eQfwRgnPVA5t+ZdxxqQefsk8kDcqutITOSG
         1YhMv86mCIbCR0nL0rWmOGjkF3gNwI2bv0uCvEIgo+BW+d8DNdPlB1CSknX8aucFck+s
         se7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6Nh0Gm7V9i6AnsYoMkrjjefNsdzIfVCKCaZ7ZdfWj5a2sHMDXy2a+iPGttHFV0B+D3wvJVdrtbfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DTQLjdF/w9gv8K/T+ZNUB/txmvnKfka+EkGFKFsYDFTVbzCz
	FTyi7zWjIeabQLlRCdn0qLVJyPVOqLHbAVdoKadHt/4DfXnY2ZuRVJcumwmOz3jWH6CTtJRKX5U
	ZuHx/d2M7BYtoxouF+NRoks4f+miymeM=
X-Gm-Gg: ATEYQzwI2Lj/kXh48id4xSuXo1ML2HCpIkelgdLN+x5w423Gsix/AGDEGW/cfqoPIlJ
	R7G3mdXWg6bcryL39V/jv0IcwP9ZhGF9JcyR7J2rX5n39lzqchPzYbs/UUYGAaiEbpty7Z0DPVM
	/0uvnpyUMPLZjIKr5CfhXo1SXbEG/33ohmHuZHi/L7O8zeqq4Qhjk3cvn5uzUc+CTKB6B1fBNPI
	ZkJcjZrxoyNdZTd5hvp6VVIObQncL+KWMAUoMnrN0noL7CAjnmKmLYKVnN8XPyTHGlGmg5FIPRn
	cDXFnfWm/ZnXozVTlG8=
X-Received: by 2002:a05:6122:6d19:b0:56a:f542:78f9 with SMTP id
 71dfb90a1353d-56d21f881admr974081e0c.7.1774404032136; Tue, 24 Mar 2026
 19:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-add_ltc2305_driver-v4-0-bc350d347f33@gmail.com>
 <20260311-add_ltc2305_driver-v4-2-bc350d347f33@gmail.com> <abEVfIKYZSl-AnL8@ashevche-desk.local>
In-Reply-To: <abEVfIKYZSl-AnL8@ashevche-desk.local>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 25 Mar 2026 10:00:37 +0800
X-Gm-Features: AQROBzB4Hue480mzEh1l6BixpPONpXCggyki0VftwNNteXbgZ6LJaNJjvXxrPuM
Message-ID: <CAF7HswPunWXkfW+Qp+FS7GDyPgd86LJivGVsHTWwnKRzHCrsYA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ltc2309: add support for ltc2305
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Mar 11, 2026 at 09:43:02AM +0800, Kyle Hsieh wrote:
> > Add support for the 2-channel LTC2305 ADC in the existing LTC2309 drive=
r.
> > The LTC2305 and LTC2309 share similar features: both are 12-bit,
> > low-noise, low-power SAR ADCs with an I2C interface.
> > The main difference is the number of channels: LTC2305 has 2 channels,
> > while LTC2309 has 8 channels.
>
> ...
>
> >  /* Order matches expected channel address, See datasheet Table 1. */
>
> This comment now confusing, it should be kept at the initial enum, but th=
e
> better idea is...
>
> > +enum ltc2305_channels {
> > +     LTC2305_CH0_CH1 =3D 0x0,
> > +     LTC2305_CH1_CH0 =3D 0x4,
> > +     LTC2305_CH0     =3D 0x8,
> > +     LTC2305_CH1     =3D 0xc,
> > +};
> > +
> >  enum ltc2309_channels {
> >       LTC2309_CH0_CH1 =3D 0,
> >       LTC2309_CH2_CH3,
>
> ...to assign proper values (in necessary order) explicitly and adjust com=
ment.
> Then add this patch on top.
>

Thanks for your suggestion.
It makes sense to have explicit values for both chips to avoid
confusion with array indices.
I will split this into a series in v5:
1. A preparation patch to refactor ltc2309_channels using explicit hex
values from the datasheet.
2. The patch to add ltc2305 support on top of that.

> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Best Regards,
Kyle Hsieh
