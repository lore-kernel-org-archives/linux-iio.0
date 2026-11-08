Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794097323;
	b=KskZeec2/6JKqjn1UPORUf33XUHLmPPJE87ieaivdZVslg4qdvClDjH/x7ch3QjCSH2j
	 8aQ8tmQ0aAWd9nzr7TMtBJ5RUpsE+C8XmRm7jbPx0GgzMy/8NDGUVyxQ+3wpYVgHNA9Xm
	 3j/Mvk782amjvjSUkntN6+PfKF2b7rl/aQRBsHX9wvx3uGnzXtRjEkNpeXS9bSjz/qw6B
	 Fyg+INK4kJSneIqBmIYZDPTrmEV8rXY6YTJ0vCqwr0BKTsU7dEWjUDSPZMsNVaZn0lCeG
	 ypv0ZzGf3YK7JddKdlHPJLutFIOzcg+j0TtiVTvuw1Jh9XNLojtL9730JebBIEMpMUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794097323;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WGL9U5fhngMQywj8uyLoBWTBxovirxmHXPosFTCLpbE=;
	b=B50iTL+vaLJAq/fOWPlyGC/mzalDUnZOzKTg05itUd9F/5BGKcvWFFyufvFXtBfYyw9M
	 988uQSNYUS0GHD69FscME+okd/HrGe4OBDpe7wdxXnl3ZxCrq5hF0lOMiGjsiukESq6vj
	 byPsw5oi7C2u0GYszNdC3J6jIKUlPTB6CuqzRyg/LPH2jTZaJsQ2G333kzzIUfUVQp8B+
	 ljLrjZ6GXukyG5N3dkQeSfyVCRwUnbeU4XTSQedQWP8GN2w8A9N7zMKQ+8pvM0jMo/atd
	 WzkDtLf5cMg2DN/rWZz2T5yNMuSX+lNDPrqLzXrEIi7u2jeBkbbzLmfH3lzTAhXK5Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyTCHfef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8E606A326;
	Sun,  8 Nov 2026 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyTCHfef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596AA1F0089F;
	Sun,  8 Nov 2026 00:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794097323;
	bh=WGL9U5fhngMQywj8uyLoBWTBxovirxmHXPosFTCLpbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PyTCHfef+Iin6bylJzKwCB7xFTWlQhFtv9EjC7R6I9VnAiAHU5xhJIALh4arGd19p
	 Rr03I8ublWRAm75MFlUqX2bUReyVSILG/DNXX1tuXauhBfxJByfxwUBiRDpVGFxA9s
	 0FOeQjpLUfJ7d2pk13yEvIJMo9yqmVT2iCD6Ek4xpzKovTVQIHW7K0A5Il0L4WW/Os
	 n1wpkEusSfk3B61F1l7a1xegpQ56BNLXu2cu9EY95bYmKOxyA2ucjkEVY8idRA2gb/
	 kf7GQWVDrAbpMPBoLPrWacrWIuKQlsCLZpbbc0PKUIQ27QOWoQGgmt0Cm/a/RQJkWV
	 KAKKmdFI1+uLg==
Date: Sun, 8 Nov 2026 00:21:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kyungmin Park
 <kyungmin.park@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: light: gp2ap020a00f: Add GP2AP030A00F support
Message-ID: <20261108002155.29740ae6@jic23-hlaptop>
In-Reply-To: <20261108-gp2ap030-v1-4-55314eb7055b@kernel.org>
References: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
	<20261108-gp2ap030-v1-4-55314eb7055b@kernel.org>
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

On Sun, 08 Nov 2026 00:31:36 +0100
Linus Walleij <linusw@kernel.org> wrote:

> The GP2AP030A00F has the same register addresses and interrupt modes
> as the GP2AP020A00F, but does not implement its automatic
> illuminance calculation or selectable ambient-light cancellation.

Hmm. Raw clear and IR signals are normally intensity channels, not
light ones (because there is no standard match to illuminance).
Seems the original driver is not doing this right and we are stuck
with that though.

> 
> Datasheet: https://jp.sharp/products/device/doc/opto/gp2ap030a00f_appl_e.pdf
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/iio/light/Kconfig        |  6 +--
>  drivers/iio/light/gp2ap020a00f.c | 80 ++++++++++++++++++++++++++++++++++++----

Hmm. Fairly small.  Normally I'd ask for this in two patches
1) Introduce the infrastructure to support chip variants, but no
   functional changes.
2) Introduce the stuff for the part being added.

If it is simple enough I'll sometimes be more relaxed about that.
This is slightly too complex for me to be completely happy.

>  2 files changed, 76 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 462fff1ddef2..549f644994df 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -259,15 +259,15 @@ config GP2AP002
>  	  module will be called gp2ap002.
>  
>  config GP2AP020A00F
> -	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
> +	tristate "Sharp GP2AP020A00F/GP2AP030A00F Proximity/ALS sensors"

As for the description below, I'd just use 'and similar' as this will
become too long on the next part addition. So might as well avoid the
problem now.

>  	depends on I2C
>  	select REGMAP_I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	select IRQ_WORK
>  	help
> -	  Say Y here if you have a Sharp GP2AP020A00F proximity/ALS combo-chip
> -	  hooked to an I2C bus.
> +	  Say Y here if you have a Sharp GP2AP020A00F or GP2AP030A00F
> +	  proximity/ALS combo-chip hooked to an I2C bus.

Similar on making extension to more parts easy.
Change to a bulleted list of parts now as it will avoid churn when
the next one turns up. Lots of recent examples of this in tree.

>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called gp2ap020a00f.

> +
>  static bool gp2ap020a00f_is_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> @@ -364,6 +400,7 @@ static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
>  					enum gp2ap020a00f_opmode op)
>  {
>  	unsigned int op_reg_val;
> +	u8 op_reg = opmode_regs_settings[op].op_reg;

If nothing else effects things, prefer reverse xmas tree. So I'd move
this up one line.

>  	int err;
>  
>  	if (op != GP2AP020A00F_OPMODE_SHUTDOWN) {
> @@ -401,12 +438,16 @@ static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
>  			return err;
>  	}
>  
> +	/* Bit 0 is reserved on the GP2AP030A00F. */
> +	if (!data->chip_info->has_als_auto)
> +		op_reg &= ~GP2AP020A00F_TYPE_MASK;

Perhaps set it explicitly to MANUAL_CALC given I guess that is
direct equivalent of this?  Effectively chip doesn't support AUTO_CALC.
That should be self explanatory given the has_als_auto check so you
can probably drop the comment after doing that.

> +
>  	/* Set OP_REG and apply operation mode (power on / off) */
>  	err = regmap_update_bits(data->regmap,
>  				 GP2AP020A00F_OP_REG,
>  				 GP2AP020A00F_OP_MASK | GP2AP020A00F_OP2_MASK |
>  				 GP2AP020A00F_OP3_MASK | GP2AP020A00F_TYPE_MASK,
> -				 opmode_regs_settings[op].op_reg);
> +				 op_reg);
>  	if (err < 0)
>  		return err;

...

> @@ -1401,7 +1448,7 @@ static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
>  
>  static int gp2ap020a00f_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	struct iio_chan_spec *channels;
>  	struct device *dev = &client->dev;
>  	struct gp2ap020a00f_data *data;
>  	struct iio_dev *indio_dev;
> @@ -1413,6 +1460,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +	data->chip_info = i2c_get_match_data(client);

Check for NULL.  Sadly can happen via various weird probe paths.

>  
>  	err = devm_regulator_get_enable_optional(dev, "vdd");
>  	if (err && err != -ENODEV)
> @@ -1437,9 +1485,12 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
>  		goto error_regulator_disable;
>  	}
>  
> +	if (!data->chip_info->has_als_auto)
> +		usleep_range(1000, 2000);

fsleep() so no need to think if allow that slack makes sense or not.

> +
>  	/* Initialize device registers */
>  	err = regmap_bulk_write(regmap, GP2AP020A00F_OP_REG,
> -			gp2ap020a00f_reg_init_tab,
> +			data->chip_info->reg_init_tab,
>  			ARRAY_SIZE(gp2ap020a00f_reg_init_tab));
>  
>  	if (err < 0) {
> @@ -1456,9 +1507,20 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
>  
>  	mutex_init(&data->lock);
>  	indio_dev->channels = gp2ap020a00f_channels;
> +	if (!data->chip_info->has_als_auto) {
> +		channels = devm_kmemdup(dev, gp2ap020a00f_channels,
> +					sizeof(gp2ap020a00f_channels), GFP_KERNEL);
> +		if (!channels) {
> +			err = -ENOMEM;
> +			goto error_regulator_disable;
> +		}
> +		channels[GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR].scan_type.realbits = 16;
> +		channels[GP2AP020A00F_SCAN_MODE_LIGHT_IR].scan_type.realbits = 16;
> +		indio_dev->channels = channels;

For this just pick between two static arrays.
Whilst that may make things a bit bigger module size wise, it is
easier to read ad puts all this in one place.  Put a pointer
to the channel array + count of it's size in the chip_info structure.


> +	}
>  	indio_dev->num_channels = ARRAY_SIZE(gp2ap020a00f_channels);
>  	indio_dev->info = &gp2ap020a00f_info;
> -	indio_dev->name = id->name;
> +	indio_dev->name = data->chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	/* Allocate buffer */
> @@ -1534,13 +1596,17 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
>  }

> @@ -1557,5 +1623,5 @@ static struct i2c_driver gp2ap020a00f_driver = {
>  module_i2c_driver(gp2ap020a00f_driver);
>  
>  MODULE_AUTHOR("Jacek Anaszewski <j.anaszewski@samsung.com>");
> -MODULE_DESCRIPTION("Sharp GP2AP020A00F Proximity/ALS sensor driver");
> +MODULE_DESCRIPTION("Sharp GP2AP020A00F/GP2AP030A00F proximity/ALS sensor driver");

These get long fast.  Maybe just jump directly to where we end up
which is the weasel words option of adding 'and similar' 

>  MODULE_LICENSE("GPL v2");
> 

