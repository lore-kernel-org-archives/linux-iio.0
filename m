Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793048604;
	b=pUUtigrn1pVvXvaqG6IolWYLuWnPLYcOMp6bmTeuPFWAqS1fSnU/8+i6NKzHNerl7NAr
	 ZZ973V/cqUKPZrC+GtMHarzGQYos9wT80tN2rLun02S5sSB/fQes2xEOOMYLbus8Zv+tA
	 x37vbECo1zcD5mvRW6cm7Kcz/B9L2p3hmjtYj5t8Y2q4NF/m30p5EyV72PmtsRASu6scH
	 2+lbnnRHm9HxsCJdPC+e3nLlCd8jcwtsuckwBhM53tiiikG4yYhDW9iLq9FIwXt8Cs07T
	 LzaAKs4Z8PuBF3IaRiYKQ7KGcyoWm4+g/mujIlB8mh2y1pbiYfLCQ9r6wz88RonOPjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dymsYL1VvcFeY1Miiq7ZnoIAQ+NOEvB3M/n82aiIv+A=;
	b=2+IGUdGrPN+u1urFFeJAKOtRLZnhSWcsfGSE7V2Hd9m2PRSDHYs0+SaJ9UluQ1I816eX
	 Y0SAbMFrTJ+aJ3dh6UoT3p8UOlXALCz344kQKNZah/stseWIzAnAmwgrgoz67QF/0j51D
	 SBzpSXSyHjUwGICO/UYz8fNEdO55czOTiDUypdCtqvlgUmSdi77k1wJ6igBzbaCuZjUJ3
	 BLnBnm/0aP0zva7dv5j1zDNvgl88fiaDUFWmANSTrESAfLTv5Ypwal8BXFzBokzHdzLaw
	 tHXJ85dcqf69d3oOvYnLnLJ0GNU76NptnCCib9wWKZXwWo38y5mGf3BnKXC64TepJDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J4mmIZEw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C1606A321
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 21:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0C1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J4mmIZEw
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so2373935e9.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 14:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793048602; cv=none;
        d=google.com; s=arc-20260327;
        b=XMlQVwYM8wsmC+bqqFWPYwcgV5taAqI5L2VmRrVZUpPX5huFicJGLQubZaLr06rMGb
         dqF/Yhnobp1Sl2mlWkOCpu/JWS6TWatcVRzYqM/A5detCnrUJf9Vpm9f2NOQZyTE34p+
         iAE0cwJ/iEUetbdmPjw2ZZtNCqzwK4HlEnpbVApoK6XiqwrdJo5gy+wmM89/U7jd5YFT
         IVVW06hEm8cksXC7AiDS2XHCXSzfy4ixeEPPccPitoGgReTiwLS/5SkQe9eDdZXi4/aH
         UVgxcrbyD8+ipig/pL1Fu+JYbSGU2uUeC7zLsPCpSgdunX9vzV2hhy3L2xCPe7T8TKmk
         BDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dymsYL1VvcFeY1Miiq7ZnoIAQ+NOEvB3M/n82aiIv+A=;
        fh=+BInJdBvvwNYY+IZeHAlitepKuPU/GA2DZgxLT82Flg=;
        b=mPWDaR7ArNEvFjsDjNzLvPV8hM5KHQ2HRJeCIKobzvFbdOPl3RXX0ip5fMztCup4Jx
         YvRSvyJOXYsE6LsrqeHvWTyB7wui91bIrwmCZhPy/1RVJzrPc7qSSxYl5Gq5ZkUL+6/B
         Aa/uaQsmdwlJ1HuqdFEC3hw2GJXQsOz6MZCtYKTxT37QBQgYMsjHd4oOAiwK+jSa/lir
         pyp1qqBo+WpBKxeKVLiUrE7PJz9/OlYyBn9zEHY+E8YEm9S4TRZT4M9LxDRbvK/aLq2B
         dUY40KN/j/nH+WnSnj4o4zo8A801iJEBCGp9NIVVfcjVIcSqJfkXJBjplPIaywXW5NWa
         loTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793048602; x=1793653402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dymsYL1VvcFeY1Miiq7ZnoIAQ+NOEvB3M/n82aiIv+A=;
        b=J4mmIZEwt4xAZc/sYfig3dP2HTPTMXUowFakzLhqmRtHDYzfy4fKcc/jKzgkWKUl4y
         kfxevcilcAXNLhls9B9ffl7fT5Bx6N+k+sMMLl0VJ/ERgGsWBR20PdjLpa95tLS7KHLY
         fKXBJVAne81Te2GZhpX722UgI2K7eI9ZkmTOXBE15v1e+T8ofbrEQoawaxeNwl86QhS2
         oyEf9TmoDNZmG/YJyOj6DjPD8zpNkbCicaUAxYDPB0gVWeryXW+t8ABqf4+6P/OyDMpt
         WnaF34wsz1SWka93dSpQAUhgd8pU4kECfewoMLk/3alh2NeAdwtZvSJJ75fTUIXnpZTC
         uqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048602; x=1793653402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dymsYL1VvcFeY1Miiq7ZnoIAQ+NOEvB3M/n82aiIv+A=;
        b=Pqe8XlcfFLFhxyXJlOLQCogmxf8tvE4JsCs7wamR8CVTLEclgv4VJVmAiNtUXWL5lM
         PtNWycXdnRjzsopycESeaopQwkROV/Zd0eMZiddNSsXfFGQ/sYueUsyBIjnzfykeTe+K
         M/zTPUt6JQKkz4bSk4w1YdA/4IA9K9Hr99U0ALly9DfWcHZ/+HcSBv6as49gBWmy5C3u
         9lDBxBozhPZkDim+0UfB6lglFZup+JU5NOqcQRNENWATyIgUZl56ZDXnTzs/S0jCiWdk
         3BNKT0g/MngYvIfAKtAoDjrsaVrx6FPqPSSya8HZFgxm4QjvlI7Ou9Y8iTkLdPW1mVFw
         NCNg==
X-Forwarded-Encrypted: i=1; AKwUvBzzamv1Wz+B2YFQQ9lQ7Hchs2wzAck5ffC2AHR0capv/AtywsXyqgTHHpQu4y0tOvagyOcUwwUSmqQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4U+K5tyCCaj/WfRgYVIUNOmLB5qruL+3Yt/FbN6F4BNxgXjlo
	BvWCMjQTo767og9peSxY+FyYA2xc7u3ZF4fmjoWeQM3zZVtZZu8TtHJamV+wA2AwXnWOwCc+omM
	cbGzANrzJXglybndo3imfSP9mUST20zQ=
X-Gm-Gg: AYBFou0YF+0a0RQ0u7DnTDqnMjSvG5X01HXk911uOOen2/Gvk/f+bvW88Q4kkr1GfKw
	/wiWfSqnj7oW35BM0j8BoV0ys8wVklSRoia/ykB3Z7evn910htjMDsI9XgEhV3xpmRgjdUDYH4D
	y7+Wmga2it01cebLTXF+yd8UoGgg/Ff9xImrjsZEm8IcXL7kQbdwfGCwUpms2/EDHcDa95IgGio
	oMy7ExbjXhNYME7T9tFylF/Ep/pLNkH0XhNLXoKqUVuZMul1r/gwzpkZkIfFf3Duh1a/V6YqW0Z
	tC8PwWxxP3FZBRX3XJmMPsAI8L0rBsadbG2FhxWbyaa4LUO1gBk5Aws5bk+peZV2otLbGj95USg
	TXbDOAlMlV0MaTkR5EkOhVBXCH1jIHy/HWa6K+WFalL43mPCSwLz5SHXocaxzO0LbfxtTo/LQeD
	+dQY/x7QsKMaTQyj/B0ho1fSsRIqJ6GLPl1h7yMwbxZpMgupZJt9WPLlCYVj+bblNzVvJyeECHs
	kApOg==
X-Received: by 2002:a05:600c:3d08:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4a7bfec49damr17336865e9.4.1793048601950; Mon, 26 Oct 2026
 14:03:21 -0700 (PDT)
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
 <20261023175919.160103-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <atyKo0pTYZyt5XJc@ashevche-desk.local> <CAMuHMdV8Q9UKrpoZuZfDUutrG=bOwcNWLnht1bufv0YVXJPNDw@mail.gmail.com>
 <at8uFFHk7DHH9e1l@ashevche-desk.local>
In-Reply-To: <at8uFFHk7DHH9e1l@ashevche-desk.local>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 26 Oct 2026 21:02:55 +0000
X-Gm-Features: AclHuK-DOQOqCxrYWenC1byTCwdE5LPCv_pLXEQMP8Kff__QGFt5Si6oKbFTyn0
Message-ID: <CA+V-a8tL+bqTtub1=nL51CJ-b6RGkRMYNttcvqGbXLRchPk6Mg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
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
Content-Transfer-Encoding: quoted-printable

Hi Andy and Geert,

On Mon, Oct 26, 2026 at 10:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Oct 26, 2026 at 11:14:53AM +0100, Geert Uytterhoeven wrote:
> > On Sat, 24 Oct 2026 at 12:38, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Fri, Oct 23, 2026 at 06:59:19PM +0100, Prabhakar wrote:
>
> ...
>
> > > > +static int rzt2h_adc_write_scale(struct iio_dev *indio_dev,
> > > > +                              struct iio_chan_spec const *chan,
> > > > +                              int val, int val2)
> > > > +{
> > > > +     struct rzt2h_adc *adc =3D iio_priv(indio_dev);
> > > > +     u64 req_scale, scale;
> > > > +     unsigned int i;
> > > > +
> > > > +     if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT=
))
> > > > +             return -EINVAL;
> > > > +
> > > > +     req_scale =3D mul_u32_u32(val, NANO) + val2;
> > >
> > > But what's wrong with the simple 1ULL * val * NANO?
> >
> > IMO that looks like a useless multiplication, which will be removed
> > again in some future "cleanup"...
> >
> > There is a reason the mul_u32_u32() helper exists...
>
> I don't see that. The 9e3d6223d209 ("math64, timers: Fix 32bit
> mul_u64_u32_shr() and friends") tells a different story.
>
I'll drop use of mul_u32_u32.

Cheers,
Prabhakar

> > > > +     for (i =3D 0; i < chan->num_ext_scan_type; i++) {
> > > > +             scale =3D mul_u32_u32(RZT2H_ADC_VREF_mV, NANO) >>
> > >
> > > Similar Q.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
