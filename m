Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEB1C84A0;
	Sun, 30 Aug 2026 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052984; cv=none; b=UbBKT3pMpB88/+Rq5FnStBPXRREJV97ZJBmflDqMbmXS5vN0tg0fcq1R9JlCdNERuC9eL4xTk1zh0ZzEh9gn6RfTzT/wqCEIek0NtlE7iDKWvML4rL7CX1tRGYVHmLa0yHaN2ZSe4YeEvOsV67F+bM+PSMwB+t1MpUbk5VrS07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052984; c=relaxed/simple;
	bh=RI+5wU5EtiUTV9CiTX6RS490GxlRGloS8lilxk43vr8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ItWDE/rqiQzQ+dA3S5KsRZCMa5F3YjcqRdPvWUDqviZATB/VbXpn3vdszaUYtn9+Be00ea3uo2uBUUBGP2hqzKO3BXE94OK9rq17LbIaczENUitqV5W9SeL2sBfpLhviTKLZo+QU7nDy6wJ76voMgBu8sinv2jM9NyRhPJKEhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlBCetkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlBCetkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8001F000E9;
	Sun, 30 Aug 2026 01:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788052983;
	bh=chZALl9SReI0x7zfIHUauZgPEoTl2J93muIW1PYESZU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=YlBCetkPFpkLNvCwksktJm7Wg8blq4HBsYz/qeB2ke++5gYne7G/k+1klQyVk3GLG
	 eUFCx1p0v0Qgtj1qcbCrlXpY/+fyF+nQCoWRg3iIBzOTCY8r626o+Q2YbAIp5cfphO
	 woYybqu05sk0W2uuXV89MB5tNOXj29Oi529L2WggKPI0AY6FoKQWSxg3mdNbHEi8Hq
	 q8jh5IHfNW79H6WQq16eaAEkJkrYlWbZob5Q912sKYSwajbujfQLvzAgQVA1uX4L5m
	 pDGTW9jIPWhJuIyzL4FWaPn/q9XssKEDhA4UVtYTCwn/6N2gmNXSz6WaEtTh4Fp8pd
	 bFw41T48YUSsA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/4] iio: accel: kionix-kx022a: Prevent memory leak
 and fix state
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Matti Vaittinen <matti.vaittinen@linux.dev>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Mehdi Djait <mehdi.djait.k@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <9e4453fcc00df6ec988207df8916226d18aecb20.1787901813.git.mazziesaccount@gmail.com>
References: <cover.1787901813.git.mazziesaccount@gmail.com>
 <9e4453fcc00df6ec988207df8916226d18aecb20.1787901813.git.mazziesaccount@gmail.com>
Date: Sun, 30 Aug 2026 02:22:41 +0100
Message-Id: <178805296127.2788519.3966625158499254314.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=RI+5wU5EtiUTV9CiTX6RS490GxlRGloS8lilxk43vr8=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqk4XjZmedrW/AcUDV8OCkE9v6XMagfj0yMmBvO
 lAfieUi/bWJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapOF4xEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiHnkEACvXGdgwtgiDzlCsoAS+on19i+5vJ/GAZBQ+BrHYGa4vlj
 Yf7l/eqo9r0CtZc8sMXprvvrdojDQijO7LCbYKA0d5rJVdSN0lAgkgwu7bHb++MXeypEm0tTZoE
 6F1OZ8C/P4dzuaK5QAhxuVpVsc3maR7h6WxnxLwbMDi6/Mr1O/hUtjGBydKSPBZtgpRlqpvENyV
 QUKF9nuyoEX/sTYVGQgcwinpufPb5B55jlvWWoVuymTN5N9l4I/carbVZdLWb4AFLizqPSwPw9X
 CitAt6CalyezIp/OFhwko3R3AxWSXd9GFOAQ1P1EHpI63kClBU9+cpLRlcur+PF8dhJ1N30m5BO
 Rq9SghzEcGdkNO2FCiTx0ysuO4ipzumhSTXxvNejlkbAn52V8JmajJSpX47lZqvD6Z2UrjfHkm2
 O0DBsYSJF+ytBqsHxIauesPGAi6dECv8zxI24mLQXl4GAc4F40EXDSZQwQou8FuLhoHgWqt3HCB
 d7r8nmw9DEqVykajwitWecZ3b6SY8nuNsyGAp+b2JKNmzZRUn0/Ko24iyj1zPXeofVSiqGpLF2z
 ugRfhMZL3/biMYbBPdnwBnjmDG/W1dHwvm5wP+5SSoEl92NezPniLhTpRKefwLdLDzVq9g7P9yP
 PnyDhrH73BsHpMUwRNXpmdqBPQwvd2UrBcKjhig==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> The driver allocates memory for samples at buffer enable path. If regmap
> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
> allocated memory is never freed. Furthermore, the state information and
> previous hardware configuration(s) aren't undone, potentially leaving
> WMI interrupts and buffers enabled, or driver state flags wrong.
> 
> Free the memory and revert the hardware configuration and state flags on
> error path.
> 
> Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

I'm not happy with the label naming.  It had me very confused!

>
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 02dd1db7a646..42bac6d724a0 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -980,26 +980,44 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
>  	guard(mutex)(&data->mutex);
>  	ret = __kx022a_turn_on_off(data, false);
>  	if (ret)
> -		return ret;
> +		goto err_free_out;
Label naming wise - this one is talking about what needs doing (works for me!)
>  
>  	/* Update watermark to HW */
>  	ret = kx022a_fifo_set_wmi(data);
>  	if (ret)
> -		return ret;
> +		goto err_wmi_out;

This one is talkign about why we went there.  For consistency would
need to be something about turning off not this.

>  
>  	/* Enable buffer */
>  	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
>  			      KX022A_MASK_BUF_EN);
>  	if (ret)
> -		return ret;
> +		goto err_wmi_out;

This I'd kind of expect to undo the set wmi but it doesn't...

>  
>  	data->state |= KX022A_STATE_FIFO;
>  	ret = regmap_set_bits(data->regmap, data->ien_reg,
>  			      KX022A_MASK_WMI);
>  	if (ret)
> -		return ret;
> +		goto err_buf_en_out;

This one is back to what we are undoing (good).

>  
> -	return __kx022a_turn_on_off(data, true);
> +	ret = __kx022a_turn_on_off(data, true);
> +	if (ret)
> +		goto err_on_out;

This is another where we came form, not where we are going to.

> +
> +	return ret;
> +
> +err_on_out:
> +	regmap_clear_bits(data->regmap, data->ien_reg,
> +			  KX022A_MASK_WMI);
> +err_buf_en_out:
> +	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
> +			  KX022A_MASK_BUF_EN);
> +	data->state &= ~KX022A_STATE_FIFO;
> +err_wmi_out:
> +	__kx022a_turn_on_off(data, true);
> +err_free_out:
> +	kfree(data->fifo_buffer);
> +
> +	return ret;
>  }
>  
>  static int kx022a_buffer_postenable(struct iio_dev *idev)
Thanks,

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
