Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778C305667;
	Fri, 15 May 2026 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865576; cv=none; b=bPjomlZGcSDLm1iQ8rUY3tnciZw89CcGevxZFNhKmcX1h63IZ1CX1JAaFPSBUkiWWzvZS57PSiYtFRpKc23rU77JIezcTnRiaiws+MvzhhiwiAR9fQmTtZqIhOfYGyIT7zDUNTc9zC0mlnQYZREFandabZzrVovZUMOK+NjdydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865576; c=relaxed/simple;
	bh=MIX5yhjyMewZ2f91SKtbvkAi0d94Tvj08jEy7R4qYok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWPj+KLJjdwReH8vxpNuRO4jabA/Gxzpo//A5M7wdIQTSf3/iqugjdnENuXQ102QRK7pJl+NdsdBqVzVKXKfr+HOfJ9CrOPmw5Yg5iq/e03H3n7s9AkAqlKhFS8g2T9I8BBfi8+TXjcqYkoqAyYwsHnDsWsGI16H7/PscmmmXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsWv2i/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsWv2i/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D1CC2BCB0;
	Fri, 15 May 2026 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778865575;
	bh=MIX5yhjyMewZ2f91SKtbvkAi0d94Tvj08jEy7R4qYok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NsWv2i/Sev/lbjfX+yFX06d6XxgxJxuySCl11gDzejV5oN18X5jMBjv6J4/KtjlMp
	 Estol0EZN7T7rELBgeN6dYPsAXdAyH8GGc/ijd1UZMIvfekSz7tESjBI2d7sCyxnul
	 S1L8Gm/nMcd7WGca1bQTJWkZCy+jUnjFf5TNITrFBYeGI8Ao4um4salOl09uvmSqpx
	 hiGoc3UazpLquNLlmWmClVng0Pm8yeNGEFtszF/RUOPYEe5WN2ZWYLMYjmCkCYZQvw
	 QbDDe05c0DB2NBsd5uPVBgvhjvEaP+1jEPgKxe5mbVCi0bjsDJWy3mk2Flqj82/JnP
	 qdq7mp/nfGHBw==
Date: Fri, 15 May 2026 18:19:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 3/5] iio: light: tcs3472: use devm for resource
 management
Message-ID: <20260515181927.04b14d95@jic23-huawei>
In-Reply-To: <20260512223215.25596-4-aldocontelk@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
	<20260512223215.25596-4-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 00:32:13 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> Convert the driver to use device-managed resource allocation:
> - Add tcs3472_powerdown_action() and register it with
>   devm_add_action_or_reset() to ensure the device is powered down on
>   cleanup. Before this patch, the chip remained powered if probe
>   failed after enabling it.
Hi Aldo,

This is a precursor. Do it without devm first (using effectively
same call but under and error label.  Then devm conversion will be a
no-op patch  - which is much easier to review.


> - Replace iio_triggered_buffer_setup() with
>   devm_iio_triggered_buffer_setup().
> - Replace request_threaded_irq() with devm_request_threaded_irq().
> - Replace iio_device_register() with devm_iio_device_register().
> - Remove tcs3472_remove() as all cleanup is now handled by devm.
> 
> Rewrite the read-modify-write pattern in tcs3472_powerdown() and
> tcs3472_resume() so the new register value is computed first, written
> to the chip, and committed to data->enable only on success.

This belongs in the guard() patch that enables that change.

> 
> Use a local 'dev = &client->dev' in tcs3472_probe() to keep the devm
> calls compact.

All the comments are not about the end result but rather about
how to break this up. 
1. Start with a fix for the failure to power down.  May not be one
   we bother backporting - but nice to be able to (move that ahead
   of the guard patch - note that will involve moving the powerdown()
   function without modifying it at that point. Will make later patches
   easier to read as a nice side effect.
2. Move the guard() related stuff to earlier patch - refactors as a direct
   result of using guard() belong there not in a patch doing anything else.
3. The devm conversion - should be easier to see it's like for like.
4. Remaining uses of struct device *dev in probe()

So effectively 3 patches + some stuff in earlier one.

Getting used to making series as readable as possible for reviewers
is a skill that takes some work!  It is easy to go too far the other
way as well so you may well get some review comments in future saying
to combine patches :(

Jonathan

> 
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> ---
> v2:
> (Suggested by Andy)
> - Rewrote read-modify-write in tcs3472_powerdown() and tcs3472_resume()
> - Use local 'struct device *dev = &client->dev' in probe.
> - Dropped "Compiled with W=1" and test details from the commit message.
> 
>  drivers/iio/light/tcs3472.c | 107 +++++++++++++++++-------------------
>  1 file changed, 51 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 4fd4fd74d0d6..7a6dc8360326 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -427,13 +427,38 @@ static const struct iio_info tcs3472_info = {
>  	.attrs = &tcs3472_attribute_group,
>  };
>  
> +static int tcs3472_powerdown(struct tcs3472_data *data)
> +{
> +	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
> +	u8 value;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
Whilst the move needs to be here, the refactor should be in
the previous patch (as guard() related).  Obviously bit tideous
to touch the code then move it but I think it will be easier to review.

> +
> +	value = data->enable & ~enable_mask;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
> +	if (ret)
> +		return ret;
> +
> +	data->enable = value;
> +
> +	return 0;
> +}
> +
> +static void tcs3472_powerdown_action(void *data)
> +{
> +	tcs3472_powerdown(data);
> +}
> +
>  static int tcs3472_probe(struct i2c_client *client)
>  {
> +	struct device *dev = &client->dev;
>  	struct tcs3472_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
As below. I'd keep the switch to dev for a separate patch.
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
> @@ -453,9 +478,9 @@ static int tcs3472_probe(struct i2c_client *client)
>  		return ret;
>  
>  	if (ret == 0x44)
> -		dev_info(&client->dev, "TCS34721/34725 found\n");
> +		dev_info(dev, "TCS34721/34725 found\n");

Whilst it's good to put the dev in for the calls that are otherwise
changing it would be better to not touch anything that isn't.  Leave
those for a follow on patch 

.... : Use locale struct device * for remaining cases
or something like that.
Aim is to have this patch (and devm patches are hard to review) do
the minimum relevant stuff.

>  	else if (ret == 0x4d)
> -		dev_info(&client->dev, "TCS34723/34727 found\n");
> +		dev_info(dev, "TCS34723/34727 found\n");
>  	else
>  		return -ENODEV;
>  
> @@ -497,59 +522,26 @@ static int tcs3472_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -		tcs3472_trigger_handler, NULL);
> +	ret = devm_add_action_or_reset(dev, tcs3472_powerdown_action, data);
Do prior to this change set am I right in thinking the device simply wasn't
powered down on error?  If so I would fix that as a precursor patch (with an extra
label and direct call of tsc3472_powerdown())  Then do the devm conversion
on top of that.

> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      tcs3472_trigger_handler, NULL);
>  	if (ret < 0)
>  		return ret;
>  
>  	if (client->irq) {
> -		ret = request_threaded_irq(client->irq, NULL,
> -					   tcs3472_event_handler,
> -					   IRQF_TRIGGER_FALLING | IRQF_SHARED |
> -					   IRQF_ONESHOT,
> -					   client->name, indio_dev);
> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +						tcs3472_event_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_SHARED |
> +						IRQF_ONESHOT,
I'd break this as
						IRQF_TRIGGER_FALLING |
						IRQF_SHARED | IRQF_ONESHOT,
or
						IRQF_TRIGGER_FALLING |
						IRQF_SHARED |
						IRQF_ONESHOT,



> +						client->name, indio_dev);
>  		if (ret)
> -			goto buffer_cleanup;
> +			return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto free_irq;
> -
> -	return 0;
> -
> -free_irq:
> -	if (client->irq)
> -		free_irq(client->irq, indio_dev);
> -buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	return ret;
> -}
> -
> -static int tcs3472_powerdown(struct tcs3472_data *data)
> -{
> -	int ret;
> -	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
> -
> -	guard(mutex)(&data->lock);
> -
> -	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
> -		data->enable & ~enable_mask);
> -	if (!ret)
> -		data->enable &= ~enable_mask;
> -
> -	return ret;
> -}
> -
> -static void tcs3472_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	if (client->irq)
> -		free_irq(client->irq, indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	tcs3472_powerdown(iio_priv(indio_dev));
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static int tcs3472_suspend(struct device *dev)
> @@ -563,17 +555,21 @@ static int tcs3472_resume(struct device *dev)
>  {
>  	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev)));
> -	int ret;
>  	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
> +	u8 value;
> +	int ret;
>  
>  	guard(mutex)(&data->lock);
>  
> -	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
> -		data->enable | enable_mask);
> -	if (!ret)
> -		data->enable |= enable_mask;
> +	value = data->enable | enable_mask;
>  
> -	return ret;
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
> +	if (ret)
> +		return ret;
> +
> +	data->enable = value;

I think this change belongs in the previous patch - it's not related to devm
whereas it is related to the guard() change.

> +
> +	return 0;
>  }
