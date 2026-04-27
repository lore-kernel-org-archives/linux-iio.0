Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9382308F1D
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329933; cv=pass; b=TGxBfpGghKUKge3BGOAx5DBvGNQXu2a/iccU6t2EKkR9vT2ydKL6iapj7OhqbZLae6SWMYLwQ2BF4xEmS3rWDvmeXWqidrHtB+x1eMyR6HHGHUbEDrbQQFhE381mTZuRHRYi5i0V0jcyNMI8s6aNwSnk37/i005brzuBgK74k/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329933; c=relaxed/simple;
	bh=NwM8y+2Ts7d7cO9hYC0y7UrNQPBdCzys1Q1nsIAgj+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3AobIS8GfD+jG77glmnwfath2TYPc/Ob6E6/vMw6S8LzlhN5r2iTMtyCKqfVWctMsEu759WSJVS0yJCsi4mWBUFWm8P7rOen3mynHAcLdlvHJ/iXwtzX525Z3Tw1SEtqYU/5/wNGT4suQDi/jqALxUlrue+AjV85KLYEWZQRIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc1g0DvQ; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc1g0DvQ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e8292423fso95467161fa.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 15:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777329930; cv=none;
        d=google.com; s=arc-20240605;
        b=TMOoXw20Jvj2km2/7UciI5uVwf9DMtn99HfMaAkdTehNMgpFAGgYYlDd6cvE2wrU7c
         cwwai/hChupKVP0P82EnPOYFLKDA3nmmmA7XXqSEIlzTjnqUuEv0syb51oEPc8Pty7Kf
         VxoC0pp8D1vBsiyQgIK0tjrzgqHVrO6DpIjzWsZpKf6HgVSFIZNS/9W7Ds//7xhPi7wj
         9SOl9NC8OB8MWz5+mlXPW0sn+CkDbdUrswzHDE4/BMhW3y5vXwH5iPD70Qt/lreILIe8
         6cQgKylOmd73GsR8mwhEXBLZ/2XrcMivLzBCz6HAGUpTBTOzxsV5ZiEk4MDLBcIBwDp1
         Ar5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXFT5KAXJCWYb3ne2SnsbwowHcutyxyOkbiWcwD6uvo=;
        fh=rTNhwfeRdb2lI8792HOmvrlLkF+LkKGXKCtV/J06nto=;
        b=XCthR7vHTsb6W0Dk5iPPFjMXDv1Bxq5e6mX5Sy/ehMgK5NGoHk0v0icS4SZ6X8SfHE
         lUOgu0Kl4BTnt1Jt4Aa2/kxvSaiuxkZw+J3EIZt5IZHfsnZwXhV4M0HmJeSxj3f13olq
         WfmpJi5BaMWCZopQWsVTUntue/4dhATZotwg32zAvogNa1M6qa6JqhfnHCB4sxyFrKLN
         3QzaMhoI+LUEGgyLRqC70LRotCaFGIYjH1UYI/OzjJ2/iWK1Sy904Ev3zd6FX4o6rNgf
         IJ6TF5L42HGOQzSz0h16mo2vDVG+jnl+9rBxsuLvykP9IExZCKJjZ8r3M1y7LJVMDvMX
         FVVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777329930; x=1777934730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXFT5KAXJCWYb3ne2SnsbwowHcutyxyOkbiWcwD6uvo=;
        b=Qc1g0DvQ1bPTTpVbyhTfFDp9GAzN1L46kgVpVJy6JbDY4JQKQ02PPeLJqIO+TwC0IC
         2ve9WEXgNSB8mwEJegJlXhQTepcGXoA/R1Pmj8jBhEUC8ll1+gvxKHMMPztsQlIUtxFR
         JxF6oso/oWKuxIdQijY4xbf85bMLh7mg8uXz1OtXgNEoBN7L4BzM+Y7cwVSRJLzJSna7
         DBmgmza8rKN0s181nUqgZ3ngdVUIa0Oeszlr5PXI92RLLtydAQpPIgPldd1ZssX3dMXk
         QJDKx0nzJ8wzHJLg1XMoy4uu2lfp9pIjn/BX3GKsBc+gcxjrudR+gxFcO+jO61CMWEqs
         0bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777329930; x=1777934730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rXFT5KAXJCWYb3ne2SnsbwowHcutyxyOkbiWcwD6uvo=;
        b=hLTbeRNj8wjZniKT2+bcvieuRBpJVIOQIrYZIt4duHKZEp4gzfyMoH6m4UsdhmSnxd
         v6mioPcpBKWbmHp4QAwA6oROEdVCSae4+SIqIUZ6WJH8VdAT2Ge8qiGxWmthKRJ4qLuY
         a+YYhoh5QScYr2VFhXyTYADMnWnUNSDPNKvn3EkmtLlSFsoo610xr0rwnLzxtV44JLpf
         pahh1i9Hvcjg0KptorPjCrG9Y3vZCnjQ64ijtuYFX83xC7AQzt4qQwl1OQBRsFNlNbtv
         okF6iscMdWsheaG3HqKfNkhvSZE+bSzYwCWPKWBRXn6d6y4iWffE1rem/D5uABzqqcGa
         DZjA==
X-Forwarded-Encrypted: i=1; AFNElJ9YPcrQsc38x4Ft9WFwld1xO5XSEjWcN/T103U7EzeLfKdBX9IuxjF4peBFicBBXw8UncXwk/fCEvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK9JIro45g9K3tiXEO1zOho4QGA/r2N2eKhvMFy/Fwjkcm6uex
	sAEsciKiVONy2prVb78Kjf/CjzVjjz41xSbUyO4bLujn31Bim93mimaWfK3mp9fWWPEi4kgFHWZ
	PLjYc5QYeUkcFcYaw0egBWSTWF1w/F9A=
X-Gm-Gg: AeBDietCifswQlosZxbl2xfr+/qywArmP7Cm6G7DRyHfnGrx1ttt44bZA69R9XEYpdg
	qmDWCUkp8p3qkJVJgIpcW1Mwuzwmw6SbkxSn3L8EllWA0z8iOvNJnkLtOa7oYtL2n0Njgj+WIZG
	BFCWGqBBEcB5vrDk4dpjgkmRwqVxyioycPF8k20WykeEbSPHyYqKBhl5oEcAPQ9ONNvUzKwc9K4
	kIia9AKMIqwtsOdzwXBK4WU9vNvtGyYzAhK49UNOtfLL0JuSf+PAuWLOGuXB1VLtQs/vUgaOByP
	CDUhSFAzCnY5COadN+gnUGWx8824dJtiBUv6xC/RaRIKb4oy1XxhzGMA5en8V5DNU5xH8ckbpOG
	3Oek=
X-Received: by 2002:a05:651c:1990:b0:38a:4dd9:23f5 with SMTP id
 38308e7fff4ca-39240f9f732mr940401fa.22.1777329929976; Mon, 27 Apr 2026
 15:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-5-piyushpatle228@gmail.com> <ae9t0WuhKgcPkfIt@ashevche-desk.local>
In-Reply-To: <ae9t0WuhKgcPkfIt@ashevche-desk.local>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Tue, 28 Apr 2026 04:14:53 +0530
X-Gm-Features: AVHnY4Kyd3mMKLSlCHdJCBn9JyaHjZzN_gbl2Tt7pONyK2SSXKOA5O2LwQlUjOw
Message-ID: <CAMB+xkZiMbkHpL5j8O+OWUAPHYj9=bo2Gk_NjT3-i1o0d2YTDA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] iio: adc: hx711: introduce hx711_chip_info
 per-variant structure
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Apr 27, 2026 at 03:39:35PM +0530, Piyush Patle wrote:
> > Add struct hx711_chip_info to hold per-variant static configuration:
> > device name, IIO channel spec array, IIO info ops pointer, and channel
> > count. Store a chip_info pointer in hx711_data and populate indio_dev
> > fields from it at probe time instead of hardcoding them.
> >
> > Use device_get_match_data() to look up the chip_info pointer from the
> > of_device_id table. Guard against a NULL return so that the driver
> > fails cleanly if probed via the platform name match path without
> > associated match data.
> >
> > No functional change for existing HX711 users.
>
> All the above is fine, but I missed the answer to the question "why?"
> You need to add that this is preparatory change to add more HW support
> or something alike along these words.
>
Will add to the commit message: this introduces hx711_chip_info as a
preparatory step so that the HX710B support patch can register a
second
variant without duplicating probe-time setup.

> ...
>
> > +static const struct hx711_chip_info hx711_chip =3D {
> > +     .name           =3D "hx711",
> > +     .channels       =3D hx711_chan_spec,
> > +     .iio_info       =3D &hx711_iio_info,
> > +     .num_channels   =3D ARRAY_SIZE(hx711_chan_spec),
>
> The array_size.h inclusion should go with this patch.
>
> > +};
>
> ...
>
> >       struct device *dev =3D &pdev->dev;
> >       struct hx711_data *hx711_data;
> > +     const struct hx711_chip_info *chip_info;
>
> Preserve reversed xmas tree order.
Will reorder the probe locals so the widest declarations come first.
>
> >       struct iio_dev *indio_dev;
> >       int ret;
> >       int i;
>
> ...
>
> > +     chip_info =3D device_get_match_data(dev);
> > +     if (!chip_info)
> > +             return dev_err_probe(dev, -ENODEV, "missing match data\n"=
);
>
> Since we are here, it's not match data, it's driver data. "missing driver=
 data".
>
> > +     hx711_data->chip_info =3D chip_info;
>
> + Blank line.
>
> >       /*
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Will make changes as suggested and give v5
