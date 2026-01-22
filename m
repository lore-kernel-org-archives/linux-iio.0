Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B35B3A2ACE;
	Thu, 22 Jan 2026 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113792; cv=none; b=IqXmdtjmHEMGiVZNFaqyJnCVbTdp307i2PBmlbpGR56DVdTOHM91+WAb6o0Ea/pC3CHnxQ7dNZmxRHdi1zDVglV3OiyOo7El628KIz+puK8HP1nZ/mvG1hV8Of62Lh9te9N8LaQATI9R00WYVcQaPJsmkzD0VwWpG4+K99nKpWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113792; c=relaxed/simple;
	bh=0QNHQyeTEB0ZXVpGKfC7zABvWuzIkD5vq2tQBWG2FFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fINFFipjLQcj8XIdczfL0RTML5vvSNugBBKscgdyJRXYsn1U4oP0LTFxDMY4dh1i9zQ0/cENT1aVjDOsv9HnkVqryOUpI4CtPhRLf7NveUj+dKs01MykMctfQxs+MTOTGmb4E5zrlhvTUeCtP4anxnwh8vJVbhF39GK8gG+0INU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMPnbMaL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMPnbMaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4C4C116C6;
	Thu, 22 Jan 2026 20:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769113790;
	bh=0QNHQyeTEB0ZXVpGKfC7zABvWuzIkD5vq2tQBWG2FFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bMPnbMaL3eHM1KsqH+KPJsXYxMjNXO8iNMNoXYexEyDJLqrxcMF/g8JjmMSRkjKol
	 JvOSUrz388rILa07QpdYuFPROA6IYA4b5d31RD1ihBffwdfO0Cj1R30nyxOHvOHchU
	 69ORGDM8FN3IYJ0hNB4cllRh7bZnRh7XzYWKv9HaXuUrZIIlzKRd77pJewhbx4SRNm
	 Gy5LkUgMTFJ6hKZ3uv2ZXFP4m1vh3W/wuzUFLStBkJr8ND6FWhZXRstwyETk5GULuH
	 YxfHtUFvclBVjlvBIjNRJ90ed3AYwlA9QsPRT+yLp1p63USPUlG/r04W2dNUe50SLX
	 N4LrrCGXUzBvA==
Date: Thu, 22 Jan 2026 20:29:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <20260122202943.344e7311@jic23-huawei>
In-Reply-To: <20260122162335.2020006-5-flavra@baylibre.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
	<20260122162335.2020006-5-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 17:23:35 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> Some IMU chips in the LSM6DSX family have sensor fusion features that
> combine data from the accelerometer and gyroscope. One of these features
> generates rotation vector data and makes it available in the hardware
> FIFO as a quaternion (more specifically, the X, Y and Z components of the
> quaternion vector, expressed as 16-bit half-precision floating-point
> numbers).
> 
> Add support for a new sensor instance that allows receiving sensor fusion
> data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> chip-specific details for the sensor fusion functionality), and adding this
> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> logic to initialize an additional IIO device if this struct is populated
> for the hardware type being probed.
> Note: a new IIO device is being defined (as opposed to adding channels to
> an existing device) because the rate at which sensor fusion data is
> generated may not match the data rate from any of the existing devices.
> 
> Tested on LSMDSV16X.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index ded9a96076e6..3b4fa57bf461 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c

> @@ -580,6 +584,16 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
>  	case ST_LSM6DSX_EXT2_TAG:
>  		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
>  		break;
> +	case ST_LSM6DSX_ROT_TAG:
> +		/*
> +		 * The sensor reports only the {X, Y, Z} elements of the
> +		 * quaternion vector; set the W value to 0 (it can be derived
> +		 * from the {X, Y, Z} values due to the property that the vector
> +		 * is normalized).

I'd missed this before.  This is going to really confuse user space.
I don't think we can just return it with a 0 in that last entry.
At the very least we need an ABI doc update to reflect this oddity.

I don't think that is enough though. This isn't a quaternion, but
rather something we can derive one from. Annoying though it is,
we can't realistically fix it up in kernel, so we are probably talking
a new MOD_TYPE.

Also it's been a long time since I did much with quaternions,
but isn't the sign of w ambiguous if we are relying on only X, Y and Z?
A bit of googling + AI suggests flipping it inverts the direction of
rotation around a given axis. Feels like there is a constraint missing
in this description.

Jonathan
