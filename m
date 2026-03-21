Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784D2D061C;
	Sat, 21 Mar 2026 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121365; cv=none; b=l+A7XWyrU3VF8AIygOeZNnDf/csNE58icekqYc24tS29MpFj300JJflEDrBYdbWaEXDhkMfP3urFDJSTM2PPEAmsEFXwNs3duQjuFchB5XT23+Zfw+gMARcn0Ad3wgintpaQBvuwslwkbjYTISnTq1ioqs+eZahJOTO7A3BC0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121365; c=relaxed/simple;
	bh=vE26k/UstL5d0/JH6FfxiLuU7+sp2O9UVegCwusstoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBiDIXQeFp503JBJ2R1QjoO96MoKNxwfdF83Sef4CDKXtctt2sFO/HH1bJt0zxIuK9s0L1Tg/lDQk8uYrfk1ZIjMpokR+e3pf46996h+Xzb6P3BbgkYU124LYhdscoHreOLBB3hfiapuEX/kCKyvVrylXIUk/dkbrDiYmmXy/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYRiWmmc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYRiWmmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E155C19421;
	Sat, 21 Mar 2026 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774121365;
	bh=vE26k/UstL5d0/JH6FfxiLuU7+sp2O9UVegCwusstoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dYRiWmmcxLLLs8Y2aoAafBZBBDOpKR7j7+tSCkZrSMBRT9YGNYEYON9xSdgxpeZNy
	 KaOoMnbbOxF80fKW/6lL8QKvgcF5absQAelrPtlMkUAOFkq8LCZqZlMhlhQJZ7+40I
	 KTfmJlLq5WYd0Ay4y03gFNymTJbZfCSJ3qCQAY5n/25M7WUZDTJdCoyIj66isIRynD
	 qPHKez6iuGmw8Bcw63u0zbEoVvJa/OjoWVBFY6RovkW77RlycF/Bkwr8Kw1Fa2G9Z2
	 uLVuEkhZuDbv7k4Mzq6GsccjSCPVXF43dVkSkali2pY0NYsJVxPDgVXLYqhFuzlb+7
	 TsZKZeLYx4gpQ==
Date: Sat, 21 Mar 2026 19:29:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 12/14] iio: chemical: rephrase comment and fix a typo
Message-ID: <20260321192917.22cb4f19@jic23-huawei>
In-Reply-To: <20260316090023.14691-13-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-13-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:20 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Rephrase the comment and fix a spelling mistake.
> 
> - insuffient -> insufficient
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Applied.
> ---
>  drivers/iio/chemical/bme680_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 24e0b59e2fdf..6aeac132394c 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -807,7 +807,7 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
> 	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
> 
> 	/*
> -	 * occurs if either the gas heating duration was insuffient
> +	 * This may occur if either the gas heating duration was insufficient
> 	 * to reach the target heater temperature or the target
> 	 * heater temperature was too high for the heater sink to
> 	 * reach.
> --
> 2.53.0

