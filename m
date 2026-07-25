Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA530F938;
	Sat, 25 Jul 2026 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940771; cv=none; b=AcnF8SBC0RYuXY8UbvUX6duHOla3QBeyACD75bNYY+B7obmw1Z/SZ9z5boshloQwgTAfbzxaTK1q8/huleugnF9c5RiLQE/Y7KNMyFy6VsqdWFZl6rrQzZtzlbGRz17h1L8t+1rk8Cp/ryo2LWyIjmGTdWr42Ml0teMlkCh3Iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940771; c=relaxed/simple;
	bh=9faX5mNXbHQM5mnJuFO8IZSeMRpOzAxgH5J+07Gug6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mX25GpEFkKSIsDwtqx88M7geDU04iS7yju5yjMrFUxqWaHg6k4+HBVHvOC+e8krvZyIE8RaUF+z1B+ag7GJBXWiPwp/Hd6/SCPeqB5lMXZRq11GPmKFoCx1VGxcFTKxT/45CmCFaTqcp/168K3KBlaoE1VXEsVyr9R5nveCRocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5d/5iF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5d/5iF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174481F00A3A;
	Sat, 25 Jul 2026 00:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784940770;
	bh=BlwxYFwl+aXxQYO7Zaoycs8xfBNNKsbWZHJyO9wv4Wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l5d/5iF+2Pz7VtEdO+hjNsyx6Rg28QiGHuofI9dmYKHlUzUbr1Ir2obdyTB4VfWry
	 ktoB3BpcoiATU5cMWgFUQVuc4ulJnrm7vqXp0hnZ6cBEyL+zXK/bzTXmfboJsB5py0
	 UhhUx15tDC23zYIsbPeY9d2o4TndZz8Emc0RYnkfqGKj7fA6c76j4ojITQytLxSfb/
	 l7XC5/kvAw5wqj2gEDEtUjISk+Kb7HZbCEX9cd1wppP13pxjj1V363IrhY5SOCMBHH
	 NlrtIjf5xYxGQwqklzzCN2CZ3G4Aj5Mo6Q7LYt59S/c8KsXKJaWe68lJPifTcJiNyM
	 k/EDz7Gz3s/Kg==
Date: Sat, 25 Jul 2026 01:52:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: light: gp2ap002: Fix unbalanced runtime PM
 on repeated event writes
Message-ID: <20260725015245.5f911412@jic23-huawei>
In-Reply-To: <20260722162247.8229-2-nikhilgtr@gmail.com>
References: <20260722162247.8229-1-nikhilgtr@gmail.com>
	<20260722162247.8229-2-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 21:52:45 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> The IIO core does not filter duplicate writes to the event enable
> attribute, so writing the same value twice invokes
> write_event_config() twice. Enabling twice leaks a runtime PM
> reference, preventing the device from ever suspending again;
> disabling twice underflows the usage count and triggers a
> "Runtime PM usage count underflow" warning.
> 
> Bail out early when the requested state matches the current state.
> While at it, switch to pm_runtime_resume_and_get() so a failed
> resume is propagated to userspace instead of silently marking the
> event enabled.
> 
> Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>

https://sashiko.dev/#/patchset/20260722162247.8229-1-nikhilgtr%40gmail.com

Sashiko raises a point about concurrent accessors. My previous understanding
was that we were fine if there was only a single file involved.  Having
dug around a bit I'm fairly sure that is correct.
The comment here implying to me that we are fine.
https://elixir.bootlin.com/linux/v7.1.4/source/fs/kernfs/file.c#L340

Now if we had more than one file then we couldn't rely on this.
Hence to me it's a bit fragile and we should probably add a local lock
anyway.

One other comment inline.

> ---
>  drivers/iio/light/gp2ap002.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index 42859e5b1089..966459994995 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -343,6 +343,10 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
>  				       bool state)
>  {
>  	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (state == gp2ap002->enabled)
> +		return 0;
>  
>  	if (state) {
>  		/*
> @@ -350,14 +354,15 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
>  		 * already) and reintialize the sensor by using runtime_pm
>  		 * callbacks.
>  		 */
> -		pm_runtime_get_sync(gp2ap002->dev);
> -		gp2ap002->enabled = true;

> +
> +		ret = pm_runtime_resume_and_get(gp2ap002->dev);
> +		if (ret)
> +			return ret;
>  	} else {
> -		pm_runtime_mark_last_busy(gp2ap002->dev);
>  		pm_runtime_put_autosuspend(gp2ap002->dev);
> -		gp2ap002->enabled = false;
>  	}
>  
> +	gp2ap002->enabled = state;
>  	return 0;
>  }
>  

