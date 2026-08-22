Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A927F017
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787425644; cv=none; b=rVgFgEXKe9U2FV6dlVg0QxyGqiHwriFeSRGlODFesbznaFnZzK6M9kZYI+bFA2wsJ4Kr146YbntWfcXPZUKJ5P90Ob5wwjX8ts/fjaMIau38b1eKojf11X4dEvpJwgzPvJ0eaEIbYGbzbWYhOMW7tO5sKj8UItBImaFkUxfKBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787425644; c=relaxed/simple;
	bh=q+JiaLcxdy3sysUNv+2t8QVziFcjTkbCGdLHD4dAkUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o5bExmGDlH+qDQ02JEZ7W3HFxWaccNk3xqF3qg4RmZWKVXeDFYfyMx37NJEnSi2UK+oSdjj5O+7NBd8m77vhRjGOUA2wRiaPZABfj3fFfqjl5KCnRP5nzestUtVrspion0p5PFsRVG+2GaCz72CanJoS884YNYWVfOAGbRDETyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CY5oT7h7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CY5oT7h7"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836c8bdac50so30678717b3.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787425641; x=1788030441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfLRiHPUQLr/m5S0xV8RZFTsv1ej10z2QqVIP6Nh6zA=;
        b=CY5oT7h7dUIaG85wif4kxQDbOxqLftOCeDCoB6CgAi6EDAWa4expzztVj2WpPF2WrX
         9kPDsdiklCJJBY3tI2/mDh81rotvevYa9333KstiQ2tLf0Pb34/RVV6y1x2AZLEi20i/
         WvJ6Kr85QvRPcmH34iakx4AKxbXB5/Ev+ZTo1jEefBDQ3R6mHoLJS5RDTEpknNIX7Xrn
         r2FDWv3hxF7i5UqZ7btYmUcFVzTg8vl0MkQAo5dGe7wg0W5RzAimyLD3ccBqM/dgq+uM
         QQzmxYOJuqWhIu1KyC5r0qgemu5K0gJagn6m3OeQhsDUWPc1vbbJano7GjSfsDeoUf/N
         SlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787425641; x=1788030441;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfLRiHPUQLr/m5S0xV8RZFTsv1ej10z2QqVIP6Nh6zA=;
        b=l6KHkObZXxvM/C2M19n9BiziosklieVSZ8TyiXZW7An8yei3n6oHP5vwxtHPXTe/Jl
         4EG9l4sVO3CVVb2R+zN3BeicYVsduM+3k1V0zoxh4CkDa+OmPtkKHKI/V5NQuDAkF/7a
         pBQKZYLvYv8nGGMmCMMUtgPeY85BP/KsKOIJEKTlX2Q+9QPoNOXYtC580a2V2iaMKySJ
         xOKNSkbLNNg6dn3CVZWjOpPf9Ths27DOaiFDztAsLsnOdajB0CFy5jrtnzi9j9JO9ESG
         L1LoUe2HUw3smdppVDJE1jiRW3usXHSQ359HPQN8pUyODqnIPvpSyqjurQmpdLbEOMFX
         z7fQ==
X-Forwarded-Encrypted: i=1; AHgh+RqP49B8O94ShGZXuSY7Zn3ersmLtX2y5ee66CWtkeJYzE+oOcvYo5cDvjq4Rd+eREE2BeE+NEf4vjo=@vger.kernel.org
X-Gm-Message-State: AFuF++lD92B6rK5ix6mC7LhGFxMf+yvXeKszlgKtAGrMXcK+kq6rvTF5
	AVEt73Rloj8Got4UH3ZaXXoRR2end8G7ByFFCoNWa9Zj5idsBF1st8Za8Ewy9us8bPE=
X-Gm-Gg: AR+sD11fkZu1wXWL9ToHKNqbJeogGXQWyjQy/3GVYoG4GysISCl0awtZDmNHZwSekuX
	q7ATuo5MlPmwhypBfDNG3ItjVEQYBZwFiGtUyjGK24SvSDMbOc+aN+PqoddS9IEFatJwtWsrBNV
	Gh+o/aayC2BHldRQRkU1nncgJOyAmQIIrRnWDs61sGToDndJaXhGZEV4daOfcMz/TOI/DrMnFTN
	g2sLWcQlb8PEMaG9rch3y0JuLE3l69OWN4WwvLEEZzHAcShv7Ph/bIpUqXTWIv3oC26KuSvhLtv
	i9WxQWB4iGRVuKJmcxX/Z6c2lvBuyc5nG9EowfK8p/d2cb/GxWHaQ0BUBpFAXTxSNpq0x1poU1o
	VX/gUh2pN14XhYFc0PH5x7OPdW3OyxLOX4M+uC0pVOc5qu/P9f5BO0RCrExfW1gR92AfnN60wVD
	yiy3xlcl5QOKTf1N8bv+TQaIrMUzBUpieUzvyKWMGyHVa51PkKNnwP4Ba/lmvWqdzb1+VKO6d7u
	SlRF8pK1J0JLttooZeMMlLrviDzGc9r0kWwJbs=
X-Received: by 2002:a05:690c:9b02:b0:81f:2403:9e70 with SMTP id 00721157ae682-849f4e5fe5bmr66342857b3.19.1787425641254;
        Sat, 22 Aug 2026 12:07:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e0ca:316a:4629:d835? ([2600:8803:e7e4:500:e0ca:316a:4629:d835])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac01868dsm13360367b3.42.2026.08.22.12.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 12:07:20 -0700 (PDT)
Message-ID: <8283770e-4c42-4d7c-adf7-7597288c9712@baylibre.com>
Date: Sat, 22 Aug 2026 14:07:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iio: accel: adxl367: add support for INT2
 interrupt pin
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux@analog.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
 <20260821180753.4633-5-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260821180753.4633-5-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/26 1:07 PM, Antoniu Miclaus wrote:
> The ADXL367 provides two independent interrupt output pins, INT1 and
> INT2, each with its own event mapping register (INTMAP1_LOWER at 0x2A
> and INTMAP2_LOWER at 0x2B) sharing an identical bit layout. Until now
> the driver hardcoded INT1 for all interrupt mappings, so a board that
> routes only INT2 to the host could never receive activity, inactivity
> or FIFO watermark interrupts.
> 
> Determine the connected pin from the interrupt-names device tree
> property using fwnode_irq_get_byname(), and route the interrupt
> mappings to the matching register. Use the interrupt number returned by
> the lookup for devm_request_threaded_irq() so the requested line always
> matches the routed INTMAP register, regardless of the order in which the
> interrupts are listed. When no interrupt-names are present, default to
> INT1 and the bus-provided interrupt to preserve the existing behaviour.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v3:
> - Use the interrupt number returned by fwnode_irq_get_byname() for
>   devm_request_threaded_irq() so the requested line always matches the
>   routed INTMAP register, regardless of the interrupt-names order.
> - Access the interrupt map register via regmap_assign_bits() following
>   the new precursor patch.
> 
>  drivers/iio/accel/adxl367.c | 40 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 54c4d1226790..f5808980b639 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -13,6 +13,7 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/unaligned.h>
> @@ -81,6 +82,7 @@
>  #define ADXL367_SAMPLES_L_MASK		GENMASK(7, 0)
>  
>  #define ADXL367_REG_INT1_MAP		0x2A
> +#define ADXL367_REG_INT2_MAP		0x2B
>  #define ADXL367_INT_INACT_MASK		BIT(5)
>  #define ADXL367_INT_ACT_MASK		BIT(4)
>  #define ADXL367_INT_FIFO_WATERMARK_MASK	BIT(2)
> @@ -168,6 +170,8 @@ struct adxl367_state {
>  	enum adxl367_odr	odr;
>  	enum adxl367_range	range;
>  
> +	u8		int_map_reg;
> +
>  	unsigned int	act_threshold;
>  	unsigned int	act_time_ms;
>  	unsigned int	inact_threshold;
> @@ -366,7 +370,7 @@ static int adxl367_set_act_interrupt_en(struct adxl367_state *st,
>  {
>  	unsigned int mask = adxl367_act_int_mask_tbl[act];
>  
> -	return regmap_assign_bits(st->regmap, ADXL367_REG_INT1_MAP, mask, en);
> +	return regmap_assign_bits(st->regmap, st->int_map_reg, mask, en);
>  }
>  
>  static int adxl367_get_act_interrupt_en(struct adxl367_state *st,
> @@ -377,7 +381,7 @@ static int adxl367_get_act_interrupt_en(struct adxl367_state *st,
>  	unsigned int val;
>  	int ret;
>  
> -	ret = regmap_read(st->regmap, ADXL367_REG_INT1_MAP, &val);
> +	ret = regmap_read(st->regmap, st->int_map_reg, &val);
>  	if (ret)
>  		return ret;
>  
> @@ -400,7 +404,7 @@ static int adxl367_set_act_en(struct adxl367_state *st,
>  static int adxl367_set_fifo_watermark_interrupt_en(struct adxl367_state *st,
>  						   bool en)
>  {
> -	return regmap_assign_bits(st->regmap, ADXL367_REG_INT1_MAP,
> +	return regmap_assign_bits(st->regmap, st->int_map_reg,
>  				  ADXL367_INT_FIFO_WATERMARK_MASK, en);
>  }
>  
> @@ -1423,6 +1427,31 @@ static int adxl367_setup(struct adxl367_state *st)
>  	return adxl367_set_measure_en(st, true);
>  }
>  
> +static int adxl367_set_int_map_reg(struct adxl367_state *st, int irq)
> +{
> +	int ret;
> +
> +	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> +	if (ret == -EPROBE_DEFER)
> +		return ret;
> +	if (ret > 0) {
> +		st->int_map_reg = ADXL367_REG_INT1_MAP;
> +		return ret;
> +	}
> +
> +	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT2");
> +	if (ret == -EPROBE_DEFER)
> +		return ret;
> +	if (ret > 0) {
> +		st->int_map_reg = ADXL367_REG_INT2_MAP;
> +		return ret;
> +	}
> +
> +	/* No interrupt-names: default to INT1 for backwards compatibility. */
> +	st->int_map_reg = ADXL367_REG_INT1_MAP;
> +	return irq;

I guess this works, but it seems like trial and error rather than being
purposeful. 

Could probably do something like this too:

	if (device_property_present("interrupt-names")) {
		ret = device_property_match_string(st->dev, "interrupt-names",
						   "INT2");
		if (ret < 0)
			return ret;

		/* If INT2 is at index 0, use it, otherwise use INT1. */
		st->int_map_reg = ret ? ADXL367_REG_INT2_MAP : ADXL367_REG_INT1_MAP;
	} else {
		/* No interrupt-names: default to INT1 for backwards compatibility. */
		st->int_map_reg = ADXL367_REG_INT1_MAP;
	}


	ret = fwnode_irq_get_byname(dev_fwnode(st->dev),
				    st->int_map_reg == ADXL367_REG_INT1_MAP ?
				    "INT1" : "INT2");


(Could use device_property_match_property_string() instead if we want to
return error on invalid values instead of assuming INT1.)

> +}
> +
>  int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
>  		  void *context, struct regmap *regmap, int irq)
>  {
> @@ -1479,6 +1508,11 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
>  	if (ret)
>  		return ret;
>  
> +	ret = adxl367_set_int_map_reg(st, irq);
> +	if (ret < 0)
> +		return dev_err_probe(st->dev, ret, "Failed to get interrupt\n");
> +	irq = ret;
> +
>  	ret = devm_request_threaded_irq(st->dev, irq, NULL,
>  					adxl367_irq_handler, IRQF_ONESHOT,
>  					indio_dev->name, indio_dev);

