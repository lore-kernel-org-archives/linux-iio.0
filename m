Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362F3C062A;
	Tue, 28 Apr 2026 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392344; cv=none; b=AJygYyy012nbFJY5ZqGDYyV/anhHSe++/qmSQxNSvwzSQEuk7PD3unUtSIpAFnus+u0Om+TxrLDl1eukd1o8AehcfLHTTxKspr/sgWTyXXO/RFy2a0eb7U69R4A29gjPrk549fQI+EKC5MbIW1HYib4ura/ktOUp4kvI9i5vWp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392344; c=relaxed/simple;
	bh=aDiqUWg2tNtCxK8PIEmg/LVRvDixdA1QpjxPlTvIa8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rChkGJft/5gx1poRPSO8QgrgTce25CGM0uDRKJWXEIsNvdoNeK8wNpoKL/MXQGl43sI4kGhR1jqcxZzZzVL18sO37CG++yoMkiXU/VuGj7S2jIpVBSjP0VFAu0g7zG828XBsxHZtC68LbUYKkWHwaGJyJlwolu9Zqc+PB6kMbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG39TPN3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG39TPN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E23C2BCAF;
	Tue, 28 Apr 2026 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392343;
	bh=aDiqUWg2tNtCxK8PIEmg/LVRvDixdA1QpjxPlTvIa8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FG39TPN3HYbEA239pB5jRuIszNmRSgZWH3yKdj8uhg7wJNGqil7zS7c0pCDELVQLj
	 eB3rMei8Bn+au4uMEi7KOKxJU2r/w5GRRVZfJc6LPH6vIDgnGgUnVYYxmMmv3Dt2mT
	 GYg6ssWKyl0mxi+N1BDkFBSfjQciiCjRMSaQ7+/HLb1cAug905ebFhhcmw5gZ0zO8O
	 xn8ySzcbef+8Du9XbXn6kwZNrPR33jcWvUNP/cdGlEhAS7zHOgwYM3PtbXrXa/ed6H
	 Y9N49wkDgDt8bFe5UOutps1l+sgMHul5kD0FomYxOy9KTEiOHzL5Ae3yZmw9mLogDB
	 SIID/ocrcJp9A==
Date: Tue, 28 Apr 2026 17:05:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Crt Mori <cmo@melexis.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mlx90614: fix missing GPIO direction return value
 checks
Message-ID: <20260428170533.308c6b91@jic23-huawei>
In-Reply-To: <20260427215800.28082-1-salah.triki@gmail.com>
References: <20260427215800.28082-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 22:58:00 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> The functions gpiod_direction_output() and gpiod_direction_input() can
> fail, but their return values were previously ignored.
> 
> If an error occurs during the GPIO configuration, the function should
> abort the wake-up sequence and return the error code. More importantly,
> failing to check these values could lead to the I2C bus remaining
> locked if an error occurs after i2c_lock_bus() is called.
> 
> Add return value checks and ensure the I2C bus is properly unlocked
> via a goto label in case of failure.
> 
> Fixes: eb4b07dae4d4 ("iio: mlx90614: Add power management")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/temperature/mlx90614.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 1ad21b73e1b4..ce12b44c84e0 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -489,6 +489,7 @@ static int mlx90614_sleep(struct mlx90614_data *data)
>  static int mlx90614_wakeup(struct mlx90614_data *data)
>  {
>  	const struct mlx_chip_info *chip_info = data->chip_info;
> +	int ret;
>  
>  	if (!data->wakeup_gpio) {
>  		dev_dbg(&data->client->dev, "Wake-up disabled");
> @@ -498,9 +499,17 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
>  	dev_dbg(&data->client->dev, "Requesting wake-up");
>  
>  	i2c_lock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
> -	gpiod_direction_output(data->wakeup_gpio, 0);
> +
> +	ret = gpiod_direction_output(data->wakeup_gpio, 0);
> +	if (ret)
> +		goto out_unlock;
> +
>  	msleep(chip_info->wakeup_delay_ms);
> -	gpiod_direction_input(data->wakeup_gpio);
If this did go forwards, I'd prefer the section under the lock moved
into a helper function so that we can do

	ret = helper();
	i2c_unlock_bus();
	if (ret)
		return ret;

Rather than introducing a goto for a section of code in the middle of
the function that isn't appropriate if we were to later introduce some
error path after this.


> +
> +	ret = gpiod_direction_input(data->wakeup_gpio);
> +	if (ret)
> +		goto out_unlock;
> +
>  	i2c_unlock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
>  
>  	data->ready_timestamp = jiffies +
> @@ -515,6 +524,10 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
>  	i2c_smbus_read_word_data(data->client, chip_info->op_eeprom_config1);
>  
>  	return 0;
> +
> +out_unlock:
> +	i2c_unlock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
> +	return ret;
>  }
>  
>  /* Return wake-up GPIO or NULL if sleep functionality should be disabled. */

