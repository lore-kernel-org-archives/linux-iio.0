Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0ED3859D4;
	Mon,  2 Mar 2026 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481276; cv=none; b=VTX4yNgb+u2hw1Vc2KS/HZdOSr2v9vV9ewHPsDpYkWwtoGIdX/N1d5TFknAmpVw4UUnYsAFQtBE340SyYylQQR9n//ZkepwXoLwviatk4fgrnz6SnceARJ0u1/mMW1Hbs5j/2QHxOD5d8m1t8SgPqTBNvtSBc1z3AWsDXcXmUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481276; c=relaxed/simple;
	bh=o3Pzei2aF0EJ9fT9Mp5rv3Ea9aHW1pFpR2gAyggCdVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WckAWZSO7V+CAmok4f+/hZKTaXUmuJgmvQDqE5vvPwaljCmKdwzz6XPn966xPfjPuE40Ts/T4RhKKHHAO8BhOrcReFCkwvMMEClDPo6s1ywY4o1gcrKU564lTzMwbct5hq8Fo5TmJ0L2hwUX/3jnEZ2ImemZbO4j1gE1edEp+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gam52E2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gam52E2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01EAC19423;
	Mon,  2 Mar 2026 19:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772481275;
	bh=o3Pzei2aF0EJ9fT9Mp5rv3Ea9aHW1pFpR2gAyggCdVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gam52E2+Gk0I6PMNUVwuhsyXt/hvgpzXhhlNNFhGYB7bJ6uZMW3ABlvDlKlWj7ZQY
	 N70VyXQ2S545itOTTFIH/GClUcnaI+c+2XdaHX8O2fMrtJ51ktFUVwgukYZ1+HjLHp
	 lK6ylBFOKrdHtWX1Qyc1NvGLoNE6PnAvV2mXdkMnLbOb4rZE6lnBb/tps6tsmhM6CM
	 piM+aEMqPLdLvACrASQoirIHm+BqAQp0yed6qe+38rk/fjV8hHumoIOHh2veSluPD8
	 8dnZNylNKgxs5TlJ7GbGd4EbpIP4dzwZbLTaYv9KMqhMo2VHNDDn9/QJBooS5hjqS1
	 voLPq4GYpyAvg==
Date: Mon, 2 Mar 2026 19:54:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Reinit completion before
 wait_for_completion_timeout()
Message-ID: <20260302195426.11b4ce81@jic23-huawei>
In-Reply-To: <20260303-ti-ads1119-1-v1-1-e3fced089a44@gmail.com>
References: <20260303-ti-ads1119-1-v1-1-e3fced089a44@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Mar 2026 00:48:45 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> The completion is not reinit before wait_for_completion_timeout(),
> so wait_for_completion_timeout() will return immediately after
> the first successful completion.
> 
> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
I agree there is a bug here but a question inline.
> ---
>  drivers/iio/adc/ti-ads1119.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> index c9cedc59cdcd..75dbb469fa27 100644
> --- a/drivers/iio/adc/ti-ads1119.c
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -276,6 +276,9 @@ static int ads1119_single_conversion(struct ads1119_state *st,
>  	if (ret)
>  		goto pdown;
>  
> +	if (st->client->irq)
> +		reinit_completion(&st->completion);
> +
What's the reason for doing here rather than a few lines later.
That is before this
ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
which the  naming suggests kicks of the actual channel capture?

Jonathan

>  	ret = ads1119_configure_channel(st, mux, gain, datarate);
>  	if (ret)
>  		goto pdown;
> 
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260303-ti-ads1119-1-cc68e3c01783
> 
> Best regards,

