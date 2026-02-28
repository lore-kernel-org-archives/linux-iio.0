Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6B35AC07;
	Sat, 28 Feb 2026 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302680; cv=none; b=OseZMd55H7sTJ/xeFJ7v7toBz2hMLdRcw05lXarjdzO4pGMkFFSkgxibtfJfhljAGD305aOI11H5BX/YN05VZS3PXQxKkqx6JPhsauo7hlQzw6C4IVBpABghUImgmaBvVqYjN1GLPzTXGVLFuBv+mikBP5Pp2sKIi3yAWSUsGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302680; c=relaxed/simple;
	bh=4Y9gB+iksEuzjGVJT+XbpcLPbg5XkqPZXSEUGAUI97w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0RfCeOLVLNCho4u8Q+TsaftPXrqaudFl/kFbSTUSqMnsqpHqklBqIpLclsr6YonVMJRSJ+2F+bnqw84W6fCi2kQ3Yt3BX5RwQ7jvCZDYjgMe3DXZ5v2AOytZBuKvKAqvZmZjGc9y3eJUkCP/IYqpvKHsHSod8NFvdRT/CuVxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAPsL1Fl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAPsL1Fl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F61C116D0;
	Sat, 28 Feb 2026 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772302680;
	bh=4Y9gB+iksEuzjGVJT+XbpcLPbg5XkqPZXSEUGAUI97w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aAPsL1FlZd1wc4o58jo/04qrKILd7h8A4KKS/KM0qKmayTqVajZwzmfqROAMgZhXw
	 XtvwtBD9xlPBlr0VdTMd3/EuKPLxTW9FXVCNFVCHDh6ChcE6J6DzGkNhNv5HRpxQUB
	 oCoAUUgAup47p0YbOdhxRixFYlA5SjyX8O6PPSa6k2LV8DQNlbaKow5uOiytRUUiRk
	 swv2tk1HtZOmS94esNYuq6jDqBHk7tqW9HoXR2AxirYVanDClJGzc8yOzra1z6h0lA
	 yLRMD+rIlqVLi2Gr3nV0hpnzbxSqg91f9yXN0ohAoTCKsOg2p6o+ufHi9lsjYyGqgY
	 s2dy2B69voWSw==
Date: Sat, 28 Feb 2026 18:17:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linusw@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: gyro: mpu3050: Move iio_device_register()
 to correct location
Message-ID: <20260228181752.05e08886@jic23-huawei>
In-Reply-To: <20260224224818.2452675-4-ethantidmore06@gmail.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
	<20260224224818.2452675-4-ethantidmore06@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 16:48:17 -0600
Ethan Tidmore <ethantidmore06@gmail.com> wrote:

> iio_device_register() should be at the end of the probe function to
> prevent race conditions.
Ah. I perhaps over stated this...
See below.

> 
> Place iio_device_register() at the end of the probe function and place
> iio_device_unregister() accordingly.
> 
> Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
> v3: 
> - Remove stray change.
> - Fix grammar with "the".
> v2:
> - Patch added to series.
> 
>  drivers/iio/gyro/mpu3050-core.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index b6e05afbe512..b590cf6709b4 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1218,12 +1218,6 @@ int mpu3050_common_probe(struct device *dev,
>  		goto err_power_down;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(dev, "device register failed\n");
> -		goto err_cleanup_buffer;
> -	}
> -
>  	dev_set_drvdata(dev, indio_dev);
>  
>  	/* Check if we have an assigned IRQ to use as trigger */
> @@ -1246,9 +1240,20 @@ int mpu3050_common_probe(struct device *dev,
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_put(dev);
>  
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(dev, "device register failed\n");
> +		goto err_iio_device_register;
> +	}
> +
>  	return 0;
>  
> -err_cleanup_buffer:
> +err_iio_device_register:
> +	pm_runtime_get_sync(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_disable(dev);
These are a rare thing that is fine either before or after iio_device_register()
as any races just result in elevated reference counts (which drop again when
the racing access finishes).

Having said that, the order you have here should be fine.

Jonathan


> +	if (irq)
> +		free_irq(mpu3050->irq, mpu3050->trig);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  err_power_down:
>  	mpu3050_power_down(mpu3050);
> @@ -1261,13 +1266,13 @@ void mpu3050_common_remove(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
>  
> +	iio_device_unregister(indio_dev);
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	if (mpu3050->irq)
>  		free_irq(mpu3050->irq, mpu3050->trig);
> -	iio_device_unregister(indio_dev);
>  	mpu3050_power_down(mpu3050);
>  }
>  

