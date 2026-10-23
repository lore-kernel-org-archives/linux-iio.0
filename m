Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788349;
	b=d07M5bJF5lFO6jmgVyLQU5vpNcXHEIeJ2tTc0S3buY94VX9tbXAvlxb6WLD+8VfcFRuv
	 nPi4X9W+tZVycw6Y4ooB1MbbWAXZyMkWLP9K22uhLaacPKXfCleZJa7WwmBnI8Zku135m
	 Z0nK/74Jd/thUr8/UAUHPM0k+0xRpVfjPOzzuyyFBE4m0ZbbNsMGNTwFTmcWnPZDvCZYv
	 TcD5M88OJJYAQMZUAQWpFOrmv0YFw+KukeLdkmQJnMEskY7aN5+LnsFUzrQpPBsJ3CKJ3
	 NKSJzGpDiVhR/UNLtqyvofGRtItR2xlCj5MgBygA0nodRPTZ8aLUh+KKWGTX2cVZcHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788349;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ERMAe4gQ6i7Ta6EWqnTv8/4TwhPeAc1qJP5T9a65q9Y=;
	b=1uG5K/RJw5A6Ycy28rfvrocGhMrnevaZQow9581YVs/Nizj+me8BOlTbLeKCu1z/JNd8
	 F6kbaqKo0gaqibX9aAm2yX14j4GrdmTfMJeaaX2mxExi7bOMypnsCYqjEieioS9eNmm9I
	 q6oVPd9NcUGKqMs6mMgEG1c7qghugC0B7xou9zvBjrpxviAzcsCkxTb2tCR9U48r23uon
	 pYbCKAFJ6bv6nZgk8iGGLs2v5w2iNQmgOne5lXkeDa961ZtpuHwB9BBBnwlrCTfMDNoSX
	 oSuNRPSI0iDbygbm4HwAzvO90NoX40/voIT9oB290za7hyORyJZ2hvBmeaQVYvIySuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgdiRnMA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3718606A31E;
	Fri, 23 Oct 2026 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgdiRnMA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6C21F01825;
	Fri, 23 Oct 2026 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788348;
	bh=ERMAe4gQ6i7Ta6EWqnTv8/4TwhPeAc1qJP5T9a65q9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dgdiRnMA1IBRaZV7sbt0GCyCMQHFVcSb55t+wf3P6474xAb5UjqA8aB5U3V9jSSjf
	 3TMwdyDt5g3d3XRibjlNWvWYD6YSwWY30x1e8YcAdCE9RER542GE6n+kOD0dXX9Q/f
	 Z2S7Lqy4GxKEajNUyI/3Z6VCxzgZZFOgxlOh6u19zmbPppwsQOQ0XVZabYcPPTSqKp
	 0xln+pIlXJDnW6j3DCRLAO5GSwnVvCorrPFPS91Ql9sN4Vh5paXMrXgj8Pfhc8KN6D
	 yw1igtIAOyKKzGSCl2kO4odfMeSudTXueZ8Vfm/Q1DhN0Frpr/zFv02nEb06pEUmfq
	 SGIeHyZCUPoFQ==
Date: Fri, 23 Oct 2026 21:45:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Andy
 Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 6/8] iio: adc: rzt2h: Prepare for SoCs with different
 ADC info
Message-ID: <20261023214542.49c6304f@jic23-hlaptop>
In-Reply-To: <20261023175919.160103-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
	<20261023175919.160103-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 18:59:17 +0100
Prabhakar <prabhakar.csengg@gmail.com> wrote:

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Prepare the driver for RZ/V2H(P) support, where the ADC supports 8-bit and
> 12-bit conversion modes with channel configurations that differ from
> RZ/T2H.
> 
> Allow each SoC to provide its own IIO info structure and use the
> chip-specific configuration when registering the IIO device.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

FWIW as I'm not going to ask you to respin for this...
I think this should just have been squashed with patch 3 where
*_chip_info was originally introduced.

> ---
> v2->v3:
> - No change
> 
> v1->v2:
> - No change
> ---
>  drivers/iio/adc/rzt2h_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> index 94dad479abff..dbe82939acc2 100644
> --- a/drivers/iio/adc/rzt2h_adc.c
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -68,6 +68,7 @@ struct rzt2h_adc;
>  struct rzt2h_adc_chip_info {
>  	const struct iio_chan_spec *chan_template;
>  	int (*sst_to_freq)(struct rzt2h_adc *adc, u8 sst);
> +	const struct iio_info *info;
>  	unsigned int num_channels;
>  	u8 features;
>  };
> @@ -763,7 +764,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	indio_dev->name = "rzt2h-adc";
> -	indio_dev->info = &rzt2h_adc_iio_info;
> +	indio_dev->info = chip_info->info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adc->channels;
>  	indio_dev->num_channels = adc->num_channels;
> @@ -778,6 +779,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
>  static const struct rzt2h_adc_chip_info rzt2h_adc_info = {
>  	.chan_template = &rzt2h_adc_chan_template,
>  	.sst_to_freq = rzt2h_adc_sst_to_freq,
> +	.info = &rzt2h_adc_iio_info,
>  	.num_channels = 16,
>  	.features = RZT2H_ADC_FEATURE_CALIBRATION | RZT2H_ADC_FEATURE_SAMPLE_STATE,
>  };

