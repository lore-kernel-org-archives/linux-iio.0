Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664E175A7E;
	Sat, 28 Feb 2026 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301390; cv=none; b=UQsQiG4PagMR2z+ja62Rvso21UTO09mV7nHOeXoWjn1CBIiX6IIlMca6+AhqGTAX0A35YJ1Tos0QzZvlwLE+i55Z13f9hQvrxOORS8BhphnoC8xavrkhxLDIs1v9hUyFRPQ4RNuzyFiFbLYA2i3GDQ2o20qWLUlKW886HGVn1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301390; c=relaxed/simple;
	bh=Sn2gZWLJT/bVt5udMjKiiltAZMWqkM8n6O3SYM03JmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmSs9PUm/XUpramQz7GTkR4FPdkQYDvt/AiaKqO1gt9yPuj5Oma3v89d4asg+dxqQtqgIYd+3bgRCnzlavDkPUyTrcxNvclJTsz7ZbTiYkWUye+VebqWq+owBOZ7Kp+FMPoXEUcO6iIcugnPJAQstVUihWFs/M3nMndWooHD+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WypsYAZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WypsYAZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B01C19424;
	Sat, 28 Feb 2026 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301390;
	bh=Sn2gZWLJT/bVt5udMjKiiltAZMWqkM8n6O3SYM03JmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WypsYAZABhxmOUc58NvkUG0kTiDVvHVv1VVTB3Q6IdGxr0soYRBrtXG/uIJaKdIVw
	 k2FtXtJlZK/3nNzVr8McZYos/X8NTgE6vTbleV5IBuQ2a6jpjE7lxQCCfhMFiFZ06C
	 GIt4uZ+Iq7irzn2huao9VZUb4hILEs971LBiJkUtX9Jw5ku7/yQRFRaEPGZirLVKa/
	 m0MB71yS3O+ySU8JOh9/cS4jRufjRQvsOPBqJXFE+oBA3mbrYgJSUfZAvfxHjmLOA0
	 85GrSjwn/c2WjdEMxZMl7gv8V//tZxOlJMjVzvdw8Y2Pky+si914LZQf81WkINI7OD
	 Jlt59nVlyZKCg==
Date: Sat, 28 Feb 2026 17:56:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] iio: imu: st_lsm6dsx: Set buffer sampling
 frequency for accelerometer only
Message-ID: <20260228175621.4973f2f7@jic23-huawei>
In-Reply-To: <20260225101632.2368093-1-flavra@baylibre.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
	<20260225101632.2368093-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 11:16:32 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
> writes the buffer sampling frequency sysfs attribute, calls
> st_lsm6dsx_check_odr(), which accesses the odr_table array at index
> `sensor->id`; since this array is only 2 entries long, an access for any
> sensor type other than accelerometer or gyroscope is an out-of-bounds
> access.
> 
> The motivation for being able to set a buffer frequency different from the
> sensor sampling frequency is to support use cases that need accurate event
> detection (which requires a high sampling frequency) while retrieving
> sensor data at low frequency. Since all the supported event types are
> generated from acceleration data only, do not create the buffer sampling
> frequency attribute for sensor types other than the accelerometer.
> 
> Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
It feels like we may need a little longer to converge on the rest of
the series, and I don't want to risk delaying the fixes further.

A such I've picked up patches 1 and 2 on the fixes-togreg branch of iio.git
Please just assume they are available for v7 and drop them from what you post.

This may mean we have to wait for these to be available in a suitable upstream
tree before I can pick up the rest. We have plenty of cycle left and
the fixes are really piling up in my tree, so that shouldn't be a problem.

Jonathan


> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 1ee2fc5f5f1f..5b28a3ffcc3d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -862,12 +862,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  	int i, ret;
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +		const struct iio_dev_attr **attrs;
> +
>  		if (!hw->iio_devs[i])
>  			continue;
>  
> +		/*
> +		 * For the accelerometer, allow setting FIFO sampling frequency
> +		 * values different from the sensor sampling frequency, which
> +		 * may be needed to keep FIFO data rate low while sampling
> +		 * acceleration data at high rates for accurate event detection.
> +		 */
> +		attrs = i == ST_LSM6DSX_ID_ACC ? st_lsm6dsx_buffer_attrs : NULL;
>  		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
>  						      &st_lsm6dsx_buffer_ops,
> -						      st_lsm6dsx_buffer_attrs);
> +						      attrs);
>  		if (ret)
>  			return ret;
>  	}

