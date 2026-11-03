Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714625;
	b=NrnDDB/CHqu1lLiRT7fp8UDo0ASfXSNeSDHe8u5T2M/88qaI7IRAjS4aLI2NHHWt/tfl
	 cmibHz0oMpbPh0tXEwtyLEpiDnEFihFPDzEnzUBdWXXqWBm0x3XcFrcc7Frii79t/ebvB
	 SOFofzMYwXrtjj5kRLjoWdLOZU6vaXFQsWp/lhs09iiTmh4U2Jmw6WC21wTToxwMZQ31W
	 /Wa7z5/T2FXDeHq9DSJRj7ZMyfT19OsIwUrEm198QQPANnFzzsfiwVYVZoBRrerNE/lQZ
	 Z4xpKhY1yky7SdhPC/5hpsiyfIxRQkL65MSfGYFbIL2H2pIE2IelyDazhs5g0K3SV0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0mpQqPcx/wO2M/JeyOkuY7Hd6GV1/TOLmZZItrx8K9I=;
	b=QafqcYj15gfzmUgZR3txEyhiZ3ugOrsfGnQ8vcN9G1o8s1a8pBsZc8bOUGueuezWHF9y
	 YETYKl+BX34DOceKmAXmQNWdhRN3Y2QXd2pzxx5+JAKTgkjnu+P/sdz4nSlEFGClFc2lx
	 Eiq93DnufAOFQ+g97gcUq1sx3yYHSKu4ZTGr7Qewrw5w9AAegJXBGoNdodfih7+1tUVMu
	 pFWUOQXI2p94xDI0lIW/CJWWJu0cHSkLldSkYdrGh5IOZZGOs2O8og8UKxUoNOtz1aNH+
	 jKZaXJ9l6TsL44eKMrwCm12f1q9MPdk0i48CHVay5jHTQzpQzZJ8uD74p+SQ7GAn1qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=re4roQiG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F296071BCF
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 14:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F296071BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=re4roQiG
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e3b22e971so2149637f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 06:03:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793714623; cv=none;
        d=google.com; s=arc-20260327;
        b=l/ClVlfAlz0ArEC3ED70rNFJmJDsrGix34vwjcs8wRQvWEWs0sC0OAUIPbDrAYo32i
         bbz+oF9bZt8hNuN9rybOVT/DvTHb67nNoUaITsoIQzXqNJzizaONOrccCrCIp6TSKYH2
         BGJzD8umgIzcebCiTLKJfMcz5ncPLbz0yLuITKDV2NSveRsEqwQ/+QBIWNrBVpFIvIfx
         rh8POjWZS8mkeTc9oqG7OxcruGgFBCLoce/lSL7W+GyQNEF/SCvxRlW6fN4hNpeVqYCq
         1Fixh0+mI7OZ6EU10UVNZyFwlBAMsr1U4C6tSL92jjCyR10dDQV11kYswWllsVQR3rG+
         dhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0mpQqPcx/wO2M/JeyOkuY7Hd6GV1/TOLmZZItrx8K9I=;
        fh=3iUz5R0BUI2tBknW6KHw22/h2tEEGoXm2kaxx8lztBc=;
        b=lsPjqubuTmAIgr5v5cyR+PXTvLiXYdaco4yoNpEKPMqfIGOAvwUXw9lJwbGhbxo/x2
         Sd5mjXv3c7cDCd2DPrjriMOI2be0Xcbr1A6qrB8+lgNQ0YHrD5Y8800H629sC1/5YQLl
         pjbjxutD6WQojyWnfAoFjQzLWfFUKenuBO+9sPTf6NXsIVGqQ91Jp5+9htdjA1quPa4E
         mPhuH4NgXZ4BFuekJ8dyX2byUIimMndhisDutCsus2AjNzcvJw5bqVZ4UX5awn+HjKM+
         5D0hiMTYuSLT5GfkQLU/ZVt5OeptBAs6tFIdJeRsGVrvp5pQIaUsCldd3QLeYD1ORLDK
         eeLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714623; x=1794319423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0mpQqPcx/wO2M/JeyOkuY7Hd6GV1/TOLmZZItrx8K9I=;
        b=re4roQiGcIOZUOxeSIUk13f6hFgq35N2BFn/TGdsSeJqrLYI9Z4m2veFBynY5CqJAZ
         zjHkmGHKXBI0giMk+YB11PczLQpOwakV4NnHnKwLIpk/VvtpzZRplMw5A+j0rPZo2M6K
         BiobOwVXJNUGgeyJhxYvRYVf8Rnpz0nYDP8z66R/UoKfL+QdA+eFKUW/WrGMQjfwrjhR
         utsU5IbH78qri9akiLmCdD0lcd2pSloJ5JvM5+PfnI7Hk9vzGDK/WrNOkvIbGzUVoSHB
         cOvIWCZ4RPp/wHS8o7W95EO7UgkTzMEG0uouNQni523u0Bh6eIXD/VfgC3+2oZUshjZh
         S8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714623; x=1794319423;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0mpQqPcx/wO2M/JeyOkuY7Hd6GV1/TOLmZZItrx8K9I=;
        b=xsA4wZ1nwce10yORtgvk/sdnt6Sru2j09m/tDK8LAV9oVRY0IF6n15NAixV3HWOmBf
         0/D0FmGC0MQK+qumFl9mfYZ6CVpu84r89uWkxvi56NbkHUuWIUchs80n2eIXyKMjbBkw
         c00kXmMlAqcl47SFK5LrQPVxE8ELQ1aIbksrRanbkQdMCyZrL6BE07Esz6DF7nFAYWHB
         AD7JCNe3ksvOa9ZTeZ9jM6NVUszQ5lXB+9XE9vAH78/JDv96Ot0KCyKgx0f7TKyU2bz/
         qmxOxt/DKFs7zLomSNpzn3jjf09owslOOQEl3X1Y9Qt8H4McSqZM9V0xXM6FeBTg6ZG6
         Jh5w==
X-Forwarded-Encrypted: i=1; AKwUvByTzB+ll1XiQdN3xhkbTZnGRwW5iKfAriIuccdG6FolL3VZRnjKJmJ52opbQQGKbbzIZoqe5HwFUaE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/X66INzyhsRY1Yq+L9IPKJysv8XpIFWOGiA0G+kBzg0kgTkG/L
	m38++K7N4cpsYBxfN4AWA83aZHQJg3rBOJf1ACVeHBPRBj76ioSG3b+opZOAadgN/UQs4l6iEuZ
	TQprPhCfxVEUlqvPP8cmrmSzR1BvEnpOT+DXc+oY=
X-Gm-Gg: AYBFou3mJhJPAHx4GtkH6cUzyOaFCXTgxXPalAxamtRwHl9YUN3nWpp+7bvsJD0qEGE
	tFbubBljPp6p0nRo7VQLEuVkVST0vQ8j2Td3ue441cWnvoTDZzSN5UhXd+1WZaVJqGm/dRWxyb0
	aSXzOmuXaW7GzwfGf0j2mD6tFAZY74OT8iPHLpgXE2VSHbsz81i8ixSd6ZzCtVH0WCq6IE1sAPq
	7eLiJXUzlzmPWsSLwCHshDmmxnOftoDnUVVwsORD2+R0G+vnLCr2ANKBXIpTztbXjSygV3Olt6H
	RulMqdeh9sZl1kaQ6GwTDQU1TmJbY0z63CQszKaVyQkXVOwSPpgWN+5Xpj9PE64JY3Gm8QL3l3q
	XDKZoMdbcRF6CH0KSPouMVHX81gSvc14nbJ9Ik1W/rooB+ZcCsdjxKj7BrwAoloS7modELqZhbJ
	X//d/nOXA/HTvQY2OaAV3UA4ICpy3hklwHBQ9oRQu209QkJhUvIUVp3Jxc
X-Received: by 2002:a05:600c:848c:b0:4a1:efd3:9862 with SMTP id
 5b1f17b1804b1-4ac1765d977mr282488195e9.21.1793714622717; Tue, 03 Nov 2026
 06:03:42 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102170911.3867389-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261102170911.3867389-1-Frank.Li@oss.nxp.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 3 Nov 2026 14:03:15 +0000
X-Gm-Features: AclHuK9lTBNUFEhnmVUe-0bw9b56qg4kVZy5zFZ6xKayAE9tcP58fndIr_XiG0M
Message-ID: <CA+V-a8t0bf_8hc1vd7c+OXBQfgBjp6EJjDALm8+myVYRNzy-Xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com
Cc: Eugen Hristev <ehristev@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>, 
	Felix Gu <ustc.gu@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, Piyush Patle <piyushpatle228@gmail.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore <cheick.traore-ext@st.com>, 
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, 
	Kees Cook <kees+treewide@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	"open list:MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER" <linux-iio@vger.kernel.org>, 
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RENESAS RZ/T2H / RZ/N2H A/D DRIVER" <linux-renesas-soc@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:55=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper.
>
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c                 | 3 +--
>  drivers/iio/adc/nxp-sar-adc.c                      | 3 +--
>  drivers/iio/adc/rzt2h_adc.c                        | 3 +--
For the T2H changes,

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

>  drivers/iio/adc/stm32-adc.c                        | 3 +--
>  drivers/iio/adc/stm32-dfsdm-adc.c                  | 3 +--
>  drivers/iio/adc/ti_am335x_adc.c                    | 3 +--
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 +--
>  7 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sa=
ma5d2_adc.c
> index 78081cbfde5e8..d479c9bc9b3e8 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1240,8 +1240,7 @@ static int at91_adc_dma_start(struct iio_dev *indio=
_dev)
>                 return -EBUSY;
>         }
>
> -       desc->callback =3D at91_dma_buffer_done;
> -       desc->callback_param =3D indio_dev;
> +       dmaengine_desc_set_callback(desc, at91_dma_buffer_done, NULL, ind=
io_dev);
>
>         cookie =3D dmaengine_submit(desc);
>         ret =3D dma_submit_error(cookie);
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.=
c
> index 2f716a2f97b80..82d8d921b0293 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -696,8 +696,7 @@ static int nxp_sar_adc_start_cyclic_dma(struct iio_de=
v *indio_dev)
>         if (!desc)
>                 return -EINVAL;
>
> -       desc->callback =3D nxp_sar_adc_dma_cb;
> -       desc->callback_param =3D indio_dev;
> +       dmaengine_desc_set_callback(desc, nxp_sar_adc_dma_cb, NULL, indio=
_dev);
>         info->cookie =3D dmaengine_submit(desc);
>         ret =3D dma_submit_error(info->cookie);
>         if (ret) {
> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> index 8ba7b0fde8a19..3e52b7d660dd3 100644
> --- a/drivers/iio/adc/rzt2h_adc.c
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -394,8 +394,7 @@ static int rzt2h_adc_start_dma(struct iio_dev *indio_=
dev)
>         if (!desc)
>                 return -EBUSY;
>
> -       desc->callback =3D rzt2h_adc_dma_callback;
> -       desc->callback_param =3D indio_dev;
> +       dmaengine_desc_set_callback(desc, rzt2h_adc_dma_callback, NULL, i=
ndio_dev);
>
>         cookie =3D dmaengine_submit(desc);
>         ret =3D dma_submit_error(cookie);
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 600f975f1d7b5..fa2a781e37777 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1901,8 +1901,7 @@ static int stm32_adc_dma_start(struct iio_dev *indi=
o_dev)
>         if (!desc)
>                 return -EBUSY;
>
> -       desc->callback =3D stm32_adc_dma_buffer_done;
> -       desc->callback_param =3D indio_dev;
> +       dmaengine_desc_set_callback(desc, stm32_adc_dma_buffer_done, NULL=
, indio_dev);
>
>         cookie =3D dmaengine_submit(desc);
>         ret =3D dma_submit_error(cookie);
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-df=
sdm-adc.c
> index 674767da3ac37..f0239f5f30afe 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1006,8 +1006,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev=
 *indio_dev)
>         if (!desc)
>                 return -EBUSY;
>
> -       desc->callback =3D stm32_dfsdm_dma_buffer_done;
> -       desc->callback_param =3D indio_dev;
> +       dmaengine_desc_set_callback(desc, stm32_dfsdm_dma_buffer_done, NU=
LL, indio_dev);
>
>         cookie =3D dmaengine_submit(desc);
>         ret =3D dma_submit_error(cookie);
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_=
adc.c
> index e53c839e87ef3..230f1c990317a 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -259,8 +259,7 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
>         if (!desc)
>                 return -EBUSY;
>
> -       desc->callback =3D tiadc_dma_rx_complete;
> -       desc->callback_param =3D indio_dev;
> +       dmaengine_desc_set_callback(desc, tiadc_dma_rx_complete, NULL, in=
dio_dev);
>
>         dma->cookie =3D dmaengine_submit(desc);
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers=
/iio/buffer/industrialio-buffer-dmaengine.c
> index b9f8b5b3aa6b6..7ecb9d875b8e8 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -160,8 +160,7 @@ static int iio_dmaengine_buffer_submit_block(struct i=
io_dma_buffer_queue *queue,
>                 return -ENOMEM;
>
>         if (!block->cyclic) {
> -               desc->callback_result =3D iio_dmaengine_buffer_block_done=
;
> -               desc->callback_param =3D block;
> +               dmaengine_desc_set_callback(desc, NULL, iio_dmaengine_buf=
fer_block_done, block);
>         }
>
>         cookie =3D dmaengine_submit(desc);
> --
> 2.43.0
>
>
