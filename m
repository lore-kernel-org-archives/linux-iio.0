Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3821257F;
	Wed,  1 Jul 2026 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934253; cv=none; b=BAyFIt3EBbRMiBxcC+9X1V3l5lp3/Sy5DDTBX6E2sitAwbXKu3NC2n+Ps9NnwzFHdHfnkCl75iqzvUT2v9YqgXHyL1ugId4BOTSBho3Kn9wBoUvmZKB6tgD/4hMWm4rNjEni8bh0xDOwF7cCDi2vYUHs6Ge/YrcRwwb+yiNr6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934253; c=relaxed/simple;
	bh=DW4u9yRFWFDliEd5f3+mGyd6JXE3Pf2rihmN7TFfnjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaZGvVzzQlZOaVSVbO8xvBv3XRY930idL1FBFrP7Q0qJTPu9o7ohNHMn/orLHNZFbzDzeHa2dxST2KlGSuj/8IoAGc/YBDVYvnbVahWZYslkHOhqL1AOHHzpN2UD6ELzZs2tcouqmvXRGBO8Q1FMLryL2DCVIXpoF1+ugXNijLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDXstdqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDXstdqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6301F000E9;
	Wed,  1 Jul 2026 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934252;
	bh=49Ev+AvYEXQm7m2aWe9UIopqJbwwyFhR6TxukdScasE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lDXstdqnZDyC1hhzkNH+hgMfRDedy5LnO7I+ZVptfrStXwUkWI3I58BbyIS9BR3/R
	 k0MBkFNhgNgOVrdPSGcz6DL92kYJh5Goj37vpqe4hpq0YDo9sPETsemhd4qPxa6KFe
	 5ddwQUVVdRM+z/wKF9jIqw0ypPDwwdfQh9D79gknETTjMZZAKKhIrtqiVB3taVqsqr
	 f6NWTV5qO6hRkffVyqqwc3kB2+neq6FgL4TC8VzzgN3B55cN3XVcBLqLPtFexCCLPo
	 pkJA0bD7cP/LFeoriuQLg+hu01v6Y5ZxW2ZBolHXmy6omjLFKuqqc2DYc1mz4nMEz1
	 PC9H9kheb1t0Q==
Date: Wed, 1 Jul 2026 20:30:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V15 8/9] iio: imu: inv_icm42607: Add Temp Support in
 icm42607
Message-ID: <20260701203044.2b60632c@jic23-huawei>
In-Reply-To: <20260626161230.93069-9-macroalpha82@gmail.com>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
	<20260626161230.93069-9-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 11:12:29 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add functions for reading temperature sensor data.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
The earlier comments on read_avail are really about a change need in this patch.

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> index c7215b3826ad..4e5db5e19e9f 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c

>  
>  static const int inv_icm42607_gyro_scale_nano[][2] = {
> @@ -182,6 +185,11 @@ static int inv_icm42607_gyro_read_raw(struct iio_dev *indio_dev,
>  	switch (chan->type) {
>  	case IIO_ANGL_VEL:
>  		break;
> +	case IIO_TEMP:

This works for read_raw, but the read_avail reported on earlier patches is
still an issue for temperature channels.

> +		if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> +			return inv_icm42607_temp_read_raw(indio_dev, chan,
> +							  val, val2, mask);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
