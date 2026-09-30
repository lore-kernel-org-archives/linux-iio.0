Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1151B163
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788506; cv=pass; b=RLngE7+sclKVbD75GLlF59pnl6qG80MSKSIp9iX4cIPVOn8qrqJ9geG3N8RJu2wsLv46bgQf4RTFIOVokypgW8n68OGtgou3LgZ4uncPr3VRckXFrO/fRMpQnRWXO9T1nBCJAu50GeLR2Z7iz+zJF1GtJqeNZeecJHpolWzUg6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788506; c=relaxed/simple;
	bh=flTa9IPUvO2Wfd7dxpZCg15j/sd3TNn9DagEWKcsB10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHaVZ8lqji/PAF13iZwmgZVqGPipj4q6F9GYp4YtaD60PxzV7aKoh53AzjaIbj5ReE1olLlgKmvBDdpKN+E/yOmypJt8os1c0TNTSTSs7qzHZdkUxxCfJfjmPqi9Sfayt1az13mj8i8RBwRg8cqW+2Vmjt7ah+IaqsLvGqP2MG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iciufym2; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iciufym2"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b02a2359aso2773f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790788502; cv=none;
        d=google.com; s=arc-20260327;
        b=EyGPed1H7m0y0UU4PF/yrbSPQXMdpiVSQMpCJEWMqvi8RuQCYjtOAd7zaI+wswQLO4
         OGKsOIxB83dT5f0oAwy1BpiwdQCs8Wxl6XbIOFA/kQxzgtfR2JHacKkz1pWSUv1yESnv
         oEa+xK6YS8DHzU40Qno+baSNvLU3GWF4uWP0WKNAFswETbwi9ML6e7z/ab3+P3ViAhHw
         WzZibXD9GO2QtZjYE82rkvf5XRNCqBjiVq+F2X6T1ZK1NGDkCl3QN9SC1Lj5Z8iVz7LV
         CKmB9/FUiZA+npIipfKdJAvs8VU/lVmZAEFHjWWcIGDng6SHwnkqM1czL0GTKln1A+69
         dvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wLIs5aSN/ephptBI36FGk5tlNNffSxw7Odm4ILpRBMY=;
        fh=xTmGcSu7+K2DLHnyE2AA+DzohwE/ozE+POeBpz01c9Y=;
        b=aH3Qfkg6xGOwZu2LM/pIa7fwJBIlsuZX8TIJHPyJZSVS0gk4AyWPJDovQk5ZPBzd/h
         HE+JOdaqxMLT2BGM+YjuYQop1P/5j01OxuUd5Tz0c1SOgfgJHgOYyuARYx1g/EUK6MUg
         6605X2xO1a3z4kMb5G6BS6KRpYUm3ZykxkxhCqIAfhhWiRqFH6E5cl5CPeGxu9P9rGCc
         N/onlt0FBvEE3UsLQM6EEN4bhLoyGfjASnxLgXSHotly7NT8wu7EjdXTxoL+iAVUVSbc
         FVhfDxXiSjyJpcY/6F+3DR6OMm+IpgI/ZLpCGAVEU15vUgEy+gnHUKAdaPFGdFYFD8qw
         OU6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788502; x=1791393302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wLIs5aSN/ephptBI36FGk5tlNNffSxw7Odm4ILpRBMY=;
        b=Iciufym2ZntFU/rJrlRxGAKWnPBz4YIbIEpD1bz2y+wMSFnwRY1Myb6KKinax40CqJ
         khQtMQvl55TCfWcc3pM2zNJaYrgC8c8k7pDPSsuAa9Mm5i8Mqqsb1Rbb3dHuh+yZRtVP
         le8mHNP9vWHXtQXtZXOHjo9NuYHrmXUfu3HLmhw8EJWbrmhMouJDehXY86RyF0XqbiKJ
         d2VqNYa4LUIumHLrNadrRiPtQ2X0VpbuO2T59KrO0iHwaNzeddTHb2RCuZyjPTrQrwQM
         iPxnJNVAGItU7YVR0E1OrDPIlm6A37u+/4ZncWNwgzVMeX2wOoOo8Pp/8LvVmrsrzpBL
         PiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788502; x=1791393302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wLIs5aSN/ephptBI36FGk5tlNNffSxw7Odm4ILpRBMY=;
        b=XgEX3QcWKIQ0h4c6FWSF3FimsO5gkbt/OMIenD3wOuxL2w1jA3dPpUuNB7Ifsab32O
         iBSOKZ+zBjaHu6IBFV1oOCkGWTy9EDiyoz6SWZaed9M00wKhTJXCxxys+jxYLkgNjup0
         k6Xty8Lg113r1p/iqyznAMvtu4dnvVKihUbKLAlDqQKzIxKJmPJkaxoBlXM/DDZmCGKL
         ap8hiY4mci6Y/vM7RSHI/KDTnBBFIvndd79m4qsc0zXNJUB3DtcFLMTqzqNvnpQXEt1H
         t94td22WntizpjIhJHNY63xL0A/RD2tZHA5eSUZRHMRtLJpXhfwKfiwkNjbgvM+uGs/P
         f8lQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGOCBp0vsLrUKZsNUo/NL1M7jKZklE0mBIYEC3FRjyLbu8zQzf1TBqCBom883W+ZM2OOZnnZWG+6I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVcZg7r4R5P7L58Y1z+hNp3GtHqfZgmDPe97E1JgTQjNlYoaXb
	AEK6yZojRWsnnlTZ0fV/YcjsvrA7CKJMhCwb3ve3b7Vad+asXVMJVGhIValM78AuvRV2Dkmk9tQ
	medJinUozOPF4ZBj8uO4jlNVceg2hQFU=
X-Gm-Gg: AYBFou3w3BMFLCU1S3mbPnEUS5spCH/iy65jbvep3yeU4pOAFwjzOXMk+8vR0Efy4rU
	wlt2l/qYvIsp8/Gp37K5c8roZa/HA38nXOqrMpPfN6zKFCRUn+HxXLTBms4MEH5UAJ02+HqaYxu
	5g2dSBipNEXEqlL/IKQPyLzlSGvU03+DZcZNHa+0tTJwwq8ojazK/W+NfWlARSNEJpoXxPTe5iS
	SUEivMcQT2/+bUbBxjODPt3R1M3mdyKEa22k0VrKxXLj8o+U1GtbQAFQo5zkREpZNoDhksVEfjC
	/FiI1tC0V/baeBtAc4yPxXOQeQrhDOGhe5WPEPky6JHCXYZQmZFhs18dFmWxVdKiiegSsNqD+S1
	zFTDzmeojXaZuuwiW8W+FELJY/1F24dOL20u789UoFnNQrPV8ZrpQo34CMlzllaX3Il/47DtQhf
	o=
X-Received: by 2002:a5d:4acc:0:b0:487:342:eb28 with SMTP id
 ffacd0b85a97d-48b068bf31bmr477202f8f.24.1790788502254; Wed, 30 Sep 2026
 10:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929124248.237032-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <arzX2pzq_0JreVJe@ashevche-desk.local>
In-Reply-To: <arzX2pzq_0JreVJe@ashevche-desk.local>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 30 Sep 2026 18:14:35 +0100
X-Gm-Features: AclHuK_nTopzCs1JxF_udaLq0aHe5Q5fBvI6nb69CERob4o8SQmK8yLw1zzL4tc
Message-ID: <CA+V-a8sj8LnuHGYOV7Et9KXtcKYrSZgP5cgYqxCiE0VCSH_Lkw@mail.gmail.com>
Subject: Re: [PATCH 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for the review.

On Wed, Sep 30, 2026 at 10:35=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Sep 29, 2026 at 01:42:48PM +0100, Prabhakar wrote:
>
> > Add support for the ADC found on the Renesas RZ/V2H(P) SoC, which share=
s
> > the RZ/T2H ADC IP but differs in channel count, sampling, calibration a=
nd
> > resolution support.
> >
> > The RZ/V2H(P) ADC provides 8 channels, has a fixed conversion time of
> > 20 ADCLK cycles, does not support calibration, and supports selectable
> > 12-bit and 8-bit conversion resolution.
> >
> > Expose the fixed sampling frequency as a read-only attribute and allow
> > the conversion resolution to be changed through the scale attribute.
> > Use extended scan types so the reported scan type follows the selected
> > resolution, and prevent resolution changes while buffered capture is
> > active.
>
> ...
>
> >       help
> >         Say yes here to build support for the ADC found in Renesas
> > -       RZ/T2H / RZ/N2H SoCs.
> > +       RZ/T2H / RZ/N2H (and similar SoCs).
>
> This wording is good for the summary above, but here please list what the
> similar SoCs are. Something like
>
>         in Renesas SoCs:
>         - RZ/N2H
>         - RZ/T2H
>         - ...specify "similar SoCs" here...
>
Ok, I will update it as suggested above.

> >         To compile this driver as a module, choose M here: the
> >         module will be called rzt2h_adc.
>
> ...
>
> > +static int rzt2h_adc_write_scale(struct iio_dev *indio_dev,
> > +                              struct iio_chan_spec const *chan,
> > +                              int val, int val2)
> > +{
> > +     struct rzt2h_adc *adc =3D iio_priv(indio_dev);
> > +     unsigned int i;
> > +     u64 scale;
> > +     u32 rem;
> > +
> > +     if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < chan->num_ext_scan_type; i++) {
> > +             scale =3D (u64)RZT2H_ADC_VREF_MV * NANO >>
> > +                     chan->ext_scan_type[i].realbits;
> > +             if (div_u64_rem(scale, NANO, &rem) =3D=3D val && rem =3D=
=3D val2)
> > +                     break;
> > +     }
>
> > +
>
> Blank line here is not needed.
>
Ok, I will drop it.

> > +     if (i =3D=3D chan->num_ext_scan_type)
> > +             return -EINVAL;
> > +
> > +     /* The scan type changes with the resolution. */
> > +     IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> > +     if (IIO_DEV_ACQUIRE_FAILED(claim))
> > +             return -EBUSY;
> > +
> > +     adc->resolution =3D i;
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *vals =3D rzv2h_adc_scale_avail;
> > +             *type =3D IIO_VAL_FRACTIONAL_LOG2;
> > +             *length =3D ARRAY_SIZE(rzv2h_adc_scale_avail);
>
> Check if array_size.h is included.
>
I will include it.

Cheers,
Prabhakar
