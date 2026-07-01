Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF22C11CA;
	Wed,  1 Jul 2026 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941616; cv=none; b=Kw1a93Xz7MYgWGG6j5oWUiszTXKKmm0Q+25Anx9v/4+GvhK1vQ9GEE+2zmn20sLwa6Yn6NGIfGkYbSu3IozzA9gE+Xk9jhPeDLax1wzkC145Hm0EvGieTBut2HgR1DSEIGURbYoY5Z8G+67NvpUIcvoIPn8Tt9aLDBg4+QEF/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941616; c=relaxed/simple;
	bh=XXJ46VMM4ojcfZM2EfuKuGPU1NOZD8Fb+uNz64t/kXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIUA2Mw+o4GKigUWIi9BeWkqBQoVuFPwvo/+I2bBT5VcV+wGV3NT53Ce0OlzYDjRKJSqhU08xrhhRIgRZbmAw1UDWwSQqHWEiH5HAm1fhhPQ2+2jQn4JGpIYQ/2tkXnO3nvsSxvexNk4IVfTHr2/lu9Snlpy7Y/fa17Y4OZWayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP1qASDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP1qASDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3BE1F000E9;
	Wed,  1 Jul 2026 21:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782941614;
	bh=YhF2ySsf0NG2TOkuiNLJ1kuY64H1XQSmuEF/4/iReW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MP1qASDPwxKcLmc5AKBiyL8Sw0HwnjRGiMCCe6slgh01Jd8bM7g6XsCunUnJzgLte
	 g8M0dW3mgTqfjCYoY6Tg+9JV+SoGXMtCwZbIVnbmxR6S7RiNNjZC2Zg+aFnrUAoTzy
	 hehs7rHeUVYMxOuaDS4JhHQ3qpyKg8Js6AZdmpge5SQddNVl1YtfUsb0/YxXGyrxq9
	 LubfptD1vZNa6RVVu1YtklZ6v+E+qrvV+AJfaGhBJzgqhTJMLCfYGGSOxppgyBCPEa
	 NjfOdvFuNTtKhpxG0LZmRsjZl/RuruPvT0DLxrkup5/kHZWeOR9zM++D//KT5ocpo5
	 rpTMyOXLLzedg==
Date: Wed, 1 Jul 2026 22:33:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Remi Buisson <remi.buisson@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm45600: Use I2C match data
Message-ID: <20260701223331.6ff4489a@jic23-huawei>
In-Reply-To: <20260624053823.73969-1-pengpeng@iscas.ac.cn>
References: <20260624053823.73969-1-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 13:38:23 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> The I2C driver provides chip_info through both the OF match table and
> the I2C id table, but probe reads it with device_get_match_data().  That
> misses id-table driver_data for non-firmware I2C matches and can reject
> a supported device with -ENODEV.
> 
> Use i2c_get_match_data() so the id-table chip_info is used when firmware
> match data is not present.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Applied to the testing branch of iio.git.  

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
> index 5ebc18121a11..c65e5501eee7 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
> @@ -23,7 +23,7 @@ static int inv_icm45600_probe(struct i2c_client *client)
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
>  		return -ENODEV;
>  
> -	chip_info = device_get_match_data(&client->dev);
> +	chip_info = i2c_get_match_data(client);
>  	if (!chip_info)
>  		return -ENODEV;
>  

