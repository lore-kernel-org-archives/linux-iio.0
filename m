Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CCB315D53;
	Thu, 17 Sep 2026 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605631; cv=none; b=qNONQXWjcqmOn4z0VEO2FzWJrcI3Q0jLHqXzYIfNyQl5MAOiPSwzaP+XQUriyFZ6P+hJXsRyhstLl4FaDNGG1uAILn4sEv2rQmoB0Cr42uwuKQyY+/Tt5ha416PK0UnSe+KXQiFhXnuN+2IOz+9GC3pMBjS3QJb/VX/XGQRkb64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605631; c=relaxed/simple;
	bh=vU2QzVgiQj1VdWTGZn61iwgkgT1piR6P5X0m+S7uxD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPMpahaawBLcxZZ1hVaAEBcV2f+hmVTWZyso2UMFxtu++4nleGa4KD3flitB6p0ppQNRiNrOTTZNYg3XjJI9p7TyIXjafW6l4DA7Rzh2BOu0Knsx8MwdCPGtj/dej51JE4ptvhLLyi2ONUxcYIh9j+SMJ2slIiQOh0eBb07T8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrKdxZnM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrKdxZnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920271F000FF;
	Thu, 17 Sep 2026 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605629;
	bh=TngripDjIv509ba9jJdzbHOoNLvRQcTJFhKWxkvF5qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LrKdxZnMF5BPyyOlKkmVDOQ+Znw+To6XUgW162u1b8dHql8VL8MlEOg1mXi6AkiSW
	 OrNZB5QG8hj+jjzr3KdmFrWw7a/JbHuYvbba74SoJVqURGIZc4VY2uvZfQc9stguTL
	 6Jij5EaIrOFmgsxZ0AHd+CRsl2ZnQPLE+Ungkn658Vk+aNSt8YWy3aAkIEuYAOXjDz
	 uNZX54ZNE8Qwh4zj4WdE6wczSEPOD7lEOCTeaXMw1ckF2ZGmS4UKhkIxtAVAT+6z33
	 L5vZ4VgZ/DKHfDSdt5VRRFNj9EoFcmhuB1THaTwsvoUMa9Yt+U1zyZo/Cb+mBOI6ZS
	 l90wL609hcpTg==
Date: Thu, 17 Sep 2026 01:40:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, email@sirat.me,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH] iio: proximity: vl53l1x: Fix trigger reference leak in
 vl53l1x_probe()
Message-ID: <20260917014027.757b0677@jic23-hlaptop>
In-Reply-To: <20260916164255.2084644-1-vulab@iscas.ac.cn>
References: <20260916164255.2084644-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:42:55 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
> vl53l1x_configure_irq() or of triggered buffer setup returns before
> that mode is set and leaks the reference acquired for
> indio_dev->trig. Move the iio_trigger_get() after those setup steps
> succeed.
> 
> Fixes: 128e5ebec856 ("iio: proximity: add driver for ST VL53L1X ToF sensor")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Not this way given the subtle ordering constraint it is relying on.

See other threads on same topic.


> ---
>  drivers/iio/proximity/vl53l1x-i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
> index 4d9cb3983dba..f1b8ff7fac09 100644
> --- a/drivers/iio/proximity/vl53l1x-i2c.c
> +++ b/drivers/iio/proximity/vl53l1x-i2c.c
> @@ -713,8 +713,6 @@ static int vl53l1x_probe(struct i2c_client *client)
>  		if (ret)
>  			return ret;
>  
> -		indio_dev->trig = iio_trigger_get(trig);
> -
>  		ret = vl53l1x_configure_irq(dev, client->irq, indio_dev);
>  		if (ret)
>  			return ret;
> @@ -724,6 +722,8 @@ static int vl53l1x_probe(struct i2c_client *client)
>  						      NULL);
>  		if (ret)
>  			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(trig);
>  	}
>  
>  	return devm_iio_device_register(dev, indio_dev);

