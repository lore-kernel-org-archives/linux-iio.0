Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C28345CDA;
	Fri, 15 May 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851052; cv=none; b=P7m3yLHXcGdia0zxrWlefJwhLHRsLR/QCR7j3GygLmcgZu2yfD0/GxjZXAuV+X54fquDvZ7qZDJqpKxOn4GI8Vkuc4ha5+yOHDLca1YQPizvd7dCza4vV8+MOxKtbN+TPrB8skbv94ylAQ9ouX35vch+pZgbjaMCsWlbAGFgP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851052; c=relaxed/simple;
	bh=v4d/zTSl9F86SeTD2rtQaaNFZ0gn111Rdv0kWzNsDng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJoFrX/KYZnp445Rn9O1baEZm0513oAg+a6/lRbCG31tlCopo7DcPYiZJpvqoIg5nyGoYK4Y0u8zF2lHxHs/O6R3aa5ZOXtV9cdkDjSHlZsTH7BpBxQs/+ljcYsOq9qJO4mrRZFBGMQHuNnIUG6IVb5mOMzWtB01Dl58cdbFWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCQHyEch; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCQHyEch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65CDC2BCB8;
	Fri, 15 May 2026 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778851052;
	bh=v4d/zTSl9F86SeTD2rtQaaNFZ0gn111Rdv0kWzNsDng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PCQHyEchGODPCQkkTPaUUIXJ75xfZO7VtKYS0PPslBmJGG65iB6FKqBWidESppZtA
	 vIsUa5WrgjaRUUczaBRtmav7vDdQEXQp9QaPiv/qwB18zpacyXnvIKs1Pxs38Hg79i
	 tYX1IJhe5yWLCYvc16rEFmxjOIlHKQfOzQ5oAiGdyMqDRi9gAArrdtvkdWCRkMtk9i
	 Lyd0E7BXU5kOHqJqxVGvhJ2qhgOzxKZr7cFyGrMYFFqU7XHzL6EVts+5a31ysOuGKC
	 btNVPjOQQL17RQwXieLUQ7Az27wDYxrFhNPniZBLM1+ZaTFz4gpz2vciGuaxzSndtM
	 VJdSRZMgIIJbQ==
Date: Fri, 15 May 2026 14:17:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] iio: magnetometer: ak8975: ensure device is awake for
 buffered capture
Message-ID: <20260515141723.5fbcaeca@jic23-huawei>
In-Reply-To: <20260513-ak8975-fix-v1-1-104ea605dd54@gmail.com>
References: <20260513-ak8975-fix-v1-1-104ea605dd54@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 16:35:52 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Currently, the ak8975_start_read_axis() can be called while the device
> is autosuspended, causing two issues:
> 
> 1. I2C transfers in the aforementioned function will fail or timeout
> because ak8975_runtime_suspend() disables the device regulators.
> 2. Since ak8975_fill_buffer() does not hold runtime references,
> ak8975_runtime_suspend() can run concurrently, and since PM callbacks
> do not use a locking mechanism, it may cause a race accessing the
> control register via the I2C bus.
> 
> Fix this issue by adding struct iio_buffer_setup_ops that contains
> preenable and postdisable functions to ensure correct that device is
> powered on when running a buffered capture.
> 
> Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6%40gmail.com
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
I'm going to take this as a clear improvement but the point sashiko makes
about turning runtime PM on only after the interfaces are exposed is possibly valid
as a general comment.  It applies to all the other paths though, not just
the buffered capture.

I believe we are actually fine here because the device is powered up
at that point (the set_active making that clear).

Open to other people's views on this though.

This is another place where we really should work out a best practice
guide / set of standard patterns to use.

Anyhow, applied this one and this is one I've marked for stable.
However given mass of stuff around this driver it'll still go the slow
way and we may need to manually do backports.  So applied to the
testing branch of iio.git.

Thanks,

Jonathan


> ---
>  drivers/iio/magnetometer/ak8975.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index dbab4d0bba348be70e5c8b71678de935879bff42..0fb2fd03d11ce195a67949056c000c473a8d3e99 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -899,6 +899,28 @@ static irqreturn_t ak8975_handle_trigger(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static int ak8975_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ak8975_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +
> +	return pm_runtime_resume_and_get(dev);
> +}
> +
> +static int ak8975_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ak8975_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ak8975_buffer_setup_ops = {
> +	.preenable = ak8975_buffer_preenable,
> +	.postdisable = ak8975_buffer_postdisable,
> +};
>  static int ak8975_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> @@ -992,7 +1014,7 @@ static int ak8975_probe(struct i2c_client *client)
>  	indio_dev->name = name;
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
> -					 NULL);
> +					 &ak8975_buffer_setup_ops);
>  	if (ret) {
>  		dev_err(&client->dev, "triggered buffer setup failed\n");
>  		goto power_off;
> 
> ---
> base-commit: 1548c54e9adc32a719499216f63fba14b2fc07c3
> change-id: 20260513-ak8975-fix-53b1b02857dd
> 
> Best regards,

