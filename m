Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99B2D238F;
	Wed,  3 Jun 2026 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505096; cv=none; b=JIndtXPWPmtnrr0TGKF2gzdec+csiWTMhAeWabN4kAi37OyKnTBDqNL2pSDbd1C8EnZOFynTcE0NMnYCGpHwru5ZqTCVNVWYq17e8rvqtWWxLmV8R2UVGMouicxpOwxcx3yXQ/KobGUySD9l5njE6kiG7nVVC9cK2R9ppUSiVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505096; c=relaxed/simple;
	bh=BUlxBkgm8FOKrOXmEjSD3+2aRV7KZxjXCTyS6MxYcsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrRSVxGveyTTdN6sGMCHY7YPoh7clnHUAAiWMZFHSN0OqheUzq8LvzGVF+qxxxwUv4PQcpJeu6JbCc866/0KZUvrkc/Wi1SbyhmqM0oXZCs5QiTaLN2MpfBAcgQNnMfHPZ+lXim3A77Oy+H2CTtghi5z8UTom0A5oB86LtAYghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kweUpJvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kweUpJvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC7F1F00898;
	Wed,  3 Jun 2026 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780505095;
	bh=i0uRfTsqw/6A4i3J5Kn/83igv+/jfV+x9vnrazFBOx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kweUpJvZxSEd41k/2wp8OIVGV4hDN6OSwU6YOHP/nadKF+79kZzdLNeqDGoMI4JO/
	 e0jDVgYJvRpfoCgA6ZeRqFDia6gfvjCjKykh0arLOQvoXCOEUhBvQGIA4hbUoKz3Sc
	 /9tOnpeOceBvMjymfFC97FomkYWZa/tUB7Ih+q/dsr582KR1rj9kO1C1dP6bJh9Amf
	 lmBRrrh+x+U1IjRhTHkGro41mOeeQs8sFl/P5MQbf7cExnbrl/dDjzXkRA3sjfRS7Q
	 TtQlrsgIyYur1CLNm3VbFlwfYh+XFFAOa5z4R9g/Zw5vedfaqIkOUm3OqYpYxosUCy
	 PFlCEllKMcrLw==
Date: Wed, 3 Jun 2026 17:44:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Tomasz Duszynski
 <tomasz.duszynski@octakon.com>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
Message-ID: <20260603174447.63a181d5@jic23-huawei>
In-Reply-To: <20260603145134.58956-1-m32285159@gmail.com>
References: <20260603145134.58956-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 09:51:33 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> The current code uses mutex_init() instead of devm_mutex_init(), which
> is incorrect as the rest of the file uses the devm automatic resource
> management API. Fix this so that the mutex is set up in the same way as
> the rest of the device data structure.
> 
> Fixes: 64b3d8b1b0f5c ("iio: chemical: scd30: add core driver")
Hi Maxwell,

No to this being a fix.  This enhances one corner case of debug, slightly.
So to me it isn't worth a fixes tag.

> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/chemical/scd30_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index db5cc295aeab..f00979c0c196 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -714,7 +714,10 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
>  	state->pressure_comp = SCD30_PRESSURE_COMP_DEFAULT;
>  	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
>  	state->command = command;
> -	mutex_init(&state->lock);
> +	ret = devm_mutex_init(dev, &state->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init mutex\n");
The only thing it can return is -ENOMEM I think. Which doesn't print anything
so 
	if (ret)
		return ret;

is enough.

> +
>  	init_completion(&state->meas_ready);
>  
>  	dev_set_drvdata(dev, indio_dev);

