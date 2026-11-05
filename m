Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892691;
	b=4ccI4EDlrHI0zWA4jMmmEbVK5j35hg7nvnhNtffOU2cc8pdhICaqJAr6ApmlYfzyMkZ/
	 Rt4kWjGX95HFwS1h7KRSW5S6kvvRNWsNfxQvs/H+KJJzwPpkp4bplwkBncmHl9eKL2z0P
	 A4LlV0fLTpEFr9EUlrwwjkzcxjqZGbrtitK0QU5B6Ia69yq+OoaI9FWoO/spOW+VtwuKK
	 y8CChXvs19eGITG0cwiAf0BGXRJjJh/05x8yJDjQ7ZenvZtPjMgTwtB7ZH1JRsTTpOpRf
	 Lb5dlZanOfGD219cIXkUN28fRz75ZM+HifXfNXWHdaE9Wxb3D7vHIbt+YKyZmoUsXSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892691;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yiM2+qWqrWpX2d99iNyQUbswa+iIJehyzs1jXXgMmXs=;
	b=Vgwr3OrrrGy2wy2Er1qLCGYoEkAEg8M5lMy5Y5PnNfZZlKN7rfu6bIpjHZrNNJ4DFt7M
	 VzLHEU+yNCWAz8gSv4wZHLOxzTdpJvffIJtJuyIQkFWEz6JmcqWGFCN8ATrGVH/7H9W/M
	 doeIvVytXPfnOqdoNzpXmjfaTpURjh4fd8crEmXnd56Ue+9d9DLdPAwOONfS5nW4MAYur
	 slU/ehx85ftXFmgmd3pHe+XwpNB3jb9+0Cib8ypDqZbJfcMDrkiUIKLzFnGSTKwb5BzCo
	 xQMCQDosksPJVxo9Nj8KCVooxiAsoODN0fpztXdMXHd2BzN5bRyYZ1Uraqc1ql9+gsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgC0JBFU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0124606D82D;
	Thu,  5 Nov 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgC0JBFU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793892691;
	b=OSNrHhiGCw/FEHYe+LiY1nA4kzR/s+c169Yfx5GosxYK5gSlQGJGxPdILbTe2DKH8Asy
	 fYOIkqhtOLmBU8awVQSNEaot33jW0S1lWy3Cd2GhkDqNziUms/uqOIuAGMhu0S32VStK0
	 ziQIRiphSrdLGPkAEPp49LD1CA5BR4xtjuU9dcbh+ib00iwgX25n6DrmHkwy/tgMUfT4a
	 wc0TCE/EoT+jc4GnpKSwAaFw9ccJE6PEmaHnZSx5xl64Suj1PcCWNvWSdA/x1cfSv4K6p
	 8snYjRir+zZwoC6f3A95BotaEVQxQA4DQEM39AiyyUpSG8C2i4gnYDF+pra3R683bGQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793892691;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yiM2+qWqrWpX2d99iNyQUbswa+iIJehyzs1jXXgMmXs=;
	b=q+fS3JzANzYqDmNA+x+8jU+ykhHExNGNCAximltdubICj3uUgA2WXuTWtWhQvwhb55u0
	 S9kya/ErBk4/b6Xe4R+7RW7+kyK7kBDzDw7gyttkI8iyrePb/LbbjNzfDdtdrYxrZP1f1
	 K/g9iBxpflcTkOsB24MVKSbEoZi4XSEyj9Pm8gBTaed38TGbPMiOzVynVS2o4Nu3b0ydc
	 GxqJGEuPcFOhGUt3YP+iwsGB7OlggkNZX2pfukEF1VNSqRkYmL79E+MK+m13SZCfxO2RT
	 7mlEDdLu7pZt4xZV0AsxFjd8HHLk76TrEvd5qjivq48WJAafgm+oaHpIcaxst0zpI5Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id ED92E1F000C1;
	Thu,  5 Nov 2026 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892691;
	bh=yiM2+qWqrWpX2d99iNyQUbswa+iIJehyzs1jXXgMmXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TgC0JBFUVrX7kzgYx4pzt2nKkXBfgZO+t1vgratxVy53uqq0Om1Ak6JpM/w8edKrH
	 Tv0t12+v5pzcHrXG8FNqdfVh5lnrlhI+tR1rXVtgiFBeuWUPqLCt7n8ny2NlQvxj/a
	 eOS7v5vq5unhtEvktM+Py2BDNpZ0QNdNoGPrzeYiRDeVU+l2ovrbseXrjrmIMkV2T9
	 yr2LbOVfjmjhkXJaR9HU3KSg95Ra5uIWnLgTctmzJgd2hyFDftxS+VcgFIkaBdAVqV
	 yq/HttVz81pGvo4b63s6/mZoY50VQOzOZjl6DX9jYgzVCwKnAut7g0fBemewgRiXSk
	 Qd0ggY58UUwHw==
Date: Thu, 5 Nov 2026 16:31:18 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com
Subject: Re: [PATCH v4 1/2] iio: gyro: mpu3050: Split data ready trigger
 enable/disable into helpers
Message-ID: <20261105163118.00001538@kernel.org>
In-Reply-To: <20261104040008.1458-2-laixiangwu@cmss.chinamobile.com>
References: <20261104040008.1458-1-laixiangwu@cmss.chinamobile.com>
	<20261104040008.1458-2-laixiangwu@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Wed,  4 Nov 2026 12:00:06 +0800
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
> ---
> 
> Changes in v4:
> - use an else for the either/or dispatch in
>   mpu3050_drdy_trigger_set_state(), as suggested by the reviewer.
> 
> Changes in v3:
> - none; reposted in a new top-level thread.
> 
> Link: https://lore.kernel.org/r/20261103092002.1332-2-laixiangwu@cmss.chinamobile.com
> Link: https://lore.kernel.org/r/20261101092327.197-2-laixiangwu@cmss.chinamobile.com
>  drivers/iio/gyro/mpu3050-core.c | 173 ++++++++++++++++++--------------
>  1 file changed, 99 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 07c0f9011..62e416df3 100644
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

Not sure if it's just me, but reading this patch is pretty hard;
please use histogram as your default diff algorithm [1] when sending
a patch next time.

Otherwise LGTM (after viewing with the histogram option :)).

Reviewed-by: Joshua Crofts <crofts@kernel.org>

[1] https://git-scm.com/docs/diff-algorithm-option.html

-- 
Kind regards,
Joshua Crofts
