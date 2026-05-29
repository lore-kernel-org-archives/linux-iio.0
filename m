Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9E375ABE;
	Fri, 29 May 2026 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075187; cv=none; b=jhMuEvMAQ2rbthIM2Bh/HTWd1oDm2kTpYMr6ldZHoZXKIEMwu9rn8FTXO3kDa5HW8dpzVepTTJkt20i/nh+uF9PHUqIu8GouErrleihOQm/sWsGWjtQ8/NtkUjrbXsowM3FeAFLcpXXNTbJyKdAL3vNHBOAQLpa7c4YZWDRo46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075187; c=relaxed/simple;
	bh=KWlaNxIFQW7MSwWN8K3lDeIpni2gWvxfhFuuSqgkFEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWwnE5cqrV4hBMLP+9DjX6AzJnPVJYYdLjND16YbNUDK3saOx+e2HptkowqQfK1RFKs6RS5Pg5kdpqHdI+bDoE8cPNZpL5NVAr3oxlGOhgcBH0nUKCaRHoZGCddMuBDtwVOIZAEyMHXUj2kA9ObcbY6V//pyEitxQQNXfevCbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O671kPLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O671kPLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253AB1F00898;
	Fri, 29 May 2026 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075186;
	bh=YLuaa8OlE5wur0dXPgONyE2ZlU7EasrK1yJWKuAoums=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O671kPLLCV/IrIIR/wBwq0scVQ9DOO6xhpdvyfmGgeFtrIpWcveupnoQJ3wg+niTi
	 INe4onWnJLBzrXyaG1xPVd3qfsM+242/0T4PIE2Rh6i5rbV560CcYoiijY/lU38bYY
	 cZWOyoRUCdqefJvqLm+WTVyIcAnGtSaOg5SPLScpcT98Vah6i9ViratoFuyYF3q6Q2
	 PzjXpBedM9Zin9AkX0faa5Pmbfd7zCnjKZ7+CruHPoVK9FPS6vtPgla477CmqRHPYv
	 Ai78NqOCX32oEZ6QTH01CFJmdbxnZ+1T97EDibSiv4Eh91XNiWcXEtTvO4qAJ41Jzz
	 fabe7h5Pt/K5Q==
Date: Fri, 29 May 2026 18:19:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: light: pa12203001: use
 devm_pm_runtime_enable() to fix probe error path
Message-ID: <20260529181939.53e85d3e@jic23-huawei>
In-Reply-To: <04c4962d435d4df8e8ce6655598c0964014392f1.1780051096.git.sozdayvek@gmail.com>
References: <cover.1780051096.git.sozdayvek@gmail.com>
	<04c4962d435d4df8e8ce6655598c0964014392f1.1780051096.git.sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 15:45:41 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> pa12203001_probe() calls pm_runtime_enable() and then
> iio_device_register().  If iio_device_register() fails the function
> jumps to out_err but the existing out_err handler does not call
> pm_runtime_disable(), leaking the runtime PM enable_count on probe
> failure and on subsequent rebind.
> 
> Switch to devm_pm_runtime_enable() so the enable (and the matching
> dont_use_autosuspend) are torn down automatically.  On its new error path
> the probe jumps to the existing out_err label so the chip-disable cleanup
> stays in step with the rest of the manual unwind.  The pm_runtime_disable()
> and pm_runtime_set_suspended() calls in pa12203001_remove() are dropped;
> the devm action runs after .remove() and handles the teardown.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/light/pa12203001.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index 98a1f1624c75..b9f50c9070a3 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -372,7 +372,9 @@ static int pa12203001_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		goto out_err;
>  
> -	pm_runtime_enable(&client->dev);
> +	ret = devm_pm_runtime_enable(&client->dev);
> +	if (ret)
> +		goto out_err;

A goto after a devm call is a big warning flag.

A quick look suggests easy enough to solve with a devm_add_action_or_reset();
Probably needs to be a precursor patch to this one.



>  	pm_runtime_set_autosuspend_delay(&client->dev,
>  					 PA12203001_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> @@ -395,9 +397,6 @@ static void pa12203001_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
> -
>  	ret = pa12203001_power_chip(indio_dev, PA12203001_CHIP_DISABLE);
>  	if (ret)
>  		dev_warn(&client->dev, "Failed to power down (%pe)\n",

