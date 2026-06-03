Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE43AC0F3
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486911; cv=none; b=ATcBVF3EdS7J7YIAanSLni87WymJloNvzcawe0aFuelZwv7+euEBblEMCXT+G6auJEsQTj74EW1D9vcUBDUyfWiRHg47+mjONOvxKyt5WhxCXgRja+b4PG1danaTHXMK1ArLWqV1/o2NLKmVnvbEzB1wUSuvATOihEnjzuQk5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486911; c=relaxed/simple;
	bh=bz4mhm+ddMGKtcsAAfF8NjHNF1+ylpMx5fsavtBVt4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxPZVH0UrDDloIk35L2aX/gNztDxJcRbKnu/dT7WImzokzX4vrezXKnIW0xLjpX25VPq84IfHfa5wqjXyAJh1hvvDtw/dGOxxTzKNalO5X7IeRdk0F/cQQ9Xhu4A0bAytpH2ElwwDCKDw9HVyXYA8l/wXF5Wyodx0etIVSvQqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFq1eipt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFq1eipt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858501F00893;
	Wed,  3 Jun 2026 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486910;
	bh=o9hED3MRY49eYKT199nx19Uo5Ljd3x1xA9PgUk+g+MU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UFq1eiptX+bg9hzoryqzWzT9HRxCybT80CB3TUN0FB3SWLtthekVs3RHMdMlwmdK9
	 iVqKRpZReJ2/Y/7q0dg5qb1D/zcKxPsa4qr+MX0ViHFdB7uF5xV7XhLOaDKtKjTxyL
	 I5dumFnf+FmgmHL7kDfgqhzrcmFXVNXpwJ0ZB/Swix+tWN94AO7dFAdjhDi2kMisp2
	 IYFj8XW43t6gPRHimMJNw/MP2QQq+vVormc6Uu3jIv68Uh/G8VMCSofoq9zrZlqb2Q
	 23iylSPUAuAc740gsy3XvmMtXO2MQqrvWDqS2xaBePDf5hkS2rhvFYzg7p/1aupzc8
	 4AeG7zyy/ppVA==
Date: Wed, 3 Jun 2026 12:41:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lucas Rabaquim <lucas.rabaquim@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Matheus
 Silveira <matheus.feitosa@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2591: remove unneeded
 tsl2591_compatible_als_persist_cycle()
Message-ID: <20260603124144.1b16554e@jic23-huawei>
In-Reply-To: <20260602181211.48399-1-lucas.rabaquim@usp.br>
References: <20260602181211.48399-1-lucas.rabaquim@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 15:11:49 -0300
Lucas Rabaquim <lucas.rabaquim@usp.br> wrote:

> From: Lucas Rabaquim <lucas.rabaquim@usp.br>
> 
> The function was only used to verify if als_persist is a
> TSL2591_PRST_ALS_INT_CYCLE_* value. However, before its call in
> tsl2591_write_event_value(), the line
> als_persist = tsl2591_persist_lit_to_cycle(period) is executed,
> meaning that by the time tsl2591_compatible_als_persist_cycle()
> is reached, als_persist is a TSL2591_PRST_ALS_INT_CYCLE_* value,
> making the verification pointless.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
I switched the credit to Sashiko given I was just passing on the
report.

Applied to the testing branch of iio.git

Thanks

Jonathan

> Signed-off-by: Lucas Rabaquim <lucas.rabaquim@usp.br>
> Co-developed-by: Matheus Silveira <matheus.feitosa@usp.br>
> Signed-off-by: Matheus Silveira <matheus.feitosa@usp.br>
> ---
>  drivers/iio/light/tsl2591.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> index 3ec823865ce2..39cb68abbbea 100644
> --- a/drivers/iio/light/tsl2591.c
> +++ b/drivers/iio/light/tsl2591.c
> @@ -309,31 +309,6 @@ static int tsl2591_compatible_gain(struct tsl2591_chip *chip, const u8 als_gain)
>  	}
>  }
>  
> -static int tsl2591_compatible_als_persist_cycle(struct tsl2591_chip *chip,
> -						const u32 als_persist)
> -{
> -	switch (als_persist) {
> -	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
> -	case TSL2591_PRST_ALS_INT_CYCLE_2:
> -	case TSL2591_PRST_ALS_INT_CYCLE_3:
> -	case TSL2591_PRST_ALS_INT_CYCLE_5:
> -	case TSL2591_PRST_ALS_INT_CYCLE_10:
> -	case TSL2591_PRST_ALS_INT_CYCLE_15:
> -	case TSL2591_PRST_ALS_INT_CYCLE_20:
> -	case TSL2591_PRST_ALS_INT_CYCLE_25:
> -	case TSL2591_PRST_ALS_INT_CYCLE_30:
> -	case TSL2591_PRST_ALS_INT_CYCLE_35:
> -	case TSL2591_PRST_ALS_INT_CYCLE_40:
> -	case TSL2591_PRST_ALS_INT_CYCLE_45:
> -	case TSL2591_PRST_ALS_INT_CYCLE_50:
> -	case TSL2591_PRST_ALS_INT_CYCLE_55:
> -	case TSL2591_PRST_ALS_INT_CYCLE_60:
> -		return 0;
> -	default:
> -		return -EINVAL;
> -	}
> -}
> -
>  static int tsl2591_check_als_valid(struct i2c_client *client)
>  {
>  	int ret;
> @@ -915,10 +890,6 @@ static int tsl2591_write_event_value(struct iio_dev *indio_dev,
>  			goto err_unlock;
>  		}
>  
> -		ret = tsl2591_compatible_als_persist_cycle(chip, als_persist);
> -		if (ret < 0)
> -			goto err_unlock;
> -
>  		ret = tsl2591_set_als_persist_cycle(chip, als_persist);
>  		if (ret < 0)
>  			goto err_unlock;

