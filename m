Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698944062B;
	Fri, 21 Aug 2026 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787270789; cv=none; b=HyxQ2ZDpLm76b3tq2vGG0CCN601zfEw+gjVT73IC3gJZj6b5diCIxglmuMEnUMl1JofmRixIPEv5ydWjCGG1gaTdsGUl0vWVT3/Ayi5RE6ro6tVHuOeSj3BOsP14hBgTISnGnwMMoAuAT7H3ucDgSPl5xU1m/3uEE7wSFHqUYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787270789; c=relaxed/simple;
	bh=YnlhTSFyYHcCqtPjd/35y8FbUJ8Djd+PYgzPIAgv3Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bN8whEtpFXFVn2bys2UXC+DTmk1DP3yDxFHZE+d/uxEfcChEY4oMRmsLLkha5XFZGQBAKy6opolk5iFn0ApiNvj8khJd4VoSJld2YvuSvau/lDwrH/HUyirbA4xRgBpDeYLmvdyZiwW9cOVWyiEaR7GY+z5fJ9HoXj8mLn5moQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcCGlX+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcCGlX+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8A71F00A3A;
	Fri, 21 Aug 2026 00:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787270787;
	bh=LIUqtJyV4B8vbIS2jMhc5C1Gzc2NSa9MU06Wj2d1H2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XcCGlX+RKFlAVXqsvX8wnMza5j7G//17cLsib8LLcOOOj5xVMsf+qPy4tdXvF//nm
	 u5PEN30FVOqpQ7mljXOfeofDCWlnYkpWFVMISgqjG4ax9ALQQjPiXThkmLtTPKeb/w
	 AQgsBPzVBJOOQai2zoDLphM7Fo3MI90e58KTmauPbCmsQ1aGIkK2sCpZiSYWM4ihKP
	 +uPlcXuJOXNdwNrknf/AVRnEwRo8CetBXI9eOG0dkL9FXbouWdQOcjwp7YjV4M8Jgx
	 7QDyvJOlKkYbTSW6+3aXIZdVWc0vWHn0UKaGpxuQLcOm49HB0DQjZ/UZbtZBYJWz5b
	 0md4Qwb5gWpYg==
Date: Fri, 21 Aug 2026 01:06:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 1/4] iio: imu: inv_icm42600: sleep before enabling FIFO
 data
Message-ID: <20260821010623.4d064f8c@jic23-huawei>
In-Reply-To: <20260820-inv-icm42600-enhacements-v1-1-075a881db557@tdk.com>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
	<20260820-inv-icm42600-enhacements-v1-1-075a881db557@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 21:02:37 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When turning accel or gyro on, a sleep is required for letting the
> mechanical part stabilize before reporting correct data. Do the sleep
> before enabling FIFO data to prevent push of incorrect data. This is
> required if the FIFO is already on because a sensor is already running.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

I would like a note in here on why the lock dance is
useful. What sort of actions will be waiting on that lock and
make sense in the interval?

Other than that looks fine to me and does indeed seem logical to 
do this before the fifo starts

Jonathan


> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 12 ++++++++----
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 12 ++++++++----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 4b0e3cd8a506..d889c1dceec1 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -254,15 +254,19 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
>  		fifo_en |= INV_ICM42600_SENSOR_ACCEL;
>  	}
>  
> +	/* sleep maximum required time */
> +	sleep = max(sleep_accel, sleep_temp);
> +	if (sleep) {
> +		mutex_unlock(&st->lock);
> +		msleep(sleep);
> +		mutex_lock(&st->lock);
> +	}
> +
>  	/* update data FIFO write */
>  	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
>  
>  out_unlock:
>  	mutex_unlock(&st->lock);
> -	/* sleep maximum required time */
> -	sleep = max(sleep_accel, sleep_temp);
> -	if (sleep)
> -		msleep(sleep);
>  	return ret;
>  }
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> index 253bf571439d..34037b9c1f82 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> @@ -126,15 +126,19 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
>  		fifo_en |= INV_ICM42600_SENSOR_GYRO;
>  	}
>  
> +	/* sleep maximum required time */
> +	sleep = max(sleep_gyro, sleep_temp);
> +	if (sleep) {
> +		mutex_unlock(&st->lock);
> +		msleep(sleep);
> +		mutex_lock(&st->lock);
> +	}
> +
>  	/* update data FIFO write */
>  	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
>  
>  out_unlock:
>  	mutex_unlock(&st->lock);
> -	/* sleep maximum required time */
> -	sleep = max(sleep_gyro, sleep_temp);
> -	if (sleep)
> -		msleep(sleep);
>  	return ret;
>  }
>  
> 

