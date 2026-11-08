Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167237;
	b=NHV59NP1kVSEVXbYSomzUVND1YCp1Qvr9c7NC6En7aiOklMVcQmbpfQf6jVGptheVJ+g
	 lDwRDN23zDFFW8q07lyS3PUR0Qaazk6shW1Ws57z3bS5WS4vuCQBZl+eTXQNxZheXT38x
	 ro2+IuseuPwcGI5tzKsEINFCPgbNKjT4zVKsXHfmGU7POnoqhUbPLeF8ppYrYuMSteiIR
	 MZGGNwRKp4gwMv2GlD7p4Vkg2sPBGlzisNY5nKljCjCUdj9EXyyPhLPJFRZQk5zoPbcEV
	 m0b9mRcCnBxBzxR72MmrYl2xWFEG0U8e3CvpZRQb+IgydkBAhxi+4O2ZxI/v/izGjUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167237;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Jiv0cmXFAXTUW8roPFUJZcsI0jEurSSfNVu7fTt2gw=;
	b=nGMcs0WN09yW+lo2odqXf5GMpsgmGAnIMe4cWyOGtap7ZA1BFr/zBbqWnUmJA0QO9Ppx
	 OEtHQIcpC2vYexzX2Pl+8XxMv7T7z1o1Cd9OAAvwgJRf8VC/4EjNmVqAL37DJDPrj3qk8
	 iIKk+Gam821MJUTz7B+kPA2SUQOWX1ByG55zLIApsQz9G4YQNL2hcTpq9eKHrtYMJ63E/
	 nhCTnooJ0kbZ+ScVy7uuHboyWEvtDHgBcLIe3k53neEe6DyCswa1vtLdVnCbcycG760Ye
	 AGylqFp419GTzOlbQ2li7WnZ+fQ5oDi6BBQ0pj1g9flo0Gy7b5iSk48m8ihr0Y5sS3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Mce/1wA6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A54606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mce/1wA6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4F51F0089F;
	Sun,  8 Nov 2026 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167236;
	bh=9Jiv0cmXFAXTUW8roPFUJZcsI0jEurSSfNVu7fTt2gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mce/1wA6YJsnKt/BD3HcLSRYl6EOsNI+nTd3vW6NnVWfYFa8/NVX8SHZPm1f5EKwS
	 o9/oHmXWnXIrb0/FkCr73+sb0bwTF3F7SAMaOTgwR55KGKV7fz5oxVL8i56Zxa1pTw
	 BIFz1G8bDP7aNOFrktr1dx1ddpJtfSv8siHI4sEsttMRhwTo7ZltmQqYcu6dr1BQP6
	 8b4V64ZupJNIhZ8diS8KCiXSUiX1D2RjNN2FXQZjaPwl4HZWUDuf3Kj5+SKBh4zXGL
	 DXnXIcLZHy8wB1sID8BG+qYe4hzv5OxSATjbCenNDA0UrQ8UuJa8xuGqFgH6zkNuEM
	 Z9L2+Kdq4zefg==
Date: Sun, 8 Nov 2026 19:47:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jean-Baptiste
 Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 16/39] iio: imu: inv_icm42600: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108194709.27824e42@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-16-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-16-8b136778eedf@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 16:05:34 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Applied.  This one is obviously fine as the buffer is right there on the
stack in both cases.

> ---
> Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 3 ++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index cc8c074777c9..d40300af9b3c 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -1250,7 +1250,8 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
>  		/* convert 8 bits FIFO temperature in high resolution format */
>  		buffer.temp = temp ? (*temp * 64) : 0;
>  		ts_val = inv_sensors_timestamp_pop(ts);
> -		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
> +		iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
> +					    ts_val);
>  	}
>  
>  	if (st->timestamp.accel_force_odr) {
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> index 4e20d61d897b..f895226f4a39 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> @@ -829,7 +829,8 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
>  		/* convert 8 bits FIFO temperature in high resolution format */
>  		buffer.temp = temp ? (*temp * 64) : 0;
>  		ts_val = inv_sensors_timestamp_pop(ts);
> -		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
> +		iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
> +					    ts_val);
>  	}
>  
>  	return 0;
> 

