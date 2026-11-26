Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677500;
	b=r/EsVvHTrLwR5Ci1DRlQIBmQ3ff0EODHCEBNmObPfyq5dkvVJKSNr3kkvxOfgKliS+8i
	 J9Jqiq5YgCOvxyI59lnZLDwjx7zg4g5tVpPZM4bwQio7qFe3PWmCYvpG3t0tsOkcW6Wa6
	 boviuUTMT5m0lBZdAT3+VC9mTHwegG1kcPvQiMF4RP5Jake5KGJRt4CrI+18qe7LWvzcO
	 R51B34KmcDC2/Ay7FXtACixVJpNRtEQW/cZuy1LRkzSyHU6dH+cese+x565S7qwVZVjyG
	 DyLWxA4vAMR6O493gvrjaqAh42XLoKKTtdoAz47T3CtJo4nDwdhEQkq1fmWYp4xeKkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677500;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=tX3o0qeNUHveUfMsho6zhAb9fsA6bZNmkDLOGDbQF6U=;
	b=qRBM1+/y99avbCzUD5zXWNJ5KacaVOnNybDIHTOuDoTJSpuvaZ1/ZokH2sXNR1fit9Yj
	 k4zmnFOuiNn2tF5SuMK1r74TSq8uePZcHWuRo8Xh/0XE2j25bLjCUTj//058bZYqDqQzt
	 IxdE5TK2R7/+u0F9y7mGb2C+Y2hsMhxxvm7L96GRcqh7+RFPiBufsH4AXhvauRTnRXAql
	 845/1qn5HZyAD86lmvYZIKveo3ImjHfoLU8a/Mw0l5JiPcBxDqOf8KAJ9sEInmaFhxT/s
	 xTzZ9TF02zcKCHTEWj/HX6LXQeKrGqb1c20whx0YOjnnTDfewltVxI0P4/QRbRBXTig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=dj2yBEI6;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD9606A31C;
	Thu, 26 Nov 2026 07:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BD9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=dj2yBEI6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795677497; x=1795936697;
	bh=tX3o0qeNUHveUfMsho6zhAb9fsA6bZNmkDLOGDbQF6U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dj2yBEI6txOoDvpYaPykPsJAaCthsH9dkkb0HKqxeZd5o37mWj/sOOf22lGbNmfzx
	 KwDc5eKxSmNYiiSupjLjOhJRTjGJaRGN0zqdJkJVg0rCUKaf6gsmbIsJNrsW3KGKxF
	 /57QBqw2LFiZU/Bg2Dc8+eaimQ9dZ5/IF+0g1w2UuKklSk2q35nheN2K9y7X/X1s6v
	 vrO4WsCUNiYchXvjmkEpkOXpls8jjmQlMBWl+EelvwlbRpE2V8ZsHKL9DALi0pP5Zk
	 7YcbNjmlRJhpxniBpX6mQ7juyLjrmomxfgzh+QgkXhsrlbsQC2rLQS60Tmw6QAxmf2
	 ew69LSxWLlYzw==
Date: Thu, 26 Nov 2026 07:18:12 +0000
To: iasnezhkov@gmail.com
From: Roman Vivchar <rva333@protonmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: mt6359: divide scale by ADC resolution
Message-ID: <cLdx9oABQCqAoQThLiQ2oL34p3QMP4Xjq-kkFh6bkQfY16c-wXzqrKm06VYO0rxMkR56vn2ycUamZ7i6zv0metPym3UtZP2DUW-7H1KKyB8=@protonmail.com>
In-Reply-To: <20261126031013.27701-2-iasnezhkov@gmail.com>
References: <20261126031013.27701-1-iasnezhkov@gmail.com> <20261126031013.27701-2-iasnezhkov@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: bf6b6590f4306e2e6d14d6933bf8b5bf3be7ec46
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thursday, November 26th, 2026 at 5:11 AM, Ilia Snezhkov via B4 Relay <de=
vnull+iasnezhkov.gmail.com@kernel.org> wrote:

> From: Ilia Snezhkov <iasnezhkov@gmail.com>
>=20
> mt6359_auxadc_read_raw() returns raw ADC counts for IIO_CHAN_INFO_RAW
> (12-bit or 15-bit depending on the channel), and returns only
> (r_ratio.numerator * vref_mV) / r_ratio.denominator for
> IIO_CHAN_INFO_SCALE without dividing by the ADC full-scale range
> (1 << chan->scan_type.realbits).
>=20
> As a result, iio_read_channel_processed() and userspace consumers
> multiplying raw * scale obtain millivolt values that are 4096x (12-bit)
> or 32768x (15-bit) too large.
>=20
> Include the 1 << chan->scan_type.realbits divisor in
> IIO_CHAN_INFO_SCALE: shift r_ratio.denominator left by realbits for
> IIO_VAL_FRACTIONAL when denominator > 1 (r_ratio.denominator is u8 and
> realbits is at most 15, so the result fits comfortably in int), and
> return IIO_VAL_FRACTIONAL_LOG2 with realbits otherwise so channels with
> denominator =3D=3D 1 use an exact shift and unpopulated descriptors (such
> as MT6357 VDCXO where denominator =3D=3D 0) cannot trigger division by ze=
ro.
>=20
> Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxil=
iary ADC")
> Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>

This fix was already submitted [1]. Please check mailing list for
existing patches first.

Also, wait at least 24 hours before sending v2 for non-trivial series.

[1] https://lore.kernel.org/linux-mediatek/20261117-6768-6358-fixes-v2-3-1f=
fc3c2f3c80@protonmail.com/

> ---
> Changes in v2:
> - Move AI coding assistant note below ---. No code changes.

This applies to all your mediatek patches as well.

Best regards,
Roman

>=20
> Found and drafted with an AI coding assistant.
>=20
>  drivers/iio/adc/mt6359-auxadc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-aux=
adc.c
> index 88b0e26..54c9048 100644
> --- a/drivers/iio/adc/mt6359-auxadc.c
> +++ b/drivers/iio/adc/mt6359-auxadc.c
> @@ -772,11 +772,12 @@ static int mt6359_auxadc_read_raw(struct iio_dev *i=
ndio_dev,
>  =09=09*val =3D desc->r_ratio.numerator * cinfo->vref_mV;
>=20
>  =09=09if (desc->r_ratio.denominator > 1) {
> -=09=09=09*val2 =3D desc->r_ratio.denominator;
> +=09=09=09*val2 =3D (int)desc->r_ratio.denominator << chan->scan_type.rea=
lbits;
>  =09=09=09return IIO_VAL_FRACTIONAL;
>  =09=09}
>=20
> -=09=09return IIO_VAL_INT;
> +=09=09*val2 =3D chan->scan_type.realbits;
> +=09=09return IIO_VAL_FRACTIONAL_LOG2;
>  =09}
>=20
>  =09scoped_guard(mutex, &adc_dev->lock) {
> --
> 2.54.0 (Apple Git-157)
>=20
>=20
>=20
>
