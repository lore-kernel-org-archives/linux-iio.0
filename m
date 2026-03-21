Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6632BD11;
	Sat, 21 Mar 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098025; cv=none; b=dK1n/kg8786tCkJUWMPB0TaLs3Osiw6i8H4mEY83dwLIBS0gyhkQDKAfBYCb/HMKxGlD9TbLrE0yZA5SAOW8xohcZkPbn8kWnx46ZHRqNWnFn+CiDp2ts31vhZR6b5BJpOy/CwLw2LPUUwrJeazMlk7OUm3aPNiSQB23oSKB5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098025; c=relaxed/simple;
	bh=dWdttv/aEBw6LiiTZo6DFYjSY6J0PeLKmsG5CXYxsrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1xkrOtyzaM4lWv6s7EPwrjRt4sDkCdHbf4OR98D0h/6A9Q+gOerjhKLXgAGI81JvCY6mjlJ6gT3ebHrliFj/DFpKYjiKzf2N5bODvoX+/Mi/QHyaNIxRik1bhDdFcaYAqCC17/EjW20m7xOmWuaLek47hBuA0g/LDe8cw1dcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X92pSV/3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X92pSV/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55030C19421;
	Sat, 21 Mar 2026 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774098025;
	bh=dWdttv/aEBw6LiiTZo6DFYjSY6J0PeLKmsG5CXYxsrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X92pSV/3Uk1bITQdjYTBKw3HwMcxfK/1EphP/q569CWCBNGT0mR/hpIvfZo7WcU0t
	 SftEv+LF6wUtfN4uYsmKz5wuvquaPbYyla+1ZrdcgVoJzV7Ie/0C8X4FC0iMiHUWaU
	 4EE90dKWdjshzVOkQh7Xfp0qftbXNkT4JBcSv9cSaMKGc0bLIwsTHIvmo1AYLEJIjh
	 EfvYpGGHyWSdwUOH6hF34IFlGKraAIHVgnsO62dgxNX6giHQ1AXuf2W54DW7Gqa0lq
	 7uqUU93NywGu6dhJjfzRl0u/2f2SaZH+IH2QMVwZjlRwuybB4U276S0CYxYPxPx2ax
	 FvfmnnN7W12fA==
Date: Sat, 21 Mar 2026 13:00:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma180: use
 devm_iio_triggered_buffer_setup()
Message-ID: <20260321130018.5ef955d1@jic23-huawei>
In-Reply-To: <20260321114848.159973-1-i.shihao.999@gmail.com>
References: <20260321114848.159973-1-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 17:18:48 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Use devm_iio_triggered_buffer_setup() instead of
> iio_triggered_buffer_setup(). This removes the need for manual cleanup in
> both probe and remove callbacks, simplifying resource management.

This also changes the ordering so that the remove() path no longer
does things in the reverse order of probe()

Whilst that might not introduce bugs in this case, it makes reasoning
about race conditions much harder so I won't take code that does this.

The basic 'rule' for devm usage is that there must be only one transition
in the probe() from using it to not using it. You should never go back
to using it after that transition.  That way the handling in remove()
and the unwinding of the devm_* happen in reverse order of probe()
and all is easy to reason about

So to make any devm_ related changes in this driver requires a
more comprehensive approach.  Note that even if the change here didn't
suffer this ordering problem I'd be pushing back because of the partial
nature of applying devm in this driver.  + a complete solution would
not run into the ordering issue.

Thanks

Jonathan


> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> ---
>  drivers/iio/accel/bma180.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 7bc6761f5135..429d5a5c7672 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -1004,7 +1004,7 @@ static int bma180_probe(struct i2c_client *client)
> 		indio_dev->trig = iio_trigger_get(data->trig);
> 	}
> 
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> 			bma180_trigger_handler, NULL);
> 	if (ret < 0) {
> 		dev_err(dev, "unable to setup iio triggered buffer\n");
> @@ -1014,13 +1014,11 @@ static int bma180_probe(struct i2c_client *client)
> 	ret = iio_device_register(indio_dev);
> 	if (ret < 0) {
> 		dev_err(dev, "unable to register iio device\n");
> -		goto err_buffer_cleanup;
> +		goto err_trigger_unregister;
> 	}
> 
> 	return 0;
> 
> -err_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
> 	if (data->trig)
> 		iio_trigger_unregister(data->trig);
> @@ -1041,7 +1039,6 @@ static void bma180_remove(struct i2c_client *client)
> 	struct bma180_data *data = iio_priv(indio_dev);
> 
> 	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> 	if (data->trig) {
> 		iio_trigger_unregister(data->trig);
> 		iio_trigger_free(data->trig);
> --
> 2.53.0

