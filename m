Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2544B048C;
	Mon, 17 Aug 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933217; cv=none; b=TExHPosvOEwrYIb1xIp4ibsRVVdnK2099H/PY3FbHdDWcLx8BP4XQH9WUnJRUv7CHMPUSBYBVR7gqfL1wOQ1ORvILbxzCh7R+kbReQ6RZYhYgIEiM+dQ/q9IlGxoVPqCZSUeG+/i38Iq/hmN6fW3pClaav2uxDUGpMqpipMWxOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933217; c=relaxed/simple;
	bh=ksGuJ1o7t7A4b0AWijejAbExiSI6qpSYjNY4w44BdTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lt5xP00iE1EHNi5HZ+oKAT/ptHmFzTDYHS+Ay8A7P8GBbSiTdLOIjrADUSoRg8+kREV3CQeBLS0V87tAbDB/BKzvEouZYQSTnvTCGUnBrfUeyeejHytDUx0zbc8Mb3h7+YguvwIDL3EqncrVAgw5HKKrvfh50fGI/K5/PY/w6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmevl5oL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmevl5oL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4121F000E9;
	Mon, 17 Aug 2026 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786933216;
	bh=Jq6+wkM9G8GNCg847YPoWEIKRWnY0MsoJEGSZLgj/qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cmevl5oLzamrM4ZQNdrPAgWaspI4V/tpUn3q03jLeopeEYkB1jgkXnHJ0cNQAHfCv
	 /qiLHUzFcpjC2HCg1clVgoY/+gFz5IEPcrMi8vcGB0ZCMqzzc/Cuik7oNppD9rMMne
	 Kphhv/zxD8cayIDcDhvxZP+3nn8U2+hi9tCwUu8EHiPX9+pLXgel+L+bT1r9R8dYHe
	 OFf4Jcp+SPL8fVYutB/TNTxPmdqHdv7gMZYSkh0J0xAbLFFmDizO9BhvKwArrCMS5y
	 gaHb2EHJv+r34uBf2JLfcyf/anXvTn0mUusMlpmLKRQSy+gq+Gt9iXzOGlCIMuoNlm
	 SRJBwALDFVQ+Q==
Date: Mon, 17 Aug 2026 03:20:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: imu: inv_icm42600: sort device id tables
 numerically
Message-ID: <20260817032012.779c01af@jic23-huawei>
In-Reply-To: <20260810191157.125550-2-jorijnvdgraaf@catcrafts.net>
References: <20260810191157.125550-1-jorijnvdgraaf@catcrafts.net>
	<20260810191157.125550-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 21:11:55 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> The I2C, SPI and OF device id tables list the parts in the chip enum's
> declaration order, which is neither numeric nor alphabetical. Sort the
> entries numerically by part number so new entries have an unambiguous
> position.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/all/20260724012505.02029e51@jic23-huawei/
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

Looks good. I used to pick this sort of thing up ahead of series
but I'm not sure we've figured out how to let Sashiko know that
is the case yet. So I'll leave this for when the reset of the
series is ready to go.

Thanks for tidying this up.

Jonathan

> ---
> No changes in v4.
> 
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 16 ++++++++--------
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 16 ++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> index 28552d2db91d..e44ed6dcde02 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -77,10 +77,10 @@ static const struct i2c_device_id inv_icm42600_id[] = {
>  	{ .name = "icm42600", .driver_data = INV_CHIP_ICM42600 },
>  	{ .name = "icm42602", .driver_data = INV_CHIP_ICM42602 },
>  	{ .name = "icm42605", .driver_data = INV_CHIP_ICM42605 },
> -	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
>  	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
> -	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
>  	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
> +	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
> +	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
> @@ -95,18 +95,18 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
>  	}, {
>  		.compatible = "invensense,icm42605",
>  		.data = (void *)INV_CHIP_ICM42605,
> -	}, {
> -		.compatible = "invensense,icm42686",
> -		.data = (void *)INV_CHIP_ICM42686,
>  	}, {
>  		.compatible = "invensense,icm42622",
>  		.data = (void *)INV_CHIP_ICM42622,
> -	}, {
> -		.compatible = "invensense,icm42688",
> -		.data = (void *)INV_CHIP_ICM42688,
>  	}, {
>  		.compatible = "invensense,icm42631",
>  		.data = (void *)INV_CHIP_ICM42631,
> +	}, {
> +		.compatible = "invensense,icm42686",
> +		.data = (void *)INV_CHIP_ICM42686,
> +	}, {
> +		.compatible = "invensense,icm42688",
> +		.data = (void *)INV_CHIP_ICM42688,
>  	},
>  	{ }
>  };
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> index faf743bc6444..3e2f4eb42e97 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> @@ -74,10 +74,10 @@ static const struct spi_device_id inv_icm42600_id[] = {
>  	{ .name = "icm42600", .driver_data = INV_CHIP_ICM42600 },
>  	{ .name = "icm42602", .driver_data = INV_CHIP_ICM42602 },
>  	{ .name = "icm42605", .driver_data = INV_CHIP_ICM42605 },
> -	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
>  	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
> -	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
>  	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
> +	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
> +	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
> @@ -92,18 +92,18 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
>  	}, {
>  		.compatible = "invensense,icm42605",
>  		.data = (void *)INV_CHIP_ICM42605,
> -	}, {
> -		.compatible = "invensense,icm42686",
> -		.data = (void *)INV_CHIP_ICM42686,
>  	}, {
>  		.compatible = "invensense,icm42622",
>  		.data = (void *)INV_CHIP_ICM42622,
> -	}, {
> -		.compatible = "invensense,icm42688",
> -		.data = (void *)INV_CHIP_ICM42688,
>  	}, {
>  		.compatible = "invensense,icm42631",
>  		.data = (void *)INV_CHIP_ICM42631,
> +	}, {
> +		.compatible = "invensense,icm42686",
> +		.data = (void *)INV_CHIP_ICM42686,
> +	}, {
> +		.compatible = "invensense,icm42688",
> +		.data = (void *)INV_CHIP_ICM42688,
>  	},
>  	{ }
>  };

