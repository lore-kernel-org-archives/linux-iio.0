Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795825817;
	b=QAxQVz2Jh904fDx0FTkYb3PxUFQobgqFip6F3y7L8hvVJc+EnOmtQ3LkA7tDSGGPiCCF
	 9mK9454qCVkgr+GKooHoWIAvNCN96OA1Y650dgx1JZgzBOIvYDyYBgdprcUKaSeNtMNse
	 b/NGuvV7d3YrhY46frA+VfyuTzBzbAsR34x2agUNETimLNIqn44SsROPyYPdWlsy6YWyC
	 AT/uOwmjrR86lEDfqK1aaOykdQDvUXVucP5pnf7jCgwO5TS1OMn934yZUxGiPl5PUjRZI
	 zO5KmzrLJ7YC/n/uAIRwM/tduZsL/Yf9l0jbmbTUg8vQYRsB4xsM/UE188tAYPKqkRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795825817;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pxZI9gh/9ZkglNz+zrfQgh/UJnhjF/6noTEZDTgaBSs=;
	b=FDEGfHVQCJFFqmbPNmTm9JtJngcR2H6gXLSK/QQSXpumkeSOdDDOMPpbUMmJh27CpmRb
	 dJqI5uslpK2W6Ae9hEYxIkI2HR2ImQMEd6CYPP7FSKEcMVLSzwJ+25KggvT0F6NolYKBP
	 RlC0zdaSzQcHXVn/D4PTJ33KWcDSKvtBgdpTTiUPx5FrABjh3XH9437ib8CXQxVsBX/uc
	 +5WyR5I0hnlYMXet4dC+wKJwa89a3CmKPoppDHxSxJwRIjxQl5iDHJJhStbBUJbuJZjfA
	 84Jo2beGdOUiFRsbIbU6F1o5kmyIml+Vl2EGR/4baLYyxs3ipdOjdEHw5GbUiMcfnDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRXo4nm6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1D606A31C;
	Sat, 28 Nov 2026 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRXo4nm6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598601F000C1;
	Sat, 28 Nov 2026 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795825816;
	bh=pxZI9gh/9ZkglNz+zrfQgh/UJnhjF/6noTEZDTgaBSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QRXo4nm6Ki7gqXcqk8PZ0eQ7xEs0GPPRb48w25CiMwtq/zBdOObeArLS8PzcP0eac
	 u9Hg5wevAsepiDcIRNyn4WyR6jMsxgxH/FsA7lim64b4Jg7YOYMX1xn3V36rWAbg8p
	 PPH5Uu+Svrdtk6InTjMD7sfJxFXI6soCSL37ZY9xedBDte0a+IrSF9GjP5LlYB9DV1
	 HVVdFbP1qGwsBjv/PiE8OJqbIXyiMX8UNeM5m9PQqO7JG4l7Z46pjww/7SfUVWVqAK
	 RytW1lNQF/xrZqHRAA0Xz8Ctq5HO5ri/N6DuH+b1aB4rHMEFYqKj8UcrfgHab7tIS7
	 uA0ZpyJaPM6gw==
Date: Sat, 28 Nov 2026 00:30:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org>
Cc: development@redaril.me, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Peter Rosin
 <peda@lysator.liu.se>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: afe: iio-rescale: Add platform IDs
Message-ID: <20261128003010.6b36fa7b@jic23-hlaptop>
In-Reply-To: <20261128-iio_rescale_platform_ids-v2-2-4c35f16c4f77@redaril.me>
References: <20261128-iio_rescale_platform_ids-v2-0-4c35f16c4f77@redaril.me>
	<20261128-iio_rescale_platform_ids-v2-2-4c35f16c4f77@redaril.me>
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

On Sat, 28 Nov 2026 00:22:10 +0100
Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org> wrote:

> From: Fabio Forni <development@redaril.me>
> 
> When a rescaler is dynamically instantiated and configured with swnode,
> device_get_match_data() will always set rescale->cfg to NULL, because
> device_get_match_data() is unimplemented for software nodes.
> 
> Define a platform_device_id table (a replica of the of_device_id table)
> and call the platform_get_match_data() helper, to deal with both
> swnode-based and non-swnode-based instantiation methods.
> 
> Signed-off-by: Fabio Forni <development@redaril.me>
> ---
>  drivers/iio/afe/iio-rescale.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index c01292a15a29..c268dbaaaea6 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -518,6 +518,21 @@ static const struct of_device_id rescale_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rescale_match);
>  
> +static const struct platform_device_id rescale_platform_ids[] = {
> +	{ .name = "current-sense-amplifier",
> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[CURRENT_SENSE_AMPLIFIER] },
	{
		.name = ...
		.driver_data = ...
	}, {
		.name = ...
Or 
	},
	{

I don't mind on that bit, but use a few more lines to make it easier
to add additional fields in future and generally make it easier to read.


> +	{ .name = "current-sense-shunt",
> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[CURRENT_SENSE_SHUNT] },
> +	{ .name = "voltage-divider",
> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[VOLTAGE_DIVIDER] },
> +	{ .name = "temperature-sense-rtd",
> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[TEMP_SENSE_RTD] },
> +	{ .name = "temperature-transducer",
> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[TEMP_TRANSDUCER] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, rescale_platform_ids);
> +
>  static int rescale_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -548,7 +563,7 @@ static int rescale_probe(struct platform_device *pdev)
>  
>  	rescale = iio_priv(indio_dev);
>  
> -	rescale->cfg = device_get_match_data(dev);
> +	rescale->cfg = platform_get_match_data(pdev);

Can we get a failure here?  Forcing a driver bind to a device not in the tables
tends to end up with NULL and it is common to just fail probe if that happens.

>  	rescale->numerator = 1;
>  	rescale->denominator = 1;
>  	rescale->offset = 0;
> @@ -603,6 +618,7 @@ static struct platform_driver rescale_driver = {
>  		.name = "iio-rescale",
>  		.of_match_table = rescale_match,
>  	},
> +	.id_table = rescale_platform_ids,
>  };
>  module_platform_driver(rescale_driver);
>  
> 

