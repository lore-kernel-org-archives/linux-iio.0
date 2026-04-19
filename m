Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE33446DA
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776599027; cv=none; b=HAbSYXe5EQGvZ7FjapaYO1aGMjQB6cV4axooCjA42b/8bIvdqtc8QkML1n7/M83y5TugldgeipTc6y0obXidWjqpa4LYeG4yoZrPX6Cve981pHlsQ0FLZPhcNqfppGCkW2jh+LsThTCEaBQ+eYHWEDzYD9YXaI6ec0gal7xrTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776599027; c=relaxed/simple;
	bh=zOTxzwb3i2Ov70tGpkIZZurB0+0xuRuf+PUjCB8fw30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEVTCL5BiKhH6CXPeLelOfTc/5E1e4bR6Ac63cb4WmTzwBhygRkhakQ5qKeLaK+m+gRDHS7x/aojTRXnuHxWwd02p8wEYUcxgX/rSqEcgqhF82u+J3e3XimdA4tDhDLio65+748B8zG8va6otovXJqhe116DEmipC9oOBjRYB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6ktPYOS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6ktPYOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D1FC2BCAF;
	Sun, 19 Apr 2026 11:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776599027;
	bh=zOTxzwb3i2Ov70tGpkIZZurB0+0xuRuf+PUjCB8fw30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G6ktPYOSst1inuQH3NrVa/r3wZ/Yrt5dYC7vJznKoBOLe9cFScYRt91ZA/i6G9X+R
	 xoMCC+zac/cJgQd5HNWOVOIxMrmQYv1JcrESZDXcdyIDS/gpDbCn9BSmd8dfM2CpS9
	 9LnbgBPUU5n422/FVAssp47qb6Sr7tVviA2A4dUk8B4stt5Stj962y6btXo3d4XjgW
	 DXxAUDvUOS0ony0f55+z+VRrh3cUMhHdUEoFG+qEKZt9rHQquIIQoIZNdDUUwZcZ02
	 W81pHgJxikrB7ZmoKExAJLQcBYdXJXVK0NwDywhFYc2Viz6GJIFvyJx35j8VJbPyf4
	 2MflVD3ZNzs7A==
Date: Sun, 19 Apr 2026 12:43:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Luiz Mugnaini <luizmugnaini@usp.br>
Cc: cmo@melexis.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mlx90614: use guard(mutex) for EEPROM
 access locking
Message-ID: <20260419124341.465353af@jic23-huawei>
In-Reply-To: <20260418205151.172046-1-luizmugnaini@usp.br>
References: <20260418205151.172046-1-luizmugnaini@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 17:51:36 -0300
Luiz Mugnaini <luizmugnaini@usp.br> wrote:

> From: Luiz Mugnaini <luizmugnaini@usp.br>
> 
> Replace mutex_lock()/mutex_unlock() pairs with guard(mutex) from
> cleanup.h for cleaner and safer mutex handling. The lock protects
> EEPROM access across five call sites in mlx90614_read_raw(),
> mlx90614_write_raw(), and mlx90614_sleep().
> 
> In all cases, the code between mutex_unlock() and the end of scope
> is either trivial computation, a return statement, or a call to
> mlx90614_power_put() (which only schedules a deferred autosuspend
> via pm_runtime_put_autosuspend()). The slightly extended lock scope
> is negligible compared to the existing hold times, which include
> EEPROM write cycles with 40ms sleeps.
> 
> Signed-off-by: Luiz Mugnaini <luizmugnaini@usp.br>
Hi Luiz,

When making this sort of modernization change I'd suggest taking
a look at the feedback and final form of other similar patches.
Pretty much everyone gets the same feedback on these and you'd have
saved everyone time if you'd realized it applies here as well.

I'd also consider if having a locked reader helper might be
worth doing here as well

Something like

static xxx mlx90614_read_word_data_locked(xxxx)
{
	guard(mutex)(&data->lock);
	return i2c_smbus_read_word_data();
}
> ---
>  drivers/iio/temperature/mlx90614.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 1ad21b73e..adf100756 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -23,6 +23,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
> @@ -296,10 +297,9 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		mutex_lock(&data->lock);
> +		guard(mutex)(&data->lock);

What is the scope of this guard?  Hint, that gets 'interesting' when in a switch
case statement and there is a standard solution for that...

>  		ret = i2c_smbus_read_word_data(data->client,
>  					       chip_info->op_eeprom_emissivity);
> -		mutex_unlock(&data->lock);
>  		mlx90614_power_put(data);
>  
>  		if (ret < 0)
> @@ -319,10 +319,9 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		mutex_lock(&data->lock);
> +		guard(mutex)(&data->lock);
Same applies here and probably a load more cases below.

>  		ret = i2c_smbus_read_word_data(data->client,
>  					       chip_info->op_eeprom_config1);
> -		mutex_unlock(&data->lock);
>  		mlx90614_power_put(data);
It may make sense to take a closer look at whether we can use cleanup magic
to handle the power management as well though that would need more substantial
refactors so wouldn't belong in this patch.


>  
>  		if (ret < 0)
> @@ -358,10 +357,9 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		mutex_lock(&data->lock);
> +		guard(mutex)(&data->lock);
>  		ret = mlx90614_write_word(data->client,
>  					  chip_info->op_eeprom_emissivity, val);
> -		mutex_unlock(&data->lock);
>  		mlx90614_power_put(data);
>  
>  		return ret;
> @@ -373,10 +371,9 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		mutex_lock(&data->lock);
> +		guard(mutex)(&data->lock);
>  		ret = mlx90614_iir_search(data->client,
>  					  val * 100 + val2 / 10000);
> -		mutex_unlock(&data->lock);
>  		mlx90614_power_put(data);
>  
>  		return ret;
> @@ -476,12 +473,11 @@ static int mlx90614_sleep(struct mlx90614_data *data)
>  
>  	dev_dbg(&data->client->dev, "Requesting sleep");
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  	ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
>  			     data->client->flags | I2C_CLIENT_PEC,
>  			     I2C_SMBUS_WRITE, chip_info->op_sleep,
>  			     I2C_SMBUS_BYTE, NULL);
> -	mutex_unlock(&data->lock);
>  
>  	return ret;
	reutrn i2c_smbus_xfer();

>  }

