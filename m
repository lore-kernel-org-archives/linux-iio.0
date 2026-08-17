Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D2301719;
	Mon, 17 Aug 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931120; cv=none; b=TAPdxUE24rf2EysR9rOiszBGU58DdLCEBVEmpUJTGb0jBebQJC6pUsNTSGWEOYqzlrCit4FGepomrn8QS8KVjR5Hwr7CxjDa18SdO1NtnwTbAIKDpE75Dt8BGmzp1JJC7dVw8U6ZjKDv4UkleqUinY2Xje0W3zV9Elav2hMKKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931120; c=relaxed/simple;
	bh=gSkhsFzjFl3zbB+VprD5N9mJEUhfBwG5eKfjBSVEwuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocPL+MIS9JqEylEVCum3ItnPZYd0618z+ow0CR8ZBCb9RS9XswLUuLRZOL2Lo82sRw3tvaLsZClb2r10Cqzizs9+QRJFRf+mAE0JUqY18iLktuzKfKWLNnkucXzVCbJowRr+UctvlpbJF4fLvjudQxzauBwYTM66EA9TLgzTSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4ml/Arb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4ml/Arb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF311F000E9;
	Mon, 17 Aug 2026 01:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786931119;
	bh=/GD+tpzWgQ0uILjByb80GufXELbNUudM2uon2e5z40U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F4ml/ArbrOFPreqfnG/eZbLKxKXI4xMpIGpfvUiqLJQbzVwUxl2/J6grlC6LhIh9+
	 lKYZbsHvbrLKq+/kUDwmz7aQdV9pkXwduZQFNIT1Y852hKtSpu0x71nEZBFMwC/mO0
	 pS70oONM6AMPsOEymALhLexWiWDJqFbUcs6SVsc+XmagyOk4ccQKyzdxI9axUoS3o/
	 79hSqP0Y5iPEnOAVd8abxJiRsr2JSG6LIf0ac80H4mlanGQm1AdBtMKAPXKOch/h01
	 y+iZTLM8OIaYEYvdAZ5ixXLeHWubdf6PclWtagWp9tVM3qKr6AqdgI/8+B5inhiOh+
	 q8h2IB3x2VbLQ==
Date: Mon, 17 Aug 2026 02:45:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 11/12] iio: accel: kionix-kx022a: Prevent memory leak
 and fix state
Message-ID: <20260817024513.0c2adab7@jic23-huawei>
In-Reply-To: <85e6bd3998863e0247c52dcf0c1486b2cddff567.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<85e6bd3998863e0247c52dcf0c1486b2cddff567.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:55:03 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The driver allocates memory for samples at buffer enable path. If regmap
> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
> allocated memory is never freed. Furthermore, the state information and
> previous hardware configuration(s) aren't undone, potentially leaving
> WMI interrupts and buffers enabled, or driver state flags wrong.
> 
> Free the memory and revert the hardware configuration and state flags on
> error path.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
> ---
>  drivers/iio/accel/kionix-kx022a.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 8a13f78aeab0..49e8b4b943da 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -980,26 +980,43 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
>  	guard(mutex)(&data->mutex);
>  	ret = __kx022a_turn_on_off(data, false);
>  	if (ret)
> -		return ret;
> +		goto err_free_out;

If we follow this path we are assuming that turn_on_off hasn't
had any side effects in failing...


>  
>  	/* Update watermark to HW */
>  	ret = kx022a_fifo_set_wmi(data);
>  	if (ret)
> -		return ret;
> +		goto err_free_out;
>  
>  	/* Enable buffer */
>  	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
>  			      KX022A_MASK_BUF_EN);
>  	if (ret)
> -		return ret;
> +		goto err_free_out;
>  
>  	data->state |= KX022A_STATE_FIFO;
>  	ret = regmap_set_bits(data->regmap, data->ien_reg,
>  			      KX022A_MASK_WMI);
>  	if (ret)
> -		return ret;
> +		goto err_wmi_out;
>  
> -	return __kx022a_turn_on_off(data, true);
> +	ret = __kx022a_turn_on_off(data, true);
> +	if (ret)
> +		goto err_on_out;


> +
> +	return ret;
> +
> +err_on_out:
> +	regmap_clear_bits(data->regmap, data->ien_reg,
> +			  KX022A_MASK_WMI);
> +err_wmi_out:
> +	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
> +			  KX022A_MASK_BUF_EN);
> +err_free_out:
> +	kfree(data->fifo_buffer);

This thing is fine here.

> +	data->state &= ~KX022A_STATE_FIFO;

This should also only occur when we have set it in the first place - 
so under err_wmi_out:


> +	__kx022a_turn_on_off(data, true);

So following path above we should not be calling this.  It might
be safe to do so but it isn't logically correct.  It should be a few
lines earlier.

> +
> +	return ret;
>  }
>  
>  static int kx022a_buffer_postenable(struct iio_dev *idev)

