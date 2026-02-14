Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D0218E91;
	Sat, 14 Feb 2026 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097561; cv=none; b=ajdJaGcVlwVThZzoDRXSfEPovg8xKtEmyHCUatlQyeIxM1FOZ8mEWZF8naf9v7y1xZlsp6KyxRoVJ7EpZ7B4+RaGFX8MM2fc+w2uahRkpXKOD/uVhNqXUtwEWqbB5mD39USrAbtOBJzphtVKTWF9RCREEc6SbEi8fK9HX6MyOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097561; c=relaxed/simple;
	bh=KJzLbCYltnc+ZG63YQJI1D72avDko0btnEVpPbd6f+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzYjZxJCHYxSwOKtjWb7470j302Ma1HF55yztddlu3wDF6YV2HPG19MyM1O8+BhaOrQfAE7kAOiAn3tZoQ0/NJ78HJQ09Ubqh+2rrmjPjNit6+I/J7NJiGGPyKCDvqd71jeD1pnjCqd/ZWfCRTrN6XkUF8B2mkDLNiRHb4M016M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwscN4j5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwscN4j5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F288EC16AAE;
	Sat, 14 Feb 2026 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771097560;
	bh=KJzLbCYltnc+ZG63YQJI1D72avDko0btnEVpPbd6f+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XwscN4j5zaqy0mabH1hO9yOM1QuXWREXJGnJ8/mGPtoo58TlRbtlFzqfne9JPlmh6
	 HxnCsHmxf0l/rQb5sRNypmA5JWihmjp8fwmq2QHmBMFch9wh0AM2XOpaMAFb87h2kp
	 gnQwUZRw4V81Irjk3ZU0FICUPsnw99cJ1Xu4VW6b9/WDmWLXnv7RctJ+F3p0w/AhDt
	 IGMHxKj1VC5pekYDwaw4rbsZ5aABQ6XXRg2FXJJWFihrZJp7zwlO+ORihYolQZb66q
	 +d+VJbR+eWSqWDEGgO8RdaXg/acyvOYWdjgYyyShbVp3ZzuEbFOUBigNxekMAiMUeP
	 C6YNSjFU9hfEw==
Date: Sat, 14 Feb 2026 19:32:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: magnetometer: si7210: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20260214193232.60ca4464@jic23-huawei>
In-Reply-To: <20260211081837.8169-2-antoniu.miclaus@analog.com>
References: <20260211081837.8169-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 10:18:28 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Simplify probe by using devm_regulator_get_enable_read_voltage() to
> get, enable and read the regulator voltage in a single call.
This needs to state that this is a functional change, but in real
deployments it is very rare for VDD to change after initial probe.

Note I once had a board where it did depending on driver
probe ordering as devices had slightly different requirements and
it was cut and paste from the driver I wrote for that which probably
led to so many drivers assuming it was dynamic.

Jonathan

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v2:
>  - use vdd_uV naming convention
>  - remove unnecessary div_s64() for 32-bit division
>  drivers/iio/magnetometer/si7210.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer/si7210.c
> index 27e3feba7a0f..8b98dd4dafa4 100644
> --- a/drivers/iio/magnetometer/si7210.c
> +++ b/drivers/iio/magnetometer/si7210.c
> @@ -128,13 +128,13 @@ static const struct regmap_config si7210_regmap_conf = {
>  struct si7210_data {
>  	struct regmap *regmap;
>  	struct i2c_client *client;
> -	struct regulator *vdd;
>  	struct mutex fetch_lock; /* lock for a single measurement fetch */
>  	s8 temp_offset;
>  	s8 temp_gain;
>  	s8 scale_20_a[A_REGS_COUNT];
>  	s8 scale_200_a[A_REGS_COUNT];
>  	u8 curr_scale;
> +	unsigned int vdd_uV;
>  };
>  
>  static const struct iio_chan_spec si7210_channels[] = {
> @@ -221,12 +221,8 @@ static int si7210_read_raw(struct iio_dev *indio_dev,
>  		temp *= (1 + (data->temp_gain / 2048));
>  		temp += (int)(MICRO / 16) * data->temp_offset;
>  
> -		ret = regulator_get_voltage(data->vdd);
> -		if (ret < 0)
> -			return ret;
> -
>  		/* temp -= 0.222 * VDD */
> -		temp -= 222 * div_s64(ret, MILLI);
> +		temp -= 222 * (data->vdd_uV / MILLI);
>  
>  		*val = div_s64(temp, MILLI);
>  
> @@ -396,14 +392,11 @@ static int si7210_probe(struct i2c_client *client)
>  		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
>  				     "failed to register regmap\n");
>  
> -	data->vdd = devm_regulator_get(&client->dev, "vdd");
> -	if (IS_ERR(data->vdd))
> -		return dev_err_probe(&client->dev, PTR_ERR(data->vdd),
> -				     "failed to get VDD regulator\n");
> -
> -	ret = regulator_enable(data->vdd);
> -	if (ret)
> -		return ret;
> +	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vdd");
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to get vdd regulator\n");
> +	data->vdd_uV = ret;
>  
>  	indio_dev->name = dev_name(&client->dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE;

