Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9003D3D11;
	Sun, 20 Sep 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789929162; cv=none; b=irc0ZK5c8AH70hY11EjqhQFog27H3zNV0mFNzlJkeLoL4b0QiisI3cNRIx20fdDgMAwyQq2SMwtEbL4usI5zFCQveTjmuBxwH3JTKvAbbRjj9ebsjtGf9vvG26Z9X7qBaMPkQcGcDzWkn6yW+hRnzztsaNHKXiDXQE6S8qTXw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789929162; c=relaxed/simple;
	bh=5qSTGmNGAhOZ8zMtxSTRknPMcWB6mtjje8RoB0c6T/U=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QxyxJlcxIWwICXfOG4LEJALttAYVhMECYDY2favdEKCEK0jdMtJsNBP7uI0+L5eEZ7yqxwDM5VyIy4uaeEDjCXLRp21UFZuAUhDYMApJbTiAlpkOx56FA9VyBsyDM42PV6AX2nmJ2cPn9SoC1Y5+WMF1nNz9SIF8OI2WL6VZ774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUL+3WDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUL+3WDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E441F000FF;
	Sun, 20 Sep 2026 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789929160;
	bh=iWJ8Hhou1ZIvrEnQGdMkTN/d+QCJmY4lUSyRAENmm8k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=kUL+3WDBuG9cogTHGfJFbka7fSZyjrI5nQHe8Yw9dc9b2MpW+KTyN5QCr4NUXD8Vp
	 VgrsZ9NlCpjeEnFL/vg5/6OCwnaVSy/Mx/YFZdMfmkTTcjG85lzPArDM9ryj6Z/aNu
	 H49n+m4+Y7/8DjAjlfZxhRkGhdTOMp+k5ECqGjTCE1bFbvzUEP8fBCOZ8npysfOhac
	 mkQyOudnqFSIKplFsxRX13m7uZsD1f8k+qjhyeqH+aN63FKaUdIBBUTam/BexwrrHh
	 CVIK0f7Lc+pJ21nvQQC2cZ7kk3z6DErOdyGjqzoMGHA5LI+qpsVwZdn7eRE52wFcHu
	 xp0U9Hfu2pXEQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 07/10] iio: pressure: dps310: read buffered samples
 from the hardware FIFO
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>, 
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, 
 Justin Stitt <justinstitt@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260918122517.377565-8-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
 <20260918122517.377565-8-zoone.rupert@gmail.com>
Date: Sun, 20 Sep 2026 19:32:13 +0100
Message-Id: <178992913316.706584.7705975324672941059.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=5qSTGmNGAhOZ8zMtxSTRknPMcWB6mtjje8RoB0c6T/U=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsCauJe6fDPhdJxdZGkmfZcIDDQcr9QJGJizM4
 bN4TTryEaOJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarAmrhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiMh7D/4314Hb5QkeQ+xzSsAbzcvTbh9cpCnLYyAIzs7EBpp/DM6
 HHIR1EO4JpSanxPgLsruvh3C3sZe9L/VQS2CP9OFgk0c12udmtfHBoJQ0bi8WfEL7/EbpZumhjg
 P/TyoVNnMQjvQnkuaGdSJ3gEExrf0gkyaZKhRRZWar9GU1W2MlVwSj9wRlAZMG8xrbFIVWY1sE+
 mMFUDtGTgZOczDa/FSKR3gZcrJQSbPf6A81gowxYJCzahhxHcAmpfrg9qUTgZSQ36/SdGuIGmjO
 b4w9ylcd5dsV/HyIx2W+O3wZG2RMaxszh6jV9D62DxnmY5xDkPZH3OM4/4T9t53Ufp0CFQ6Gcnl
 XWc5nss7XRjcpJIaTBF/Q2UppA2ZPieqVqzSOnqKwsxXIR6s3oYPfSvFuZtYjTfQG+IHvONt2sU
 7rCEPQNdt2edqFmx98/UOikb6amTkcE+996pMU4UooPngakwRX75ADDo4R4QsZVZB043FHGXutw
 aya4nzpR7kcMUNdQnhoeUdUvnbUgiodLne+Yw+m5sQ+pDxB+8duIZSpqgOaGK4v1MAlOJ/gwX4T
 82FqF4tcWVXtTkmZV5zgmI1px9+xRCbIXRMYr6v9rG2BRKdoYBxvUxhsp//e8HRs/bTXCWgtw07
 NPaeQd2rsonWsxFuyrrudmL0oHcuXChpB4Y1QpA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> The DPS310 has a 32-entry FIFO shared by both measurements. Drain it from
> a work item and push what it held, so a buffered capture needs no
> trigger. Nothing in tree wires the interrupt pin, so the work rearms
> itself at half the time the FIFO takes to fill.
> 
> Entries carry one measurement each, so a pressure entry is compensated
> with the temperature ahead of it. Pressure read before the first
> temperature of a session is held until one arrives rather than dropped,
> so the first push can wait a temperature period.
> 
> FIFO entries are not timestamped, so postenable refuses the timestamp
> channel unless a trigger is attached.
> 
> Tested on a DPS310 on a BeagleBone Black.
> 
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Looking good.  Just a few small things.

Jonathan

>
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index dd816d47bbec..e63ea7873e5b 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c



>  enum dps310_scan_index {
>  	DPS310_SCAN_TEMP,
>  	DPS310_SCAN_PRESSURE,
> +	DPS310_SCAN_TIMESTAMP,
>  };
>  
>  static const struct iio_chan_spec dps310_channels[] = {
> @@ -140,7 +168,7 @@ static const struct iio_chan_spec dps310_channels[] = {
>  			.endianness = IIO_CPU,
>  		},
>  	},
> -	IIO_CHAN_SOFT_TIMESTAMP(2),
> +	IIO_CHAN_SOFT_TIMESTAMP(DPS310_SCAN_TIMESTAMP),

Why not in previous patch?

>  };


> +/* Pressure seen before any temperature, kept until one turns up */
> +static void dps310_fifo_hold(struct dps310_data *data, s32 pressure_raw)
> +	__must_hold(&data->lock)
> +{
> +	if (data->fifo_held < data->fifo_hold_max)
> +		data->fifo_hold[data->fifo_held++] = pressure_raw;
> +}
> +
> +/* Returns scans pushed */
> +static int dps310_fifo_push_held(struct dps310_data *data)
> +	__must_hold(&data->lock)
> +{
> +	unsigned int i, held = data->fifo_held;

As below, I'd separate those two declartions onto different lines.

> +	int rc = 0;
> +
> +	for (i = 0; i < held; i++) {
> +		rc = dps310_fifo_push_scan(data, data->fifo_temp_raw,
> +					   data->fifo_hold[i]);
> +		if (rc)
> +			break;
> +	}
> +
> +	/* What did not go out stays for the next drain */
> +	data->fifo_held = held - i;
> +	memmove(data->fifo_hold, &data->fifo_hold[i],
> +		data->fifo_held * sizeof(*data->fifo_hold));
> +
> +	return rc ? rc : i;
> +}
> +
> +/*
> + * Read the batch out before compensating it, so a pressure entry pairs with
> + * the temperature preceding it rather than the last one in the batch.
> + *
> + * Returns scans pushed.
> + */
> +static int dps310_fifo_drain(struct dps310_data *data)
> +	__must_hold(&data->lock)
> +{
> +	bool pressure_enabled = test_bit(DPS310_SCAN_PRESSURE,
> +					 data->iio->active_scan_mask);
> +	u8 kind[DPS310_FIFO_DEPTH];
> +	s32 raw[DPS310_FIFO_DEPTH];
> +	unsigned int i, n = 0, pushed = 0;

Please use separate lines for declerations with assignment and
those without.

> +	int rc;
> +
> +	for (i = 0; i < DPS310_FIFO_DEPTH; i++) {
> +		rc = dps310_fifo_read_entry(data, &raw[n]);
> +		if (rc < 0)
> +			return rc;
> +
> +		if (rc == DPS310_FIFO_EMPTY)
> +			break;
> +
> +		kind[n++] = rc;

Given n is used in a couple of places, I'd keep the handling simple
by doing it as
	for (i = 0, n = 0; i < DPS310_FIFO_DEPTH; i++, n++)

That makes it visisble that it is a loop variable rather than
one tha is only sometime incremented.

Maybe rename it to something like cnt to make it more obvious
what it is.

> +	}
> +
> +	for (i = 0; i < n; i++) {
> +		if (kind[i] == DPS310_FIFO_TEMP) {
> +			data->fifo_temp_raw = raw[i];
> +			data->fifo_temp_valid = true;
> +
> +			if (!pressure_enabled) {
> +				rc = dps310_fifo_push_scan(data, raw[i], 0);
> +				if (rc)
> +					return rc;
> +
> +				pushed++;
> +				continue;
> +			}
> +
> +			rc = dps310_fifo_push_held(data);
> +			if (rc < 0)
> +				return rc;
> +
> +			pushed += rc;
> +			continue;
> +		}
> +
> +		if (!pressure_enabled)
> +			continue;
> +
> +		if (!data->fifo_temp_valid) {
> +			dps310_fifo_hold(data, raw[i]);
> +			continue;
> +		}
> +
> +		rc = dps310_fifo_push_scan(data, data->fifo_temp_raw, raw[i]);
> +		if (rc)
> +			return rc;
> +
> +		pushed++;
> +	}
> +
> +	return pushed;
> +}
> +

> +
> +static void dps310_fifo_hold_free(struct dps310_data *data)
> +	__must_hold(&data->lock)
> +{
> +	kfree(data->fifo_hold);
> +	data->fifo_hold = NULL;

Why clear fifo_hold?  Nothing ever checks if it is NULL.

> +	data->fifo_hold_max = 0;

Similar for this.  If you are checking it you are in a path
where we are assuming the fifo is valid. I'd hope the
code is structured so that isn't the case.

> +}
> +
Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
