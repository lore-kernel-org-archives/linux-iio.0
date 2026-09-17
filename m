Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E125B087;
	Thu, 17 Sep 2026 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605320; cv=none; b=j2JCqoe3v/j+3Jl+vF8UNc3rC+XqR2vLmy/tQbr0mfoLTm67Nf8pK3JSezRQXa5aljkgk49OAdti3tolmULG3IvXzmZrYHyYOXsXRlZPAVXu4mmb/4FK33rIGhFNHsjWuLayeEDyGFN91Yi3lbzdsu9Hl9satliXzoeOR+bv4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605320; c=relaxed/simple;
	bh=UB08fcCscQl2yGoG9aNvnY7amcDSnj7N8A4ec2metOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjGfto2TAhGU0Fe/ftLBTdAuwt8Mg8h6ml5oUAPApMSURl5ne7ckhuJbaicyaSGplCTVnOIPbzPWc3o4NeW/8lolBWWkb4FopxG8Ry3UBTrAb+0wMIVoZFyK9biIG2hbvmXzZnXsDninWOKe28mxISMyh+6SW1QrJREO2l/k7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfyYXDTE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfyYXDTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C096A1F000FF;
	Thu, 17 Sep 2026 00:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605319;
	bh=lBfkcSAIIaxLc8Maiw+8mR9NCNqCii9fgVYM79lwnds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IfyYXDTE65zklI5HupVeOM88B+3vMTcImlJ2gs6dbnvI/ged1fCXkiMUWKKWM50jJ
	 /cacGGZfFxvpyOTzFThiZvRQFGN9i/MVjB2eCTtG0LknKTAilmpQxNRNjbQKjM0XTB
	 iI9jgM71bNCdjBM9Z/rCmwS3WGFdKtISLbC+7XHH5l6ExqzPAplAwedzlwRhKF6R0S
	 T8p5yQKNYZbHJMsWMO2YXRI1nEJIs6gQwhWbPM1ODCdFIy1C8NypZ3KlrkddTOlCRw
	 VywAx0tRmFSXMJV8AJ2YmTr4ojnss51A0VL/IYtKLHMf5w0VIfRduxLhoWVYK4UDRk
	 zNNhwG8P1/yuA==
Date: Thu, 17 Sep 2026 01:35:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jianping.Shen@de.bosch.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH] iio: imu: smi330: Fix trigger reference leak in
 smi330_core_probe()
Message-ID: <20260917013513.568ec343@jic23-hlaptop>
In-Reply-To: <20260916163250.2083963-1-vulab@iscas.ac.cn>
References: <20260916163250.2083963-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:32:50 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
> devm_iio_triggered_buffer_setup() fails before setting that mode, the
> reference acquired for indio_dev->trig leaks. Move the
> iio_trigger_get() after the buffer setup succeeds.
> 
> Fixes: 6f3d8de8886d ("iio: imu: smi330: Add driver")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Same again.  Not going to introduce subtle ordering fixes like this.
We need a comprehensive solution with appropriate changes in the
IIO core to handle cleaning that reference up. See bma220 for
more on this.

> ---
>  drivers/iio/imu/smi330/smi330_core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
> index 7ec5ae7f521a..6bd735c6b61a 100644
> --- a/drivers/iio/imu/smi330/smi330_core.c
> +++ b/drivers/iio/imu/smi330/smi330_core.c
> @@ -886,9 +886,6 @@ int smi330_core_probe(struct device *dev, struct regmap *regmap)
>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  					     "IIO register trigger failed\n");
> -
> -		/* Set default operation mode to data ready. */
> -		indio_dev->trig = iio_trigger_get(data->trig);
>  	}
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> @@ -897,6 +894,11 @@ int smi330_core_probe(struct device *dev, struct regmap *regmap)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "IIO buffer setup failed\n");
>  
> +	if (data->trig) {
> +		/* Set default operation mode to data ready. */
> +		indio_dev->trig = iio_trigger_get(data->trig);
> +	}
> +
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Register IIO device failed\n");

