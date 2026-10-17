Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022C3CAE99;
	Sat, 17 Oct 2026 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260015; cv=none; b=lWKFiVLOU4KCkT6IF7HX6TNqGXSbXPqiJCtDkSbfOMnatAgYEyevD1xhNSZPeQFqtkDPdPcoe2dsnabF0NrZAi/u3c/dEs4hk1Qn+wseRxL33Ii/AxNAI7CUF3eOoZ9/pW2rCtQJUEO8UVx+1iOWaG4IV/flYZXXuBPMqfWiits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260015; c=relaxed/simple;
	bh=HquGZUkZOpRPgbAHAlcRmha521nr66ji75VxUc48C5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kkw2/K4zXQsGKudqmXkRqR4eDHzkK0dyNPohBnZctcL/j5K3CI3KaHqbAYzqzr6EPSVxEw1lgWwFQAYhtCB4WNiq4tH5HfTmA29Tw+EE+j647tvvTVLOVwQbF+6YusXNIILL6scTfaPkOki9O4c4UiAXMi9hr+Ohsy3TzGMpoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHokEeoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHokEeoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C541F000C4;
	Sat, 17 Oct 2026 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792260013;
	bh=rba4idDZOfCzF7jut3vMgqHAP5ZyqQ99TWoYvy+/Jjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kHokEeoKJCq3VrTLvtSrj6g1l9Ukh9CjI/Fy3cA/KQ9PZ0uoRb5MBkH+/6YBkysHd
	 iBBw72L5J6O1bj0WrsOGrzRCHo+kSrYZjtM01VqYxkjvXCcSlYj4zjbXBtOqRZlTzH
	 FIRizU6PVAgx3UxnYLlG+omRf0CGcq27Xz2syiVR+u1PS1cG2qmjeA+tvi/1S3sFw7
	 jinutfvHzHDNq0KpbpFCjuNtpWOYd9JrwuKcWTUZfZFBLUGawqmMWodn0a6FpiiHbp
	 4Keaagji6ar430QF70H8Uoa6NHq+jdQff8mZpYuAuHlxAxr/tvts4nt6yfAM2v5TMy
	 60w3q620jFw7Q==
Date: Sat, 17 Oct 2026 19:00:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: gp2ap002: add led power supply
Message-ID: <20261017190006.224b73e7@jic23-hlaptop>
In-Reply-To: <20261017-iio-light-gp2ap002-v2-2-d6879767a446@rudorff.com>
References: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
	<20261017-iio-light-gp2ap002-v2-2-d6879767a446@rudorff.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 19:27:42 +0200
Christoph Rudorff <chris@rudorff.com> wrote:

> The led power might be attached to an extra supply.

I'd add a mention of LEDA.   + the fact it is always attached
to a supply, what is 'maybe' is whether we need to control it.

> 
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
> ---
>  drivers/iio/light/gp2ap002.c | 101 +++++++++++++++++++++++--------------------
>  1 file changed, 55 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index de29081fd3b2..5e4599e40376 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -123,12 +123,26 @@
>  #define GP2AP002_CON_OCON_HIGH		(0x3 << GP2AP002_CON_OCON_SHIFT)
>  #define GP2AP002_CON_OCON_MASK		(0x3 << GP2AP002_CON_OCON_SHIFT)
>  
> +/*
> + * @vio: regulator name controlling VIO
> + * @vdd: regulator name controlling VDD
> + * @vled: regulator name controlling VLED (optional)
> + */
> +static const char *const gp2ap002_supply_names[] = {
> +	"vio", "vdd", "vled"
> +};
blank line here.
> +enum {
> +	SUPPLY_VIO,
> +	SUPPLY_VDD,
> +	SUPPLY_VLED,
> +	NUM_SUPPLIES
> +};
Force these to match up via

static const char *const gp2ap002_supply_names[NUM_SUPPLIES] = {
	[SUPPLY_VIO] = "vio",
	[SUPPLY_VDD] = "vdd",
	[SUPPLY_VLED] = "vled",
};

You might as well also move this naming array local to where
it is used.

> +
>  /**
>   * struct gp2ap002 - GP2AP002 state
>   * @map: regmap pointer for the i2c regmap
>   * @dev: pointer to parent device
> - * @vdd: regulator controlling VDD
> - * @vio: regulator controlling VIO
> + * @supplies bulk regulator data
>   * @alsout: IIO ADC channel to convert the ALSOUT signal
>   * @hys_far: hysteresis control from device tree
>   * @hys_close: hysteresis control from device tree
> @@ -140,8 +154,7 @@
>  struct gp2ap002 {
>  	struct regmap *map;
>  	struct device *dev;
> -	struct regulator *vdd;
> -	struct regulator *vio;
> +	struct regulator_bulk_data supplies[NUM_SUPPLIES];
>  	struct iio_channel *alsout;
>  	u8 hys_far;
>  	u8 hys_close;
> @@ -521,45 +534,52 @@ static int gp2ap002_probe(struct i2c_client *client)
>  		}
>  	}
>  
> -	gp2ap002->vdd = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(gp2ap002->vdd))
> -		return dev_err_probe(dev, PTR_ERR(gp2ap002->vdd),
> -				     "failed to get VDD regulator\n");
> +	regulator_bulk_set_supply_names(gp2ap002->supplies,
> +		gp2ap002_supply_names,
> +		NUM_SUPPLIES);
I was kind of expecting this to be local style you were copying, but nope the
driver is at least fairly consistent in indenting to align parameters.
e.g.

	regulator_bulk_set_supply_names(gp2ap002->supplies,
					gp2ap002_supply_names,
					NUM_SUPPLIES);

	ret = devm_regulator_bulk_get(dev, NUM_SUPPLIES, gp2ap002->supplies);

> +
> +	ret = devm_regulator_bulk_get(dev,
> +		NUM_SUPPLIES,
> +		gp2ap002->supplies);


>  
> -	gp2ap002->vio = devm_regulator_get(dev, "vio");
> -	if (IS_ERR(gp2ap002->vio))
> -		return dev_err_probe(dev, PTR_ERR(gp2ap002->vio),
> -				     "failed to get VIO regulator\n");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get regulators\n");
>  
> -	/* Operating voltage 2.4V .. 3.6V according to datasheet */
> -	ret = regulator_set_voltage(gp2ap002->vdd, 2400000, 3600000);
> +	/* vdd operating voltage 2.4V .. 3.6V according to datasheet */
> +	ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VDD].consumer, 2400000, 3600000);
>  	if (ret) {
> -		dev_err(dev, "failed to sett VDD voltage\n");
> +		dev_err(dev, "failed to set VDD voltage\n");
>  		return ret;
>  	}
> -
>  	/* VIO should be between 1.65V and VDD */
> -	ret = regulator_get_voltage(gp2ap002->vdd);
> +	ret = regulator_get_voltage(gp2ap002->supplies[SUPPLY_VDD].consumer);

Ah. I'd failed to register the voltages were being manually set (generally
we leave that to firmware in more modern drivers).
That rather reduces the advantage in using bulk regulators.  Probably
still just about worth doing.


>  	if (ret < 0) {
>  		dev_err(dev, "failed to get VDD voltage\n");
>  		return ret;
>  	}
> -	ret = regulator_set_voltage(gp2ap002->vio, 1650000, ret);
> +	ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VIO].consumer, 1650000, ret);
>  	if (ret) {
>  		dev_err(dev, "failed to set VIO voltage\n");
>  		return ret;
>  	}
> +	/* LED voltage 2.4V .. 3.6V according to datasheet */
> +	/* We need to check this, as dummy or fixed controllers trigger an error. */
I'd make that a multiline comment and say what 'this' is.
	/*
	 * LED voltage 2.4V .. 3.6V according to datasheet
	 * We need to check control is supported, as controlling dummy or fixed
	 * controllers results in an error.
	 */

Do you actually need to control this for your board?  I'm not that
keen to replicate the controlling of voltages if we don't have
to.  We can't drop existing code as maybe a board is relying on it
but we can avoid adding new examples!

> +	ret = regulator_is_supported_voltage(gp2ap002->supplies[SUPPLY_VLED].consumer,
> +		2400000, 3600000);
> +	if (ret == 1) {
> +		ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VLED].consumer,
> +		2400000, 3600000);
> +		if (ret) {
> +			dev_err(dev, "failed to set VLED voltage\n");
> +			return ret;
> +		}
> +	}
>  
> -	ret = regulator_enable(gp2ap002->vdd);
> +	ret = regulator_bulk_enable(NUM_SUPPLIES, gp2ap002->supplies);
>  	if (ret) {
> -		dev_err(dev, "failed to enable VDD regulator\n");
> +		dev_err(dev, "failed to enable regulators\n");
>  		return ret;
>  	}
> -	ret = regulator_enable(gp2ap002->vio);
> -	if (ret) {
> -		dev_err(dev, "failed to enable VIO regulator\n");
> -		goto out_disable_vdd;
> -	}
>  
>  	msleep(20);
>  
> @@ -570,7 +590,7 @@ static int gp2ap002_probe(struct i2c_client *client)
>  	ret = gp2ap002_init(gp2ap002);
>  	if (ret) {
>  		dev_err(dev, "initialization failed\n");
> -		goto out_disable_vio;
> +		goto out_disable_power;
>  	}
>  	pm_runtime_get_noresume(dev);
>  	pm_runtime_set_active(dev);
> @@ -616,10 +636,8 @@ static int gp2ap002_probe(struct i2c_client *client)
>  	pm_runtime_put_noidle(dev);
>  out_disable_pm:
>  	pm_runtime_disable(dev);
> -out_disable_vio:
> -	regulator_disable(gp2ap002->vio);
> -out_disable_vdd:
> -	regulator_disable(gp2ap002->vdd);
> +out_disable_power:
> +	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
>  	return ret;
>  }
>  
> @@ -632,9 +650,8 @@ static void gp2ap002_remove(struct i2c_client *client)
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> +	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);

Why at that point in sequence?  You are turning the power off
before removing the userspace interfaces which seems unlikely to
be race free. More generally it is no longer reverse of probe
order. If that is necessary for some reason I'd expect a comment
to say why.

>  	iio_device_unregister(indio_dev);
> -	regulator_disable(gp2ap002->vio);
> -	regulator_disable(gp2ap002->vdd);
>  }


