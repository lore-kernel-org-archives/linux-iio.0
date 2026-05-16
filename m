Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067D2BD030;
	Sat, 16 May 2026 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778928860; cv=none; b=QhfYWnwZUJKXBKsD0KNg30lX7bEA1hpCK/TWHIwklel/YmMlV1InUPH5Axti4/KrnzPjxUpQg2hfAfQ727yn5KirP2OAQSEwaiPfEYQCGsdcejF4YtX4kQxFW1y6Rs882qh4HNvrEOfv2QZAW93WSqPC2YAuxqbcEBgX0SJp+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778928860; c=relaxed/simple;
	bh=jMAeSSuWlWIqujpypaPE/kf/UfNekpv+m8476hvJzK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTtIlxSOeovcVJQAL2bsa7W2FDrELUicedYWD4LtYct0MCE2+jZy5kRhC12ftB1311PYdl+pe8QeMMFbYGaoWTCmRM7+jsHN5HSdZMQLTbuIV/5/0oRCEQR0rWuuqjWcWgGLM6WWos4ijzBbsFis0iHtsREq9TgLWGwlRpFtJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPxuvgRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPxuvgRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E56EC19425;
	Sat, 16 May 2026 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778928859;
	bh=jMAeSSuWlWIqujpypaPE/kf/UfNekpv+m8476hvJzK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aPxuvgRUMhc2OoLri6XZpYrpjHRK0c6IZUBdiep+qjQ6eW3gnHkTiLh5qYEgN3Dzk
	 0FjUdum4EeQdJ4MuqyEwg6bKZj7hSiaDYXejlmIWWztkju4+iH0LM+Ahka1NtLIbgm
	 1SOYxzrMlVPC2j7Cw6v5mPon8zx69zx3d4QtOiaEyriZoKAO8CE+FhmH8H5wFtMaU2
	 x5dCvcP8C4B3ZOH6hCK1BG5PTOZw7Sy9pJ0kaRfnq6z62eO51Ff/KH5GRMEpkZ+rB0
	 V5OJhWviSI0WX/H2hF7T23W0RBIyXSpYWLIXCQw4oiB9/HWtAIxT5VI3XWNCmB3F0U
	 xkUGMdZeinECA==
Date: Sat, 16 May 2026 11:54:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: vl53l0x: notify trigger and clear
 IRQ on error paths
Message-ID: <20260516115411.1e980a5c@jic23-huawei>
In-Reply-To: <20260514143711.23648-1-sozdayvek@gmail.com>
References: <20260514143711.23648-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 19:37:10 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> vl53l0x_trigger_handler() returns directly on the I2C read failure
> paths without calling iio_trigger_notify_done() or vl53l0x_clear_irq().
> 
> A single transient i2c_smbus_read_i2c_block_data() failure (negative
> errno or a short read) therefore leaves two pieces of state behind:
> 
>   - iio_trigger_notify_done() never decrements the trigger's use_count,
>     so iio_trigger_poll_nested() silently drops further dispatches
>     (see industrialio-trigger.c, the !atomic_read(&trig->use_count)
>     guard);
>   - vl53l0x_clear_irq() never writes SYSTEM_INTERRUPT_CLEAR, so the
>     chip keeps the DRDY interrupt asserted.
> 
> The sensor's buffer mode stays wedged from then on, recoverable only
> by re-binding the driver. The sibling driver vl53l1x-i2c.c handles
> exactly the same case correctly by jumping to a "notify_and_clear_irq"
> label that always calls both helpers; mirror that here.
> 
> The bogus negative-int return value cast to irqreturn_t also goes
> away as a side effect.
> 
> Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Applied and marked for stable, not so much because it wedges (as probably
won't recover anyway) but more to get rid of a negative error return in an
irq handler.


> ---
> v2:
> - Drop the cited error-path code from the commit body; the diff
>   already shows it (per Andy)
> 
>  drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index ad3e46d47..7acb94acc 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -87,15 +87,14 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
>  	ret = i2c_smbus_read_i2c_block_data(data->client,
>  					VL_REG_RESULT_RANGE_STATUS,
>  					sizeof(buffer), buffer);
> -	if (ret < 0)
> -		return ret;
> -	else if (ret != 12)
> -		return -EREMOTEIO;
> +	if (ret < 0 || ret != 12)
> +		goto done;
>  
>  	scan.chan = get_unaligned_be16(&buffer[10]);
>  	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
>  				    iio_get_time_ns(indio_dev));
>  
> +done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	vl53l0x_clear_irq(data);
>  

