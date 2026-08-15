Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76C8632B;
	Sat, 15 Aug 2026 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786827927; cv=none; b=d2l3aoTtiM0gshFV77JlgaQr8frWydoZNwEvR28tjvSqkH7Y8AfRhD52lo6PfE98RwMYhQmrHAFbvFnPEgI3i7zhBmHHp03SZgNJeZHAj1TSsK3zrYLH4sNekW3mz4q+s37oSFYHk2TuAlGowg7r51Qvx7+bsh5T2vcPXf/ty88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786827927; c=relaxed/simple;
	bh=9OyS1sMj/HsQr9iWADei6vP86xfmr5bWYLZwulZeYTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNNhIRSxLEIbjbJzlEtzJLAd8CCaDvXv2DCIMIo7ZbQbzv0E/B8rak9CPXEgZ+Hhxe98FYs4mHXqTPpos7Btxe23DDimCgbk+42C1I//T7FuwVEbIxtERZTbQd+ByiY+9ASqFtVMFiwifZOdl0Au32zJUy9SGXhoChkTstXAzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhkOdR8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhkOdR8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCE31F000E9;
	Sat, 15 Aug 2026 21:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786827926;
	bh=/dXCcJ9v78alRZI5QksmTm4e7wzn1hZbUcSySwvI8zM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nhkOdR8t28mjFd0Fn49ueP490b0kEHhcQqMLGOC52TgMpoEK61su0frKoaCTfWciI
	 /RaIQJwhTO4TP8rssWTdsjJr0fyDiEVthjLAZ44ySGrukH2yMl+D2BYnAHZYqR4KWx
	 xV+BFShowbgRMI6WlmDx0QUnajjhcAJpjcwYsUEp9sOXoyi0wywg4+UqHCuu/RMr8u
	 eQTLfusOeZxRvTk5S6p/k2rCtESB83t3IDXOt185XSg7spJjgwlbM2RqMirxurCoQK
	 WCCnwnvO0Sq6Wpz4kG3qnSv23z6zpzq/++2JErYSApHMGnXmNDzFybWwhKmfvIxuOS
	 qn7tQvGwkcHcA==
Date: Sat, 15 Aug 2026 22:05:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Wadim Mueller <wafgo01@gmail.com>, Maxwell Doose <maxwell@maxwelld.cc>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
Message-ID: <20260815220523.0769e222@jic23-huawei>
In-Reply-To: <20260805110255.504576-1-lilinmao@kylinos.cn>
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 19:02:55 +0800
Linmao Li <lilinmao@kylinos.cn> wrote:

> slf3s_suspend() stops continuous measurement before disabling VDD. If
> regulator_disable() fails while the supply remains enabled, the system
> sleep transition is aborted. Since the PM core does not call the
> corresponding resume callback for a device whose suspend callback failed,
> the sensor remains idle after the system returns to the running state and
> subsequent reads fail.
> 
> Attempt to restart continuous measurement on this error path. Preserve the
> regulator error and warn if restarting the measurement also fails.
> 
> Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/iio/flow/slf3s.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
> index dfa7c14090454..75ee82fbd3295 100644
> --- a/drivers/iio/flow/slf3s.c
> +++ b/drivers/iio/flow/slf3s.c
> @@ -462,6 +462,7 @@ static int slf3s_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct slf3s_data *sf = iio_priv(indio_dev);
> +	int restart_ret;
>  	int ret;
>  
>  	guard(mutex)(&sf->lock);
> @@ -470,7 +471,16 @@ static int slf3s_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	return regulator_disable(sf->vdd);
> +	ret = regulator_disable(sf->vdd);
Similar to previous thread I replied to, I'm not convinced spending much
effort to recover from this sort of condition is useful.
If we have a regulator that doesn't respond reliably to instruction chances
are we very unlikely to recover, and adding the recovery logic complicates
the driver somewhat.

I we do decide this is worth doing then not this style.  Keep the error handling
as the out of line path
	if (ret) {
		int restart_ret;

		restart_ret = ....

Makes it easier to spot that it is an error path.

> +	if (!ret)
> +		return 0;
> +
> +	restart_ret = slf3s_start_meas(sf, sf->medium);
> +	if (restart_ret)
> +		dev_warn(dev, "failed to restart measurement after suspend failure: %d\n",
> +			 restart_ret);
> +
> +	return ret;
>  }
>  
>  static int slf3s_resume(struct device *dev)
> 
> base-commit: 0efaefce4e95a3331550329c0078b2fb38b3ff1f

