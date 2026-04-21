Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A43D904F
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782287; cv=none; b=Dbv88FGajsqEiiSGKWMAbEhwmVuaqA03MrwOWmDr5rgfhT9KVO+/eIsmkz2EGjD7rLDta9sBRai4k+uAib9uP0FAqoJM/3FGJJXPrgPFjljuaqeEmYVH7MSrqNxG0OwZzVO5c9KVJA4o0e3yRsfNsn9pczlj7icj5tN3PDqAYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782287; c=relaxed/simple;
	bh=LwzB1RpcdhydPdoiQBUfDxnOm/+WgF4/emr+VXwhb6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYQfYX+l3ZJM6P7sZXxRvHAkW0ZcIwc8bxiCvnul75XmKynQjTqI50Vx/xpA8dCtK1KY+YhiFUAswkIN9Nve0MHCHlp/I9PWkqVucTBPqU+JymKkof8u2+9hbSshqVIK3SbxHbpVk2L0J/AfauMqZSntffLXpHa5+vWmbMnStFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfIIRQ8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfIIRQ8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BE3C2BCB0;
	Tue, 21 Apr 2026 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776782287;
	bh=LwzB1RpcdhydPdoiQBUfDxnOm/+WgF4/emr+VXwhb6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dfIIRQ8RAN+48PpjFQivytgEUM2A/0X4T1cf+8VpyRfa3uycLXT4p4J8B8UYWevan
	 ihv7HNKWxr9leaiJqrOG1g5ZhnyTo1CurxcYlsEhScydCMJnPGlbHKGL9l2OhWmYyF
	 eAg3EGPkPxDi9i6xKcBgIt6XgOMZv/j2ptMxAz3peY7MsTAYjebHa+q1ummPtm7UxO
	 e05ongBBl8imdLg0pq5MfoYdS8279T9BoqG3+kKHedaTeZQpe1DnddJ3IfsPA/7EPN
	 fsmV6g4OC5E6CJ4EF7p71hu00+Zboy4qyeWcXEMzVLabSUOTr8HiEmpyI3y35cbmUU
	 88J2onI//H8jA==
Date: Tue, 21 Apr 2026 15:38:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Luiz Mugnaini <luizmugnaini@usp.br>
Cc: cmo@melexis.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: mlx90614: use guard(mutex) for
 EEPROM access locking
Message-ID: <20260421153802.7a5426d5@jic23-huawei>
In-Reply-To: <20260420141512.196932-1-luizmugnaini@usp.br>
References: <20260420141512.196932-1-luizmugnaini@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 11:14:29 -0300
Luiz Mugnaini <luizmugnaini@usp.br> wrote:

> From: Luiz Mugnaini <luizmugnaini@usp.br>
> 
> Replace mutex_lock()/mutex_unlock() pairs with guard() and
> scoped_guard() from cleanup.h for cleaner and safer mutex handling. The
> lock protects EEPROM access across five call sites in
> mlx90614_read_raw(), mlx90614_write_raw(), and mlx90614_sleep().
> 
> In all cases, the code between mutex_unlock() and the end of scope is
> either a return statement, or a call to mlx90614_power_put() followed by
> trivial computation. In the later cases we prefer the use of
> scoped_guard() to avoid holding the lock longer than needed.
> 
> Signed-off-by: Luiz Mugnaini <luizmugnaini@usp.br>
Hi Luiz,

Thanks for the patch.

This one is very marginal benefit.

I'm all in favour of guard() usage when it simplifies things a fair bit
because we can have returns where previously goto magic was needed.
When it's just 
mutex_lock();
// oneline
mutex_unlock();

To me the churn is just not worthwhile - these really short lock
regions are not a cause of bugs.

The power management in this particular driver is what makes this
a bad idea.

So sorry, but I won't be picking this one up

Jonathan



> ---
> Changes in v2:
> - Prefer using scoped_guard() instead of guard() for cases where we
>   don't immediately return. This avoids adding more code to the critical
>   section and preserves the same semantics as the previous mutex_lock()
>   and mutex_unlock() pairs.
> - Removed the intermediate variable ret from mlx_90614_sleep() as
>   suggested.
> 
>  drivers/iio/temperature/mlx90614.c | 37 ++++++++++++++----------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 1ad21b73e..6c58375de 100644
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
> @@ -139,6 +140,7 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
>  	return ret;
>  }
>  
> +
>  /*
>   * Find the IIR value inside iir_values array and return its position
>   * which is equivalent to the bit value in sensor register
> @@ -296,10 +298,10 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		mutex_lock(&data->lock);
> -		ret = i2c_smbus_read_word_data(data->client,
> -					       chip_info->op_eeprom_emissivity);
> -		mutex_unlock(&data->lock);
> +		scoped_guard(mutex, &data->lock)
> +			ret = i2c_smbus_read_word_data(data->client,
> +					chip_info->op_eeprom_emissivity);
> +
>  		mlx90614_power_put(data);
>  
>  		if (ret < 0)
> @@ -319,10 +321,10 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		mutex_lock(&data->lock);
> -		ret = i2c_smbus_read_word_data(data->client,
> -					       chip_info->op_eeprom_config1);
> -		mutex_unlock(&data->lock);
> +		scoped_guard(mutex, &data->lock)
> +			ret = i2c_smbus_read_word_data(data->client,
> +					chip_info->op_eeprom_config1);
> +
>  		mlx90614_power_put(data);
>  
>  		if (ret < 0)
> @@ -358,10 +360,10 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		mutex_lock(&data->lock);
> -		ret = mlx90614_write_word(data->client,
> +		scoped_guard(mutex, &data->lock)
> +			ret = mlx90614_write_word(data->client,
>  					  chip_info->op_eeprom_emissivity, val);
> -		mutex_unlock(&data->lock);
> +
>  		mlx90614_power_put(data);
>  
>  		return ret;
> @@ -373,10 +375,9 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		mutex_lock(&data->lock);
> -		ret = mlx90614_iir_search(data->client,
> +		scoped_guard(mutex, &data->lock)
> +			ret = mlx90614_iir_search(data->client,
>  					  val * 100 + val2 / 10000);
> -		mutex_unlock(&data->lock);
>  		mlx90614_power_put(data);
>  
>  		return ret;
> @@ -467,7 +468,6 @@ static const struct iio_info mlx90614_info = {
>  static int mlx90614_sleep(struct mlx90614_data *data)
>  {
>  	const struct mlx_chip_info *chip_info = data->chip_info;
> -	s32 ret;
>  
>  	if (!data->wakeup_gpio) {
>  		dev_dbg(&data->client->dev, "Sleep disabled");
> @@ -476,14 +476,11 @@ static int mlx90614_sleep(struct mlx90614_data *data)
>  
>  	dev_dbg(&data->client->dev, "Requesting sleep");
>  
> -	mutex_lock(&data->lock);
> -	ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
> +	guard(mutex)(&data->lock);
> +	return i2c_smbus_xfer(data->client->adapter, data->client->addr,
>  			     data->client->flags | I2C_CLIENT_PEC,
>  			     I2C_SMBUS_WRITE, chip_info->op_sleep,
>  			     I2C_SMBUS_BYTE, NULL);
> -	mutex_unlock(&data->lock);
> -
> -	return ret;
>  }
>  
>  static int mlx90614_wakeup(struct mlx90614_data *data)

