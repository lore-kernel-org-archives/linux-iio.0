Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793800616;
	b=e3UhBeMfoVRGYDDEnOby1gdWzgXnzsK3Digz/LC9ULHmxnCcpw38dyTsO2s+jj23Xe5U
	 tRUYQkw15d8fmqsPfyzzFVaMMz+SyS/yXI1qW8UYLRyejw3nP0Y0dFLTBYVFMPkH0EPGo
	 vaM8mhrTMXT8xcOiqYJdatRu3yiJsWJ9LAKTsUDXEHSDHfXcDQYW/ZAP+Kvq5K7as+zp7
	 8zugoF53+oTirCTt85aomYQZtAgU0DtHwSIvfJif4qA5lTpqV4ifJXdgqQqLBp85NJ5wh
	 UbAz4xX8NvVE0F7bgZkHp8JxFjrqbKp9xlmRzz9BXEiyowFt0nKNwEnbtHipa9MnFHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800616;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vKic/C72+wqsttWAVuyp/YoaAXXWO+b8jG90BXZi1Zk=;
	b=Dh+J1AbMRIl5XCRjlc/RtfHS/FU8RkiyUWT2V0w/Mzfkh4xk7/Awh5FcqIVW+4e7RDl6
	 eWak/lenjrXGYiOt9BClKx7u5ymm2oS8thI3l3yREGD6YD9Hkpm38jWJ1+3vr/DU0WVtZ
	 h3TJM9F/Du0W4iTIT/gLSMlbJQWbyWC/FTOtSUHOYxGY/3r7sVR4PstmFCbSRBvpRYmLA
	 DNs+0IA40IdOJ0xKKnHqEZQu2wD5v28IxSSkxMNODSd8DYQXAyvXY3qi4CXg9iRl8hbqc
	 fTCMxke8x0/fCAwuAwgxCyQM0zyEVLf7KnVAydFsy8IKwqmb3lobEWDssJRlk3ZxR8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbLsPnud;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90504606A31B;
	Wed,  4 Nov 2026 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbLsPnud
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793800616;
	b=ROACCw/h4Ho02HiQa+WvwTYnDfXCnAoMNjrGzU1oWC+h1QN5vKIvXRbaIvkl3HWxscmj
	 SSn8OoiQAqkm/Brsst8H4Qm64mDvtsZDMWCye+HogimNi1boq5mTtByv3HgQ5NmCvK6rO
	 5gaXGAbWgUK2w9H3uwvLaY2pEp1AgG3QtTOZzAbcwjl2YWWm9Nu6Qjfd3qyiuYT5eroAO
	 76+Uuc+io31WLLE2nVoGHxI80Su12TyZwP4HtE+XUGCTx8EzdIvOVgRQRCjWjssh8HEoO
	 20ocxXk+v2ogikCd+7+5+hJrP/9SN2ExFm9yK88Zr8SqByN0of/yRobDq2o9aOtOBEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793800616;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vKic/C72+wqsttWAVuyp/YoaAXXWO+b8jG90BXZi1Zk=;
	b=Umraio9WGSsS2Keq/gsHyv3UMnueAJ/5lJxL4/LNcsCrXtDJUAR6Hw6jAW/XMZPvAo8Q
	 1uZZx04GFvpcjnYMMdFiqSO140UNKGhF6owMGpc5P1BnaGSTyR8//zRprLxaW19yIpCyd
	 TlRCTCSf6e8vSfGHc1voYOtyMpxb6LWaAVQSNBi/9NOOK/y1BOsjEjGMB6HVjXFmtT/Ey
	 WMFsoIUHtaJ19HJ3H/yByn+MO+84+xx4h8ZTqYPh/KFoK8daVG25JOCM39rJXXq8OM4IJ
	 tRxiWp9eKYl7/hzfd/DtLtMtMNVRV5UF9G0VgM3R0W2U1VAgVSWqj5U0qP5ggMSwkmQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 683B91F000C1;
	Wed,  4 Nov 2026 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800616;
	bh=vKic/C72+wqsttWAVuyp/YoaAXXWO+b8jG90BXZi1Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IbLsPnud0D1mUXuC/ZBeLR6kvJ93sDofOsrwh1adBZJErGaJpublLSPCSaRj1F0T/
	 Yi+Box5ThELYqlJNZRqg58LC31uYyNkqlSjjMmU8EgnSfNvrbgQHySvhN4GFXKvMWH
	 0zo+RB/xUt1Y1btOgD8qNJ4/xpp11aclLSbA1JCYqVYkGtF5KV7F3hnTRJOpdSyDp4
	 YVAsP/TJfd2AUKuxEzITWS+0lsqc5/mwyWOvl7Neh1JqjcPbCCDMQJU9qK2nRjBA7z
	 Vpd8piVIPWkg7oX+lB+7T+gUmxocSGqav2Htj8IvnIjSxaNYeoSc39eLMWBxTmWAl2
	 G+JQQsD6P5zsA==
Date: Wed, 4 Nov 2026 14:56:41 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Rodolfo Giometti
 <giometti@enneenne.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz,
 herve.codina@bootlin.com, thomas.petazzoni@bootlin.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <20261104145641.000070f2@kernel.org>
In-Reply-To: <20261104125726.1754980-3-maxime.chevallier@bootlin.com>
References: <20261104125726.1754980-1-maxime.chevallier@bootlin.com>
	<20261104125726.1754980-3-maxime.chevallier@bootlin.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Wed,  4 Nov 2026 13:57:25 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

...

> diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
> new file mode 100644
> index 000000000000..ec754ec43d7c
> --- /dev/null
> +++ b/drivers/iio/adc/ti-tla2528.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Texas Instruments TLA2528 ADC
> + *
> + * Copyright (C) 2020-2021 Rodolfo Giometti <giometti@enneenne.com>
> + * Copyright (C) 2025 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Datasheet: https://www.ti.com/lit/gpn/tla2528
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>

Remove mod_devicetable.h, now i2c.h supplies this. See Uwe Kleine-Konig's
work on this.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/adc-helpers.h>
> +#include <linux/iio/iio.h>
> +

+ #include <asm/byteorder.h> for be16_to_cpu()

> +#define TLA2528_OP_WRITE_REG		0x08
> +#define TLA2528_OP_READ_REG		0x10
> +
> +#define TLA2528_GENERAL_CFG_ADR		0x01
> +#define TLA2528_GENERAL_CFG_RST		BIT(0)
> +#define TLA2528_CHANNEL_SEL_ADR		0x11
> +#define TLA2528_CHANNEL_SEL_MANUAL_CHID	GENMASK(3, 0)
> +#define TLA2528_AUTO_SEQ_CH_SEL_ADR	0x12
> +
> +#define TLA2528_NUM_CHANNELS		8
> +
> +struct tla2528 {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	int vref_mv;

Slight nit, but _mV so we emphasize this is a SI unit.

> +
> +	/* Protects manual channel selection */
> +	struct mutex lock;
> +};
> +

...

> +static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
> +{
> +	__be16 data;
> +	int ret;
> +
> +	guard(mutex)(&tla2528->lock);
> +
> +	ret = regmap_update_bits(tla2528->regmap, TLA2528_CHANNEL_SEL_ADR,
> +				 TLA2528_CHANNEL_SEL_MANUAL_CHID, channel);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_master_recv(tla2528->client, (char *)&data, sizeof(data));
> +	if (ret < 0)
> +		return ret;
>

As rare as short reads may be, perhaps add a check whether the expected amount
of bits have been returned from the device?

-- 
Kind regards,
Joshua Crofts
