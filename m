Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CF280CE5
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782457; cv=none; b=JgOLMOt94t7Cj+ed0HJFtbnG+e/Mr0+ZWXcSeaJjr4SK6mf+uTtsi2iYkjnrRGmPl6RFrK6bojDS5KWZXTrGOuitLUjpV0C2oCQuuScYlvWFmQZb9Z8gUlCmxlJDBcUaWd3D2d6hPtDmrYlo1DasIQcVqR58nu2os2PyTvirrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782457; c=relaxed/simple;
	bh=gCnIYXS7l6OLB7PpxEY05mTYnJlHvIVhDb+6beqSHZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoEneW3qjRvQVbdlOQs7arfJtQzBvnj4z7qmmEfpmynY3qcA/BdKVpRmM5lt8ejPv/NG1h5oHYQSLyTtCQbjWPIDu0XvG33acAfgHV40tNL9nlBKhbOdW34z+SytaaDSsB50eruHTA3gjGjuXhyc2t+xvaKrut+EEZehbit1C7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=l0vRvDAa; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="l0vRvDAa"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-49190e20a0cso945125b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783782453; x=1784387253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G95LYy3SIhKCZuULQ6kHhqOCotb5tWbIJKUEos0d2CQ=;
        b=l0vRvDAaetNx2URX6tpMka5Xu0AxeFHne4N5w7LP6smNdR76ppU2ENvpGo+zI15CVu
         mf/8jeDgoJru0ODVcpVLlHAqDsDx+qTMzgnNe5xfxIgQWdg8ycUHXISkdA6hSP0ldK/6
         1LNtnO4V+aXotroRd9CmAe/0z3ufWaZtwMs5ln4xD4oTHiDQZUGKHspDxSkNPRVPvyYd
         SnWyK5oB8oXM1FKsOMBmw4s+j0ojsz4vIkKzubbSsWxySZk73j4o/lZkqZMcXPYTGgam
         7zX8kpSL+FMLMp6zsRqTXvk699ea2B7KG+oLwGHOvpwLvk8dva3n8pnYb6XWR7qX6HZx
         3DEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782453; x=1784387253;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G95LYy3SIhKCZuULQ6kHhqOCotb5tWbIJKUEos0d2CQ=;
        b=gYd3dwTjUJPbXTSfc4SACJIkVIS3sTd1n2u52/aMx8DtVnxln00aMdpUeW9ZjjxHgP
         rviSMJhD6Z6ttIHxWTcG3qBldSXvC8Oji//2NI3E1cEn4igCbuj6CtQkGZXKR5hkbrP2
         FS4ZBkb+rPN+EzfYqmXZkary8KwTS2bT0zV6EF7/XoVXu7REj56cwbsLPm5OAvzwTHsc
         xoqLUhG8rc17IPG5beuXMLsw0eS/AbvUzgMOco7cUAAOdiR0jdgZ9SOqJv5drQZ9eLAx
         /6DJRoSPru3s21Z2DUeJ3PJvdkMd4Na9opoJkw7duK9tpm8Co7Zu/5ZQm4c2RZ3CwKYV
         IcPA==
X-Forwarded-Encrypted: i=1; AFNElJ9EAwJHqGAwwTYoT+4cAM4E/0tm2U/qSnYYpKJdzeqdyz203aff+XCudYMrscFalL1qA28LXZ3R9NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJVBeHOUL3SyfqhdcfEdt8O5hbm7/SowIoS2+zhMcvaGOb5jPh
	PdaCkz4eJ88D3m3+sfM8mv/VOLBOKScJiGbhdQdIh9RzYkPfcLvlQeyYxaFwM4IMX00=
X-Gm-Gg: AfdE7cmM7p+7vyM7CdI2p4ajByaPjzCB5Wx/Z3XYRwkpZ6wpNw5q4jyPQQYGmT9uKxB
	xJ8mPfoQnnjzdjq8ZvRMG7XqVtPGt3lBKpj/mOHsHOOj7BxiCU9o0r1ChysWJApSTCVBS0MjkuU
	mEf27pSZP5fHknCpCm6t0X0Xs1JNj3+KUTVh5ailAnYQDAMl7HSIUjiu7XJx0HwbFXucTsxId7t
	T+90XH8AiJbw1k3mLE+arQ6h8enWui40A7HMRrz9CLErgT9S55H9ynhO2K4GP3A9N++fYl07wFt
	EMOn0pBmnlwrUvz9++SKSee2aCiD2igkIuO3O4YlnWa4vc60rEA3jiZNjaaoYEtHbA8is0yhmwV
	quWGjm/Lk/paS8Gxxd/Hs0ZfXZwqvNqsd6ZpdeB5diRy83UzYqezJ5wE6LPxnEnZ5yNfwtcfW4O
	YcTKofsrfXyLI0222+DO7J+HFRo2BLl+JzNEWzb/60+zAmSWKZ3TkpUYmdNsm2aNQ=
X-Received: by 2002:a05:6808:bce:b0:497:e39e:a002 with SMTP id 5614622812f47-4a42aed5ce8mr2156666b6e.30.1783782453233;
        Sat, 11 Jul 2026 08:07:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b02e5abbsm8265036b6e.15.2026.07.11.08.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:07:31 -0700 (PDT)
Message-ID: <931fe63d-d200-4b79-9e17-fa48c8de7f29@baylibre.com>
Date: Sat, 11 Jul 2026 10:07:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] iio: dac: ad5686: implement new sync() op for the
 spi bus
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-4-1bcc8c280e4d@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710-ad5686-new-features-v7-4-1bcc8c280e4d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 6:20 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use of local SPI bus data to manage a collection of SPI transfers and
> flush them to the SPI platform driver with the sync() operation. This
> allows for faster handling of multiple channel DAC writes, avoiding kernel
> overhead per spi_sync() call, which will be helpful when enabling
> triggered buffer support.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686-spi.c | 129 ++++++++++++++++++++++++++++++++-----------
>  drivers/iio/dac/ad5686.c     |   4 +-
>  drivers/iio/dac/ad5686.h     |   8 ++-
>  drivers/iio/dac/ad5696-i2c.c |   2 +-
>  4 files changed, 108 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index d3b64b4361d5..ae74a17ba48e 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -13,59 +13,95 @@
>  #include <linux/errno.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/spi/spi.h>
>  
>  #include <asm/byteorder.h>
>  
>  #include "ad5686.h"
>  
> +/**
> + * struct ad5686_spi_data - SPI bus specific data
> + * @msg: SPI message used for transfers
> + * @size: number of transfers currently in the message
> + * @capacity: maximum number of transfers that can be added to the message
> + * @xfers: array of SPI transfers, allocated with the provided capacity
> + */
> +struct ad5686_spi_data {
> +	struct spi_message msg;
> +	unsigned int size;
> +	unsigned int capacity;
> +	struct spi_transfer xfers[] __counted_by(capacity);
> +};
> +
>  static int ad5686_spi_write(struct ad5686_state *st,
>  			    u8 cmd, u8 addr, u16 val)
>  {
> -	struct spi_device *spi = to_spi_device(st->dev);
> -	u8 tx_len, *buf;
> +	struct ad5686_spi_data *bus_data = st->bus_data;
> +	struct spi_transfer *xfer;
>  

This could use some comments similar to the explanation in the
commit message that this function is just queuing writes to
be sent over the bus when sync() is called.

> +	if (bus_data->size >= bus_data->capacity)
> +		return -E2BIG;
> +
> +	if (bus_data->size)
> +		bus_data->xfers[bus_data->size - 1].cs_change = 1;
> +	else
> +		spi_message_init(&bus_data->msg);
> +
> +	xfer = &bus_data->xfers[bus_data->size];

Why not a local variable for st->data[bus_data->size] too so we don't
have to write it so many times?

>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
> -		st->data[0].d16 = cpu_to_be16(FIELD_PREP(AD5310_CMD_MSK, cmd) |
> -					      FIELD_PREP(AD5310_DATA_MSK, val));
> -		buf = &st->data[0].d8[0];
> -		tx_len = 2;
> +		st->data[bus_data->size].d16 =
> +			cpu_to_be16(FIELD_PREP(AD5310_CMD_MSK, cmd) |
> +				    FIELD_PREP(AD5310_DATA_MSK, val));
> +		*xfer = (struct spi_transfer) {
> +			.tx_buf = &st->data[bus_data->size].d16,
> +			.len = sizeof(st->data[bus_data->size].d16),
> +		};
>  		break;
>  	case AD5683_REGMAP:
> -		st->data[0].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
> -					      FIELD_PREP(AD5683_DATA_MSK, val));
> -		buf = &st->data[0].d8[1];
> -		tx_len = 3;
> +		st->data[bus_data->size].d32 =
> +			cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
> +				    FIELD_PREP(AD5683_DATA_MSK, val));
> +		*xfer = (struct spi_transfer) {
> +			.tx_buf = &st->data[bus_data->size].d8[1],
> +			.len = sizeof(st->data[bus_data->size].d8) - 1,
> +		};
>  		break;
>  	case AD5686_REGMAP:
> -		st->data[0].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
> -					      FIELD_PREP(AD5686_ADDR_MSK, addr) |
> -					      FIELD_PREP(AD5686_DATA_MSK, val));
> -		buf = &st->data[0].d8[1];
> -		tx_len = 3;
> +		st->data[bus_data->size].d32 =
> +			cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
> +				    FIELD_PREP(AD5686_ADDR_MSK, addr) |
> +				    FIELD_PREP(AD5686_DATA_MSK, val));
> +		*xfer = (struct spi_transfer) {
> +			.tx_buf = &st->data[bus_data->size].d8[1],
> +			.len = sizeof(st->data[bus_data->size].d8) - 1,
> +		};
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	return spi_write(spi, buf, tx_len);
> +	spi_message_add_tail(xfer, &bus_data->msg);
> +	bus_data->size++;
> +
> +	return 0;
> +}
> +
> +static int ad5686_spi_sync(struct ad5686_state *st)
> +{
> +	struct spi_device *spi = to_spi_device(st->dev);
> +	struct ad5686_spi_data *bus_data = st->bus_data;
> +
> +	bus_data->size = 0; /* always reset, even on sync failure */
> +	return spi_sync(spi, &bus_data->msg);
>  }
>  
>  static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  {
> -	struct spi_transfer t[] = {
> -		{
> -			.tx_buf = &st->data[0].d8[1],
> -			.len = 3,
> -			.cs_change = 1,
> -		}, {
> -			.tx_buf = &st->data[1].d8[1],
> -			.rx_buf = &st->data[2].d8[1],
> -			.len = 3,
> -		},
> -	};
>  	struct spi_device *spi = to_spi_device(st->dev);
> +	struct ad5686_spi_data *bus_data = st->bus_data;
> +	struct spi_transfer *xfer = &bus_data->xfers[0];

It would be nice if the commit message also explained why the
read() function needs to be changed to use bus_data.

>  	u8 cmd = 0;
>  	int ret;
>  
> @@ -86,8 +122,21 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  				      FIELD_PREP(AD5686_ADDR_MSK, addr));
>  	st->data[1].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, AD5686_CMD_NOOP));
>  
> -	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> -	if (ret < 0)
> +	xfer[0] = (struct spi_transfer) {
> +		.tx_buf = &st->data[0].d8[1],
> +		.len = sizeof(st->data[0].d8) - 1,
> +		.cs_change = 1,
> +	};
> +	xfer[1] = (struct spi_transfer) {
> +		.tx_buf = &st->data[1].d8[1],
> +		.rx_buf = &st->data[2].d8[1],
> +		.len = sizeof(st->data[1].d8) - 1,
> +	};
> +
> +	spi_message_init_with_transfers(&bus_data->msg, xfer, 2);
> +
> +	ret = spi_sync(spi, &bus_data->msg);
> +	if (ret)
>  		return ret;
>  
>  	return be32_to_cpu(st->data[2].d32);
