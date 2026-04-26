Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990762E11D2;
	Sun, 26 Apr 2026 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777200087; cv=none; b=CFsRhTUf2gc+bSl0brahLkqUG5s8nUt29trtAb3Af8phZtYe1pH+8DPvHdq2oO8M7yQPvBRoK3t4Fn5WCWrwWZhtUjwTllJ/Z2yiH2rRj7fX6NwsJ39IWSao39cxYZh4bbryHdq2sESF0BuVkLtFBUdDdAUtR4AaAeiUaO1VCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777200087; c=relaxed/simple;
	bh=bWuYnO75xPWJJzpmOLfME7o59x3oZomw2PqqFsHNDKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kugBr2/um7i0yq7BZ0etG3/tgFmu1HGAnnpnvWB4D3+qy3HWMkPkzbBoBRnjMCYYCdn2hK2FfJKY3Qx75HyPHCWohhMoLIgnIP0fzgWYWTz88PSQ/rURE4C4izAbIljM6F6nilfvjioXvPD+DAJqGwlLuDuxjYXYvVW7IKH8JM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxn4W1yb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxn4W1yb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B5DC2BCAF;
	Sun, 26 Apr 2026 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777200087;
	bh=bWuYnO75xPWJJzpmOLfME7o59x3oZomw2PqqFsHNDKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rxn4W1ybROgNUPHL7WHZepd5HEn3s4NjpiHxJPTzVQTagfs298o6rOZZ3vI4COjS0
	 Zo1QTzuYVJJEhelJrboWJ+aYJZsM/LthaEvmMqcFjg+2TOQZvd6FP9h40puitiI696
	 qGup3Zb0LePODPuqynEoHZA936p8PvtaL9GK/RJAmK5gfwmUXI1q8B3iAhgWP3MsR3
	 2TUZmwQcf0j0+HQwKrKWJwMkbUxdviLcEfi2ZEHMD8XBUJGVWIHHcW35afjIB1vAlB
	 ZhtLxGOS6feEg8BeHxFvIMPytR2sbX52jNC4sLyZ43+naquvu5p1m+BrsuNnPhFB+e
	 v4Dt1yZDNY+OA==
Date: Sun, 26 Apr 2026 11:41:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Felix Gu <ustc.gu@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on
 error
Message-ID: <20260426114118.7ad8b130@jic23-huawei>
In-Reply-To: <CAKxU2N9_Nmk_apUZLSCGssXpwxYOz9k99ggRcUM3EPGUzaVi7w@mail.gmail.com>
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
	<CAKxU2N9_Nmk_apUZLSCGssXpwxYOz9k99ggRcUM3EPGUzaVi7w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 25 Apr 2026 12:20:55 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> On Sat, Apr 25, 2026 at 9:07=E2=80=AFAM Felix Gu <ustc.gu@gmail.com> wrot=
e:
> >
> > meson_sar_adc_temp_sensor_init() allocates a buffer with
> > nvmem_cell_read(), but the old code leaked it if
> > syscon_regmap_lookup_by_phandle() failed.
> >
> > Switch buf to __free(kfree) so all return paths release it.
> >
> > Fixes: d6f2eac64403 ("iio: adc: meson: no devm for nvmem_cell_get")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > ---
> >  drivers/iio/adc/meson_saradc.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_sar=
adc.c
> > index 23991a3612bd..9708ddcc4919 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -786,7 +786,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *i=
ndio_dev,
> >  static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
> >  {
> >         struct meson_sar_adc_priv *priv =3D iio_priv(indio_dev);
> > -       u8 *buf, trimming_bits, trimming_mask, upper_adc_val;
> > +       u8 trimming_bits, trimming_mask, upper_adc_val;
> >         struct device *dev =3D indio_dev->dev.parent;
> >         struct nvmem_cell *temperature_calib;
> >         size_t read_len;
> > @@ -807,14 +807,12 @@ static int meson_sar_adc_temp_sensor_init(struct =
iio_dev *indio_dev)
> >         }
> >
> >         read_len =3D MESON_SAR_ADC_EFUSE_BYTES;
> > -       buf =3D nvmem_cell_read(temperature_calib, &read_len);
> > +       u8 *buf __free(kfree) =3D nvmem_cell_read(temperature_calib, &r=
ead_len);
> >         nvmem_cell_put(temperature_calib);
> >         if (IS_ERR(buf))
> >                 return dev_err_probe(dev, PTR_ERR(buf), "failed to read=
 temperature_calib cell\n");
> > -       if (read_len !=3D MESON_SAR_ADC_EFUSE_BYTES) {
> > -               kfree(buf); =20
> I don't like this. Just add the missing kfree.

That is the minimal fix, so we should probably do that first
even if we then circle back to consider if __free() magic is worth using he=
re.

J
> > +       if (read_len !=3D MESON_SAR_ADC_EFUSE_BYTES)
> >                 return dev_err_probe(dev, -EINVAL, "invalid read size o=
f temperature_calib cell\n");
> > -       }
> >
> >         priv->tsc_regmap =3D syscon_regmap_lookup_by_phandle(dev->of_no=
de, "amlogic,hhi-sysctrl");
> >         if (IS_ERR(priv->tsc_regmap))
> > @@ -835,8 +833,6 @@ static int meson_sar_adc_temp_sensor_init(struct ii=
o_dev *indio_dev)
> >         priv->temperature_sensor_adc_val |=3D upper_adc_val << BITS_PER=
_BYTE;
> >         priv->temperature_sensor_adc_val >>=3D trimming_bits;
> >
> > -       kfree(buf);
> > -
> >         return 0;
> >  }
> >
> >
> > ---
> > base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
> > change-id: 20260425-meson_saradc-54abc52d9b31
> >
> > Best regards,
> > --
> > Felix Gu <ustc.gu@gmail.com>
> > =20

