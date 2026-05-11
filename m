Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AC3EAC9A;
	Mon, 11 May 2026 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506368; cv=none; b=a+U3VMoC1+zXwEJlbY/lMr4YqBV9DeJ/qv81BLzM1X/HNwS6EPqL8kwGMayaPqjv36fCVx+4kLzQe6Vdr3lnIiMyxfozN9H8VS+leXioo+i5h9RGgo1Y5+G/gDZpJEVvGnyH9pmKE4IFeOTzUvblFJ+lZRK78UvxJ5CL5Ccw1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506368; c=relaxed/simple;
	bh=Xy0jOASYprqQMLN9fRqH4R9OQ7/u/8jfBN8y34JbdE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEp2CPFYPfXQKhbNj4aAfwBNfoxL5xG4cz4KE1HCHj/JdBac/OXxVLyZZ/Gm2GZkCbbLZmVLONWGTXQLFNTILyH50oAM4+Qhey16VpFCkdY432LCN4U+Blu0QGx+RoJ9/9QUxvjXV8301F9KJlcURwSJ0ByYMLtKeWezKLAspLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU1dBsMf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU1dBsMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF07DC2BCC9;
	Mon, 11 May 2026 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778506365;
	bh=Xy0jOASYprqQMLN9fRqH4R9OQ7/u/8jfBN8y34JbdE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AU1dBsMffZk4IHrn5jG3CQRXT3sYs4dU3BeYc0Ee2o+10aMjWYrom4Vi75OCSmvrG
	 UNAxkN4QyUkMv+EBI7ZNECVsU6vqniWhi0qEKs1+aLdYyAPRIR8hh7TMdDfZqbMYmH
	 p2j+CHDY3QP42FH0dLT9eKEc2wXGkjmzLcowgQw0w1AYWjLctz2cLgHJtT4kcXRDYd
	 HrjCAUE/WZ50xfvlXPF0hjq1EsrgBswqi6MYmRFEwe6XftSvvzOS9ezpnGHV2kZo1a
	 pXfQY3Z2b9/0oDOmLnor7iQFdHdJCiIodnl9rKa364nRwAsW6rDAiKg/4FPgB9kND8
	 5UaKm+hO/bSkQ==
Date: Mon, 11 May 2026 14:32:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: light: opt3001: switch driver to managed
 resources
Message-ID: <20260511143237.040382d8@jic23-huawei>
In-Reply-To: <20260511-opt3001-cleanup-v1-7-f7879dc3455c@gmail.com>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
	<20260511-opt3001-cleanup-v1-7-f7879dc3455c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 12:04:12 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Move the driver to use devm_* functions to automate resource
> management and simplify error handling. This also allows removal
> of the opt3001_remove() function.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Hi Joshua

A few things inline.

Jonathan

> ---
>  drivers/iio/light/opt3001.c | 67 +++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 155794bb28f68a945e20b083e382561ca6ad462e..3ea18d8993da627ae226ac414e8035d8c968861b 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -804,6 +804,29 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
>  	return IRQ_HANDLED;
>  }
>  
> +static void opt3001_power_off(void *data)
> +{
> +	struct opt3001 *opt = data;
> +	int ret;
> +	u16 reg;
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +			OPT3001_CONFIGURATION);
> +		return;
> +	}
> +
> +	reg = ret;
> +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
> +
> +	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> +					   reg);
> +	if (ret < 0)
> +		dev_err(opt->dev, "failed to write register %02x\n",
> +			OPT3001_CONFIGURATION);
> +}
> +
>  static int opt3001_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -822,7 +845,10 @@ static int opt3001_probe(struct i2c_client *client)
>  	opt->dev = dev;
>  	opt->chip_info = i2c_get_match_data(client);
>  
> -	mutex_init(&opt->lock);
> +	ret = devm_mutex_init(dev, &opt->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize mutex\n");

Don't print on this one.  I'm fairly sure it can only return -ENOMEM as
part of devm registration failing and for those we don't print errors.
dev_err_probe() won't print anything anyway so it's just noise having
it here.


> +
>  	init_waitqueue_head(&opt->result_ready_queue);
>  	i2c_set_clientdata(client, iio);
>  
> @@ -836,6 +862,10 @@ static int opt3001_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(dev, opt3001_power_off, opt);
> +	if (ret)
> +		return ret;

This is undoing only part of what happens in the previous call (I think)
and if we get an error in there (opt3001_configure()) we don't turn the
power off again.  I'd move this registration into that function - probably after
the configuration write but before the thresholds etc are set.

That way those error paths are covered and it's more obvious what this
is undoing.

> +
>  	iio->name = client->name;
>  	iio->channels = *opt->chip_info->channels;
>  	iio->num_channels = opt->chip_info->num_channels;
> @@ -849,9 +879,9 @@ static int opt3001_probe(struct i2c_client *client)
>  
>  	/* Make use of INT pin only if valid IRQ no. is given */
>  	if (irq > 0) {
> -		ret = request_threaded_irq(irq, NULL, opt3001_irq,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				"opt3001", iio);
> +		ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,

Hmm. Without hardware too risky I think to touch it, but why is this only registering
the interrupt after the userspace interfaces? That seems to be a nasty race.

> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						"opt3001", iio);
>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  					     "failed to request IRQ #%d\n",
> @@ -864,34 +894,6 @@ static int opt3001_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static void opt3001_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *iio = i2c_get_clientdata(client);
> -	struct opt3001 *opt = iio_priv(iio);
> -	int ret;
> -	u16 reg;
> -
> -	if (opt->use_irq)
> -		free_irq(client->irq, iio);
> -
> -	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> -	if (ret < 0) {
> -		dev_err(opt->dev, "failed to read register %02x\n",
> -				OPT3001_CONFIGURATION);
> -		return;
> -	}
> -
> -	reg = ret;
> -	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
> -
> -	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> -			reg);
> -	if (ret < 0) {
> -		dev_err(opt->dev, "failed to write register %02x\n",
> -				OPT3001_CONFIGURATION);
> -	}
> -}
> -
>  static const struct opt3001_chip_info opt3001_chip_information = {
>  	.channels = &opt3001_channels,
>  	.chan_type = IIO_LIGHT,
> @@ -930,7 +932,6 @@ MODULE_DEVICE_TABLE(of, opt3001_of_match);
>  
>  static struct i2c_driver opt3001_driver = {
>  	.probe = opt3001_probe,
> -	.remove = opt3001_remove,
>  	.id_table = opt3001_id,
>  
>  	.driver = {
> 

