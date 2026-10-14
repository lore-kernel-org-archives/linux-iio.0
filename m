Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AB522EFF
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990774; cv=pass; b=ZYv5P/SsPZzfRBxdGkBXNhV2DpCNS/wQlaw7xRDcXkcvtmywDMJO1MVBk9+Qsjhzi33Hl1FSB0wnJPey4yTQj2DYoH4p/Eb3GFIMZOUG78XaTKobWiGMPn4yCLfHNPC9POswpMiR6uYItk8yhxcxFJd++Ay79pa8ID6aLS4Xso0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990774; c=relaxed/simple;
	bh=S5zs7o+IvJ94PTcJ859wDkqWMdgUCMYMIGrDaQPMmSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqhhuVjFEe3w+7fMRKYUqNaR9XyKndzO8WTV5o3UsowcXkkAE5ilrJTBaDhJBJ3DmcHVElSWBO3gI6jPcMwVgHyR4/WPAe5+FnOP1XXeif9gAKGecWVHd3N1w15qKXSmqeIFdXfJ5f2WctQNldg/oT3rvQGJuSeeV7BpZl7ZsDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXfwA3nj; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXfwA3nj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2698144f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 08:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791990771; cv=none;
        d=google.com; s=arc-20260327;
        b=XR2goiIWeZUbFqtO+qwEIVVMEJ5LypCTZyHNfhr95+YIfqBUsfNtGUnojjFzrLyAOo
         CDmhkrl3ePbE2zLjefb8K8z1OXGAGYjwJK+JMfCBW7jCIRYxB2uWh1lwrN5ksFqqGnTc
         7mxX+R5zzkLYeUuoZLuI9Z4l7UQGux5RUm9u4lYvE6XSq42b2P4zqrctHPBBGrIEL9xY
         NFQ9tTmtmRdNjnC21EfYSglLMzXHCuDhnC9FwcnJhz6tp0Zot0D4OH4NkWANTH5vtHON
         e52/lSN9UkcxG8sY50XnnrFFW24LjI6a0148uhKW54pVLqHiBNNridgid4nJQRNBZJiW
         OUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WUSTZfpPOOhjEr0q1WimSib8kVLmZYK9NAgp2MPe0uQ=;
        fh=VeqDBIZnjHP4Iwd62zCwp3tmdPySnAJAINatEd90S8A=;
        b=HmkVYPBsAf2qnFLDH0F03QQ4aI+6BizW1C4RQo+Jk149ZSwHhPPeuxVAcM/W7M3t7T
         x2lpzGVO2jzUayi228zb2XQ8qwC46GIXb6CSukJZ8ZNsLQ82MVYd5h4S3lA2YWDyflp/
         jHsiJqjuxKklEDeHjdqJZYpw+Vom6n3eKLlv8tNxyagJGW0NqYD92LP15SUi6imlaeBL
         M55Bykk0ORYLmEC0ea3YzQgXzNFubyZQ2ce/YE9hHswzIjt1ohHeodFreG4phvrBlEyg
         yH8f+A/nIE7SI2cO+2qTPs0mJY1072QX+WH8W3kSN8ncILLX6AzEtrzD3ZRmtFOGB8CS
         6xpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791990771; x=1792595571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WUSTZfpPOOhjEr0q1WimSib8kVLmZYK9NAgp2MPe0uQ=;
        b=DXfwA3njbnanK1S+51Hx1cy4UO9CZ0e2Oa4rvzBS+JGEYkWcmjEkvDq+GR1ZTJxFG6
         Oj0EJKJ8bqP+3ok2+Wv85blS/YJh7EES4pYWOqBVUqzyYNVE9ILJovS2AINGN+jgv5pN
         kInj8WcsUElThf793hZrtbeANVHIhdQBFlm437b7Kj9PUPhIt+sNJktS6FYBm+YEIc+V
         jjV9seGNTnk4gP/SHPSzhClmtYryZgyjGb83Jmyfwr/trylUPQhQxcnVZ2f1cwApss1P
         gDGyDuuLZTuus0hnJyC5zHKL48wkJDff9u+ansoalKQRes4I/vvI82ixp54YABQmQISU
         HTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791990771; x=1792595571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WUSTZfpPOOhjEr0q1WimSib8kVLmZYK9NAgp2MPe0uQ=;
        b=Tjk2NvjMM9W0luCGxjyXYyAEQAzx7hndAGiyZqNfcJT8wwqE303y9+TGR4LFbeh/Fq
         CgZMVgktyP3TvzDAP1rn/3NucGdrAkhcwEBMJrpMnxWuWwKLWg4kPXrWTudy1HtLSZUQ
         Rq0YMdiPB11zJodmag+RRYf7J/bvpVjRR3x/f9tRVAynrkcU0fETSwTCz2fwuZtjTKDq
         VL13kSviquHzbyHYeMapO7UpyivMgp3k7PyNeCDw6hBC6fG/UxoMY3cE0H4zgwSHXPAG
         eWM+NNIsnPwyFZvkxL7iZq/CmUYnmoZQYCWlABCfIxhc4KCEaL8n3hp9WixyRJg9bTD6
         TJ7w==
X-Forwarded-Encrypted: i=1; AKwUvBzd1f1EI0Tu1AiAx9PcEat5p54dzUjdKCu2xe+5gJPeAl7oSHgHUnxgFl7tUFfO1ubahO65uvdy5QA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSYVwMX3UFhXk5oR6q99muHHkwLE43KeooATdvLFow9EzYAVIZ
	M4tiTtFLTDL3uC9e3jirmSXISQHDUhh2fAlWlmVTI5hFhyIv+TRBfknuNTapsver0QEtxketeSl
	6vWVTVZWyA0UHPa1vK4pqL7QET+XJ9Kw=
X-Gm-Gg: AYBFou1PXQ1N2QKLzfZIL6hIcx5mTBQpJvrFS8jU8eiLgfz/9NSr63L2fczJAfK47n2
	H6GLW4+za7wjL5ZrMsUdH4kUkUsRyB617wCazBJwO8In92wd8Yo0AYGMQa1a9frSeGaAb/gPNr1
	K7hSy9BDzR0meH8SrNeuTo34pjjIiXsbhV5grzmG2Ou/1J9vYIKDBfgmraxUKGaUH2Z22MWb+KH
	3iIf+g+53A2+wQBlXFTEyoe3IqMBJYC0BWNTbma244iWvlLzGPuQowdnRk0LYZh9fsozc3SuITH
	gH86nFPt+Wk3x7POPJ4OxIYnDe1cvd0+YZDDCgFkfQFd9nGx7ggRpVtk7LMUy/y5RG3I7LlBhyr
	jlLMNBnb2ZExN/0i4oP4GYBgDvQQ7NPDA2229DiIY5cq7+sOWNLVatpk5hUvNYKJmS5P7Opo1UN
	Gav4zzLiBc
X-Received: by 2002:a05:6000:2085:b0:488:7496:15b5 with SMTP id
 ffacd0b85a97d-48dbacf126amr30278767f8f.47.1791990771057; Wed, 14 Oct 2026
 08:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261009184122.1378797-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <as5LQ6zFzkft2zNJ@ashevche-desk.local>
In-Reply-To: <as5LQ6zFzkft2zNJ@ashevche-desk.local>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 14 Oct 2026 16:12:24 +0100
X-Gm-Features: AclHuK_fe1o3s5DtDV5FGIwilMVE-kQkfjxo_HHCOHYJ4usL-K9N52nyOxeW19E
Message-ID: <CA+V-a8vV80UfHtfrxMFDk_UFH04F=evyAqTvHEMSOiRNTJd+Kw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
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


On Tue, Oct 13, 2026 at 4:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Oct 09, 2026 at 07:41:22PM +0100, Prabhakar wrote:
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
> > +             scale =3D (u64)RZT2H_ADC_VREF_mV * NANO >>
> > +                     chan->ext_scan_type[i].realbits;
> > +             if (div_u64_rem(scale, NANO, &rem) =3D=3D val && rem =3D=
=3D val2)
> > +                     break;
>
> Hmm... AFAICT we can use multiplication as the result of the division is =
just
> used to compare.
>
Agreed, I will drop it.

> > +     }
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
> > +     ret =3D reset_control_assert(adc->rstc);
> > +     if (ret)
> > +             pwrseq_enable(adc->pwrseq);
> >
> > -     return reset_control_assert(adc->rstc);
> > +     return ret;
>
> Hmm... If it was added in the previous patches, add with unfolded check a=
nd
> explain in the comments that the code done this way to avoid churn in the
> future changes.
>
Ok while adding reset support I will check the return value to avoid this c=
hurn.

Cheers,
Prabhakar
