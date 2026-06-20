Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42A2222C5
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781941402; cv=none; b=giyrjWB3NRseNaCN2HeR8yhoROdFQoR+s/K1y9P5PedpDieYgYlxpl75AMS8m/f4gKB2QlhvYfWL+MeYIHXUGvotirVzS/QTunte7LTi1L0YH8RjLEKN+qJAfaY815gJzIC6qkCPf+HL7Xu4CokzbvOSY7vmjPTJEy1WvVG4HEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781941402; c=relaxed/simple;
	bh=vdfnhw3YRthYLW7NoZkxwLQDENYWZHxfnzLd1ME8oFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvZ3fj6Uc2TO+gQg4J6eaargXJDmZdcLDEc9TM4RpT7qdKXXUVVwnPc5xaAanOLCgeCYQThRaOspf2ITbktIXr4yUyTg2xmr40Iyz2n2/sqAX4O5pNxR85r1ZfaCbf/OMu9unB2K9N5JV4Jhtuf3KxjOHUVfW4Gx7DvpV96c9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl2raJ3n; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl2raJ3n"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso17870055e9.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781941400; x=1782546200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXS8t5npxhKaIsgGfv/VQGf/gDm2d4sf6lLIFq0N37A=;
        b=jl2raJ3n4GgVOsrjL0NP377U0t3NomUYeHhZFZum4fqrJO0Jv5P4WJn0cOpHbpzV/H
         WmkzZavSU7KxBMPexGLm4RJJODJ/qou4ZwRu1ca+MLToIAN47mGkyOnPjHsWuQ+f9YwB
         eksx0KEPbA3tjWfAwceyxTHYzWwGan+AiV/1Anz3fN7Yxjd9eNvUJEGh6LHWCQIR9aUd
         RT1PJoxC+8+Z4a12HAWKyyIoAXuPquyYPdjIKbnMYMZyBarUtgbDeITIFzub56/I9BeE
         QGbSv1+BdlexfwGIuS5rCFPgZobtKOb1i0Z7KtnGKfHH53OuzNsV+D/1qxU8PkR7+Cc+
         dGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781941400; x=1782546200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXS8t5npxhKaIsgGfv/VQGf/gDm2d4sf6lLIFq0N37A=;
        b=pQPlTVjtk9/apZ8PZxAS0InPmtDTjE3MzsVUcAqGzB3dYDUwBeGpl02qoUdq21mtiW
         kv3WJnsMNOg+lNpC79RcPeqXrxMMKCNVcOntJRsFb5pgbojXwayXw4kop7XAxYDx8hvY
         Q9mHRcb3ERsJ255X+LU3ZfzDC9RIOwDG5sOQ+q899wYuu+06g2WTGnyQlJSqr+Kd7xv5
         7wG3nRho1cBHRuPCoRfyPGEiYyCZXlNfP+/FmSYRhti5P/ysP8RgoqTZYzQHmlpAt745
         P/Fw3acS3TnT9EO2T2f2EzYiGzIyT8HB5pB3+9TEBIcGvSkzMF97GF+4UBOThB5eDDrT
         baWw==
X-Forwarded-Encrypted: i=1; AFNElJ8yj5SEwMij7SwZFXhneM8qlZ2k3EFtWPBv1kYtBtl3vuTv6HfGs5GkyzwTVMbKEWuPSApTkcGrpxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCghM7gefLC5Lca5KfZHLqqbBUfsswjPf3X687FeFi0Uf1MiLS
	ukGXG6GI7TyY2vgw5Sr8h5OZyEAwSyO3HFyGruxfrScCH6o3p7gRXtCh
X-Gm-Gg: AfdE7cmhbkUNuNA7ih2hGZpUR6XjJTVwyCSohnmUyinExOvpAKfS30ojdJRIjbTHQ0n
	SfnAGx6XEP6mD1L0GnL2Kt9ezkfN1R70dKEcVU675BzKxw8ThEEnm3c1TgOkHNWBYbnhDmqcbEN
	V+2ssLlnPypYQiPnqEznh+vCvkcwmZGNiJrrZnb8Vv1n1Ju9AeAaNBzwgJ7Aq2OwUFufVDzbCZE
	3neOrfUZD/9WmfqtaakAOTNwkrw3CVlThak/LjZ5U3DWAwOMf9euWhQZAqJlbb1fyn/xNfHwpL5
	At6PAhNrOeimQSf6EkSiKJyAVXiEZ8xhkmCWf4ZsLcGl7VCB4Bsuo+ULpWVYX32gJ63gDjM9DqQ
	r0kWYyMa+pX2DIG+q+PKWDDBsQPJC0zk59TJgK0Bj/bu+mnXHSRrdJdbRTfZ2Xi3XWTkgnS6cqJ
	yRwpI/UAr4Hjt2ScWRzwtQKG9B4jr8iUI8OFER0EW9rXmk5N9dHoLg/01YlRzjsUQaqQ0HpXV01
	OUlfT4BHax8hZGu0U7QLD+9BPII6MZ53Dl5+4Upc4hGMZyXqcgWjQgv5qVWnjZXd0wuxWc6/nRk
	E6LWQQ==
X-Received: by 2002:a05:600c:6990:b0:490:b189:212d with SMTP id 5b1f17b1804b1-492490b7ea3mr32101455e9.33.1781941399416;
        Sat, 20 Jun 2026 00:43:19 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5413sm5922063f8f.11.2026.06.20.00.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 00:43:19 -0700 (PDT)
Date: Sat, 20 Jun 2026 09:43:17 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 2/3] iio: temperature: Add STS30 temperature sensor
 driver
Message-ID: <20260620094317.4e503b7d@systembl0wer>
In-Reply-To: <20260620044010.1082621-3-m32285159@gmail.com>
References: <20260620044010.1082621-1-m32285159@gmail.com>
	<20260620044010.1082621-3-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Max,

comments inline, some nits, some more serious, some Sashiko reviews.

Josh

On Fri, 19 Jun 2026 23:40:06 -0500
Maxwell Doose <m32285159@gmail.com> wrote:
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 Maxwell Doose
> + *
> + * Sensirion STS30 temperature sensor driver
> + *
> + * Datasheet: https://sensirion.com/media/documents/1DA31AFD/65D613A8/Datasheet_STS3x_DIS.pdf
> + *
> + * Author: Maxwell Doose <m32285159@gmail.com>

Nit, but this is probably unnecessary since you already have
the copyright statement above.

> + */
> +

You're missing array_size.h, as used in probe.

> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>

Move the IIO specific headers below the generic linux headers
and group them separately.

> +#include <linux/i2c.h>
> +#include <linux/kernel.h>

Don't use kernel.h for new entries, you should include what
you actually use instead of relying on this. (there is a tool
that can help with this, it's called `iwyu-tool`).

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +/* Amount of bytes received from the STS30 after a read command */
> +#define STS30_MEAS_SIZE 3
> +
> +#define STS30_COMMAND_READ_HIGH_REPEAT 0x2C06
> +#define STS30_COMMAND_READ_MED_REPEAT 0x2C0D
> +#define STS30_COMMAND_READ_LOW_REPEAT 0x2C10
> +
> +/* Soft reset command */

No point in having a comment if your macro is sensibly named.

> +#define STS30_COMMAND_RESET 0x30A2
> +
> +/*
> + * sts30 includes a CRC8 checksum at the end of its i2c responses. The polynomial
> + * is used to generate the CRC8 table and the seed is the starting value.
> + */
> +#define STS30_CRC8_POLYNOMIAL 0x31
> +#define STS30_CRC8_SEED 0xFF
> +
> +DECLARE_CRC8_TABLE(sts30_crc_table);
> +
> +enum sts30_read_delays {
> +	STS30_REPEAT_LOW = 4500,
> +	STS30_REPEAT_MED = 6000,
> +	STS30_REPEAT_HIGH = 15000
> +};
> +
> +/**
> + * struct sts30_data - data structure for STS30 driver
> + *
> + * @client: underlying i2c client data structure
> + * @lock: mutex for serialized communication on the i2c bus
> + * @delay: measurement duration for the current repeatability mode
> + */

I'd remove this comment altogether and just add a comment on why
you need a mutex.

> +struct sts30_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	/*
> +	 * sts30 has three potential repeatability/measurement durations. We need to
> +	 * account for them while reading the i2c bus.
> +	 *
> +	 * See section 2.2 in the datasheet for more info on processing times.
> +	 */
> +	enum sts30_read_delays delay;
> +};
> +
> +static int sts30_verify_crc8(struct sts30_data *data, u8 buf[STS30_MEAS_SIZE])
> +{
> +	int crc;
> +
> +	crc = crc8(sts30_crc_table, buf, 2, STS30_CRC8_SEED);

Please use sizeof() instead of hard coding the buffer length.

> +	if (crc != buf[2]) {
> +		dev_err(&data->client->dev, "Expected CRC8 value of 0x%02x, got 0x%02x\n",
> +			buf[2], crc);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sts30_read(struct sts30_data *data, u16 command, u16 *val)
> +{
> +	u8 tmp[2];
> +	u8 buf[STS30_MEAS_SIZE];
	
Reverse christmas tree order.

> +	int ret;
> +
> +	put_unaligned_be16(command, tmp);
> +
> +	ret = i2c_master_send(data->client, tmp, sizeof(tmp));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(tmp))
> +		return -EIO;
> +
> +	fsleep(data->delay);

Adding Sashiko's comment:

Will sending a STOP condition here abort the measurement? Since
i2c_master_send() issues a STOP condition rather than a Repeated START,
this sequence violates the protocol for the Clock Stretching Enabled
commands (0x2Cxx) defined above.
Should this use the "Clock Stretching Disabled" commands (e.g., 0x2400)
instead, or alternatively use a single i2c_transfer() with a Repeated START?

> +
> +	ret = i2c_master_recv(data->client, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	*val = get_unaligned_be16(buf);
> +
> +	ret = sts30_verify_crc8(data, buf);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

...

> +static int sts30_reset(struct sts30_data *data)
> +{
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = sts30_write(data, STS30_COMMAND_RESET);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(1500);

Add a comment or change this to a macro to explain why 1500
specifically.

> +
> +	return 0;
> +}
> +
> +static int sts30_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int *val, int *val2,
> +			  long mask)
> +{
> +	struct sts30_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u16 tmp;
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (data->delay) {
> +		case STS30_REPEAT_LOW:
> +			ret = sts30_read(data, STS30_COMMAND_READ_LOW_REPEAT, &tmp);
> +			break;
> +		case STS30_REPEAT_MED:
> +			ret = sts30_read(data, STS30_COMMAND_READ_MED_REPEAT, &tmp);
> +			break;
> +		case STS30_REPEAT_HIGH:
> +			ret = sts30_read(data, STS30_COMMAND_READ_HIGH_REPEAT, &tmp);
> +			break;
> +		default:
> +			dev_warn(&data->client->dev, "Repeatability state corrupted, got: %d\n",
> +				 data->delay);

Do we need this warning? Returning -EINVAL is sufficient
enough.

> +			return -EINVAL;
> +		}
> +
> +		if (ret)
> +			return ret;
> +
> +		*val = tmp;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		/*
> +		 * We use this constant -16852 as calculated using the formula
> +		 * in the datasheet. See section 4.12 in the data sheet for more
> +		 * info.
> +		 */
> +		*val = -16852;

Okay, this would definitely be better if it were a macro. I'd even
be tempted to add the formula in a comment for safe keeping.
 
...

> +static const struct i2c_device_id sts30_id[] = {
> +	{ "sts30" },
> +	{ "sts31" },
> +	{ "sts35" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sts30_id);

Move the struct i2c_device_id struct after probe(). Additionally,
use the `.name` named initializer when defining the IDs (this reflects
on Uwe Kleine-Konig's effort in IIO).

> +
> +static int sts30_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct sts30_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->name = client->name;
> +	indio_dev->info = &sts30_info;
> +	indio_dev->channels = sts30_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sts30_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	data->delay = STS30_REPEAT_HIGH;
> +
> +	ret = devm_mutex_init(&client->dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = sts30_reset(data);

You're not checking ret here.

> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +

-- 
Kind regards

CJD
