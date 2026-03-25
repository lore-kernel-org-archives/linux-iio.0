Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234437267C
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470566; cv=none; b=NQikgGe6r9iuPVaZblvj9AeSyXzbLMwdnmDf6Rrc6WFfTE+uyX4oNa8ggUrIABGHNYD6gVzK3SvDH+itTxdY14PPSlGWMLYn93/FzVPIEIarvIb8BnmitR0OtifABigULYW0nHCThSaoFHx/uSST7bYLsp9zeNQnnIMGG9pZ0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470566; c=relaxed/simple;
	bh=GlbfqHUGip8crU/Efod9hMBVxE+29ayiIj0mXFp2wxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqKARkbvqcaAdgHIg1emP5H4wpZr8VY/N8tD6cPFj8XbN91hEC4zzp5gKl0atzKW1w23b3ayYIlKYrZtymnU1b/fITjGqWOM38iybRPk0NxWH+QZ3Kw44n2OqGdA3vD3z5sHWQvpVp3fu0v2quoxyJ9r5Hw1t8efggb7U4uq0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUygCYUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUygCYUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B01C19423;
	Wed, 25 Mar 2026 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774470566;
	bh=GlbfqHUGip8crU/Efod9hMBVxE+29ayiIj0mXFp2wxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VUygCYUnxb/7k2/RSjjcOl9ofb8AqMa9jyn75wu9qMa21/UqlPrRBEH6mQRfyNaNW
	 SpdoWsSQmyM/eUIW41RBrjAHxMx8nD4GC74sCd5W/0cqCClK4eruToH0WTniTmlRP1
	 iImuLFzINXr6AvFNn5QXeQXSEUKIfgUQM6ZXBYKNowGwQ4dj7ZrG97zNi/jpWKD7r9
	 RSnnyeCsmJalZMI1GANY6vDSN2nRjMH46yj0GhfcUkpjAFdhPGGLWHUt7dCf+4Kirm
	 rTa3UEVdfg9q/z9h4s6gwrhhQQf4Q2bcPG2BiTeYMwL8Br3SjjbDXithZoSsRyzhS9
	 TlvOLFpxOoOIQ==
Date: Wed, 25 Mar 2026 20:29:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max11410: make vref register name arrays
 static const
Message-ID: <20260325202919.20741805@jic23-huawei>
In-Reply-To: <20260323064640.32497-2-giorgitchankvetadze1997@gmail.com>
References: <20260323064640.32497-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 10:46:41 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> The vrefp_regs and vrefn_regs arrays are constant lookup tables and
> are not modified.
> 
> Make them static const so they are not reinitialized on each probe
> call and are placed in read-only memory. Mark the pointer array as
> const as well to prevent unintended modification.
> 
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
I don't feel that strongly about this one but sure it might help.
Applied.
> ---
>  drivers/iio/adc/max11410.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> index 511b2f14dfaf..69351f4f10bb 100644
> --- a/drivers/iio/adc/max11410.c
> +++ b/drivers/iio/adc/max11410.c
> @@ -912,8 +912,8 @@ static int max11410_self_calibrate(struct max11410_state *st)
>  
>  static int max11410_probe(struct spi_device *spi)
>  {
> -	const char *vrefp_regs[] = { "vref0p", "vref1p", "vref2p" };
> -	const char *vrefn_regs[] = { "vref0n", "vref1n", "vref2n" };
> +	static const char * const vrefp_regs[] = { "vref0p", "vref1p", "vref2p" };
> +	static const char * const vrefn_regs[] = { "vref0n", "vref1n", "vref2n" };
>  	struct device *dev = &spi->dev;
>  	struct max11410_state *st;
>  	struct iio_dev *indio_dev;

