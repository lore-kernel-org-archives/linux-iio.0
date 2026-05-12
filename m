Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F33AFAF4;
	Tue, 12 May 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595969; cv=none; b=hs7Sku6G1hmxANca6zyhos/XjcWeIIdZI/j6eaBpIrGicQmQTVYUraorxPSUwiHG+WhURjk7LTs590D5N7QPcquk2udnoQe4TN0ousS8UjONqLST0nyyHfVyNLEteLOWymCcfSpeOY37EDZkRA5EPH2Uu9TL4KqwvwRaRCQp6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595969; c=relaxed/simple;
	bh=EYtJNTGix1ffkXhf5VB49qJE891RKBx7m+VdsYOjJ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iW6fI0S/qkB2v1wAelrYnIUy1U42u6ileocyBbCDOw/lveCuBXJfpRj3+GaYtR352fjbxemqtYHlYFhh9hZLWN/dXufWC9t4QypHTUielS7FLmJdqNHwlfNASxMltvBXsomaVSM9rjgC2mzbCF/rImTlYOweRruuDEC8Rrv1Ccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZJtKp32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZJtKp32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FC5C2BCB0;
	Tue, 12 May 2026 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595969;
	bh=EYtJNTGix1ffkXhf5VB49qJE891RKBx7m+VdsYOjJ5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZJtKp32SVhouSjVafhoijb7P1hcoobnsRCtZuCzMcVM/sTwfzPukPokjzzXOhvpA
	 ZEboM70Q5BVh4QtAeRNhsFIvTl5i64nMp2SELQIkHjjwDswHFOt9ngkQz92Jg+XzgT
	 vjz8fDA3H0BErMUXhB1CsygyOxSURsPnWJv9Gqfxzey/DAI/xNkeSsmMhkRVYHk8p1
	 8AEPgTDmEAgiAUNzVhQb+pQpBMd+fFD7bhdMaq8p6tjBnsJDZtULTNwUYY1kGdZMyp
	 rKPmrhnpwLwiQYqEIsjayIFaK1/TYJbZ72cDfuKHlmpdd/tkHNsM52dP67Zb+7iINP
	 qylmSwQCaEowA==
Date: Tue, 12 May 2026 15:26:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Alexander Koch <mail@alexanderkoch.net>, Michael Hornung
 <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] iio: light: opt3001: switch driver to managed
 resources
Message-ID: <20260512152600.764ff7c7@jic23-huawei>
In-Reply-To: <20260512-opt3001-cleanup-v2-9-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
	<20260512-opt3001-cleanup-v2-9-8018cf3a8a0a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 12:57:29 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Move the driver to use devm_* functions to automate resource
> management and simplify error handling. This also allows removal
> of the opt3001_remove() function.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Some trivial stuff inline.  I'll probably wait for sashiko to catch up with
it's backlog and get to this one.  If nothing comes up there or in other reviews
I'm fine tweaking the stuff below whilst applying the series.

Jonathan

> ---
>  drivers/iio/light/opt3001.c | 75 +++++++++++++++++++++++----------------------
>  1 file changed, 39 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 39ea60c0af2c1ec7473d49b73778cac1f9bb6086..1319e5941b66bd82e4dc2badf5ea27cacbcfd54a 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -702,6 +702,31 @@ static int opt3001_read_id(struct opt3001 *opt)
>  	return 0;
>  }
>  
> +static void opt3001_power_off(void *data)
> +{
> +	struct opt3001 *opt = data;
> +	struct i2c_client *client = opt->client;
> +	struct device *dev = opt->dev;
> +
Really trivial but why the blank line here?  If nothing else comes up
I might bother dropping it whilst picking up the series.

> +	int ret;
> +	u16 reg;
Obviously not a change you made - but none the less reg is a bad name.
It is often used for register address rather than value.  So better as
regval.  Again maybe I'll tweak this if nothing comes up but if you
do another version for other reasons nice to change it.

> +
> +	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read register %02x\n",
> +			OPT3001_CONFIGURATION);
> +		return;
> +	}
> +
> +	reg = ret;
> +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
> +
> +	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
> +	if (ret < 0)
> +		dev_err(dev, "failed to write to register %02x\n",
> +			OPT3001_CONFIGURATION);
> +}
> +
>  static int opt3001_configure(struct opt3001 *opt)
>  {
>  	struct i2c_client *client = opt->client;
> @@ -740,6 +765,11 @@ static int opt3001_configure(struct opt3001 *opt)
>  		return dev_err_probe(dev, ret, "failed to write register %02x\n",
>  				     OPT3001_CONFIGURATION);
>  
> +	ret = devm_add_action_or_reset(dev, opt3001_power_off, opt);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register power off function\n");
> +
>  	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "failed to read register %02x\n",
> @@ -834,7 +864,10 @@ static int opt3001_probe(struct i2c_client *client)
>  	opt->dev = dev;
>  	opt->chip_info = i2c_get_match_data(client);
>  
> -	mutex_init(&opt->lock);
> +	ret = devm_mutex_init(dev, &opt->lock);
> +	if (ret)
> +		return ret;
> +
>  	init_waitqueue_head(&opt->result_ready_queue);
>  	i2c_set_clientdata(client, iio);
>  
> @@ -856,13 +889,12 @@ static int opt3001_probe(struct i2c_client *client)
>  
>  	/* Make use of INT pin only if valid IRQ no. is given */
>  	if (irq > 0) {
> -		ret = request_threaded_irq(irq, NULL, opt3001_irq,
> -					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -					   "opt3001", iio);
> +		ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						"opt3001", iio);
>  		if (ret)
> -			return dev_err_probe(dev, ret,
> -					     "failed to request IRQ #%d\n",
> -					     irq);
> +			return ret;
> +
>  		opt->use_irq = true;
>  	} else {
>  		dev_dbg(dev, "enabling interrupt-less operation\n");
> @@ -876,34 +908,6 @@ static int opt3001_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static void opt3001_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *iio = i2c_get_clientdata(client);
> -	struct opt3001 *opt = iio_priv(iio);
> -	struct device *dev = opt->dev;
> -	int ret;
> -	u16 reg;
> -
> -	if (opt->use_irq)
> -		free_irq(client->irq, iio);
> -
> -	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to read register %02x\n",
> -			OPT3001_CONFIGURATION);
> -		return;
> -	}
> -
> -	reg = ret;
> -	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
> -
> -	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to write register %02x\n",
> -			OPT3001_CONFIGURATION);
> -	}
> -}
> -
>  static const struct opt3001_chip_info opt3001_chip_information = {
>  	.channels = &opt3001_channels,
>  	.chan_type = IIO_LIGHT,
> @@ -942,7 +946,6 @@ MODULE_DEVICE_TABLE(of, opt3001_of_match);
>  
>  static struct i2c_driver opt3001_driver = {
>  	.probe = opt3001_probe,
> -	.remove = opt3001_remove,
>  	.id_table = opt3001_id,
>  
>  	.driver = {
> 

