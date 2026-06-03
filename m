Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072D46AEEF;
	Wed,  3 Jun 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491129; cv=none; b=CLtwWTR5nhnJ39f3jshg4DHeMmpZAmqr5N1wafHO7mH5HYSKtz6kkBz6J6ySu6AQ7xCXNPrHsVPnOiV/vpCzBE3LtnEPAI9pYeC8JRtpPHrJt0WkCsU/tMun9wgWaXIU2Gi3xeWfDv7tSS4FfiQIIFi7bsVwCxpdrjFufd2EEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491129; c=relaxed/simple;
	bh=8eKivnL6rIP7uq8FU0P9rtmpsR9dQ/aVtg8WULglB3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abUWbshe4vnCFWrMSTHEnEvRNkU1WXfga5Q7GnREHRcZBXnaeVgJTTae4XrbhILVURCw9LBJlnsWBdQ276phVuqvB/sF3/yat570VP5Viyw8evMflg7hyL3t/DZ7dpexxEqvtGEfyHEwRtC8xT7aHG2KzfyJAtbM4gCDs6Ey6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObNl8bCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObNl8bCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44E91F00893;
	Wed,  3 Jun 2026 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780491128;
	bh=FtocfIoyInlHJrTnG9L0+JlEkrTxGrUIvuAZAWuzkGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ObNl8bCVsLygNySgPtaSq9nxN3fhHt5BlRqShtfnZE7KJMh403mBqNbHvHV4squtf
	 /8HwmWVpXBS7z5u4lOrcsXycD3gGzSLEL01t8Q3jaDOehFAeho208kVhXywPnb5Tcn
	 HD8xM/mHzh7B9WEIQdj2PcSkEhNNNr1ydn6Qa2kphJS4iCxnb+tSWOv3IUfw52CDPF
	 Pb7yH15OV7Oy4zFVWJWdQYf3wq8hDymmT0PuW58wY9HrpJSmupBFTc7UlpjQGIkYv+
	 VyCxpmGAPZqzECOa4nKg44rbthriEJcFcGx5E3bkPLi9LaMoAlWx+m++WNcLJH3tS0
	 56QZMTa+GGrMg==
Date: Wed, 3 Jun 2026 13:52:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: fix PM reference leak in buffer
 preenable
Message-ID: <20260603135201.0e484c7b@jic23-huawei>
In-Reply-To: <20260603121640.1394763-1-lgs201920130244@gmail.com>
References: <20260603121640.1394763-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 20:16:40 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

> ads1119_triggered_buffer_preenable() resumes the device with
> pm_runtime_resume_and_get() before starting a conversion.
> 
> If i2c_smbus_write_byte() fails, the function returns the error directly
> and leaves the runtime PM usage counter elevated. The matching
> postdisable callback is not called when preenable fails, so the reference
> is leaked and the device may remain runtime-active indefinitely.
> 
> Store the I2C transfer result in ret and drop the runtime PM reference on
> failure before returning the error.
> 
> Fixes: a9306887eba41 ("iio: adc: ti-ads1119: Add driver")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Note I may well drag these across to the togreg branch for the coming
merge window as I'm not really expecting to squeeze in another fixes
pull this cycle and all the fixes I currently have queued are for ancient
bugs.

> ---
>  drivers/iio/adc/ti-ads1119.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> index 79be71b4de96..9324408cb3b0 100644
> --- a/drivers/iio/adc/ti-ads1119.c
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -459,7 +459,11 @@ static int ads1119_triggered_buffer_preenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	return i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
> +	ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
> +	if (ret)
> +		pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
>  }
>  
>  static int ads1119_triggered_buffer_postdisable(struct iio_dev *indio_dev)

