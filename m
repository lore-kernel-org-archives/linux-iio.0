Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786635957;
	Fri, 29 May 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075350; cv=none; b=qm/Ot2L8zE+qE9YXIFTxVHLQo4AdIob0SHL1JTtkn4kUZgiGgTWH1SkSfCBe4y8MemhDn/du/0WLqTmiRrBEA3jJFyU0XU+YOuKiofS2A4V1nVZ5lNf7kdL37zKweL3es4A4CYIKQNB9CWCSbm+NfziOgUs4/AVhnVpv6Dt2QiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075350; c=relaxed/simple;
	bh=hJbZQQEWEIYZjQuSPzO1jd+4brIRBWpqzLQDzqoXhlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/3rDkOI87A21gkSxOcV7av878Nz1MhRJBexEGJjrt3ZRYmyJ1JNShE48U3SykweqXleicArfYisa5aFabG5p0c+h/YcoqoLLMg2Qk1l8GWHEPeZmUQpSFqK6VzBCvPkJM6hOZa0QyvqdUYzT29t6HUn832D0U+FQDMCmqtnWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv10+UyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv10+UyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFCC1F00893;
	Fri, 29 May 2026 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075348;
	bh=z1mf4XHLUExm3w+00D3liPQPIrVaDY4Ql+TvoiwCZO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hv10+UyQooiGA75GfsxiNsd0+NKfKu9OrLdWfDyskz/RaPlaK0zO4UCowHQMHfXWl
	 kjMx9SGx0xw5ejz4O+qGrH3lA86n/6MXOw0XRWL4pqdg027aZzzEzt51WALt2RJysf
	 jz601SSJPUP9Ss3aUKYQR+cevGG7157c/y3O6djdpdoXDPC+RrZxY3zNTJ6cxbMv8j
	 W6hiSLmJkbO5Qxw+RBeocel6k4+xGkglD5GVdIh6cuYFl3wzZae3Kgq9HAvVHxTdHT
	 a72gX5e2Z+wade1f2r5b29DbBUzwkwKY8fXVUOKir/0qnt10edVKouGSogwnYTcXll
	 dND/PSz3zh6bg==
Date: Fri, 29 May 2026 18:22:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: light: apds9960: use devm_pm_runtime_enable()
 to fix probe error path
Message-ID: <20260529182221.27f06999@jic23-huawei>
In-Reply-To: <abf95e4e9a43c08ce429578ea067155ff5178d73.1780051096.git.sozdayvek@gmail.com>
References: <cover.1780051096.git.sozdayvek@gmail.com>
	<abf95e4e9a43c08ce429578ea067155ff5178d73.1780051096.git.sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 15:45:43 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> apds9960_probe() calls pm_runtime_enable() and then several operations
> that may fail through goto error_power_down, ending with
> iio_device_register().  None of those error paths call
> pm_runtime_disable(), so the runtime PM enable_count leaks on probe
> failure and on subsequent rebind.
> 
> Switch to devm_pm_runtime_enable() so the enable (and the matching
> dont_use_autosuspend) are torn down automatically.  The probe error path
> on devm_pm_runtime_enable() itself is a plain return because no hardware
> has been powered on at that point.  The pm_runtime_disable() and
> pm_runtime_set_suspended() calls in apds9960_remove() are dropped; the
> devm action runs after .remove() and handles the teardown.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/light/apds9960.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 785c5dbe2d08..edbf149b931e 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -1074,7 +1074,9 @@ static int apds9960_probe(struct i2c_client *client)
>  	if (ret)
>  		goto error_power_down;
>  
> -	pm_runtime_enable(&client->dev);
> +	ret = devm_pm_runtime_enable(&client->dev);
> +	if (ret)
> +		return ret;

Leaves the power on.  And resolving that would have the same issue
as the previous two patches with being a mix of goto and devm cleanup.

Very strong advice on this is the moment anything at all needs to be in remove()
you have to stop using devm for remaining calls and unwind them by hand.

>  	pm_runtime_set_autosuspend_delay(&client->dev, 5000);
>  	pm_runtime_use_autosuspend(&client->dev);
>  
> @@ -1123,8 +1125,6 @@ static void apds9960_remove(struct i2c_client *client)
>  	struct apds9960_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
>  	apds9960_set_powermode(data, 0);
>  }
>  

