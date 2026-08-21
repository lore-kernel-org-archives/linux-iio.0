Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3021DDC35;
	Fri, 21 Aug 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271273; cv=none; b=r7CloDRjZosX+o3cJ2chX8CdlDiot5f0MSkEHKyLpifLLBVeiWEpdLniRnXn0jJZH9PpemquuiAoCvA50xw1W3sS9r0KxIJH3Gp6sBMxZB9v6+r5zCnn7kfk/HKyiV6GRaJNXCIM/9CrXs/iZQ2bo9JbFT5ye5o3VyUoA4CXcKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271273; c=relaxed/simple;
	bh=odZgfCoFg38S4dhLWFZ9oM4C6dNQRRubiqXHCtY+IEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIy0UchMNMwh8SR0CMXa/nr79AY/miu7M1e+5lvqxZOi7DAcl5MPY84CoCk0jkeE/pSxEZo05lU5vTvp+Qkr6EIoFAQhMw4QKXDeiY8J8mLO9DWk0I2B4bUOY1x/Gj1hHi58bIjrI3sX7VdNW4Pr3cxzs+1JLl5Mhpew3Dlpi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4rSTVPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4rSTVPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C692D1F000E9;
	Fri, 21 Aug 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787271272;
	bh=tB2XpZYHjiBxDQCxDTWNRCKVVuM1jgmAIj72kQ0F0q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G4rSTVPZXrYuBxGj71hQhKS+JH3AdPCZhL/Y9mOiAr6ych+ogknkdLRtyVQg5q5ny
	 kbSxtwljRmbRlw55APgKgtgPdh6EDx69MdUsgggDyHDPw0DKdYS9wMmLayKEGsfUpD
	 g60OufKzGsT7YEjGyYFuzm+S5bPpfJNXWDQVbtKG/tjYcJ8oEnMne3Ld/8Ez/64i20
	 Aok6AdictQqx1HA3NM1bEZnK8N31EzTI3deAPpEvHmLuNBGaxvxvzWSvElUCf4UWCn
	 6S8kT34JTKTXm7Wxoo+/TNJXDvfB7+a3DLduiiVpESeXoaxe1ShSvkp811u8G8F5m7
	 ZaxQX59lUMi2Q==
Date: Fri, 21 Aug 2026 01:14:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 3/4] iio: imu: inv_icm42600: simplify watermark
 computation by using gcd
Message-ID: <20260821011428.4a31cb7d@jic23-huawei>
In-Reply-To: <20260820-inv-icm42600-enhacements-v1-3-075a881db557@tdk.com>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
	<20260820-inv-icm42600-enhacements-v1-3-075a881db557@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 21:02:39 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> The watermark computation was in fact resulting in computing the gcd

Maybe GCD if we are referring to it by acronym rather than talking
about the function that implements it. 

> of the latencies when both sensors are on. Gcd is required because
> of the IIO buffer watermark. We need to use a divider of IIO buffer
> watermark, otherwise we will overflow the requested watermark.
> 
> Move to use gcd and update documentation accordingly.

gcd()
as this is about the function I think.

> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 47 ++++++++++------------
>  1 file changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 043ae9deee65..1428f18408ce 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/gcd.h>
>  #include <linux/kernel.h>
>  #include <linux/minmax.h>
>  #include <linux/mutex.h>
> @@ -172,15 +173,14 @@ static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,
>   *
>   * FIFO watermark threshold is computed based on the required watermark values
>   * set for gyro and accel sensors. Since watermark is all about acceptable data
> - * latency, use the smallest setting between the 2. It means choosing the
> - * smallest latency but this is not as simple as choosing the smallest watermark
> - * value. Latency depends on watermark and ODR. It requires several steps:
> - * 1) compute gyro and accel latencies and choose the smallest value.
> - * 2) adapt the chosen latency so that it is a multiple of both gyro and accel
> - *    ones. Otherwise it is possible that you don't meet a requirement. (for
> - *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
> - *    value of 4 will not meet accel latency requirement because 6 is not a
> - *    multiple of 4. You need to use the value 2.)
> + * latency, we should need to use the smallest latency value. But it is not as
> + * simple as choosing the smallest watermark value. Latency depends on watermark
> + * and ODR and IIO buffer watermark adds another requirement. The required steps:
> + * 1) compute gyro and accel periods and latencies
> + * 2) Use the smallest period and the gcd of the latencies. Gcd is required

GCD here as well.

> + *    because of the IIO buffer watermark that will prevent send of data if not
> + *    crossed. Thus accel and gyro watermarks must be a multiple of the watermark
> + *    value. Computing the gcd gives us the biggest value that meets this criteria.
>   * 3) Since all periods are multiple of each others, watermark is computed by
>   *    dividing this computed latency by the smallest period, which corresponds
>   *    to the FIFO frequency. Beware that this is only true because we are not
> @@ -190,7 +190,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
>  {
>  	size_t packet_size, wm_size;
>  	unsigned int wm_gyro, wm_accel, watermark;
> -	u32 period_gyro, period_accel;
> +	u32 period_gyro, period_accel, period;
>  	u32 latency_gyro, latency_accel, latency;
>  	bool restore;
>  	__le16 raw_wm;
> @@ -218,22 +218,17 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
>  		watermark = wm_gyro;
>  		st->fifo.watermark.eff_gyro = wm_gyro;
>  	} else {
> -		/* compute the smallest latency that is a multiple of both */
> -		if (latency_gyro <= latency_accel)
> -			latency = latency_gyro - (latency_accel % latency_gyro);
> -		else
> -			latency = latency_accel - (latency_gyro % latency_accel);
> -		/* all this works because periods are multiple of each others */
> -		watermark = latency / min(period_gyro, period_accel);
> -		if (watermark < 1)
> -			watermark = 1;
> -		/* update effective watermark */
> -		st->fifo.watermark.eff_gyro = latency / period_gyro;
> -		if (st->fifo.watermark.eff_gyro < 1)
> -			st->fifo.watermark.eff_gyro = 1;
> -		st->fifo.watermark.eff_accel = latency / period_accel;
> -		if (st->fifo.watermark.eff_accel < 1)
> -			st->fifo.watermark.eff_accel = 1;
> +		/*
> +		 * In case of both accel and gyro enabled, we need to use the
> +		 * shortest period and the gcd of the latencies. Gcd is required
> +		 * because of the IIO buffer watermark that will prevent data
> +		 * sending if we are not crossing the watermark level.
> +		 */
> +		period = min(period_gyro, period_accel);
> +		latency = gcd(latency_gyro, latency_accel);
> +		watermark = max(latency / period, 1);
> +		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
> +		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);
>  	}
>  
>  	/* compute watermark value in bytes */
> 

