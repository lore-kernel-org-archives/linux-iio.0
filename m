Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DCA3C5DB8
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787115553; cv=none; b=jOIHGbgtgvjDiqkOcA5c6zN9O1S6hv63Nju1cAbz3JpF/JTl8OtIR4I4fBNrTs9XgEPDOm1wVkzM9p9GSLzTIVkzE3y+yveq5mvE3UDJ1MgOWRDhqEAUVCQ6ZJXQBo9ADMNazg5F+MqMIIAf4jlo7XmmVDMIp6wyj5aCRUZi/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787115553; c=relaxed/simple;
	bh=n+Pb9matbU1dVcNGq+0pct/200e/2qf/ReNVDCFpisU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0s3G6ve8UEbNLWLjrNVB2OAC3aXuK8x7qYMGIAHkLXSypWsCCM/fRvuP3kOVeOpV2wcxx/Fngf2dKXc3P0vnYfbRPIJCq6yhPXvYUUUEO6qb3DxGUtEbSZJnL+mqjUsTbfh+KBkHzOCRgT21rMZST924Bb1fTLwVtX7iKKLL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz+raYE+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz+raYE+"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso670872e87.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 21:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787115549; x=1787720349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOaL/zRClOSJoPQivaJVBfwO66s06kLVbM+qFpnBbqg=;
        b=Kz+raYE+6RVqEjZvLrPcrxLSyzUCjhd/2/X4qGOXyodX/6uTE+icESnPfmJHn5VmQd
         QyO9idEf+iFLWxUVL9O6gs/et6tKY9y2FCzwFSPuNuPraKPi0DtUiIzbHu3aaTQ8mXqf
         pBdeOzJi4u4eDo28pg+n7TzjXt/ZRG/BAhBiFp3sKTnH0G25lYUOfeBDxNOOpETLtqQn
         gkI5O2wSP4R8Jozw8J/Ic/GnmnmO5rlhPcsKCJNtgcEmfj/HNwwirTeaBNG8iI9OERXA
         wh0knPZeAdMbGrbux29px6qpLjlT7wThX/eMoal5QXuewcZTTqLo9/2fISS8eqZnWx4q
         ndlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787115549; x=1787720349;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOaL/zRClOSJoPQivaJVBfwO66s06kLVbM+qFpnBbqg=;
        b=SSVOxsD75Br3RZzN9TrvPS0vzzIPROAILcr/5xefDSWII5yyFNPKbKelwBrnSW+oD3
         aNhcSgFcBKiAJN4vAUR80KNb5EU/p1a0xjoYz5PeiSFFnjrBJXM5Zpz9fAn0XKzT1eK3
         ofn/1UFXjPLgMkUHYK1lA/IuCsai2vNiIkrrbBnozvuFVI4yLW7vlOg7I5tTiCTMtLWn
         xwbGza5a5bP5Zg8ewkcTcTci+eM80RUl0mVXFjWHEC/vRM7/uAMAVPM3WxwunSs4swHo
         NX9alWQhyS+mOGxi06KVONBaqIWxNYu4wBjAVXOBPhlQCmumXusKBpYftlfs3qvrElcw
         /e9g==
X-Forwarded-Encrypted: i=1; AHgh+Rp/bVInZv2Gqwyi/7e2hliJTYpmz1AwUWTQuEVOnyOqNgjEnadaIB44t988MWoNxhfXoWehN4UDQ24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15btf/MxzwOdfSw0aqaRosDuUZ12mWCZkJC8TqQu+1FQDHE6k
	ISS/0S0NAnsQFEdthNcA4QGWfhqzxgR2URBEC7mUalbtZhYAuDScufmn
X-Gm-Gg: AR+sD104hFsr0MhVP6fC43wa/6S1QR4FrdZPg2hhvMDamYNlYhS3L5ZvBgYtR7oxAcx
	zOOaTWEUdXlFUlV3sEmGLYfW2WDWCfKWRq3WwgRITxK7FcAvyQFzw3AgXFr3lfKXTdeAYHXxRTQ
	EM7b4iH43tZdnnC2G7yBKVl6Yg3IXsB41CnVkPn3zNoBchaGk4Ju4+w8IaxE9iCV1hF5yrND4wx
	Nna76GyQ6I0Q9lKPs1I7alRdk5emnm8Hmqyg7mgzOcP1/gC/gveesr/nDIewiwnB4uUCTIrzx2i
	cHjH9uAhjY9JPG1z2NAU/bsw2Bt1KA073v6gzb4sXOCXSaoU3Sdn1nLktzSRuiak/ylq4iE2LHf
	hWLs6A4mAg2Rtm/b0NgYmbbt8CwYkt9Qq1yz7YECJ78fiqG0rLzgM0Yr1nF4bc846Yo8VfAoV1+
	xvCs03gr6dghA6W+2cleG8IIJ9zAeVUp1vh2wx/raKllGF54W5Y48Nc5g5H/guLa3Mp6oEXR1Bn
	/psy+cH4wXfmePpqG96N6bHOA2w0LTQCIzQ7PSEEuW8
X-Received: by 2002:a05:6512:685:b0:5ad:5c4a:8221 with SMTP id 2adb3069b0e04-5b4789245e7mr550067e87.0.1787115549476;
        Tue, 18 Aug 2026 21:59:09 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b47885ac3esm231487e87.28.2026.08.18.21.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 21:59:08 -0700 (PDT)
Message-ID: <e0c893ba-4a72-4ac4-84f7-f3d5e5fdf729@gmail.com>
Date: Wed, 19 Aug 2026 07:59:07 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: accel: kionix-kx022a: use scan struct for
 one-shot and trigger reads
To: Gabriel Rondon <grondon@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260818215122.52715-1-grondon@gmail.com>
 <20260818215122.52715-2-grondon@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260818215122.52715-2-grondon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 00:51, Gabriel Rondon wrote:
> The driver kept two separate staging areas that hold the same thing:
> buffer[8], a DMA-aligned area used by the one-shot read in
> kx022a_get_axis() and by the triggered handler, and the scan struct,
> used by the FIFO flush path. Both are three __le16 channels plus room
> for the timestamp.
> 
> Drop buffer and route the one-shot read and the triggered handler
> through scan.channels, so the driver has a single staging area. Move the
> IIO_DMA_MINALIGN alignment onto scan, since it now backs the regmap bulk
> reads that buffer used to.
> 
> No functional change. get_axis() only runs via read_raw() under
> iio_device_claim_direct(), so it cannot run while the triggered buffer is
> active, and the triggered handler only runs while it is; the two never
> touch scan concurrently, exactly as they previously shared buffer.
> 
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>

Suggested-by?

Other than that - looks good to me.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/accel/kionix-kx022a.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 02dd1db7a646..cf2cb751b4e8 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -301,11 +301,10 @@ struct kx022a_data {
>   	__le16 *fifo_buffer;
>   
>   	/* 3 x 16bit accel data + timestamp */
> -	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
>   	struct {
>   		__le16 channels[3];
>   		aligned_s64 ts;
> -	} scan;
> +	} scan __aligned(IIO_DMA_MINALIGN);
>   };
>   
>   static const struct iio_mount_matrix *
> @@ -613,12 +612,12 @@ static int kx022a_get_axis(struct kx022a_data *data,
>   {
>   	int ret;
>   
> -	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer[0],
> -			       sizeof(__le16));
> +	ret = regmap_bulk_read(data->regmap, chan->address,
> +			       &data->scan.channels[0], sizeof(__le16));
>   	if (ret)
>   		return ret;
>   
> -	*val = (s16)le16_to_cpu(data->buffer[0]);
> +	*val = (s16)le16_to_cpu(data->scan.channels[0]);
>   
>   	return IIO_VAL_INT;
>   }
> @@ -1029,12 +1028,12 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
>   	struct kx022a_data *data = iio_priv(idev);
>   	int ret;
>   
> -	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l, data->buffer,
> -			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
> +	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l,
> +			       data->scan.channels, KX022A_FIFO_SAMPLES_SIZE_BYTES);
>   	if (ret < 0)
>   		goto err_read;
>   
> -	iio_push_to_buffers_with_timestamp(idev, data->buffer, data->timestamp);
> +	iio_push_to_buffers_with_timestamp(idev, &data->scan, data->timestamp);
>   err_read:
>   	iio_trigger_notify_done(idev->trig);
>   


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
