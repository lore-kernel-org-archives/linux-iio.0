Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0E440636;
	Fri, 21 Aug 2026 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787270970; cv=none; b=jenuJnoIFYecT4SDe4C4e3Op/FBLNLW9ipfLlOTuDPeJoRXvdnMtRQTeTpueJt/vhH1d0hIO1VEQFD1oOT/mItwqjFRkpyNTzjRVQ+g5G9R36VIlmB6jzJyDUl1wjAJCuIgZXwjpUtalHdZe2K07AWTD0a9X8/a629EvwJCcYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787270970; c=relaxed/simple;
	bh=vK60J/jziQElcbBXiwCN+c3ap1tALbuYh0DB7J7ysHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1Z6jwjM0FGdcj8VOXhX2MVYIkjDyx7ByMCEO8o32gDI9HVBxCc4gWGwiWTDOwcnWBYJLT+eWQ/fjvrQlZQ0eqXD4YGTQTlihwkw+o5eZr4OimLI/PhUmXKub4naug4ICa0s0AkL9rCIB0mUWwmc+zbLEqSW7+MOjxA+q4DYDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPHuhye0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPHuhye0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7341F000E9;
	Fri, 21 Aug 2026 00:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787270968;
	bh=e2AUyFYN9srhTzO9HLmr2odY1w5rWZSgTCPisc4weRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RPHuhye0QXdQ85G+4I+kIJ8wAb6ernRFVjojyP+BA3dhUNv9SPpMFbfOMosI+iGPm
	 8FQtDGULuyoHRHK86eYyG9IH4XYgWzWtUTSjcI3hNNRKoPHNGCqvCVdtQLBbd+zf5Y
	 SrvULnh1qn7gm5ySsYTY8d1ku2ggpVqztdbLDXH5gzd7q7au8ZVrG6N9J1cE5ceJmo
	 dWmA2EEZhq7XTiKhL3dJpPLd2I8dzaK72MYGsjshfS/8WWCZ8xceQTCj9jdqhTYaKI
	 RfUSBaNCJOAtUk7wW5PayxlO2wVqMVgMV8LpVIldp5mXqymL1wSGAqhqPIeq76NuIS
	 wBGxAi0RItbUw==
Date: Fri, 21 Aug 2026 01:09:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 2/4] iio: imu: inv_icm42600: use 2 sensors fixed packet
 size of 16 bytes
Message-ID: <20260821010924.3761225d@jic23-huawei>
In-Reply-To: <20260820-inv-icm42600-enhacements-v1-2-075a881db557@tdk.com>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
	<20260820-inv-icm42600-enhacements-v1-2-075a881db557@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 21:02:38 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Sometimes dynamic switch between 1 sensor frame to 2 sensors frame is
> not working when there are too much frames already in the FIFO. By
> moving accel/gyro on sleep before turning FIFO on, we are storing many
> FIFO frames before updating the frame format hitting the bug everytime.
> 
> Fix that by always using the 2 sensors frame of 16 bytes. Also update
> the hwfifo max watermark reported.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

So from that description this sometimes happens without the reorder?
If so is it appropriate to give this a Fixes tag?

> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 998d312f7bde..043ae9deee65 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -131,13 +131,13 @@ int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,
>  		INV_ICM42600_FIFO_CONFIG1_GYRO_EN |
>  		INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
>  
> -	val = 0;
> -	if (fifo_en & INV_ICM42600_SENSOR_GYRO)
> -		val |= INV_ICM42600_FIFO_CONFIG1_GYRO_EN;
> -	if (fifo_en & INV_ICM42600_SENSOR_ACCEL)
> -		val |= INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
> -	if (fifo_en & INV_ICM42600_SENSOR_TEMP)
> -		val |= INV_ICM42600_FIFO_CONFIG1_TEMP_EN;
> +	/* always enable/disable all bits for allowing dynamic transitions */

This needs a little more.  It makes sense in the context of
this patch but will seem rather odd if we look at it sometime in
the distant future.  Dynamic transitions of what?

> +	if (fifo_en)
> +		val = INV_ICM42600_FIFO_CONFIG1_TEMP_EN |
> +		      INV_ICM42600_FIFO_CONFIG1_GYRO_EN |
> +		      INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
> +	else
> +		val = 0;
>  
>  	ret = regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_CONFIG1, mask, val);
>  	if (ret)
> @@ -149,19 +149,6 @@ int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,
>  	return 0;
>  }
