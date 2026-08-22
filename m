Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB22E6CA6;
	Sat, 22 Aug 2026 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365557; cv=none; b=S6+Y4Q9tIW8QdySS55Atb4GM86TTecAE9h0sm5TJ570m2FvF0Y00XXfLYYLBbk7d26AonTM/Wj1JFiGuuiRw1WkfFBSCjGWmpnRqXrhbJkqVok336+/bAMxFsxgdHUTbol81vZSPpIx+4p7l/xXRCNXobXAWZ/S5R4z+pz1egrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365557; c=relaxed/simple;
	bh=aCzhTjA7GA38+VpuTyRof1qlLJD4M4Z6XnJFC3rqjn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUFz9WkFMDlqoncImBlzuT5Rk73R517EsJeIqip21niEDeKqqvCGHvWO71FLUcj6wcjK5gGcwZZE3xZ51cev1Jbkf+VqbbNNU/9R/vMNA4aKCE6EHoyVUg21u56O/UJ0GhZAMiCA+RAXPdqxy1MWEpY4Dvd7f+goQw7zK9nd4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1vcgXtv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1vcgXtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7576C1F000E9;
	Sat, 22 Aug 2026 02:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787365555;
	bh=ZzSrLhNyS0p2DYV9gUZiG+QHvjtTCgPo5OC0GCJBZ3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l1vcgXtvo4VBtnE3mPbb3ZERL2zpV/dakxnS8m/fR16zTZCz4x8QaQoIlPsTIMPS9
	 Q0O2QoJvVW4tXUSuqufeQYkXEi5qmUUyDtgM5KqxVxkCdqtcqwzfnY4Qu3XdYpW7l2
	 IojjTpg8VaOQGt3DScE7cljeUGlLThrlAUJll6Gdg4ty8iapwOEzC82A4JswCp3Kut
	 OaaYy+AOAAyUG0UZYhEkdeQU4XS6xH0DJAz4B1ZHRUrsjcBjvb2bUzzKXEbnQ/Cc9X
	 CJ0W5KCayFs/KE/s374P2+6UIsXUzMBbklspy6tEqGLOkiWSSLaHMHBll+catbBsUx
	 Uqy97tcYGWrMA==
Date: Sat, 22 Aug 2026 03:25:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Tsz Shan Chan
 <tchan@jacques.com.au>
Subject: Re: [PATCH v2 2/2] iio: light: vcnl4000: add shared IRQ support
Message-ID: <20260822032550.31a0fa9e@jic23-huawei>
In-Reply-To: <20260814-vcnl4000-v2-2-9b771290cc1d@jacques.com.au>
References: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
	<20260814-vcnl4000-v2-2-9b771290cc1d@jacques.com.au>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 14:30:43 +1000
Tsz Shan Chan <tsz.chan.dev@gmail.com> wrote:

> The INT output of vcnl4010/4020 and vcnl4040/4200 is open drain active
> low which can be shared with other devices.
> Add IRQF_SHARED and switch the trigger type from IRQF_TRIGGER_FALLING to
> IRQF_TRIGGER_LOW. Edge triggering can miss interrupts on a shared line.
Fairly low risk change but I guess we'll see.

It used to be annoyingly common for interrupt controllers to support
only edge based interrupts, but hopefully that silliness is a thing
of the past.

So crossed fingers, I'll apply this and see if we get anyone shouting.
I think we'll get away with it

Thanks,

Jonathan

> 
> Return IRQ_NONE from the irq handler when read fails or when none of the
> interrupt source bits handled by the driver are set. This prevents
> claiming interrupts from other devices on a shared line.
> 
> Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
> ---
>  drivers/iio/light/vcnl4000.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 663e623da833..8a723eaadbb6 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1470,7 +1470,11 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
>  
>  	ret = i2c_smbus_read_word_data(data->client, data->chip_spec->int_reg);
>  	if (ret < 0)
> -		return IRQ_HANDLED;
> +		return IRQ_NONE;
> +
> +	if (!(ret & (VCNL4040_PS_IF_CLOSE | VCNL4040_PS_IF_AWAY |
> +		     VCNL4040_ALS_FALLING | VCNL4040_ALS_RISING)))
> +		return IRQ_NONE;
>  
>  	if (ret & VCNL4040_PS_IF_CLOSE) {
>  		iio_push_event(indio_dev,
> @@ -1526,7 +1530,10 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
>  
>  	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
>  	if (ret < 0)
> -		goto end;
> +		return IRQ_NONE;
> +
> +	if (!(ret & (VCNL4010_INT_THR | VCNL4010_INT_DRDY)))
> +		return IRQ_NONE;
>  
>  	isr = ret;
>  
> @@ -1558,7 +1565,6 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
>  	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
>  		iio_trigger_poll_nested(indio_dev->trig);
>  
> -end:
>  	return IRQ_HANDLED;
>  }
>  
> @@ -1981,8 +1987,8 @@ static int vcnl4000_probe(struct i2c_client *client)
>  	if (client->irq && data->chip_spec->irq_thread) {
>  		ret = devm_request_threaded_irq(dev, client->irq, NULL,
>  						data->chip_spec->irq_thread,
> -						IRQF_TRIGGER_FALLING |
> -						IRQF_ONESHOT,
> +						IRQF_TRIGGER_LOW |
> +						IRQF_ONESHOT | IRQF_SHARED,
>  						"vcnl4000_irq",
>  						indio_dev);
>  		if (ret < 0)
> 

