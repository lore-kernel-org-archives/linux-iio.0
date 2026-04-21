Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7431E822
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793827; cv=none; b=TqIqYosoEvd6nEawzKxsEdMm1tt65/M81nyp2kdPUHoRt3ApE3R06BquyEIDqSSwu9hYnBsrYGo5iyhC6Fwg+/EohCZAcQu9S5+w3r0vns6JVKx00NKWb0XO0+NGwaoEGl2QjWgljzVS8JVpnMuHFqhg9+22guvzwPibDkQQgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793827; c=relaxed/simple;
	bh=l5EUzgxUJ5jark8UFQOEGBAfMbDR4aB/xC76ZtvqsTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDoPeH1VOmlxaRu7JAAXlLJNGeG9Vz4ksS3M4nVcrHrg1MDAKkq4hfqbBpYlYO7ykWCe60WPeAemNZlGBZxJ7HwAlyBwFNWrw/Vq24Wnkd/zx5bJTS9dlwELY0cRYCPPdWn6GWPtCYV66r/UxJhppazB9Tx+U93HEj+jANQZkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry1OH5JY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry1OH5JY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E31C2BCB0;
	Tue, 21 Apr 2026 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776793827;
	bh=l5EUzgxUJ5jark8UFQOEGBAfMbDR4aB/xC76ZtvqsTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ry1OH5JYI68nzIaE+a/sKDkDc9vLDEI2Y7PsgkO43mXQseZaRJjMMlBi+2spccKH7
	 OEpffbBpoz3CaXzi3UuyhSyndt3MjuOpZdn4F1i6ov3is0ukxw2cDvG8eSF0ZyAbSd
	 gwZqNk6fkUeu2LeJiLtAFQ/fzL8USk/pXIRl9BInL0Gq4+j3v5OE6YP9zdvKW8yyfI
	 yMPMqbbKDgs1YNrLiZalXE1VbRXpKL0u9UMsFtLe9hCTFZJbNHongQlxPm6tZD5L67
	 8BmKJFN1ERiBYne3ACTP/9330fyUmsbTv3SvFuk00caCrFOqu8DnVmkchhXckV8kyP
	 983gqi/J9NVpQ==
Date: Tue, 21 Apr 2026 18:50:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: lauraarakaki <lauraarakaki23@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tsys02d: Use guard(mutex) in
 tsys02d_write_raw()
Message-ID: <20260421185019.64411e62@jic23-huawei>
In-Reply-To: <20260421154007.1114389-1-lauraarakaki23@gmail.com>
References: <20260421154007.1114389-1-lauraarakaki23@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 12:40:01 -0300
lauraarakaki <lauraarakaki23@gmail.com> wrote:

> Replace the manual mutex_lock()/mutex_unlock() pair in
> tsys02d_write_raw() with guard(mutex)() from the scope-based
> cleanup helpers (include/linux/cleanup.h).
> 
Hi and welcome to IIO.

The wrap of this message is rather short. Normally we go
for 75 characters for a commit description.

> The previous code stored the return value of
> ms_sensors_write_resolution() in a local variable solely to
> bridge the gap between the manual mutex_unlock() call and the
> return statement. Using guard(mutex)() removes the need for
> both the intermediate variable and the explicit unlock call,
> since the mutex is released automatically when the function
> goes out of scope.
This paragraph is unnecessary detail.
> 
> No functional change intended.
> 
> Signed-off-by: lauraarakaki <lauraarakaki23@gmail.com>

> ---
>  drivers/iio/temperature/tsys02d.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
> index 0cad27205667..55a55f2f4663 100644
> --- a/drivers/iio/temperature/tsys02d.c
> +++ b/drivers/iio/temperature/tsys02d.c
> @@ -10,6 +10,7 @@
>   *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -62,7 +63,7 @@ static int tsys02d_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
> -	int i, ret;
> +	int i;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -72,17 +73,13 @@ static int tsys02d_write_raw(struct iio_dev *indio_dev,
>  				break;
>  		if (i < 0)
>  			return -EINVAL;
> -		mutex_lock(&dev_data->lock);
> +		guard(mutex)(&dev_data->lock);
Unfortunately this broken because the non obvious definition of scope
in switch case statements.  You need to add {} in appropriate places.

See some similar threads from last few days.

>  		dev_data->res_index = i;
> -		ret = ms_sensors_write_resolution(dev_data, i);
> -		mutex_unlock(&dev_data->lock);
> -
> -		return ret;
> +		return ms_sensors_write_resolution(dev_data, i);
>  	default:
>  		return -EINVAL;
>  	}
>  }
> -
Unrelated change.  Always check for these and clean them up before posting.
>  static const struct iio_chan_spec tsys02d_channels[] = {
>  	{
>  		.type = IIO_TEMP,

