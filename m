Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880A3E8320;
	Sat, 16 May 2026 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778948934; cv=none; b=U8RL295/Fq4Yk0HbXZW+sQydrcL82tzckja0FTgFQkoSL0NQti2qKdit/uvqpVrUzmjxrNXanqipjdiPuhtvr6a8T2KFcFNeIo0UAC3D6rx1JPqu2/oA2jndFwzninnPLbOaAaBRCOik9gkx4GmhNZ/T7lSy03B5GZ4y18eFETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778948934; c=relaxed/simple;
	bh=nh1wZz3TzDBqoTrooUonj/Keonc1uMvSWFURmWHefmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kh4nXJUJqdY72n5jURDP4GMLXgA+fxSP7gLjg6qpMPx/bRvckz5XslsiKQWQ71i8t8E3N/kD84yTITBJvpyoYlRYbb35vpWjKZMOTylAt172n4rWPWAZfCON/dQWc58OulkFpHGMdWOYnFq6wd9TmecuRj1qDBKwgx8sK/d4MVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GamuJsqA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GamuJsqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A77C19425;
	Sat, 16 May 2026 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778948933;
	bh=nh1wZz3TzDBqoTrooUonj/Keonc1uMvSWFURmWHefmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GamuJsqAbxDk/EbIPcXRxqI8x+/ChAF9tXcYODA0Yy8dRSqPPS1Ifnz/8YXU0J8Dd
	 K3Es5ROcfSh8gm5hXEyA+uzZMeC7FoXGxgXxytQaBlOZ/4MxgO9PtFpx2KVZay++WU
	 vu3RyIEeXUZnefhVRZueCdaCDRwdYezQlLlbFdc8N9+ot/HyvChbpyJRdJ9s8Ih0I+
	 D4/zLpmvpACgieJo2BGvk02V9RSdEHnmuebQUNXED87mOOJawz8XwxgURTEs7B+3cU
	 K3itPd3FV0krGoaiEYVJMMNlGiuvi01k7K9HwvyX7aMgXrOXKZNdDnR5XQYztpXive
	 H7JZlRw9dEbUw==
Date: Sat, 16 May 2026 17:28:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3] iio: potentiostat: lmp91000: fix probe order and
 cleanup paths
Message-ID: <20260516172846.581c0cc4@jic23-huawei>
In-Reply-To: <20260514080847.296285-1-salah.triki@gmail.com>
References: <20260514080847.296285-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 09:08:46 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> Fix the initialization order in lmp91000_probe() where the immutable
> trigger is set before data->cb_buffer is initialized, which would cause a
> NULL pointer dereference.
> 
> Also, reorder the cleanup labels and ensure all error paths properly unwind
> resources using gotos instead of direct returns, following the standard
> LIFO resource release order.
> 
> Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
https://sashiko.dev/#/patchset/20260514080847.296285-1-salah.triki%40gmail.com
Is correct wrt to the error path being wrong. Remove also needs fixing up.

> ---
>  drivers/iio/potentiostat/lmp91000.c | 34 ++++++++++++++---------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index eccc2a34358f..30b40b3a97d9 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -330,17 +330,27 @@ static int lmp91000_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb, indio_dev);
> +	if (IS_ERR(data->cb_buffer)) {
> +		if (PTR_ERR(data->cb_buffer) == -ENODEV)
> +			ret = -EPROBE_DEFER;
> +		else
> +			ret = PTR_ERR(data->cb_buffer);
> +
> +		goto error_unreg_buffer;
At this point the buffer hasn't been registered -so shouldn't do that.

In fact nothing that is not handled with devm_ unwinding has happened yet.
So returning is fine I believe.


> +	}
> +
>  	ret = iio_trigger_set_immutable(iio_channel_cb_get_iio_dev(data->cb_buffer),
>  					data->trig);
>  	if (ret) {
>  		dev_err(dev, "cannot set immutable trigger.\n");
> -		return ret;
> +		goto error_unreg_cb_buffer;

At this point we just need to undo the get_all_cb().  So indicates the unwind
order below is wrong.


>  	}
>  
>  	ret = iio_trigger_register(data->trig);
>  	if (ret) {
>  		dev_err(dev, "cannot register iio trigger.\n");
> -		return ret;
> +		goto error_unreg_cb_buffer;
>  	}

>  
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> @@ -349,35 +359,23 @@ static int lmp91000_probe(struct i2c_client *client)
>  	if (ret)
>  		goto error_unreg_trigger;
>  
> -	data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb,
> -						 indio_dev);
> -
> -	if (IS_ERR(data->cb_buffer)) {
> -		if (PTR_ERR(data->cb_buffer) == -ENODEV)
> -			ret = -EPROBE_DEFER;
> -		else
> -			ret = PTR_ERR(data->cb_buffer);
> -
> -		goto error_unreg_buffer;
> -	}
> -
>  	data->adc_chan = iio_channel_cb_get_channels(data->cb_buffer);
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_unreg_cb_buffer;
> +		goto error_unreg_trigger;
That doesn't smell right either.   The most recent thing to undo after
the reorg is triggered_buffer_cleanup(). 

Take a very close look at the ordering.

>  
>  	return 0;
>  
> +error_unreg_trigger:
> +	iio_trigger_unregister(data->trig);
> +
>  error_unreg_cb_buffer:
>  	iio_channel_release_all_cb(data->cb_buffer);
>  
>  error_unreg_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
As per the above. These are in the wrong order - they need to
unwind in reverse of above. That means that error_unreg_cb_buffer
belongs down here (1st thing setup above).

>  
> -error_unreg_trigger:
> -	iio_trigger_unregister(data->trig);
> -
>  	return ret;
>  }
> 
I've also clearly been dozing whilst reading this -> If you move stuff
in probe order, then you need to move it in remove to unwind in the
opposite order.  It might not be a bug to not do so, but it is harder
to reason about.

So remove should be (I think)

iio_device_unregister()

iio_channel_stop_all_cb() // kind of unwinds cb_get_channels()? 
//I'm fairly sure that isn't needed as all paths that turned it on will
// have been unwound before we get to here - but can't test - so lets
// leave it in place.

iio_triggered_buffer_cleanup()
iio_trigger_unregister()
iio_channel_release_all_cb()

Anyhow, take a close at those flows and convince yourself your
updated patch does everything in error and remove paths in the
correct order.

Jonathan





