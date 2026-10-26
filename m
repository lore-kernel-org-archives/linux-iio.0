Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010064;
	b=Gww9Du/CgF9af1nG+b1Ji3CwqNiRysKe9NjcezqFuwOgZmYYibzT7cpwX5emtZOoTwzC
	 CJr6KMHS6XgccU+21dCapIiRyea6XwAsBLlAeeapulJseJfGVxoHCZsECdTdI/e6oTkyr
	 k/rSCxFHVVR4umKUxPvlkXkDRovBd/C68+p1WO6ANPYjCGjBRPuoyIiky0bBygwnhQ1hs
	 yJfHMglrdd0j/B1eqmCKj1l9vY7J68DimX3D5Kj3QXENWTKU1vWNW8Vds7ZdgbVY13pL0
	 f+Fk5Xe9jnCW8RSU+DlO2NQLbb/FTEeB9cmIVawcwpOzfwxsFwXB1sMvR+n2V5kbgsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010064;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=xvHDL7X7nDz4fdHlD/Zd2vVTXXgNDrA1NXktS57i7t4=;
	b=uUf3NWU7L0uTkNt10jfmVtFETr4+oe9hi0ea99uYMTaF/HC4ZFupm3XSvmrhNCmZU+I1
	 ulwobu0qUlm58YABxtMNNJ0hgO0Z+X3zXLGN5dvAlhhUtKYwgT15S8djoYFpp7cpuIx5q
	 Q+8lDWv7ETWgNUDMV5XpZSNOgFQmIak+cCZZA4wKNiEFIHUK+Y+BWr3obLCLkcdsrP74Q
	 b7svVsssjgR0podKCkD3gFDTwWlPXUumUPTKIjUQ9evdaBfkIGYpiBTLOlmHWljgdfXIa
	 oH3mGnAuDOz5iXo7Ej0AJBYavu981PHTFteODyVZn49xvw6AYYJN8if+BKK6Ll0lg/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F6606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 597F6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9908346255fso1855461241.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010063; x=1793614863;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xvHDL7X7nDz4fdHlD/Zd2vVTXXgNDrA1NXktS57i7t4=;
        b=nJ+CXnYEQKqPSDfY9LfWAs5fzRN9gYslMjRcz5xYpbTKoZHepVT6U79jnjdfCagzli
         GybPtx+DnMgpb/SPQHcHJxzMLKdSdAfrWrdvUtagrmxWgJjfTAnUg/Ikx0C02iWk4wNc
         13oi7PmmMpNg65MgncBcIP4yTHzZwLmf3JAfWT5L3l1VEQRb7yS2l8UzdVdC1h/dCg8d
         wN2bR5dWYJgPJFVEA7uSVhzch+Pg5R2yvpUvDb5/2VSgSkCdc+UBSh9cH688ss/iJHpM
         Ye9DRB1j9e0wvZpWrheGbIMP59Q+9ERYh8DIMQDf8tXo9idwfJBMrIKlstNI2yGykPey
         5Yow==
X-Forwarded-Encrypted: i=1; AKwUvBzPrXvfdalDO4Ky3u5zMr+uESvePJgML1f8r45FemCiUM7tJ28OMMeixc+fDUL5wou0AzZSRfNxvfQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu5+jtBrTkDV2lnINfi+FiUP8gp+fYeGVPUC5euvSe/kbF1EsL
	/tmsxBzxO3qpJGuxiTd0g/ucmPQCwkgJowyKU+7imbnrbQIzJ0azjludq/JhNmkM
X-Gm-Gg: AYBFou30IxmQXG9c2c9wG3Yz2BKtDdR6WmCpyBHiKm8xU4hUiqFhuZvx40LA5q9Rkce
	nSIhUqNZCoA7q7GacT6uH3ca6DFuc/7KleMfXsARIP6Q7CdBxxkygtDXiNuoewtJSfr6F8dfd2W
	xsoX8pS2e6m9SFzWkrDVMZzdwuZz3Ll3egoYi9ni8kOdhAMU+jE0owflj2q5Z/0BD4l7vYJCEeR
	R5rmlLTfhz0bO9W9qnnQ5YtUOT3oSupUEOWu8xRi72dQIiN0Y0cvF6nmimnUw9F1dS6xJlb2Kog
	tw62X5vst+QN919DbyV+rfJb5UtXTxeNMh/AXRfknblk4s+r8XIdaGo8wNv+H3t/OPShCGKZ88i
	8p7n/yVIZ+EgHE0jGgOSg0JlWLNV1dfKYCOEqWG3N7tz7RXbVLZdUEeyxA56SmKDs7ydCAH7lMj
	UXRd3t+4kt5mAvMsT8G7IhyYIB6zRDw8yIPIKVar9MWkJOWyoan9OdoS3poqA3ROg3Kf/5dyLuG
	koVAAa/RZGg+/ftzKs9OVFJEEZqV3BDt3UdKamteNcMlckLux/cMHw4JJD9G2D/yz6fSlSw1wzn
	0bJSM4S8ufCcLqrZBjNMTw==
X-Received: by 2002:a05:6102:5113:b0:7ba:7a64:5946 with SMTP id ada2fe7eead31-7ce5ce460b9mr1410409137.35.1793010063381;
        Mon, 26 Oct 2026 03:21:03 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e7b8f0csm7813475241.5.2026.10.26.03.21.03
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:21:03 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so3532560e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxm6VWHwFcMu7FIDB4Jl4YIiV6O1AFN24SX/k29kcP3dEbCSYF4rOuAJ3+Fdq+svF/F6hJV3PiSJso=@vger.kernel.org
X-Received: by 2002:a05:6102:6890:b0:7cc:ace:24ad with SMTP id
 ada2fe7eead31-7ce5c6c0026mr1500062137.0.1793009705218; Mon, 26 Oct 2026
 03:15:05 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261023175919.160103-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <atyKo0pTYZyt5XJc@ashevche-desk.local>
In-Reply-To: <atyKo0pTYZyt5XJc@ashevche-desk.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Oct 2026 11:14:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV8Q9UKrpoZuZfDUutrG=bOwcNWLnht1bufv0YVXJPNDw@mail.gmail.com>
X-Gm-Features: AclHuK_Zae-S6levySXX9MNUVg775ICficux5w8oZYwqHzeoFMa3QGI09OnmK_U
Message-ID: <CAMuHMdV8Q9UKrpoZuZfDUutrG=bOwcNWLnht1bufv0YVXJPNDw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Prabhakar <prabhakar.csengg@gmail.com>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Sat, 24 Oct 2026 at 12:38, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Fri, Oct 23, 2026 at 06:59:19PM +0100, Prabhakar wrote:
> > Add support for the ADC found on the Renesas RZ/V2H(P) SoC, which shares
> > the RZ/T2H ADC IP but differs in channel count, sampling, calibration and
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
> > +static int rzt2h_adc_write_scale(struct iio_dev *indio_dev,
> > +                              struct iio_chan_spec const *chan,
> > +                              int val, int val2)
> > +{
> > +     struct rzt2h_adc *adc = iio_priv(indio_dev);
> > +     u64 req_scale, scale;
> > +     unsigned int i;
> > +
> > +     if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
> > +             return -EINVAL;
> > +
> > +     req_scale = mul_u32_u32(val, NANO) + val2;
>
> But what's wrong with the simple 1ULL * val * NANO?

IMO that looks like a useless multiplication, which will be removed
again in some future "cleanup"...

There is a reason the mul_u32_u32() helper exists...

>
> > +     for (i = 0; i < chan->num_ext_scan_type; i++) {
> > +             scale = mul_u32_u32(RZT2H_ADC_VREF_mV, NANO) >>
>
> Similar Q.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
