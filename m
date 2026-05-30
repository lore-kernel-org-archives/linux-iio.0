Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93331079B;
	Sat, 30 May 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780153858; cv=none; b=l5+iyFZL7F2IWpUSj6UWo/tgz1dtcdX0/hmj2O7hgaonLceLOld2QsiNWivDpZbysnhDQd2Mal30G+PYNgs0DwxIXFKTELgoXsZB89S7PwwYz23kuu7rywI7fWt/3yLFCgWJe3bnZZgNFx+m5tZbBUSuZ8UsIcxayEBHUv10IO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780153858; c=relaxed/simple;
	bh=F/koFu3owgjliup/OPGTczaNTWtF+ETzzpyNa/s2pFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbLKIC8TUBC279M1AwFx5iOcf9FYZWd6y3oZ5x6+5Rjt4tHa1++nUGS2UcNmqrYK+PGNGZEIXWKk+ZfvHw7qrkxSP22MYmqdck/bH+6h2KN0pHy1xZoRxR9yumZ+TFs7W9E9DSYoEKYawDxXEUGUaHImvJfKvQzeiMtjGQ2xO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc3TjrWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc3TjrWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6E61F00893;
	Sat, 30 May 2026 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780153856;
	bh=RyiLTfukQ5UJQX5GgXjDqcgmSbBrMqEAzX84ojaTuj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nc3TjrWmpWql7z4CHmWEKtTaemf2B3xwtx4Dum3LfzzwDaIOd4bJ7ZqxIEe+YO/ye
	 RVfqfNRBs3cukXOQ7ucb+4y4YM031igDFaVh6105OCm9XHGVRZA7u+cebTFesrQw2f
	 3qTxZ6Uxz/YJ112CiiialnaTgYtgk+1/3JVHx1ydrKQ3T17P64Xhx/CCXPfsrxhCl7
	 ZlD3dOedu09C0nr2HB3SEqk795JmtRPy6Tte0bIjZxWqb3wHO/XmscZ5s+/DS+TsJ+
	 7WoVmyU2BllgupjuJG7g2GU+hM/9jEFeTHQPLqSyLGJBBZsqQw3QVZB4F5iKlUy82T
	 k5OO6BaaSOgGQ==
Date: Sat, 30 May 2026 16:10:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, apokusinski01@gmail.com, me@brighamcampbell.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/4] iio: pressure: mpl3115: convert probe to fully devm
 managed
Message-ID: <20260530161048.0e2ce1fe@jic23-huawei>
In-Reply-To: <20260530113938.171540-2-suunj1331@gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
	<20260530113938.171540-2-suunj1331@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 20:39:35 +0900
SeungJu Cheon <suunj1331@gmail.com> wrote:

> Convert probe to use devm-managed resource allocation,
> removing the need for an explicit remove callback.

Hi SeungJu,

> 
> Replace iio_triggered_buffer_setup() and
> iio_device_register() with their devm equivalents.
> Register a devm action to return the device to standby,
> replacing the cleanup previously performed in
> mpl3115_remove().

This should have noted that in error paths the standby wasn't there and now is.
However see below; I think the patch need to be split in at least two parts.

Very short wrap.  Exactly whether to limit commit messages to 72 or 75 chars
is a bit of a matter of opinion, but this is 50 something.
> 
> Move mpl3115_standby() and suspend/resume helpers above
> probe to satisfy declaration ordering requirements.
Not obvious why the suspend/resume moved.  Just move the minimum to make
the patch easier to read.
> 
> No functional change.

Not true. That error path gaining suspend of device is a functional change.

> 
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 81 ++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index aeac1586f12e..befb6d48efa9 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -691,6 +691,33 @@ static int mpl3115_trigger_probe(struct mpl3115_data *data,
>  	return 0;
>  }
>  
> +static int mpl3115_standby(struct mpl3115_data *data)
> +{
> +	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +		data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);

Take opportunity to tidy indent up now we are less fuzzy about 80 chars.

	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
					 data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
is the preferred style.

> +}
> +
> +static void mpl3115_standby_action(void *d)
> +{
> +	mpl3115_standby(d);
> +}
> +
> +static int mpl3115_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

Andy covered this. I think we ripped out most instances of this a year
or so back as it is a pointless bit of bouncing back and forth between
container structure and the contained.

> +
> +	return mpl3115_standby(iio_priv(indio_dev));
> +}
> +
> +static int mpl3115_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +
> +	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +					 data->ctrl_reg1);
> +}

Andy called out the question of why these moved. It makes the patch
somewhat harder to review, so don't do that in this patch even if there
is a reason to do it. 

> +
>  static int mpl3115_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> @@ -730,53 +757,24 @@ static int mpl3115_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = mpl3115_trigger_probe(data, indio_dev);
> +	ret = devm_add_action_or_reset(&client->dev, mpl3115_standby_action,
> +				       data);

So in the error path for this function we will now call this standby
action. If there isn't an equivalent in the original code, break this up.

Patch 1. Add that cleanup without any devm stuff (almost a fix but it's
         only going to waste a bit of power in an unlikely error path so
	 we probably won't backport it).
Patch 2. Devm stuff.

>  	if (ret)
>  		return ret;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -		mpl3115_trigger_handler, NULL);
> -	if (ret < 0)
> +	ret = mpl3115_trigger_probe(data, indio_dev);
> +	if (ret)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto buffer_cleanup;
> -	return 0;
> -
> -buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	return ret;
> -}
> -
> -static int mpl3115_standby(struct mpl3115_data *data)
> -{
> -	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> -		data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
> -}
> -
> -static void mpl3115_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	mpl3115_standby(iio_priv(indio_dev));
> -}
> -
> -static int mpl3115_suspend(struct device *dev)
> -{
> -	return mpl3115_standby(iio_priv(i2c_get_clientdata(
> -		to_i2c_client(dev))));
> -}
> -
> -static int mpl3115_resume(struct device *dev)
> -{
> -	struct mpl3115_data *data = iio_priv(i2c_get_clientdata(
> -		to_i2c_client(dev)));
> +	ret = devm_iio_triggered_buffer_setup(&client->dev,
> +				      indio_dev,
> +				      NULL,
> +				      mpl3115_trigger_handler,
> +				      NULL);

Indent as something like:

	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
					      mpl3115_trigger_handler, NULL);

> +	if (ret)
> +		return ret;
>  
> -	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> -		data->ctrl_reg1);
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(mpl3115_pm_ops, mpl3115_suspend,
> @@ -801,7 +799,6 @@ static struct i2c_driver mpl3115_driver = {
>  		.pm	= pm_sleep_ptr(&mpl3115_pm_ops),
>  	},
>  	.probe = mpl3115_probe,
> -	.remove = mpl3115_remove,
>  	.id_table = mpl3115_id,
>  };
>  module_i2c_driver(mpl3115_driver);

