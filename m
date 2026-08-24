Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9727AC31
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558271; cv=pass; b=pmM//QFXWvPZ9WHvQfSMpWlrnnVrAZi51khk67oTgW8GWCGtk/N/Ecm3r7bL9cu93XyNUJvwZy+V5yseEbDlVB01yfaXDiynwxelrTQj+id1N21PBvWcEv+DHhBhjOstxJVmhJru+MhMunwg18ma7YyTv4Gz3+W2WNuuF+0metc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558271; c=relaxed/simple;
	bh=WrtUjVJk6alrvqmX7ok/YmeHd1u9WPIdgJPTrkxRxh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+s9bMgsj3YXUBx6eqlpENi2bDvXPP5Oslj0hR2sGx6nEEx6+FfAqRck4ThbXDkxfShwUTsuwUVhXUV2mh8Vqhnhm19dvhi2/9NCCMn4qwntwXo2vZTfvpNehlc1iIDB+PuGhkhXVRQV+wp7wt1o82FVw2tXWs3a2CNxOT50fSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSvEv93F; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSvEv93F"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c953950dfso23674841fa.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 00:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787558265; cv=none;
        d=google.com; s=arc-20260327;
        b=J00MXakdkupykVg3ZQ/OKL9Bke2XjFAS0TLFFuuhb/Iz6sp7MZ2sAefTbqz66xudFe
         V5k5m66oz3nmq9VXmljhiUfII+AQYwDXn/yqlRoZNEjQSNKM7uP3Zi7aYaoVjCjGHAwS
         7IgKAJrvan7pLMtcz5wEnSOhHT7ABEi6YdgzN/2GAwyZo3bzfZ91CqABae35+pgt4m6G
         JUiYCtJ+2iOLpwZKBexIiYKEblQi/5qZcZ93/RgkyJWT21oDmkqIYi3GkF4DA12lsWoU
         aeEyBRURT4vZAdA0kFsI9z/GJHQQu7zVoSJwBeUvuCempSmfa/9rNNPnxE3XWN3CcwBP
         s0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VWCwm00e2NQzgOI6ji4mfpuOp31nsUpfbcVtkliODgg=;
        fh=dgGErQRThC6s+Fk92qpNGd0T4FrUho321lBl9fHvwlk=;
        b=OvrVRICCXwG+1R0lxVkDJXRcn9UgJu/q51KWB3nrnla4NeFrOX+5BvtSEKgc6OfXu+
         sB6kb0An7McCTMGCXfoBV3AvhTG1T8WPPa9Gcpx2tkKtApOaVuL4MXfNicisIor0rT4N
         CYpxyVqpdjRgTwa69snbyfq6U0oIMs2evOiChgbZdSqeaUEh7fOwa+h4XPHyyRP9m5ch
         FYPNNGCegc00IPFkYzdVarBJ7F5LIzkb6iwGIGGRwIdBnF2el1CzqrKZjIUGwUY7oFnk
         jobJ+yj8/YTyP0IazbT4Ll5HHizKKYOGAtlOkN+NgyLZsuvDdTOUTGqtGLpp1+dpX3Gn
         P6rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787558265; x=1788163065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VWCwm00e2NQzgOI6ji4mfpuOp31nsUpfbcVtkliODgg=;
        b=YSvEv93FDh0ukiHQADBaOq1Desl2PVpJvKSOrmRiWNq5xMsecTdkdHf5k3VJboaHGj
         rM01wHo0PIATxzfH4uLAa0ciRdLrB2dskcctjMN2j4UsYD/Yq4TeA0b7nxSBVOM1Jm0N
         6BE9RujCfknSmd5mlVhQAPZjt+1vDGAApL265OOxurMJOofNaWMUN6VijceVTBssDyLc
         6AD5y8SzAzleIAk+Gku+j9D5ohIIQKEjWCPWwiNSBKkLGZZ7J00JRukqNr36pGJ3PUcf
         3xdHO9xBx7ir4vI4wwvx7Fq6czRIlfSlQsnmtKixxkqll71Ugl7RK4JTfrRt0/yPw/5C
         cUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558265; x=1788163065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWCwm00e2NQzgOI6ji4mfpuOp31nsUpfbcVtkliODgg=;
        b=Sk/8mmdcDrfcxSXTp4P3fmRTjjsm+L1EuVFYYqBTmwUkBCDsPU4UfqMOS4VWvqJwK2
         UVVYQxsSL5ZqXMVv2MS6710surXdchQhQMPLhtkojus22GtGWX++BZLkkpFyBcgmu6k1
         +tg4cVqwxAM/cIvjfAGandPdmIpaKhXR/CJrmqmDkiKNFXDri80P+VOpaGV8QhtJmDRR
         HGpyvsNWSGPqlGe05yBH4jjyrBsl9iYbf16Gg1Cc06UmqS1dBDfN1twv4gr2iT77UEMo
         gXHcCuERplBGbNpBDFfydM0FNhhQxqmHbOUBmh97rXINZ0UjvjBrePXCvz6CL2BFarLK
         Kg9A==
X-Forwarded-Encrypted: i=1; AHgh+RrduKs6YQS0I8V8o9VS3q4RLdAWBLQQvEInLi30PYcCxHbRsusXKHF37BzsGA/5EDItiNnN33xRPr0=@vger.kernel.org
X-Gm-Message-State: AFuF++kb5+82ph2tHsfsjdCpGXVAYZhrb3qxYLpKAfA0le3HbkE0P9VL
	YNxXw3+rZVdIpsbArp+P6r5ZrjyC2cVk3du1RoclPzjcnxQm/rPeXL0lQfkPXpo+eS8Dk1/7tcB
	ITX4U3dC6jacL8meloAe5xd+29eibyfk=
X-Gm-Gg: AR+sD12il9awMHgPCShUbXW5P+Mq4BQIGqjVZ1N3u8wScHBbOGbYk2nOF9MqVhzH9vE
	2JtKsei2aIta/k3Q93ElDR6R/k+K7Ba1eKy5qPGBgAaephwRwaZxIZ5UiNYJ6OOyV88vjUyH7/E
	6Iza7JhfBaR4Ib22xCv2MSZKZ42r9haxuwaQUSOIZKuvlgANS8oEAGs3WraPxYz7G81a1DZXPfI
	b4gzTOB/TODow4CE0Y4Mz6WagUvdavTluRRV+1M0C6Mlg+lZWgeTn/VYq3me1K7QVB2d56lsrxX
	arsMO+M/E6kUxB5Cxr6WEMP6ArGhRL8M+az/os4Oz1lasZiISB1ID1R9
X-Received: by 2002:a05:651c:a382:10b0:3a1:9562:73b with SMTP id
 38308e7fff4ca-3a1aec07a7bmr42175991fa.11.1787558264439; Mon, 24 Aug 2026
 00:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com>
 <20260820-ti-ads112c04-driver-v6-2-0e8f0aacce9b@gmail.com> <1b0af12a-0653-4a14-9c0b-4948eab9a4cf@baylibre.com>
In-Reply-To: <1b0af12a-0653-4a14-9c0b-4948eab9a4cf@baylibre.com>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 24 Aug 2026 16:00:49 +0800
X-Gm-Features: AcwNN1U4ahlelk9rgkeVTfIHrIU3wa7mxWz-Nrmu3SlqD4eZV_AV1OdCyJK0trQ
Message-ID: <CAF7HswMT-e87oapWSw11-Qhj570wLDiayKeSP5vuYo9Fm9AbxQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 8:06=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 8/20/26 2:51 AM, Kyle Hsieh wrote:
> > Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> > delta-sigma ADCs.
> >
>
> ...
>
> > +static int ads112c04_parse_channels(struct iio_dev *indio_dev,
> > +                                 bool *need_avdd_ref, bool *need_ext_r=
ef)
> > +{
> > +     struct device *dev =3D indio_dev->dev.parent;
> > +     struct ads112c04_state *st =3D iio_priv(indio_dev);
> > +     struct iio_chan_spec *channels;
> > +     u32 num_channels, pair[2], channel;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     num_channels =3D device_get_named_child_node_count(dev, "channel"=
);
> > +     if (!num_channels)
> > +             return dev_err_probe(dev, -EINVAL, "no channel subnodes f=
ound\n");
> > +
> > +     if (num_channels > ADS112C04_MAX_CHANNELS)
> > +             return dev_err_probe(dev, -EINVAL,
> > +                                  "num of channel nodes exceeds %d\n",
> > +                                  ADS112C04_MAX_CHANNELS);
> > +
> > +     channels =3D devm_kcalloc(dev, num_channels, sizeof(*channels), G=
FP_KERNEL);
> > +     if (!channels)
> > +             return -ENOMEM;
> > +
> > +     st->vref_source =3D devm_kcalloc(dev, num_channels,
> > +                                    sizeof(*st->vref_source), GFP_KERN=
EL);
> > +     if (!st->vref_source)
> > +             return -ENOMEM;
> > +
> > +     i =3D 0;
> > +     device_for_each_named_child_node_scoped(dev, child, "channel") {
> > +             const char *sp =3D "single-channel", *dp =3D "diff-channe=
ls";
>
> What does the "p" mean? I would make the names the same as the string,
> e.g. sc, dc, or s_chan, d_chan since they are used quite far from here.

Renamed to s_chan and d_chan in v7.
>
> > +             struct iio_chan_spec *spec =3D &channels[i];
> > +
> > +             if (fwnode_property_present(child, "excitation-channels")=
)
> > +                     return dev_err_probe(dev, -EOPNOTSUPP,
> > +                                          "excitation-channels is not =
supported yet\n");
> > +
> > +             st->vref_source[i] =3D ADS112C04_VREF_SOURCE_INTERNAL;
> > +
> > +             if (fwnode_property_present(child, "reference-sources")) =
{
>
> ads112c04_parse_vref_source() already calls fwnode_property_present(child=
, "reference-sources")
> and returns ADS112C04_VREF_SOURCE_INTERNAL as default, so we are duplicat=
ing that
> logic here. Either drop the helper or drop the extra code here.

Dropped the extra code in the loop and now call the helper directly.
>
> > +                     ret =3D ads112c04_parse_vref_source(child);
> > +                     if (ret < 0)
> > +                             return dev_err_probe(dev, ret,
> > +                                                  "invalid reference-s=
ources value\n");
> > +
> > +                     st->vref_source[i] =3D ret;
> > +             }
> > +
> > +             if (st->vref_source[i] =3D=3D ADS112C04_VREF_SOURCE_EXTER=
NAL)
> > +                     *need_ext_ref =3D true;
>
> Can just assign these directly:
>
>                 *need_ext_ref =3D st->vref_source[i] =3D=3D ADS112C04_VRE=
F_SOURCE_EXTERNAL;

I used |=3D instead of =3D here: the flags accumulate across all channels,
so a plain assignment would let a later channel clear what an earlier
one set. For example with channel 0 on "external" and channel 1 on
"internal", *need_ext_ref would end up false and probe would skip
reading the refp voltage.
>
> > +             if (st->vref_source[i] =3D=3D ADS112C04_VREF_SOURCE_AVDD)
> > +                     *need_avdd_ref =3D true;
> > +
>
> ...
>
> > +
> > +             i++;
> > +     }
> > +
> > +     indio_dev->channels =3D channels;
> > +     indio_dev->num_channels =3D i;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ads112c04_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct iio_dev *indio_dev;
> > +     struct ads112c04_state *st;
> > +     struct reset_control *reset;
> > +     bool need_avdd_ref =3D false, need_ext_ref =3D false;
> > +     int ret;
> > +
>
> ...
>
> > +     /* Datasheet: POR releases ~500us after supplies are stable */
> > +     fsleep(500);
> > +
> > +     reset =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> > +     if (IS_ERR(reset))
> > +             return dev_err_probe(dev, PTR_ERR(reset), "failed to get =
reset\n");
> > +
> > +     if (reset) {
>
> I'm pretty sure devm_reset_control_get_optional_exclusive() already asser=
ts
> the reset. So the way this is usally implemented is that we get (assert)
> the rest, then wait chip-specific time (usually a few microsonds) then
> reset_control_deassert().
>
> I don't see any other IIO drivers that are using reset_control_reset().
> (And I think a lot might be calling reset_control_assert() unnecissaraly.=
)
>

You're right - reset-gpio requests the GPIO with GPIOD_OUT_HIGH, so the
reset is already asserted by the time we get the control. Changed to
waiting tw(RSL) and then calling reset_control_deassert(). That also
makes the pulse width explicit, rather than relying on the assert and
deassert inside reset_control_reset() happening to be far enough apart.
> > +             ret =3D reset_control_reset(reset);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret, "failed to reset d=
evice\n");
> > +     } else {
> > +             ret =3D ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
>
> If it wasn't for the duplicate code, I might have said good enough. :-)

Thanks,
Kyle
