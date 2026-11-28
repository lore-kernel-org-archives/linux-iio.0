Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830267;
	b=CmxS5HV03mfTIeuUuUaN9AVcnMpuyXhbk0MVgiOOrj3XTYlT+0h3U/Y7z0xxxHiARknW
	 kCbFaWKRKzE4ZzpU6XCDmirEhpqHMDRomtRk61WnJmwvKk6sG/0uBWqeB2OkCjgMCaWwP
	 t+oxnEVNJWfHr/JXWeVMe2C3Sf/JmLn17or1X5IJEVeeUH+IMz5tfPyj85FQoFkUR8o4w
	 8pbbQYlVMVuYVKk6fiqKA6PrvWvrUyZqDbC1bw7B8Qye8IlVYyH9Hxu0DSXe6oz3wJzy2
	 eYDuEwCv89RxVewhtdBnVAWXb3ou0PYmBoQjchH5qkKK2KCZDEioDEWzEuU4mG2y4WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830267;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YmWM6npUiKBOpIOwoLsyB1g6oBEkpvum18IxGnWazho=;
	b=Tcbrqa83ZpDXpQssnZNd+SfVpdZkCQiIAYD7eqRdiOPhVdUZU5WmckeHrhbyHFmN0kLS
	 WeRWg8e+xyFvSyd0FYOfgpNxBg/pklf0bu0BSJ9v2xIa0RQe1lAUfB5LEBgfum8c22kgR
	 7hqCaIjDH/aK9oiV3l/S2CgAI7lMkfx/SH9z/x5kotDPuFJjAh5pEVuCCDQzzP8atXdY2
	 izjLns9dMMpBHNP/OkkTyWHqdlRFx6ZDFczWUZEetQ/MqwwAFttXVa8NdwY7yCrriHxob
	 hysooz6xm4GprSoA2v2d8kKWNl0H4Kn8fjCZ0qzOEh7bl1YzTE3DoXH3l5SQDzPMsXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IEIkhpJ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C710606A31C;
	Sat, 28 Nov 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEIkhpJ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125AA1F000C1;
	Sat, 28 Nov 2026 01:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795830267;
	bh=YmWM6npUiKBOpIOwoLsyB1g6oBEkpvum18IxGnWazho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IEIkhpJ/h9PP0FXIISN9zoka4QS7lWEA61AssaSiAO59hsnutTSq5N1MjbZpyzP9B
	 qdNHbmWZUoHHCz7/M3uJ0aIjXUZNM1QwSFPQzR4kr23LNP1aRHsRoN56U052WZ4KU6
	 fIehv0Q6a6QcQQGyp9fAOQt61vCvVbXXVnW0bp7ZNZPiTq/y4NtOQ5OzLUF+VDwHKg
	 bGYilmmq4mS7dlhK9OBf+tEZnNchzE5PrzdQomofZ/entIiv3WzBi10vJjb5ekwuw2
	 gSJPZHnY1nzdA9BSbWMXOSwIrfmvIXEbsKtD+FgS8GE3Ua1EroX/53d54NwNF3/1Jd
	 ED5vkDZESixlQ==
Date: Sat, 28 Nov 2026 01:44:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
Cc: iasnezhkov@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>, Arnav
 Kapoor <kapoorarnav43@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: inkern: guard fwnode_xlate with info_exist_lock
Message-ID: <20261128014419.78eb8e57@jic23-hlaptop>
In-Reply-To: <20261127031038.12685-1-iasnezhkov@gmail.com>
References: <20261127031038.12685-1-iasnezhkov@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 03:10:38 +0000
Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org> wrote:

> From: Ilia Snezhkov <iasnezhkov@gmail.com>
> 
> __fwnode_iio_channel_get() dereferences indio_dev->info->fwnode_xlate
> and invokes it without holding info_exist_lock. Concurrent
> iio_device_unregister() clears indio_dev->info under info_exist_lock,
> allowing a NULL dereference or callback execution during provider
> teardown.
> 
> Hold iio_dev_opaque->info_exist_lock with scoped_guard(mutex, ...)
> matching the rest of inkern.c, and return -EPROBE_DEFER if
> indio_dev->info is NULL. Since iio_device_unregister() calls
> cdev_device_del() before clearing indio_dev->info, seeing a NULL info
> pointer corresponds to racing right before device removal from
> iio_bus_type, where !idev already returns -EPROBE_DEFER. Using
> -EPROBE_DEFER also avoids colliding with the -ENODEV sentinel used by
> callers to continue parent or map-list lookups and avoids the named
> lookup -EINVAL fallback in __fwnode_iio_channel_get_by_name().
> 
> Fixes: acd8256723f2 ("iio: inkern: Add of_xlate function to struct iio_info")
> Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
Good catch.

I'm not going to rush this one in given we are getting latish in the cycle.
So queued up on the testing branch of iio.git for the next merge window.
Marked it for stable.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Place `struct iio_dev_opaque *iio_dev_opaque;` in reverse xmas tree
>   order (Andy Shevchenko).
> - Move `iio_dev_opaque = to_iio_dev_opaque(indio_dev);` right after
>   `channel->indio_dev = indio_dev;` immediately before scoped_guard()
>   (Andy Shevchenko).
> - Carry Reviewed-by from Arnav Kapoor.
> 
> Changes in v2:
> - Return -EPROBE_DEFER instead of -ENODEV when indio_dev->info is NULL
>   so callers do not treat it as the "no channel on this node, keep
>   looking" sentinel and named lookups do not overwrite it to -EINVAL
>   (Arnav Kapoor).
> - Drop the unrelated indio_dev->num_channels bounds check from this
>   locking fix (Arnav Kapoor).
> - Move the AI coding assistant note below the --- separator.
> 
> Link: https://lore.kernel.org/r/20261126060615.63790-1-iasnezhkov@gmail.com
> Found and drafted with an AI coding assistant.
> 
>  drivers/iio/inkern.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 1f22275..92b6679 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -145,6 +145,7 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
>  				    struct fwnode_handle *fwnode, int index)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque;
>  	struct fwnode_reference_args iiospec;
>  	struct device *idev;
>  	struct iio_dev *indio_dev;
>  	int err;
> @@ -162,10 +163,15 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
>  	}
>  
>  	indio_dev = dev_to_iio_dev(idev);
>  	channel->indio_dev = indio_dev;
> -	if (indio_dev->info->fwnode_xlate)
> -		index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
> -	else
> -		index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
> +	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	scoped_guard(mutex, &iio_dev_opaque->info_exist_lock) {
> +		if (!indio_dev->info)
> +			index = -EPROBE_DEFER;
> +		else if (indio_dev->info->fwnode_xlate)
> +			index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
> +		else
> +			index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
> +	}
>  	fwnode_handle_put(iiospec.fwnode);
>  	if (index < 0)
>  		goto err_put;

