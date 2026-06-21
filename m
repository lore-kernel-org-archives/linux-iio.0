Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F041DDC38;
	Sun, 21 Jun 2026 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063707; cv=none; b=kY0x6rt7UBOaQHGDTZl3Hic+DMeAmfJKESyD2QaMZNBH5HiJwLSjaSJrXWFlghYiS6w/Fy01G8T0nuXAUHK4IFIV8TFxaSgpZJQutNVLQOkGyoFUDOgiOv/iiFEAgW0rYEdgoDCRfBZSVae3dwPCQUhIWoL+D3QLDqPY7p+vj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063707; c=relaxed/simple;
	bh=L/+97sfte18DEDYYopfPHVii26ZDDwSpc8YN3nu6ovE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgznFkaRKT/zsNTXybFSq30zf+O16DA3EfzvH4anT4lK4sQMIjV5yQjauAlpVxsJ2owCl1HqkYljMtVrIohuQGw8VWXHLlBZjancMYZhfIrM9xHlvFd4ElMGZojSWCCVTaMm09yMONOXOrU8ecF/KCsmAMJvlUM0V+gz7bW2ynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx/iBQG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx/iBQG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AF71F000E9;
	Sun, 21 Jun 2026 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782063706;
	bh=DBuUAQpuh//udmCVnimcxOsvNs2KgbowAkZ7xLpIk3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mx/iBQG79HkTVuW5Z15E5Qif0mgxTJMPoX4K5QLSF0ofGOCISeuJPhQ59rWBNf6Vj
	 6h3re0KxvTIqPiT4Lg8bPxLVcvBAehyvFm7Uml5gCkUdqzAEvPLI/YEZFinKRIX0Vs
	 JjUDZzWiinfT32uW/OVROAwlbPrMLgMsiAQRSZn12tR1mvUQ4Dk3f3zM2xOx3WMqsX
	 2mQdYomJBHibPBtYdxewEZHPjAhgN9xqJ72CQtIP4O/hIT/Gaiok2/gm25kDhm53Iu
	 ctYH1F7ot6GnMMGPq9ymOWP5fmbDtq19LhKVAixrsZGcUPdDr/eA8F208ZLl+hJU5G
	 y68tALs3vrtaA==
Date: Sun, 21 Jun 2026 18:41:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxsd9: Fix runtime PM error handling and
 scoping
Message-ID: <20260621184138.39540fda@jic23-huawei>
In-Reply-To: <20260615200330.33207-1-birenpandya@gmail.com>
References: <20260615200330.33207-1-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 01:33:30 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> The kxsd9 driver uses pm_runtime_get_sync() in multiple places without
> checking its return value, which can lead to silent failures. It also
> relies on manual pm_runtime_put_autosuspend() calls in various return
> paths, which is prone to memory leaks if a return path is missed.
> 
> Fix the runtime PM handling by using the new scoped guards and proper
> error checking:
> - In kxsd9_write_raw() and kxsd9_read_raw(), use the scoped
>   PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() macro to safely automate
>   cleanup on function return, while maintaining the behavior of
>   waking up a suspended device via pm_runtime_resume_and_get().
>   This allows us to cleanly remove all manual puts and error gotos.

Somewhere here mention that one of the puts was missing.

> - In kxsd9_buffer_preenable(), replace pm_runtime_get_sync() with
>   pm_runtime_resume_and_get() to safely check for errors and handle
>   usage-counter unwinding on failure.
> - In kxsd9_common_remove(), replace pm_runtime_get_sync() with
>   pm_runtime_resume_and_get() and only invoke kxsd9_power_down()
>   if the resume succeeds. This prevents unbalanced regulator disable
>   warnings and bus timeouts if the device is already suspended.
> 
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>

Given this fixes a path, needs a Fixes tag.

Otherwise, what Andy said.

> ---
>  drivers/iio/accel/kxsd9.c | 50 +++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 4717d80fc24a..f23d1660e6da 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -139,68 +139,63 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
>  			   int val2,
>  			   long mask)
>  {
> -	int ret = -EINVAL;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
>  
> -	pm_runtime_get_sync(st->dev);
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(st->dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> +		return PM_RUNTIME_ACQUIRE_ERR(&pm);
>  
>  	if (mask == IIO_CHAN_INFO_SCALE) {
>  		/* Check no integer component */
>  		if (val)
>  			return -EINVAL;

This one is a real fix that needed addressing as it exits
with an error code leaving the power on.

> -		ret = kxsd9_write_scale(indio_dev, val2);
> +		return kxsd9_write_scale(indio_dev, val2);
>  	}
>  
> -	pm_runtime_put_autosuspend(st->dev);
> -
> -	return ret;
> +	return -EINVAL;
>  }


