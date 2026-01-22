Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759E2773C1;
	Thu, 22 Jan 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112487; cv=none; b=LbGN9vf0ar3eLI1liVudbCeE2Nq2I9IgCAjjsBORe5fJIKhUHKY4Zt7Vnz6/H6mHLXNHIzEyd58Xj63HH4+ksa3FvDCmeVYXVa5H7DLwnmh/IZ6DHcHhH6uGc0RFUeZ/8HiUcNo7A0NxikfgWO+k3Grqj87Mej94lBh+DXSP7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112487; c=relaxed/simple;
	bh=TtKasqEsGC6r5n+cW78XJcd4NBmmsVN619CA3gbsI0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWv9Y0TKklXTzQooRj93++7ZUcmnr/vVA2MRHJGS2fek3lWqkRggQ9Zax3vZF+pjJSyiGCUm4UxTG4Uz/VlxVRmS+p0smB1izVZZ4Ppn+CJ9QA/x5qQEU/ni7BpYwmvHpOuxusyZcaKW6rFlGTcLcJHVodut9LUEmFHWixGG42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbz0cdi0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbz0cdi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49939C116D0;
	Thu, 22 Jan 2026 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769112485;
	bh=TtKasqEsGC6r5n+cW78XJcd4NBmmsVN619CA3gbsI0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tbz0cdi0NBlYZgwKB3ntHo0Y5PrBvoomqOLOJubyujUVn12f0mcbCuGvm8MZF65m0
	 R788rfUlCoQHz7FbNRMOFedxPfyR5n2JxL49uoIW56GxkJuKuCybXDlSy0MMK5PUx0
	 xZMnD+sJb4CHXgtDBbajatNwFnZWSQwHbK7ulyXfJaXXN6UtsODg0Y6lWteABGktVD
	 9niWOuJy8N+50ipeEeE8gfsI+rE8BcvyWB1hYf/OviLoxjc5ivruTZIfkSFghYeyty
	 SwLN2yaoQsMonuAqtporqgF10YLvir9CV9+HkA1UIlbNiU0kK5kOgCgk+dzf8PDhxD
	 iS7ojSKzpIFRQ==
Date: Thu, 22 Jan 2026 20:07:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <20260122200757.47863f0f@jic23-huawei>
In-Reply-To: <20260122162335.2020006-4-flavra@baylibre.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
	<20260122162335.2020006-4-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 17:23:34 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> accelerometer invalid samples (i.e. samples that have been acquired during
> the settling time of sensor filters) with the special values 0x7FFFh,
> 0x7FFE, and 0x7FFD.
> The driver checks FIFO samples against these special values in order to
> discard invalid samples; however, it does the check regardless of the type
> of samples being processed, whereas this feature is specific to gyroscope
> and accelerometer data. This could cause valid samples to be discarded.
> 
> Fix the above check so that it takes into account the type of samples being
> processed. In st_lsm6dsx_push_tagged_data(), change the type of the data
> parameter to __le16 *, to reflect the fact that this function is called
> with an aligned data argument and avoid casting to __le16 * when checking
> sample values.
Hi Francesco,

I'm going to guess Andy meant all the way up rather than pushing the cast
upwards.  I think this can be done in a fashion that cleans up the type
representation in general.
> 
> Fixes: 960506ed2c69 ("iio: imu: st_lsm6dsx: enable drdy-mask if available")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>


> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 5b28a3ffcc3d..ded9a96076e6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -539,14 +539,14 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  #define ST_LSM6DSX_INVALID_SAMPLE	0x7ffd
>  static int
>  st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> -			    u8 *data, s64 ts)
> +			    __le16 *data, s64 ts)
>  {
> -	s16 val = le16_to_cpu(*(__le16 *)data);
>  	struct st_lsm6dsx_sensor *sensor;
>  	struct iio_dev *iio_dev;
>  
>  	/* invalid sample during bootstrap phase */
> -	if (val >= ST_LSM6DSX_INVALID_SAMPLE)
> +	if ((tag == ST_LSM6DSX_GYRO_TAG || tag == ST_LSM6DSX_ACC_TAG) &&
> +	    (s16)le16_to_cpup(data) >= ST_LSM6DSX_INVALID_SAMPLE)
>  		return -EINVAL;
>  
>  	/*
> @@ -670,7 +670,8 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
>  					reset_ts = true;
>  				ts *= hw->ts_gain;
>  			} else {
> -				st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
> +				st_lsm6dsx_push_tagged_data(hw, tag,
> +							    (__le16 *)iio_buff,

This is ugly but at least it's near the declaration so improvement on previous.

However, I smell a cleaner solution.  If I read the buffer definition correctly
it could be replaced with

struct {
	__le16 data[3];
	aligned_s64 timestamp;
} iio_buff = { };

//note the zeroing because the code never writes the hole which is
bad...  Also that the { } is guaranteed to fill the hole with the build options
the kernel uses (there is a selftest for this).


Which will let you pass iio_buf->data to this call.


>  							    ts);
>  			}
>  		}

