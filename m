Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC111CAF;
	Sun, 22 Feb 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771775933; cv=none; b=Po4i+lBtVLGqRuHOP7K6yr9a4Ev2Pi8rFKMimS0rN/kGaLQxjBl5XXz6PoOSIL+lonQqxsG0gTTDXIroXrWF0/jTYgwVVnD5UWIoAe8euDHNOqVPIP77TNRTBMG+zyoO6gzC8yvIhcKd2kQyUbGXy0G4sBH2ElVmfQARvEVfOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771775933; c=relaxed/simple;
	bh=DmBnfXE4CVqDHt/3NcmzWpj8z5uDA6PaSlwMJkGpaGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYWzscV/P7jsVTA4EYopYkn8aVG1/rt34fC+4zqdOeEiVMT9cGrAAoY2xj9f5dUGI4ffmfa2eBlJsFc3sHq/VOh1eks15lWnzY4y9dgAePmdnRaLgxANoKCBMBjuFlHvPZsUA2b9PVKxvnk/senJ3F347y39NBrtayjC2mJMzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHhqIUsb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHhqIUsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75498C116D0;
	Sun, 22 Feb 2026 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771775932;
	bh=DmBnfXE4CVqDHt/3NcmzWpj8z5uDA6PaSlwMJkGpaGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eHhqIUsblaH213121b9EJi1j5HU5QXN6ZqAl+HLWT+25EibBa9Zme9ZgOOaL13DtX
	 SUpIYtmaLk44TcbyiB7zKiKhX653UV5ioySNufg2Lm8d1TzDzquHnLS4p8L6VttzCf
	 aNJ4b1cAYjMgFH2cgEptNvn6BAYm4gNTZ0JlKWmLJrqDedKa0UjdBtwffk1VnENQgm
	 tnR/+2dqNQCA0u31K6m32o0KZiTKYZPGfOYOtiJUJV2uzhRYIPx6CDSOXDoISodI7i
	 94zmUqA0kDyZGw5coA1ZTCHy99ZJDDA1AkE9PaAtNK3D+lI7z4w05RWQXDz7YEc+vP
	 DDUeA/vc009Bw==
Date: Sun, 22 Feb 2026 15:58:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tabrez Ahmed <tabreztalks@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1015: Use scoped_guard() in trigger
 handler
Message-ID: <20260222155845.2b0b7824@jic23-huawei>
In-Reply-To: <20260221142500.87016-1-tabreztalks@gmail.com>
References: <20260221142500.87016-1-tabreztalks@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Feb 2026 19:55:00 +0530
Tabrez Ahmed <tabreztalks@gmail.com> wrote:

> Replace the manual mutex_lock() and mutex_unlock() calls with the
> scoped_guard() macro in ads1015_trigger_handler(). This simplifies
> the locking logic by ensuring the mutex is always properly released
> out of scope, while maintaining the trigger notification on the
> error path.
> 
> Signed-off-by: Tabrez Ahmed <tabreztalks@gmail.com>
Hi Tabrez,

Take a look at the comments in cleanup.h 

Basic rule is don't combine guard() or __free() with
gotos.  The actual bugs that avoids aren't present in your patch
but to keep things simple for review, that rule stands anyway.

See below for alternative.

> ---
> Compile-tested only.
>  drivers/iio/adc/ti-ads1015.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index f2a93c63ca14..582d30c07874 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -451,18 +451,16 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
>  	} scan = { };
>  	int chan, ret, res;
>  
> -	mutex_lock(&data->lock);
> -	chan = find_first_bit(indio_dev->active_scan_mask,
> -			      iio_get_masklength(indio_dev));
> -	ret = ads1015_get_adc_result(data, chan, &res);
> -	if (ret < 0) {
> -		mutex_unlock(&data->lock);
> -		goto err;
> +	scoped_guard(mutex, &data->lock) {
> +		chan = find_first_bit(indio_dev->active_scan_mask,
> +				      iio_get_masklength(indio_dev));
> +		ret = ads1015_get_adc_result(data, chan, &res);
> +		if (ret < 0)
> +			goto err;
> +
> +		scan.chan = res;
>  	}
>  
> -	scan.chan = res;

There was never any reason to hold the lock over this assignment as
scan.chan and res are both local variables.

Hence, this can become something like

	mutex_lock(&data->lock);
	chan = find_first_bit(indio_dev->active_scan_mask,
			      iio_get_masklength(indio_dev));
	ret = ads1015_get_adc_result(data, chan, &res);
	mutex_unlock(data->lock);
	if (ret < 0)
		goto err;

	scan_chan = res;
...

Which gets you most of the advantages of using scoped_guard()
(no need to unlock in multiple paths) without running into problems
due to the goto.

Jonathan

> -	mutex_unlock(&data->lock);
> -
>  	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
>  				    iio_get_time_ns(indio_dev));
>  

