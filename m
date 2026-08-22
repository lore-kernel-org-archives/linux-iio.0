Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED149363F;
	Sat, 22 Aug 2026 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437400; cv=none; b=DbGvwKhaHPf1acnBP2J7oDE1/jB21uaTivD6Kx/4yIfj6V6F1PEMcN5CpGrhJy9DExAoKiLq0wdPLk11eDaN6CYmG3x0NnlhYK4KdmjNe7V5FDdkqMqvyZ3GOtcdy+9pYNSPK9IrH2fEGi7BV5uPyc1xPTY94gKsci7rUmgOcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437400; c=relaxed/simple;
	bh=622IaMsKTA5Jc40PGEEldkGGRXEXjOiSlcMWvX1QwmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcwjBg0YDFLDV+irCJLu0BhpYMDu4UzgTT63LCooQLlWZUzdAkEnk5OeDKg2kfPJ/ME7tklwuT2O72vRRiFqJyy8YlVwgsz1Y5rYxc92UXD/CFggXciHNnUqm0ovx+ZqSPecIrVzb40HAvM9pl93ORQqACe6xD5AH7uvjXHE1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJc9CuCo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJc9CuCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C6C1F000E9;
	Sat, 22 Aug 2026 22:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787437399;
	bh=wWrbwBGvtlnMgPCmqjc+fpsf/SCdvB2xBgU9iCs5K8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NJc9CuCoAbdVXqRD4XWaoDHdv2evLkqoZELjkcyEjyvwMXGmoQd42eDSTYflsLlq1
	 N/dKzCzp7+QkA6SooMtRs8FiWzs5elphWMtjbBA1o5ensjQGJ3tV+JD86Yoz+SAHOE
	 WGUD/EuOAekRY0tEm0wJgThRs1av7LmkD3u7OJtdxbfvyX00Bskr0N0LdD/41STUDm
	 +afh1qlSH2JtvU71elUkhYNHz4DS9qW4y85j5Hs/ACIfZEQvXBSGtnlgQ4Si0NCjZc
	 lCMhVZkxolmRO/SuZ/xQqsUWnCC8Tlzhlj4miJc8pfK1XSLQ3cwDVq3V86wEY/MneH
	 3prV4w9dmUyOA==
Date: Sat, 22 Aug 2026 23:23:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix runtime PM leak on trigger
 errors
Message-ID: <20260822232313.66ff7ff8@jic23-huawei>
In-Reply-To: <20260814134111.1387580-1-ruoyuw560@gmail.com>
References: <20260814134111.1387580-1-ruoyuw560@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 21:41:11 +0800
Ruoyu Wang <ruoyuw560@gmail.com> wrote:

> The first user of the MPU-3050 data-ready trigger takes a runtime PM
> reference before configuring the FIFO, sample engine and interrupt. If
> any of those operations fails, iio_trigger_attach_poll_func() tears down
> its IRQ resources without calling set_trigger_state(false). The buffer
> error path then releases only its preenable reference, leaving the
> trigger's reference held and preventing runtime suspend.
> 
> Use pm_runtime_resume_and_get() so a resume failure does not leave a
> usage count behind. Route later setup failures through a common unwind
> that clears hw_irq_trigger and drops the trigger's reference. Successful
> enable and disable behavior is unchanged.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: f11d59d87b8622 ("iio: Move attach/detach of the poll func to the core")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/iio/gyro/mpu3050-core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b4314..33a98a6e9cb84 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -988,20 +988,23 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  		return 0;
>  	} else {
>  		/* Else we're enabling the trigger from this point */
> -		pm_runtime_get_sync(mpu3050->dev);
> +		ret = pm_runtime_resume_and_get(mpu3050->dev);
> +		if (ret)
> +			return ret;
> +
>  		mpu3050->hw_irq_trigger = true;
>  
>  		/* Disable all things in the FIFO */
>  		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;

All these gotos are rather ugly.  I would consider using a helper
function so there is something like

		ret = mpu3050_dataready_do_enable();
		if (ret) {
			mpu3050->hw_irq_trigger = false;	
			pm_runtime_put_autosuspend(mpu3050->dev);
			return ret;
		}
		...


>  
>  		/* Reset and enable the FIFO */
>  		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
>  				      MPU3050_USR_CTRL_FIFO_EN |
>  				      MPU3050_USR_CTRL_FIFO_RST);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		mpu3050->pending_fifo_footer = false;
>  
> @@ -1013,12 +1016,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  				   MPU3050_FIFO_EN_GYRO_ZOUT |
>  				   MPU3050_FIFO_EN_FOOTER);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		/* Configure the sample engine */
>  		ret = mpu3050_start_sampling(mpu3050);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		/* Clear IRQ flag */
>  		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> @@ -1037,10 +1040,16 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  
>  		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  	}
>  
>  	return 0;
> +
> +err_pm_put:
> +	mpu3050->hw_irq_trigger = false;

Clearing this on a write failure is a change, so good to call that out
in the patch description.

> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +
> +	return ret;
>  }
>  
>  static const struct iio_trigger_ops mpu3050_trigger_ops = {

