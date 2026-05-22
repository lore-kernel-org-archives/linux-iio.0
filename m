Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679839B493;
	Fri, 22 May 2026 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462129; cv=none; b=CgHBlwZtRk0fYN0kdWiff84al+vcImBOReVTXu9Xd6g4pVMJXhyktP/zMYdJz3vrlvZXo+K4vN3TAkrFnReCaqhbRghiSD4JB0/4nLGTYonlhXDPOiDltklwQoEFS9kUfKO84Ns/Gu3n3rbNYru+flPVhtPc9HXuV6ECDvIHFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462129; c=relaxed/simple;
	bh=AsLdi8xqpRHq/uiVDVBwje0EejhxCD0acrrUQhpLu14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYhGjf9M+dex6N4DehI4vt3T8cNp5CYgkFeMKae8xt9ztfDBwFaKSg/1iFy/UY6gKBtNvgGIZNz/nWXDJ2C0sRL3R1aomUMl/+qMnlyL8/UUHhSxYj1Aj8hqorXqeg8sM0pyCVytVOBTvtd2QnQ+NNB5Cf0CPvNeKVWqYZAuZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBhfBhaL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBhfBhaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5E51F00A3D;
	Fri, 22 May 2026 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779462127;
	bh=nmKZA/eTBYmZdhgEqSsXDeAbeGcmrMGoMlMJX9Z9mKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bBhfBhaL5lK/oNDjn7XyHdO1Ytf8G2xwe1d4Yh1M2GRMTzSjIFgklwHPEvGy76oqA
	 JkLjkHKzKffey1B45tc/jCDDk/2knUyGqMBb9oRijHj9kAhVKki1I/bdoYOUiN9R6g
	 X8glHT8lfMhGss1JQdQ7gZkl7MwO6GH61fCMmWX7V7/EYQdh0/qz6n0r1xQE0uRJTd
	 EfqZK7XI188QzGUx0fjBuEdrKCFCUrLM+48NXQfK5aYOTfCdSisE9PhTj6x8+L1YnW
	 Wp2qrrbsjWT9YPqbnAJ8knCBvIdqzf9M/U+yae1slegH6Q1GHARtSa0BluY/KGoZ66
	 f4THVITfWOZdQ==
Date: Fri, 22 May 2026 16:01:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Salah Triki <salah.triki@gmail.com>
Subject: Re: [PATCH] iio: potentiostat: lmp91000: fix NULL deref in probe by
 reordering setup
Message-ID: <20260522160158.43cd1645@jic23-huawei>
In-Reply-To: <20260520185142.34015-1-sozdayvek@gmail.com>
References: <20260520185142.34015-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 23:51:41 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> lmp91000_probe() calls iio_trigger_set_immutable() with
> iio_channel_cb_get_iio_dev(data->cb_buffer) before data->cb_buffer is
> assigned. The struct is zero-initialised by devm_iio_device_alloc(), so
> cb_buffer is NULL on entry, and iio_channel_cb_get_iio_dev() does an
> unconditional cb_buffer->indio_dev which dereferences NULL.
> 
> Reorder probe to acquire cb_buffer first (handling -EPROBE_DEFER) and
> only then set the immutable trigger, register the trigger, set up the
> triggered buffer, and register the iio device. Move the cb_buffer
> release to the end of the cleanup chain so a late failure properly
> unwinds in reverse order.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

Hi Stephan

Make sure to check the list before sending out a patch.
+CC Salah who is working on a fix for the same thing.

Jonathan

> ---
>  drivers/iio/potentiostat/lmp91000.c | 36 +++++++++++++----------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index eccc2a343..7a938a023 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -330,17 +330,27 @@ static int lmp91000_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb,
> +						 indio_dev);
> +	if (IS_ERR(data->cb_buffer)) {
> +		if (PTR_ERR(data->cb_buffer) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(data->cb_buffer);
> +	}
> +
> +	data->adc_chan = iio_channel_cb_get_channels(data->cb_buffer);
> +
>  	ret = iio_trigger_set_immutable(iio_channel_cb_get_iio_dev(data->cb_buffer),
>  					data->trig);
>  	if (ret) {
>  		dev_err(dev, "cannot set immutable trigger.\n");
> -		return ret;
> +		goto error_release_cb;
>  	}
>  
>  	ret = iio_trigger_register(data->trig);
>  	if (ret) {
>  		dev_err(dev, "cannot register iio trigger.\n");
> -		return ret;
> +		goto error_release_cb;
>  	}
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> @@ -349,35 +359,21 @@ static int lmp91000_probe(struct i2c_client *client)
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
> -	data->adc_chan = iio_channel_cb_get_channels(data->cb_buffer);
> -
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_unreg_cb_buffer;
> +		goto error_unreg_buffer;
>  
>  	return 0;
>  
> -error_unreg_cb_buffer:
> -	iio_channel_release_all_cb(data->cb_buffer);
> -
>  error_unreg_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
>  error_unreg_trigger:
>  	iio_trigger_unregister(data->trig);
>  
> +error_release_cb:
> +	iio_channel_release_all_cb(data->cb_buffer);
> +
>  	return ret;
>  }
>  

