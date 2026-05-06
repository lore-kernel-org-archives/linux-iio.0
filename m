Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CE4BC015;
	Wed,  6 May 2026 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089681; cv=none; b=Sh8+rl6hL/GDSO+1zSXyicIBWZB/f6uixWh3Tq+WbKxXG2OEhLm92PpNwkROy20NzOqQJUKx+z1r2GXl4/DiAbnM78U7nX7HJnZC7M3cmffHzzzsTHGWoniJTVC8LYXYatgMy0wEySqC94Oz3/+GO90dfX4INn/D8SQutYF06ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089681; c=relaxed/simple;
	bh=upSg/DpDm/+C63Eocm5VS7Kfe4aX6xz7+SaRhzfJXB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRb1iccO83hKKxGtDZRN84DmsAEeCN74zxlMrwZqhVBH2YsrVqlVSYNjmRycjEDqYNPY4Wq9zbCIPEtsIb3B6Aw0M/a/buj1S2dQh+kbR8wJEE/GSxb/iWb13JWYfg5d6F281SjmztJZKnJvmJLhKNI0kRq1rSOkpZ7lfUfPXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGUSurm4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGUSurm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37A2C2BCB0;
	Wed,  6 May 2026 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778089678;
	bh=upSg/DpDm/+C63Eocm5VS7Kfe4aX6xz7+SaRhzfJXB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nGUSurm4n6Q2gDKCVICaqMm3ifLnxAi/fMua6iD0DrRi5d84WpwqQY0wzqOL/sS1V
	 qYCzu3SQZtINdOsI2p0COUaOOn67hoot0lsg7UPJrd+iswADXHvKBaZG/vtCVO1V/S
	 AWYHBwXtnhzuc5rEUiua3sqDUuKFUTrC5rYNK4kgWAtYimVdleGB2g8stmxZj20r7o
	 R2aw1yCHb1JCgS306sNxdx8UaYr5L79C/H9l9hxMNn4KdWcO2NbxrPPxkuUkA2PeK3
	 pajuFBeDFtrLrCxqdlL3+FFZH+Mzdl4UHwCmpDwnAU25nOuhHhAwC+cboSyb+7vnLm
	 LPT3WtTkBwxoA==
Date: Wed, 6 May 2026 18:47:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] iio: accel: mma8452: switch to non-devm
 request_threaded_irq()
Message-ID: <20260506184749.5b69d86f@jic23-huawei>
In-Reply-To: <20260505174640.3998281-3-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-3-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 23:16:32 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Avoid using devm_request_threaded_irq() as the driver requires explicit
> error-handling path(s). Using devm_* API together with goto-based
> unwinding breaks the expected LIFO resource release model.
> 
> Add explicit IRQ cleanup in the driver teardown paths to follow kernel
> resource management conventions.
> 
> Fixes: 28e3427824cc ("iio: mma8452: Basic support for transient events.")
For a fixes tag we need to have an explicit issue rather than
it not following best practice.  Patch itself is correct, and if all
else is good and you don't have a specific ordering problem in mind
I'll just drop the fixes tag whilst applying.


> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/accel/mma8452.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index cefc7cf4bd83..279a9b364886 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1682,18 +1682,16 @@ static int mma8452_probe(struct i2c_client *client)
>  		goto trigger_cleanup;
>  
>  	if (client->irq) {
> -		ret = devm_request_threaded_irq(&client->dev,
> -						client->irq,
> -						NULL, mma8452_interrupt,
> -						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> -						client->name, indio_dev);
> +		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					   client->name, indio_dev);
>  		if (ret)
>  			goto buffer_cleanup;
>  	}
>  
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret < 0)
> -		goto buffer_cleanup;
> +		goto free_irq;
>  
>  	pm_runtime_enable(&client->dev);
>  	pm_runtime_set_autosuspend_delay(&client->dev,
> @@ -1702,7 +1700,7 @@ static int mma8452_probe(struct i2c_client *client)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> -		goto buffer_cleanup;
> +		goto free_irq;
>  
>  	ret = mma8452_set_freefall_mode(data, false);
>  	if (ret < 0)
> @@ -1713,6 +1711,10 @@ static int mma8452_probe(struct i2c_client *client)
>  unregister_device:
>  	iio_device_unregister(indio_dev);
>  
> +free_irq:
> +	if (client->irq)
> +		free_irq(client->irq, indio_dev);
> +
>  buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
> @@ -1738,6 +1740,9 @@ static void mma8452_remove(struct i2c_client *client)
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  
> +	if (client->irq)
> +		free_irq(client->irq, indio_dev);
> +
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	mma8452_trigger_cleanup(indio_dev);
>  	mma8452_standby(iio_priv(indio_dev));

