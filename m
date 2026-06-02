Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE9372044
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418537; cv=none; b=F3LtX9vO2enD0CRvt27em/GVNh5SKOmFd6rh95Uzh+T7ruPOJWvitdsHqyuG8n01eWqiGG3UkD+YdnKXGOPctL+XTRBJa9GaVwdM7v4+Il4AuYCYD1hmJkP3l5Hfnkkr8qA8DzPZOxW8yU9/mY+IO501yKVb8BD49vuBDqrCDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418537; c=relaxed/simple;
	bh=s6aDIM5T4K9eEgStPnqzEH7yFVm5qbwDjPGc76UY+L4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAgnuQhO31ccJIBpq+4La9jTCaws3xSTaijdbZVGqpfgJyHmQ2Mk8C5zlzK5J2h7cf3DBSBdoXz2Sgk/2Q1lKWH7+0qFyEk3Yi7zstcr6F7i4FGd2197Sk/7hlSFfHx+wEYZ5peRAOnw90s00CDqHTTffm/WpsDVZODUu59Js+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBa81a4/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBa81a4/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso116743955e9.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780418535; x=1781023335; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zCciMA4f/2leknE0hevkJM9c0pFZpflJQvPHBF72s8k=;
        b=PBa81a4/OEWRqHeaosFr/rcSVB57ibcd7SCnyTwVa1d80Uy0ihbUMC6wUw+cenAQ+c
         +pAo3Sh2L6y5xWaeVMvSfsodjk/7kuGvbkGkmH/Z0jagEOmpxMTSF7qTS5nLQenw0Zmt
         WP5daLAXhIi/2InIleN9JRNiKZdJUkzG6MlG5/g8ebJUW4GM+C8gxJzxJFDUSdHIy6bU
         7Zd3K48GS/u91WgVg6gLzHU0d28VOmqSPTZVI3/9/FDzfuONyLRoOq6lAXbXmZIQg0dU
         AFgJypGrCXX1YQuCr15NNJ9hxXXFlRzFm440AT2RooldbCbNUqVdnONhuGpK7EXkT6jH
         VDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418535; x=1781023335;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCciMA4f/2leknE0hevkJM9c0pFZpflJQvPHBF72s8k=;
        b=nckBP29iy1nINIe0OoSCIoHbhYbYuP6JppdCciupgIs9dIr/9ZmmV9oQ/dZG/mM4VS
         HXm5Sw13mtlq/tsGImSsBtgzo7BxES/6RbgfB1WrCfTeWh16yrHKiU1POc/kHmlAJBw3
         i43vz+//m+xeuaD0jKC0qiknhyHYNeINc/bFQ61uVjUp/zTxYpMtSFcVPu4U0aQSIVu7
         pqcQ7VpenCpdESXZuMu6KbQAUa7NHLoY7xFoqHexules5955vjvLC3eY8j2eDzhSx+tW
         YrvTwYxjB3pW6ALhfDRBn6ivF6nLXaVGRdBCUX2jsRJMVOcOTEgsazGTiA5vbdhv/YGh
         /Z6Q==
X-Gm-Message-State: AOJu0YzJyfxhmIFBcPsZJUFbK4sZ/XvZy7nI4gB51cswywnJTGNFYeaJ
	oxxuy04/d97rjp0whGnuSEaEQeU6Kdo1N5tnDyaeF9xzSUFN4NpA+mLT
X-Gm-Gg: Acq92OE5P9cmrdeTssWOR1ppjaNNSpn+kYJFrfjNlxarN0w/sKMFpeKWtpuh63f4ClJ
	Vjr0A+mWk6/5dr1QrXp1AKJNMn7WB0osFpRXJhlAzY5CS2UlD7+6a7KXEf1WcfTruj9t2ou8+uT
	I4UBfioVnYaHu63Du05iaIKqAgnZ/m7wlF1kOD4DumFdXKtqGE4O5TpDoJb/2uWBOvf2BI/wmei
	E6M/PLPZ1QTL/gTV3gGtaVK9uHfJuOYJ77PMzKv971HPIGcBOLyFAyLXRdo4RIM68UFEOcQezRB
	snVoQGCuG7NVDlT6KhQorrNSi3KrHrtYDW/wDzaafpliuKqExrffCXHs+Lml8NfVxQvr6Rm+iKv
	ZHSIgegsPLeoTSycwqBtl60CIZHRq7YNJM7KahztfjWhywN+aPNMlyHcb5y9+8wDjyzfLf7D2aQ
	kvCkzribXOZDWxucPdglLJ5FXHTMzBWtqoKkESIAQ9tetBKeBHAGXyZ9o+z0bugU/LZEH7nkHjx
	SdUY83Pxn3BOss+CZPdgxk=
X-Received: by 2002:a05:600c:35c9:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-490b50b972amr8330945e9.22.1780418534540;
        Tue, 02 Jun 2026 09:42:14 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e20bacsm74368025e9.6.2026.06.02.09.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:42:14 -0700 (PDT)
Message-ID: <2df4cad5e29fbcb4c5c5f59ea0bf322c7a301bdc.camel@gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: rva333@protonmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Andy Shevchenko	 <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger	 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno	 <angelogioacchino.delregno@collabora.com>, Lee
 Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Date: Tue, 02 Jun 2026 17:43:18 +0100
In-Reply-To: <20260602-mt6323-adc-v1-2-68ec737508ee@protonmail.com>
References: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com>
	 <20260602-mt6323-adc-v1-2-68ec737508ee@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-02 at 15:46 +0300, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
>=20
> The mt6323 AUXADC is a 15-bit ADC used for system monitoring. This driver
> provides support for reading various channels including battery and
> charger voltages, battery and chip temperature, current sensing and
> accessory detection.
>=20
> Add a driver for the AUXADC found in the MediaTek mt6323 PMIC.
>=20
> Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd
> Generation)
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 8 ++
> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 11 ++
> =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/mt6323-auxadc.c | 299 +++++++++++++++++++++++++++++=
+++++++++++
> =C2=A04 files changed, 319 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..c9ad2417a3ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16256,6 +16256,14 @@ S:	Maintained
> =C2=A0F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> =C2=A0F:	drivers/mmc/host/mtk-sd.c
> =C2=A0
> +MEDIATEK MT6323 PMIC AUXADC DRIVER
> +M:	Roman Vivchar <rva333@protonmail.com>
> +L:	linux-iio@vger.kernel.org
> +L:	linux-mediatek@lists.infradead.org=C2=A0(moderated for non-subscriber=
s)
> +S:	Maintained
> +F:	drivers/iio/adc/mt6323-auxadc.c
> +F:	include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h

The above file was not added in this patch

...

> +
> +static const struct iio_chan_spec mt6323_auxadc_channels[] =3D {
> +	MTK_PMIC_IIO_CHAN(baton2,=C2=A0=C2=A0=C2=A0 MT6323_AUXADC_BATON2,=C2=A0=
=C2=A0=C2=A0 MT6323_AUXADC_ADC6,=C2=A0
> IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(ch6,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MT6323_AUXAD=
C_CH6,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MT6323_AUXADC_ADC11,
> IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(bat_temp,=C2=A0 MT6323_AUXADC_BAT_TEMP,=C2=A0 MT6323_=
AUXADC_ADC5,=C2=A0
> IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(chip_temp, MT6323_AUXADC_CHIP_TEMP, MT6323_AUXADC_ADC=
4,=C2=A0
> IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(vcdt,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MT6323_AUXADC_VCD=
T,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MT6323_AUXADC_ADC2,=C2=A0
> IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(baton1,=C2=A0=C2=A0=C2=A0 MT6323_AUXADC_BATON1,=C2=A0=
=C2=A0=C2=A0 MT6323_AUXADC_ADC3,=C2=A0
> IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(isense,=C2=A0=C2=A0=C2=A0 MT6323_AUXADC_ISENSE,=C2=A0=
=C2=A0=C2=A0 MT6323_AUXADC_ADC1,=C2=A0
> IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(batsns,=C2=A0=C2=A0=C2=A0 MT6323_AUXADC_BATSNS,=C2=A0=
=C2=A0=C2=A0 MT6323_AUXADC_ADC0,=C2=A0
> IIO_VOLTAGE),
> +	MTK_PMIC_IIO_CHAN(accdet,=C2=A0=C2=A0=C2=A0 MT6323_AUXADC_ACCDET,=C2=A0=
=C2=A0=C2=A0 MT6323_AUXADC_ADC7,=C2=A0
> IIO_VOLTAGE),
> +};

All of the above are IIO_VOLTAGE. Just remove _ch_type then.

> +
> +/**
> + * struct mt6323_auxadc - Main driver structure
> + * @regmap:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Regmap from PWRAP
> + * @lock:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mutex to=
 serialize AUXADC reading vs configuration
> + *
> + * The MediaTek MT6323 (as well as a lot of other PMICs) has the followi=
ng
> hierarchy:
> + * PMIC AUXADC <- PMIC MFD <- SoC PWRAP (wrapper for PWRAP FSM)
> + *
> + * Therefore, PWRAP regmap should be obtained using dev->parent->parent.
> + */

The above kerneldoc seems unnecessary to me.

> +struct mt6323_auxadc {
> +	struct regmap *regmap;
> +	struct mutex lock;
> +};

...

>=20
> +
> +static int mt6323_auxadc_read_raw(struct iio_dev *indio_dev,
> +				=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0 int *val, int *val2, long mask)
> +{
> +	struct mt6323_auxadc *auxadc =3D iio_priv(indio_dev);
> +	int ret, mult;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->channel =3D=3D MT6323_AUXADC_ISENSE ||
> +		=C2=A0=C2=A0=C2=A0 chan->channel =3D=3D MT6323_AUXADC_BATSNS)
> +			mult =3D 4;
> +		else
> +			mult =3D 1;
> +
> +		/* 1800mV full range with 15-bit resolution. */
> +		*val =3D mult * 1800;
> +		*val2 =3D 15;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &auxadc->lock) {
> +			ret =3D mt6323_auxadc_prepare_channel(auxadc);
> +			if (ret)
> +				return ret;
> +
> +			ret =3D mt6323_auxadc_request(auxadc, chan->channel);
> +			if (ret)
> +				return ret;
> +
> +			/* Hardware limitation: the AUXADC needs a delay to become
> ready. */
> +			fsleep(300);
> +
> +			ret =3D mt6323_auxadc_read(auxadc, chan, val);
> +			if (ret)
> +				return ret;

Could be return mt6323_auxadc_read(...)

- Nuno S=C3=A1
>=20
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MediaTek MT6323 PMIC AUXADC Driver");
