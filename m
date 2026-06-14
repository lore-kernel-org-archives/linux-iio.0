Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BB2F7EF2;
	Sun, 14 Jun 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443361; cv=none; b=i3cdkIetTZI84n+GnKWh9Q/gml3JacoF7pAi6pfB1erUxLVzsL3b0dE8Qo7c+s+hZW6I18NwwRH6l8Z1al+tMXknn+QXjV3fhUn0JvqxXzxj1goTnw9ydvIO9U2pwrc68eXSE5AoeglEeu7XuPq2Yerc8DFUe1s45JSZKJmSvy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443361; c=relaxed/simple;
	bh=19wiB6QWfH0Fx3aqwxEsyxzSyg9g4IFK/COUNRc2H0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IA0O107kD8rZHADjjcYLLFS+Rg0kjLRnKdOa9kl3Mwvz5QOAtVyvQMqtkkSuywlc6/Kel47GGR6hqlf7FtNqSMQTIKzcffVpWaY+41gvRWcu+Y3hd0cHyz4EgZswAzZRE/aLxKIDlj674xOHf67C7OUIw/7yWrzUCK5gb+7Ye0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUWlrU7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUWlrU7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC711F000E9;
	Sun, 14 Jun 2026 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781443359;
	bh=rhSTn0RIk4Z8hFs4vXW+tANplgocA55BAXTxy4noJhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WUWlrU7BjTrenSVWJrzhHwzgzQ8mfGhT/NrPQSoskn0NJWOItbqWUsuH6dyECpLCp
	 +Vq9efg/uvMB5iQpkTKHnUg4BaPa/LfQSzn/D2gwm83DEBLiqcTREylWGL7ZXMAW7u
	 QfzkcCFjVi7YE3SpPqMwb6RUy05gATVwyqpTKOPhAOz2tjKqHx39Cn7pCKz0iqePkw
	 cbJDEQ/DYSG0GeF0i1dAUN8LWeHG5uZ9t8SnsinzmkYyTjfnvRcBaQ7y2b3WG0zgQm
	 fht0MY0OxogbVyaJuYlx9Muig1ZNm3jAM2ssG+8BTTOZdvdn7Ru/gSG4X4HGuTZNq9
	 cM33ulPiId0SA==
Date: Sun, 14 Jun 2026 14:22:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] iio: gyro: mpu3050: fix runtime PM leak when
 enabling trigger fails
Message-ID: <20260614142231.736476db@jic23-huawei>
In-Reply-To: <20260614071549.81920-3-birenpandya@gmail.com>
References: <20260614071549.81920-1-birenpandya@gmail.com>
	<20260614071549.81920-3-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 12:45:47 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> mpu3050_drdy_trigger_set_state() calls pm_runtime_get_sync() when the
> trigger is enabled, but several error paths in the enable branch return
> directly without dropping the usage counter again. pm_runtime_get_sync()
> increments the usage counter, so every failed enable leaks a runtime PM
> reference and the device can no longer autosuspend. The driver state flag
> hw_irq_trigger is also left set after a failed enable.
> 
> Jump to a common error label that drops the reference and clears
> hw_irq_trigger, mirroring the disable path. The success path deliberately
> keeps the reference, as the device must stay resumed while the trigger is
> active.
> 
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> Assisted-by: Claude:claude-opus-4-8 coccinelle

This looks more or less fine to me, but I'd like to leave it on list
for a little while so hopefully someone who is more familiar with the device
can take a look.

A suggestion below for a less minimal but perhaps nicer way of doing this.
> ---
>  drivers/iio/gyro/mpu3050-core.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b431..783be9a786df 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -994,14 +994,14 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  		/* Disable all things in the FIFO */
>  		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  
>  		/* Reset and enable the FIFO */
>  		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
>  				      MPU3050_USR_CTRL_FIFO_EN |
>  				      MPU3050_USR_CTRL_FIFO_RST);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  
>  		mpu3050->pending_fifo_footer = false;
>  
> @@ -1013,12 +1013,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  				   MPU3050_FIFO_EN_GYRO_ZOUT |
>  				   MPU3050_FIFO_EN_FOOTER);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  
>  		/* Configure the sample engine */
>  		ret = mpu3050_start_sampling(mpu3050);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  
>  		/* Clear IRQ flag */
>  		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> @@ -1037,10 +1037,16 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  
>  		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  	}
>  
>  	return 0;
> +
> +err_power_down:

I'm not particularly keen on a goto error block that only applies to one
leg of an if / else.  Given there is effectively not sharing of code between the enable
and disable paths, I'd rather see this whole thing broken into two helpers.
mpu3050_drdy_trigger_enable() and mpu3050_drdy_trigger_disable()

Then the error unwind would not have the issue of only applying to some code
paths as it would be in the helper.  Obviously it is a more invasive change
but I think it is worth doing rather that having a minimal fix then sweeping around
later to replace all that code.


> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +	mpu3050->hw_irq_trigger = false;
> +
> +	return ret;
>  }
>  
>  static const struct iio_trigger_ops mpu3050_trigger_ops = {

