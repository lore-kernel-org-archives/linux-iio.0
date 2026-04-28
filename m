Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B212D8795;
	Tue, 28 Apr 2026 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390376; cv=none; b=b0h4QgsJdLpzH/swzDSoSvPyp3TnLYJIz/xERYSuddrCcCKHeh23TVT7rRmz5VvOhOAR4tiCPtySvoK5zcoedRbP5+Y05l+9naPj0h3L8RqVvArGnBrL9GmGJ/J2v2Y/mclZ14pI5R8be9btydj+mzZfPDVg0L95EBCZPtp/Du0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390376; c=relaxed/simple;
	bh=unlpE5t+tYHvEF17ZobLkXJsuXBcIp9ybMmKHB5e1K4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONhEFonRJ/S+BAGGzM2Hpk4NrCJQXYaiAgyZG5KuWYRLO2kFmEgRYLoy9FWpXp2CI4yvu6b/mBxzZ1gnHm9AFSM0+skoJtvZqxWfOFIj+bAhU9FsrTJEFX2MVilRcPMvkMm+Nlp8z7uQ7KNpuON4RJyN3s1YBPZcUmHshzSkqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpIVsV9h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpIVsV9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4B9C2BCAF;
	Tue, 28 Apr 2026 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777390376;
	bh=unlpE5t+tYHvEF17ZobLkXJsuXBcIp9ybMmKHB5e1K4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kpIVsV9h4Cj8FhffBtRvaAyTRhdwiQrzFJvvHnKf41uDlzULkkRWLWsCL60+jLrXy
	 DtIyLpLgMnPTuOUpzvSHxepOpUs37qiuIh9WrB4tAkZrmSd92AN4MBiLR9DI+6SwBv
	 kdWxrQmIGL6Ql4Sjz70v1OPk2+vsljarNKIkpO5ANcqTd4mYFqXNC6m5ksJdDFXWL3
	 Fy8nvPRp7RBwZZVOyfgCTrbpmr4YovVArqYhdp1LXfSu4uyvvS3rTxeK7R7L0YYpfc
	 5InwLQiG3sVpuZp4BkHgGNltDBLHcEX4mDqsnX/mgZGmW5dklcPjv888h2Pg5/Dsgk
	 BUrHStETUfECg==
Date: Tue, 28 Apr 2026 16:32:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: magnetometer: rm3100: Use guard(mutex)() in
 rm3100_trigger_handler()
Message-ID: <20260428163247.4511aa5b@jic23-huawei>
In-Reply-To: <20260428124644.49707-5-m32285159@gmail.com>
References: <20260428124644.49707-1-m32285159@gmail.com>
	<20260428124644.49707-5-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 07:46:44 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Replace mutex_lock() and mutex_unlock() calls in
> rm3100_trigger_handler() with the more modern guard(mutex)(). This will
> help modernize the driver and bring it up-to-date with modern available
> macros/functions.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>   v2:
>  - Switched out scoped_guard() for guard(mutex)().
>  - Because of the replacement of scoped_guard(), fixed an error due to
>    gotos bypassing __attribute__((cleanup)).

Read the guidance in cleanup.h  It's pretty clear that nothing from
that file should ever be used in functions that use gotos.

Whilst there might not be a bug here, it ends up being fragile
as people changing the code may not noticed that can't use an existing
label and hence jump the hidden __free() in that guard() call.

The cleanest way to use guard() here is to factor out the code under the guard.
Don't increase the scope as the final stuff in here is not trivial.

There is even an outside chance of deadlock if you hold a local lock
when calling iio_trigger_notify_done() as that can call back into the driver.
Here you are ok because no trigger_ops are set so there isn't a reenable()
callback. 

Be careful to ensure any expanded scope only contains calls where you can
easily see they don't deadlock or do anything time consuming.

Jonathan



> 
>  drivers/iio/magnetometer/rm3100-core.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> index eb59ea8d5bf5..fdee82c1290f 100644
> --- a/drivers/iio/magnetometer/rm3100-core.c
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -459,11 +459,11 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>  	struct regmap *regmap = data->regmap;
>  	int ret, i, bit;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
> +
>  	switch (scan_mask) {
>  	case BIT(0) | BIT(1) | BIT(2):
>  		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
> -		mutex_unlock(&data->lock);
>  		if (ret < 0)
>  			goto done;
>  		/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for paddings. */
> @@ -472,21 +472,18 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>  		break;
>  	case BIT(0) | BIT(1):
>  		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
> -		mutex_unlock(&data->lock);
>  		if (ret < 0)
>  			goto done;
>  		memmove(data->buffer + 4, data->buffer + 3, 3);
>  		break;
>  	case BIT(1) | BIT(2):
>  		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
> -		mutex_unlock(&data->lock);
>  		if (ret < 0)
>  			goto done;
>  		memmove(data->buffer + 4, data->buffer + 3, 3);
>  		break;
>  	case BIT(0) | BIT(2):
>  		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
> -		mutex_unlock(&data->lock);
>  		if (ret < 0)
>  			goto done;
>  		memmove(data->buffer + 4, data->buffer + 6, 3);
> @@ -495,12 +492,9 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>  		for_each_set_bit(bit, &scan_mask, mask_len) {
>  			ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * bit,
>  					       data->buffer, 3);
> -			if (ret < 0) {
> -				mutex_unlock(&data->lock);
> +			if (ret < 0)
>  				goto done;
> -			}
>  		}
> -		mutex_unlock(&data->lock);
>  	}
>  	/*
>  	 * Always using the same buffer so that we wouldn't need to set the

