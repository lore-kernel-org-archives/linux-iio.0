Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207013CAA2F
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105155; cv=none; b=FyTmrgGvaCFJkGKVSyvkHUWTDUgqdGICkhg76SBMcka/fbEFrxt+ogJ/3ujL3VUQ0Y1TKngs2334zJyY1UDUBu5Ci+W2PkFiZMK64Xh+z6SJPu8NoQiUHtrskGWxlmmTaH7VZp3bdovto3C4Rfa36AOk7ZbSrYqOHuPvifNK66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105155; c=relaxed/simple;
	bh=eafklUz/Nihxt4G0Y/5YOLYKvHeikJPXuRmnhgcXHh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uADScrc+M3sq9AARGzuzYpM33iM801Z6MtH6UJnOXnQJcNU+MiIlvlxU+vTg1DPvMXm5+jfTfwtyEZ44zfCdcuhRH2n42B9juKIsI1ok8fei9IaGOvUiHTPhyLE9SC6E8hc2Fkud1F5kZ7egEeqhe2GAVZHkgB241TWVeZj9aG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpepXURs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpepXURs"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4720d22c94aso1908714f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 01:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784105146; x=1784709946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HqhbTpyt7Pwu4H6jri5SJXn72wEdVDjqv1xv5v6hVLQ=;
        b=DpepXURsGO+PHl3fwOc6BOyBNiq5HwMl4MxMVuV1BD/3w6eVSxLhzdP3OV6p+Xt13R
         QYzZkD49NDzYzI7PEjwC4C1PiFhabD+XBFk142IYe3Tnzyz2yApBRuJlrvSYtExmVqE8
         RBfw+hoeBZuabjxNJJkk/kqCgS1461NP88RHUcCUbaHmmAaTPmiHEj0KnXEpyHldYgJL
         MeUarCQ2FVhrp7gxxDggMqlNj9HBUMGFSQaQdDYOTK8MA5SGC7j3xwVXpTEvM9sPTUiP
         +GywDoH0zsI+vPsKi7ObK4DcHT8Dwk7Dhz5ioUZUX2ayg68hLXVlWQNYdUTFF3WhgdTz
         YpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105146; x=1784709946;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqhbTpyt7Pwu4H6jri5SJXn72wEdVDjqv1xv5v6hVLQ=;
        b=jnUgWkVvse35T/YaAt9nAygIBqcDk1WBSF2jVXX9Cs+WL0AeExsaum8rrkpDSVnE3B
         DZ3J1Q0nPBxETYZjtof4FRGxut1EUC++vfUq67bNTCxflfWuY7tpc4OS7AN/4kP0pzdv
         LsEioV4w1wYHtisglmwTSVT8PPtt4ynVZcRKH+Wg/vxPCwMISPRq2puRNzCFMFfLHq4t
         uee2CDl1d0SF9mi8MJkdHk6gPnz1AwL3HYlHN9vTJkgLiJ5v6c+qNz6Z4UHhQUCfy/vN
         WDW6ubqAUTfdUwvgZd5clOerr2CJJEG64Z22k+Jsml2tnfaGyfHTXHhg6dP5aj+4lCDE
         CBaA==
X-Forwarded-Encrypted: i=1; AHgh+RpnpU/Lr0gfO2ewPupeBh9xA90Xf2DZa9R7UK/+b3gevHAR48zvv58uLWvdFweboN1NJDM2yn8jTkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRMqGoE/TQOf69IYEMVCqQKnH219JkB10LcbchnC1LCFHQhmg
	xyEGxJwxOsv+uSVwbPDGXv771aotGWEvyJb74fNrI1TFMMctzXRa/aU9
X-Gm-Gg: AfdE7cl6/w3MB+2ryRrc0Lq3rIHS8qcSJC7pI0eWvDobBGkWa4nWFn/2K/p/vJ9RVko
	hLN0uEYqG1ZOw+CxgQ0NIbOMPgd+y9/q2snEHNC9QaEicoVMS94nYImnHsYZV+XbPr2MxtxRSsL
	FWTFQcBYAHVUi5n8zpSuobvJ4cv5FhCYRZVdz07Ni2FkEb/z/82rt83qzFSoeD1T20U4cKvuUJE
	kPbhy9ZMQe3ftn9gdUhzYO4ocDOCCGItojDdMkaYAf14VzJdFq0hRkv+8ZcypevUjWOJSO6a49C
	Vq9ruIB0zdhh7Gyj6MttOmT5lLJKwTfh2AwkW8RmjniyMn3DA2EO7AVPeyeZ2IkPMZqWgW063za
	EfeC13h2pYcpd+Wqy0PukccnSmlABFEV1jir0e0GzqxAJpAwGdMZYmDbGpW5Uxe0XiSRcMte3YS
	HMUBYEmfUP53nioXUcGtb8Kt4qxFHrzS4FIMIo3aDpw+6eESZ3xsm+wZGGXzXwnov/U56CtEo06
	ko4Ca/edZmkIyfSk/gLzTesVTQgsCTLqAEaJaz4JBS71eL2IdXnkKciLgXmMTzau/B/pSdlxF04
	msC8LzfNjIVWYrgSgbVOBA8ddB5oEySZW9xygnV9/MX/qBvnh/45xU1yTXHUgmFD9qfWiYNSqQy
	KZDqC+9UjOTDp3AD7cIzu1f8=
X-Received: by 2002:a05:6000:25fe:b0:476:d52b:b85 with SMTP id ffacd0b85a97d-47f2dcc0208mr19425011f8f.16.1784105144565;
        Wed, 15 Jul 2026 01:45:44 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a973fsm15495170f8f.17.2026.07.15.01.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:45:44 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:45:42 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Message-ID: <20260715104542.0000433d@gmail.com>
In-Reply-To: <20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
	<20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 10:07:39 +0200
Esben Haabendal <esben@geanix.com> wrote:

> When sharing interrupt line with other chips, the interrupt pin most
> likely needs to be configured in open-drain mode instead of push-pull.
> If this is needed, you must add drive-open-drain property to the
> device-tree.

Why are you mentioning the device tree in the commit message? Just keep
the first sentence + a short description of what you added/changed/removed.

> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7d683686dd9d..a20c02ce0b9c 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -81,6 +81,8 @@
>  #define  MMA8452_CTRL_REG2_RST			BIT(6)
>  #define  MMA8452_CTRL_REG2_MODS_SHIFT		3
>  #define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
> +#define MMA8452_CTRL_REG3			0x2c
> +#define  MMA8452_CTRL_REG3_PP_OD		BIT(0)

I know that the defines are completely incorrectly aligned, but please
ensure that at least all the defines in this block are aligned.

Also, consider sending a patch which aligns all the other defines.

>  #define MMA8452_CTRL_REG4			0x2d
>  #define MMA8452_CTRL_REG5			0x2e
>  #define MMA8452_OFF_X				0x2f
> @@ -108,6 +110,7 @@ struct mma8452_data {
>  	struct iio_mount_matrix orientation;
>  	u8 ctrl_reg1;
>  	u8 data_cfg;
> +	bool open_drain;

Hmm, i checked pahole and it says there is a 1 byte hole, maybe try some more
reordering to pack it?

>  	const struct mma_chip_info *chip_info;
>  	int sleep_val;
>  	struct regulator *vdd_reg;
> @@ -646,6 +649,22 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
>  	return mma8452_change_config(data, MMA8452_CTRL_REG2, reg);
>  }
>  
> +static int mma8452_set_interrupt_pin_mode(struct mma8452_data *data)
> +{
> +	int reg;
> +
> +	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG3);
> +	if (reg < 0)
> +		return reg;
> +
> +	if (data->open_drain)
> +		reg |= MMA8452_CTRL_REG3_PP_OD;
> +	else
> +		reg &= ~MMA8452_CTRL_REG3_PP_OD;
> +
> +	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG3, reg);
> +}
> +
>  /* returns >0 if in freefall mode, 0 if not or <0 if an error occurred */
>  static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>  {
> @@ -1666,6 +1685,9 @@ static int mma8452_probe(struct i2c_client *client)
>  			goto disable_regulators;
>  	}
>  
> +	data->open_drain = device_property_read_bool(&client->dev, "drive-open-drain");
> +	mma8452_set_interrupt_pin_mode(data);

You're not checking the return value here.

> +
>  	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
>  			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
>  
> @@ -1683,7 +1705,8 @@ static int mma8452_probe(struct i2c_client *client)
>  
>  	if (client->irq) {
>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> +					   data->open_drain ? IRQF_SHARED : 0,

Sashiko raises a pretty fun issue: the statement

IRQF_TRIGGER_LOW | IRQF_ONESHOT | data->open_drain ? IRQF_SHARED : 0

is actually evaluated as

(IRQF_TRIGGER_LOW | IRQF_ONESHOT | data->open_drain) ? IRQF_SHARED : 0

Bitwise OR precedes the ternary operator.

You should wrap the data->open_drain ternary in parenthesis.

>  					   client->name, indio_dev);
>  		if (ret)
>  			goto buffer_cleanup;
> @@ -1800,6 +1823,10 @@ static int mma8452_runtime_resume(struct device *dev)
>  		return ret;
>  	}
>  
> +	ret = mma8452_set_interrupt_pin_mode(data);
> +	if (ret < 0)
> +		goto runtime_resume_failed;

You can just have if (ret), as only 0 is successful.

> +
>  	ret = mma8452_active(data);
>  	if (ret < 0)
>  		goto runtime_resume_failed;
> 



-- 
Kind regards

CJD
