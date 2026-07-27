Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431912F3C13;
	Mon, 27 Jul 2026 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116048; cv=none; b=CAetbJfQGbzM+89BpZBxOAqK/fBitR9yrwFLQa5S31fpw/R9OhJvXsfNO9GHaFQgfxPLgI8fC8/NVufHy2e115+CGVf8B4ge7gls72x9rHS6dftAbvQrRdimjGosqz889puchxE/reKngxXhgvvsoical7j57LU0AasZmlhOWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116048; c=relaxed/simple;
	bh=PvyI2q3PgBTqZ/De8FTvXtTi2HHpZ2f1byPFkp2CUPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqA7J4Gu8HEJhVg9UGEnYSU7i/SeUpCantwkEYyD+50AAR2VsGttQ5RfDWRU3eQOyVNUAx8Y4Z3tYUnx5M9eqY8721x2v5aLvlJN++s3HIiLzkrgYlbYECoS+chm0N7eEtki1XONsR0RUFZlTGxhZlXivZamwNo1bKETsefyEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz5PODy2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz5PODy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34071F00A3A;
	Mon, 27 Jul 2026 01:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785116047;
	bh=O6J6PEAv12iD7ZVbJVVRwFC4pDFYJxH3KSj4c5R/l5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sz5PODy2+myVO5fPhO1fbVF3n0LfCZfPWZlb6GV6LHsn7ImF6zxL7IJExoK3oSHok
	 R9iNkRjRtC8WdIo/U4ngeMFt0QKGQaWXhtVhn7r6GWmtezwo1AV6tKID1CETo4jAgf
	 HeHJ2rvkiPxbxFVYe3l/vrQ7wyC0OUYZMQZJf546q1RwTU9WTJnIDYen9kflE4AIfe
	 82qcbwnUg6JcHuulDv3hKLbgRHsBS1hMKYHkMmUcHmsQnRiziiK+uSU2sAeDUV6bD1
	 yU5zgkmymVBhhQiX1fYRABbeZ2UgATVmJsVn2+6NlLkukrZBrqvhFS8rxm4X5qycBi
	 ytdjtsIkJlcOQ==
Date: Mon, 27 Jul 2026 02:34:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-ads112c14: add DRDY interrupt support
Message-ID: <20260727023403.3b733be7@jic23-huawei>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-1-9eb0b7a4f020@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com>
	<20260724-iio-adc-ti-ads112c14-continuous-mode-v1-1-9eb0b7a4f020@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 15:13:10 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add handling for the DRDY interrupt to wait for data ready events rather
> than polling (only when it is wired up).
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

I'm not sure the comment that I've made will still be true by end
of the various series you've posted but for now the complex
code flow would be simplified by duplicating a couple of lines
and having two helper functions to pick between dependent on whether
we have the drdy interrupt or not.

> ---
> 
> Small note: the hard-coded 100 ms timeout will be replaced in a future
> series with a dynamic value, so I didn't bother with a macro or comments
> to explain why the value was chosen.
> 
> And passing indio_dev instead of data to irq is intentional as it will
> be used in the next patch.
> ---
>  drivers/iio/adc/ti-ads112c14.c | 82 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 8ad8caee0ff7..57e301c15314 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c

> +
>  static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> @@ -601,17 +621,33 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
>  			return ret;
>  	}
>  
> +	if (data->drdy_irq) {
> +		reinit_completion(&data->drdy_completion);
> +		enable_irq(data->drdy_irq);
> +	}
> +
>  	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
>  			   ADS112C14_CONVERSION_CTRL_START);

Given this is basically the only shared code, maybe just split into
two helpers and chose between them?  The outer code in single_conversion
would be shared. I just mean this inner bit to establish we have data.


> -	if (ret)
> +	if (ret) {
> +		if (data->drdy_irq)
> +			disable_irq(data->drdy_irq);
>  		return ret;
> +	}
>  
> -	ret = regmap_read_poll_timeout(data->regmap,
> -				       ADS112C14_REG_STATUS_MSB, reg_val,
> -				       FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
> -				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
> -	if (ret)
> -		return ret;
> +	if (data->drdy_irq) {
> +		ret = wait_for_completion_timeout(&data->drdy_completion,
> +						  msecs_to_jiffies(100));
> +		disable_irq(data->drdy_irq);
> +		if (ret == 0)
> +			return -ETIMEDOUT;
> +	} else {
> +		ret = regmap_read_poll_timeout(data->regmap,
> +					       ADS112C14_REG_STATUS_MSB, reg_val,
> +					       FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
> +					       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
> +		if (ret)
> +			return ret;
> +	}
