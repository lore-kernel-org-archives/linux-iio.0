Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E3311587;
	Fri, 20 Feb 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582739; cv=none; b=gnkBJZhm3v75na41OZOz2Lvuu7RlF9YJId70ILih/9ODlzltV+yqg5Inrb+3PZqnfYN4H0lroxmye7iTjzUwMGVirh+7t9kD7LF/ofvsnz9sFvwYxgkgc5DzQ2eN0ScCAvM5fnrfR48nQV9JOyLQRUIq7qITcrIa/PItRf9yqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582739; c=relaxed/simple;
	bh=3JV5EwM5S/j2JwgEMeRJfGSgsBWwBzzYgcsowch5eTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqihs3Sl1by1uugjhJftKhIcuYn5iXYfbHfy85QBewA7odewduMlUqCG6aQbta/oOYVgsMj8bzUYqmMktL/dcF3olfwJBGCHH1F2S6FuugXtAH6YzwMhkGJfYRzFayn8m7N8a/QUetX9Cb0cTYw+GdhYCry2eYumRY7DHP5vQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj+zbh5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj+zbh5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B464C116C6;
	Fri, 20 Feb 2026 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582739;
	bh=3JV5EwM5S/j2JwgEMeRJfGSgsBWwBzzYgcsowch5eTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sj+zbh5IAK55flunboaTUIqDgpOeIhfbVCLpYJFvCZ/z6GrSA2uEXUNwkiA2zCU9n
	 jikCvbbn1N5qU6IZGLN0edLbS6BPzundXZwQJmeroP8fZZavxH2uLUXSoZktsU7iUd
	 Yv/sQJkmqjObykUalUXJKNBuE3yBgjI1+/NYxcn/qqMffOCz0kaxToMJq1yM+tzgGw
	 kVLnyInSeEAtxmKnmihXkpA7Ivj/aCxnXN5sAE9KfV2yrnHwOC+XSOHGXg/5sGXYal
	 VkD3yRBUHQhX5qR9D6sNTW91mMmQ1VfE47l7pEAOiAeXmKA5Pf8Wk6gdZy2GHtMm3E
	 xOtF8ue8uL1pw==
Date: Fri, 20 Feb 2026 10:18:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
Message-ID: <20260220101844.17f3bc63@jic23-huawei>
In-Reply-To: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
References: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 09:14:12 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice.  There was a mass sweep up of these cases a few years
back but I guess these instances slipped through the scripting
that was used to find those.

> ---
>  drivers/iio/buffer/kfifo_buf.c     | 29 +++++++++++++----------------
>  drivers/iio/industrialio-trigger.c | 24 ++++++++++--------------
>  2 files changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index 38034c8bcc04..a126cc05fb38 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -234,23 +234,20 @@ static void devm_iio_kfifo_release(struct device *dev, void *res)
>   * @dev:		Device to allocate kfifo buffer for
>   *
>   * RETURNS:
> - * Pointer to allocated iio_buffer on success, NULL on failure.
> + * Pointer to allocated iio_buffer on success, error pointer on failure.

This had me briefly confused as I failed to notice it was static
(no idea why I gave such a simple internal function kernel-doc!)

However that brings the obvious follow up question.  Given your
simplification does having a helper make sense given only a single caller?

Let's just squash it and have the two calls inline + some resulting docs
updates to get rid of the references to this function.

Thanks,

Jonathan


>   */
>  static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
>  {
> -	struct iio_buffer **ptr, *r;
> -
> -	ptr = devres_alloc(devm_iio_kfifo_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> +	struct iio_buffer *r;
> +	int ret;
>  
>  	r = iio_kfifo_allocate();
> -	if (r) {
> -		*ptr = r;
> -		devres_add(dev, ptr);
> -	} else {
> -		devres_free(ptr);
> -	}
> +	if (!r)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = devm_add_action_or_reset(dev, devm_iio_kfifo_release, r);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	return r;
>  }
> @@ -275,8 +272,8 @@ int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
>  	struct iio_buffer *buffer;
>  
>  	buffer = devm_iio_kfifo_allocate(dev);
> -	if (!buffer)
> -		return -ENOMEM;
> +	if (IS_ERR(buffer))
> +		return PTR_ERR(buffer);
>  
>  	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
>  	indio_dev->setup_ops = setup_ops;

