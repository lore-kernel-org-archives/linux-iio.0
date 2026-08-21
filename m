Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EDD305666;
	Fri, 21 Aug 2026 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272096; cv=none; b=uhGjQl9WrQJLCe5HyK5XvJ5YWqJmGBKjeGd+/iztYzLn/HhVPY1YUF+QqIgh6WMmyZMnkJFPSqmPrxzLmnOa46AAAymckgk1LzL8p6JkE9wsYtoe4p9QacqYbSmUXKFAkmUl+wukxV6Ohay2+8cJI8jmiJQwTeZjxDT7cwzw4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272096; c=relaxed/simple;
	bh=Bp2Dygoh09lG+e6gu4BXy+hjPBxOj7TlEjCEvRhsF0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffozXBn2TKzHOYXee26cYF5dd5KNyduG6EMIBLsMwO8eh3m51eJ2d1O/JClW5r3CvH3x1HD/4B62uvu9MKMv31FwvnV0GU1dQnHZwYvWtylsOjOvIbqXr6szN5ii2oB0eILKFKsKm5v21c0wYufzuBLPUiXTpmFWDDPmXXT6Jhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrUMCbh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrUMCbh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF501F000E9;
	Fri, 21 Aug 2026 00:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787272094;
	bh=ohPqfqgPUhDunJdjRMtvTTUeoD/o5bqzZUn5xXwkBN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SrUMCbh5NBpw3xAJSNUnVutb28suDLYQXlYQNJpNEJ5MRVILeRxHDiufUbmxyLHQF
	 RO7utJf8djPZi9uDT4XrOUbzkKWpUiPvvkZj8T6Z5iq1+GkaB6r2KL7X6uUsdxP5xZ
	 bDo09JR10tQP0yDKNfrb3EixkwTavva2UzggGkjedYGsGc3REU5/3c6goya2/sYjN9
	 UCGHGbX24xdRrteXn4k1mrN3/vQLdboKANyG3yUk/MfByxfZI9xgrvV4yBAsffoJa8
	 5glhwXqTnZDZXF5x3nwqhBSOhfnRBBMrG1PB/uxskX3aSEhErVym6rJh7PYZIe52KZ
	 bmwjHBl7//AWw==
Date: Fri, 21 Aug 2026 01:28:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 4/4] iio: imu: inv_icm42600: do not read FIFO count for
 watermark it
Message-ID: <20260821012809.169b0b8b@jic23-huawei>
In-Reply-To: <20260820-inv-icm42600-enhacements-v1-4-075a881db557@tdk.com>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
	<20260820-inv-icm42600-enhacements-v1-4-075a881db557@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 21:02:40 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Optimize data reading for high frequencies by not reading FIFO
> count in case of watermark interrupt. We already know there is
> watermark samples in the FIFO and we need to not read more than
> watermark samples for timestamping mechanism. Let's just read FIFO
> data directly without reading FIFO count in this case.

Just to check

Level interrupt?  Or one that will definitely get triggered again?

The thinking on reading as much as possible is that for some devices
we need to be very sure we drained them past the threshold or we
don't get a fresh interrupt.  So if the threshold is set low (say 1)
it could easily reach 2 before we get to handling the interrupt.
Races are nasty anyway with those devices anyway but reading as
much as possible helped.

Do you have data on it being worth skipping the read? If we are
at high frequencies I'd assume it is more useful to read more than
the minimum just to reduce how often we read the fifo at all.

Jonathan


> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 33 ++++++++++------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 1428f18408ce..1410096f6e6d 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -474,24 +474,21 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
>  	st->fifo.nb.accel = 0;
>  	st->fifo.nb.total = 0;
>  
> -	/* compute maximum FIFO read size (watermark for max = 0 interrupt case) */
> -	if (max == 0)
> -		max = st->fifo.watermark.value;
> -	max_count = max * INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
> -
> -	/* read FIFO count value */
> -	raw_fifo_count = (__be16 *)st->buffer;
> -	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT,
> -			       raw_fifo_count, sizeof(*raw_fifo_count));
> -	if (ret)
> -		return ret;
> -	st->fifo.count = be16_to_cpup(raw_fifo_count);
> -
> -	/* check and clamp FIFO count value */
> -	if (st->fifo.count == 0)
> -		return 0;
> -	if (st->fifo.count > max_count)
> -		st->fifo.count = max_count;
> +	/* read watermark samples for interrupt case (max = 0) or read FIFO count */
> +	if (max == 0) {
> +		st->fifo.count = st->fifo.watermark.value *
> +				 INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
> +	} else {
> +		raw_fifo_count = (__be16 *)st->buffer;
> +		ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT,
> +					raw_fifo_count, sizeof(*raw_fifo_count));
> +		if (ret)
> +			return ret;
> +		max_count = max * INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
> +		st->fifo.count = min(be16_to_cpup(raw_fifo_count), max_count);
> +		if (st->fifo.count == 0)
> +			return 0;
> +	}
>  
>  	/* read all FIFO data in internal buffer */
>  	ret = regmap_noinc_read(st->map, INV_ICM42600_REG_FIFO_DATA,
> 

