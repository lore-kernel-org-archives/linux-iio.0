Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757592;
	b=XqC9IjxFVP4k/hrPe2F1Xlud2uq5xFh/GU2IaJ0RBFsBg+mZA4ZrkDX8PsdHSuY0lflC
	 ybQo6W+5H32sNEkfF7EMXPxgjuikJcOxhwJ9rtVZr8rkc8dnloWHnmCtGAO3os34xfXGy
	 Df7oYeUyIx2KYSW0me+5ALChBzJNmOwj/uAwj+szSWxfO1xc8lR84Ajprxi+MSiDJmqUc
	 dEcV0Xi1hR8IAnmi3+WCWzPei0s/4HB2TWt/CaUWyhH9PJvbO5c0ej+6P9hIW7rW3SG1R
	 U8ZdPz8RfvuQ1l11kWmBZTl0vQueV+Gj68gddGa2USreBWTvvQJzngZvzJuJkTdr6jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757592;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iZ8ZEB69e99iUpBIdOKFs2774n2XFkLw9sMemZG3Lbg=;
	b=Po1oO8kG+wJszA0IGWbQpTY5djMRzaSUQZ+Ifjt7NQfUNhlRVusfw/A22m+wb9zlNqJx
	 B5CVKsqB80PBo7eGbTrUZHaliaPSHFK6SyjRyHqXSFxZFl809CY2G33vZJg06QDVx7c8i
	 h34Anpg0Vg+yiXVVeHJGlNmjFCWY9DipIo1ZSlTiurVWbmh6EYBo6Hb8a/2zIlS6INXR4
	 0sKapgXtN80UEJ65lsN8ODAz7iyNJRsIK4rS7UXJwZEA5y4le3mertcLJSsrD9dnNyHOt
	 3+8kanJsGhVLfMMfR76KdR6Y4G1akIB1dA3sgShAu0QptFnOJ5MxnRUvjci2pebefsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ng90dtXe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB21606A328;
	Wed,  4 Nov 2026 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ng90dtXe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEFF1F000C1;
	Wed,  4 Nov 2026 01:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757591;
	bh=iZ8ZEB69e99iUpBIdOKFs2774n2XFkLw9sMemZG3Lbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ng90dtXe6KTTpr5tRJMbsm4OVkaofi1qRqc+dGBnkPqN+PuXwkAnyJvklipaAtfle
	 /IyGfXuuWqPYsJ3BHezY7dKmnRFt+iCohk0i43A1D4kYnb0YaNhkF8IUO+Lw5cMdfu
	 uu/flybnsU8ldB5HewcxeViR8qPJ9DB4eIXQjO6jNqi6aFRHjOE5CUPlHzTGzxOiKY
	 NKvrSA2fg9nA12/stnlLKF8TPs0tUkcti+VzwVRgOiFT8wJjV2UJ7vRsPiIWUA6ven
	 NLfYIJVU2Z1uB3oFVTzL/+Zfkk69U496e0u3hbHnR+hE8bSyJds1yA4iK1u1pP/XEZ
	 Df539qlOBs5sg==
Date: Wed, 4 Nov 2026 01:59:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com
Subject: Re: [PATCH v3 1/2] iio: gyro: mpu3050: Split data ready trigger
 enable/disable into helpers
Message-ID: <20261104015945.77c936c5@jic23-hlaptop>
In-Reply-To: <20261103092002.1332-2-laixiangwu@cmss.chinamobile.com>
References: <20261103092002.1332-1-laixiangwu@cmss.chinamobile.com>
	<20261103092002.1332-2-laixiangwu@cmss.chinamobile.com>
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

On Tue,  3 Nov 2026 17:20:01 +0800
Xiangwu Lai <laixiangwu@cmss.chinamobile.com> wrote:

> From: laixiangwu <laixiangwu@cmss.chinamobile.com>
> 
> mpu3050_drdy_trigger_set_state() implements both the enable and the
> disable path of the data ready trigger in the two legs of a large
> if/else statement.
> 
> Split the two legs out into separate mpu3050_drdy_trigger_enable()
> and mpu3050_drdy_trigger_disable() helpers and reduce
> mpu3050_drdy_trigger_set_state() to dispatching to the appropriate
> one. This is a pure code move with no functional change, done to make
> the error handling of the enable path easier to read.
> 
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>

Hi. You have definitely picked some ugly code to work on!



> ---
> 
> Changes in v3:
> - none; reposted in a new top-level thread.
> 
> Link: https://lore.kernel.org/r/20261101092327.197-2-laixiangwu@cmss.chinamobile.com
>  drivers/iio/gyro/mpu3050-core.c | 173 ++++++++++++++++++--------------
>  1 file changed, 99 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 07c0f9011..d966911ab 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -946,103 +946,128 @@ static irqreturn_t mpu3050_irq_thread(int irq, void *p)
>  }
>  
>  /**
> - * mpu3050_drdy_trigger_set_state() - set data ready interrupt state
> - * @trig: trigger instance
> - * @enable: true if trigger should be enabled, false to disable
> + * mpu3050_drdy_trigger_enable() - enable the data ready trigger
> + * @mpu3050: device to configure
> + *
> + * Power up the device, enable the FIFO and configure the data ready
> + * interrupt.
>   */
> -static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
> -					  bool enable)
> +static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)
>  {
> -	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> -	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
>  	unsigned int val;
>  	int ret;
>  
> -	/* Disabling trigger: disable interrupt and return */
> -	if (!enable) {
> -		/* Disable all interrupts */
> -		ret = regmap_write(mpu3050->map,
> -				   MPU3050_INT_CFG,
> -				   0);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error disabling IRQ\n");
> +	pm_runtime_get_sync(mpu3050->dev);
> +	mpu3050->hw_irq_trigger = true;
>  
> -		/* Clear IRQ flag */
> -		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error clearing IRQ status\n");
> +	/* Disable all things in the FIFO */
> +	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
> +	if (ret)
> +		return ret;
>  
> -		/* Disable all things in the FIFO and reset it */
> -		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error disabling FIFO\n");
> +	/* Reset and enable the FIFO */
> +	ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
> +			      MPU3050_USR_CTRL_FIFO_EN |
> +			      MPU3050_USR_CTRL_FIFO_RST);
> +	if (ret)
> +		return ret;
>  
> -		ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
> -				   MPU3050_USR_CTRL_FIFO_RST);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error resetting FIFO\n");
> +	mpu3050->pending_fifo_footer = false;
>  
> -		pm_runtime_put_autosuspend(mpu3050->dev);
> -		mpu3050->hw_irq_trigger = false;
> +	/* Turn on the FIFO for temp+X+Y+Z */
> +	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
> +			   MPU3050_FIFO_EN_TEMP_OUT |
> +			   MPU3050_FIFO_EN_GYRO_XOUT |
> +			   MPU3050_FIFO_EN_GYRO_YOUT |
> +			   MPU3050_FIFO_EN_GYRO_ZOUT |
> +			   MPU3050_FIFO_EN_FOOTER);
> +	if (ret)
> +		return ret;
>  
> -		return 0;
> -	} else {
> -		/* Else we're enabling the trigger from this point */
> -		pm_runtime_get_sync(mpu3050->dev);
> -		mpu3050->hw_irq_trigger = true;
> +	/* Configure the sample engine */
> +	ret = mpu3050_start_sampling(mpu3050);
> +	if (ret)
> +		return ret;
>  
> -		/* Disable all things in the FIFO */
> -		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
> -		if (ret)
> -			return ret;
> +	/* Clear IRQ flag */
> +	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error clearing IRQ status\n");

The original code indeed didn't do anything beyond printing this
error but to me that seems random and inconsistent.  So should
probably be tidied up as part of this series. 

>  
> -		/* Reset and enable the FIFO */
> -		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
> -				      MPU3050_USR_CTRL_FIFO_EN |
> -				      MPU3050_USR_CTRL_FIFO_RST);
> -		if (ret)
> -			return ret;
> +	/* Give us interrupts whenever there is new data ready */
> +	val = MPU3050_INT_RAW_RDY_EN;
>  
> -		mpu3050->pending_fifo_footer = false;
> +	if (mpu3050->irq_actl)
> +		val |= MPU3050_INT_ACTL;
> +	if (mpu3050->irq_latch)
> +		val |= MPU3050_INT_LATCH_EN;
> +	if (mpu3050->irq_opendrain)
> +		val |= MPU3050_INT_OPEN;
>  
> -		/* Turn on the FIFO for temp+X+Y+Z */
> -		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
> -				   MPU3050_FIFO_EN_TEMP_OUT |
> -				   MPU3050_FIFO_EN_GYRO_XOUT |
> -				   MPU3050_FIFO_EN_GYRO_YOUT |
> -				   MPU3050_FIFO_EN_GYRO_ZOUT |
> -				   MPU3050_FIFO_EN_FOOTER);
> -		if (ret)
> -			return ret;
> +	ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
> +	if (ret)
> +		return ret;
>  
> -		/* Configure the sample engine */
> -		ret = mpu3050_start_sampling(mpu3050);
> -		if (ret)
> -			return ret;
> +	return 0;
> +}
>  
> -		/* Clear IRQ flag */
> -		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error clearing IRQ status\n");
> +/**
> + * mpu3050_drdy_trigger_disable() - disable the data ready trigger
> + * @mpu3050: device to configure
> + *
> + * Disable the data ready interrupt, flush the FIFO and drop the
> + * runtime PM reference taken in mpu3050_drdy_trigger_enable().
> + */
> +static int mpu3050_drdy_trigger_disable(struct mpu3050 *mpu3050)
> +{
> +	unsigned int val;
> +	int ret;
>  
> -		/* Give us interrupts whenever there is new data ready */
> -		val = MPU3050_INT_RAW_RDY_EN;
> +	/* Disable all interrupts */
> +	ret = regmap_write(mpu3050->map,
> +			   MPU3050_INT_CFG,
> +			   0);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error disabling IRQ\n");
>  
> -		if (mpu3050->irq_actl)
> -			val |= MPU3050_INT_ACTL;
> -		if (mpu3050->irq_latch)
> -			val |= MPU3050_INT_LATCH_EN;
> -		if (mpu3050->irq_opendrain)
> -			val |= MPU3050_INT_OPEN;
> +	/* Clear IRQ flag */
> +	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error clearing IRQ status\n");
>  
> -		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
> -		if (ret)
> -			return ret;
> -	}
> +	/* Disable all things in the FIFO and reset it */
> +	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error disabling FIFO\n");
> +
> +	ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
> +			   MPU3050_USR_CTRL_FIFO_RST);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error resetting FIFO\n");
Obviously fine in this patch as it's a direct refactor, but
shouldn't a failure to disable the trigger result in an error return?

might be later in the series.
Now the error return doesn't propogate far in the iio core.
That's intentional because cleaning up this sort of failure
to disable is hard and rarely useful.  I'd still expect the
driver to not be making that decision however.

I guess maybe it's not worth the effort to fix this.


> +
> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +	mpu3050->hw_irq_trigger = false;
>  
>  	return 0;
>  }
>  
> +/**
> + * mpu3050_drdy_trigger_set_state() - set data ready interrupt state
> + * @trig: trigger instance
> + * @enable: true if trigger should be enabled, false to disable
> + */
> +static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
> +					  bool enable)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
> +
> +	if (enable)
> +		return mpu3050_drdy_trigger_enable(mpu3050);
> +
Personally I'd use an else to give a visual clue that this is
an either / or situation.

> +	return mpu3050_drdy_trigger_disable(mpu3050);
> +}
> +
>  static const struct iio_trigger_ops mpu3050_trigger_ops = {
>  	.set_trigger_state = mpu3050_drdy_trigger_set_state,
>  };

