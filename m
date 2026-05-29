Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D78380FEC;
	Fri, 29 May 2026 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075245; cv=none; b=nCmbh7jXEwd5kcz+NOnayhX5yhEqY+aYmwxUv5Y8y/UdBpYtZ1a/cTYyJzbNoPPEBRQdAQ3mlJ9M/snDfcjTpStzkB3Pv5ve8996V/gVPflHlKz5mWrJTrsZgude31uV6kgFJZYye2HH3WzWZYpo45iCdZtQbJj2xBcOpdLe+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075245; c=relaxed/simple;
	bh=c4nhKXlyX2y+GflNZP+cB47ewDOcXUhlkkwgpojsQaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qi3lBLX4mctGjBi8FbjgFDqUoSEHkMMSTUcZXwRNZiXxpatK1bDBeVSJkJOESj5witso6DTX7YuHWuV2Fl6ZIMW5fNduIM7M1V+dA87saTJqH6xuS3ePzqRZuf32xzNOjm5E55Nb9gt3rKPAF0yL0YqWX8zBgXzPtjy0d7bfopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5shHjbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5shHjbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1251F00893;
	Fri, 29 May 2026 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075242;
	bh=8EDibRoqJdB5dW241NtayGMOSFaEcaYco2sc3T5i39A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b5shHjbqP6W3wDJwjWrtnwyXftCJQhALbDqa/dOO1DL6lv7LLhtv/Jj1hUTy/TSbF
	 NpKSeq53423KJjqVjDYcoEYvPqcFp95p+ruoH3/aJYvjTMsTy/B49h4nbk3er/62uT
	 YVW40mRaqp7Zy1FWn07AI4GbfhC1LjxDeI+jGnOQdTu4vGBCuafdADE+3hCgTMD/FS
	 ttYzyeX8xPtbo14cN5U+HqCKWtcU7GkszTXI424e4MlHas5qGFmyPq9Ck+LUbCzctt
	 ZAFamZ6p5Ar1BxiPXeUIGte55MyM+kjHnrjNevT5b3FbayRvJi1PLZn100P/Kgg8l/
	 S+53p6aqcPQ+g==
Date: Fri, 29 May 2026 18:20:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: light: us5182d: use devm_pm_runtime_enable()
 to fix probe error path
Message-ID: <20260529182034.12dfa221@jic23-huawei>
In-Reply-To: <ba9abb34df8a0b16015817c44bd4a22d53d2c065.1780051096.git.sozdayvek@gmail.com>
References: <cover.1780051096.git.sozdayvek@gmail.com>
	<ba9abb34df8a0b16015817c44bd4a22d53d2c065.1780051096.git.sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 15:45:42 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> us5182d_probe() calls pm_runtime_enable() and then iio_device_register().
> If iio_device_register() fails the function jumps to out_err but the
> existing out_err handler does not call pm_runtime_disable(), leaking the
> runtime PM enable_count on probe failure and on subsequent rebind.
> 
> Switch to devm_pm_runtime_enable() so the enable (and the matching
> dont_use_autosuspend) are torn down automatically.  On its new error path
> the probe jumps to the existing out_err label so the shutdown_en() cleanup
> stays in step with the rest of the manual unwind.  The pm_runtime_disable()
> and pm_runtime_set_suspended() calls in us5182d_remove() are dropped; the
> devm action runs after .remove() and handles the teardown.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Same a for patch 1. Needs more work so there is no goto.

> ---
>  drivers/iio/light/us5182d.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index d2f5a44892a8..ada75f710bfc 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -880,7 +880,9 @@ static int us5182d_probe(struct i2c_client *client)
>  			goto out_err;
>  	}
>  
> -	pm_runtime_enable(&client->dev);
> +	ret = devm_pm_runtime_enable(&client->dev);
> +	if (ret)
> +		goto out_err;
>  	pm_runtime_set_autosuspend_delay(&client->dev,
>  					 US5182D_SLEEP_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> @@ -904,9 +906,6 @@ static void us5182d_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(i2c_get_clientdata(client));
>  
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
> -
>  	ret = us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
>  	if (ret)
>  		dev_warn(&client->dev, "Failed to shut down (%pe)\n",

