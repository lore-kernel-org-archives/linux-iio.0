Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3A335568
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272168; cv=none; b=HjndSBGy2hrwR8KAERY50WIN49zC4xtl842Arx6mJ7w6S16nVyVDLuF0jDYBUcF++25YafB4EZ5/pswXE5NmnJWwMgH2p/eLyR0dAn2zNNu/owVx3P6XC515Zbq6CDk9Oyi8QvMhyAbf99rOrXY+aexDENSKIMa8QkTfpth3YQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272168; c=relaxed/simple;
	bh=cuVqdlPBE/ZYdGFnfBVcnU7U+YIxtiI4ErQo6Qk6J2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ+EzC4/zzhp8CiEIpdjsxzrpPHyRIFWMAKe9+Na2u+i68iP44aEfL0eK5y19sVOL7AYFPlOBO7OG/h/fw/wV7vhye8v3U0bXK9NHw3ESRelPFqfxftm+AnyTxuj2FsPp7Lz+tdXU+jTdbwl5seGFBHfZ6T2tdmfMasox8yXZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2fT5eas; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2fT5eas"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so6726645e9.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781272165; x=1781876965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KlTuI81fMvZbGzbW+82D669jenQJLv5gsQIFsK9Lzo=;
        b=p2fT5easxpFZmv2JR74o8HHrl7vi47gwZgL/qufwWiuSZ7MLkDZzi5C/mkUihZg4lq
         sAoOzCl21MDsyNGMAsFkIfgaR+Gc2hvjjHVN/yfP1uVxjx2R7OIaK8kLF3tsInIyjoM2
         ACQE7qQJ3NikcsOa5XrLaBzGXhgz8CVXj5kopnK4LHHvc0+4mCqZPVn/D6SOC0Zvx5Ow
         DwYbmMm8uqJX6Stcm4Yx80Tkgu6k9uwGh/8fxzBDHH+aAubTSyddH78hYXjknUztA+IT
         RiL7YH0QRtZmMKiOXQ1Cfzu0W2alJv9nydlmPMINwodpe1kpjVk6yeyY/NIzA0vYsbkK
         FDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272165; x=1781876965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1KlTuI81fMvZbGzbW+82D669jenQJLv5gsQIFsK9Lzo=;
        b=rP6DPvBoJ1T70kZwUA6ql/1a4yB97zRLE57uuiFLSOtsqVutmSwiFCY0qiJazI5mfV
         kJGWAaKkptggyJnfITIFfaQbB/QVlfOfQpq4ZP3Clpr9YmEFhyfvWg9oBuuO7J3y93wb
         p4lmQvpDdGdBWldiwzAS6W1whiK/hJGFnO+G3wOPA+wsQCfcSw+0SsNjyY1FRrfOzlur
         UeKYK6LE41FaR4BJQBIPQglTN1XUyTaC4ca+Xx8cqz6vp6g38Ugc3G/ZR8WmbpRWlU6U
         tkfsvJgNNzdyQqGuDtG9W8qM4vICK2h0rwXz+GYtkBBzswyJHkUk3O33jWpaEEyAZojc
         Lddg==
X-Forwarded-Encrypted: i=1; AFNElJ9+j3m8ZUEun6i4DqmcpM2zveNtb8OXWXpUPoZmgN64db+NQKcdJM/WSdweSXbjS7ZQLIRp8zEM4oI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2hdOhe3/iU/z3YJSRE6kVcoqtojB/SFFvNPuIHpUiLKZa++p
	AQH4LXxqDS3EC0XIaI3I4qZSpDkuuraWbNETeT1AQunzwHTF5jWSZN4M
X-Gm-Gg: Acq92OFdwsBoSVK+wmQKM1ORtdC/8HtEHJrQZuNYxWu+zhXRnG4kI8viWUoQmsxSLMJ
	ohYyBtv71WpjMFB2JYMN5qbZ+Y9XCmS08hvEst9u6nGocjzjv2v8vwHGjsGxqodLx4WJMkoEaY2
	0GBZKq6PRnhE+wkvVYlI4u0OrOtAropt29OBb4BGbi0IhuvXXTNXUhaZsUYBm4SNS+UC9LG2Wqs
	5utegT1c5Y6MR1NvradFtJ56YhaQefc4ZFGSFxtga03GqKKn0ZV1Rsnu1HOygVQEjyWrYD9FzKP
	0pBvO8cfpyqYJ1cV0BW49+6fyJcoBcjPFePVjmegjeo/qG9gzxvdPfKQqDcb/eH+BTGrev50cPx
	9i0JzygIoY95mUcybSawHqpq/p361VulYi5qC2syYp/coGrJGMxGdV8szfXUL8hXJwgW06EXSbo
	SRJDDjkAeABrANC5jOkc+nKfmTPsQ95iubpFbv+N0ONvpJGq/Zght/686fhL+eVePFZriN3RQQQ
	SP3wum5h7IOMz/som8vzNysFmsiss7ztkzPauPmLadiOI2Yif+7L/7TKqH8IGSXd3WAv6sinD/m
	ku0cBK9h5IYMVPVhkSLSY+9oD5Xte+v0CJcEHnKRgLej5pQ3Njb6JfAa8J0cXWHD2Q==
X-Received: by 2002:a05:600d:8486:20b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-490ec4809abmr29434765e9.7.1781272164371;
        Fri, 12 Jun 2026 06:49:24 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7db56asm85979705e9.7.2026.06.12.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:49:24 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:49:22 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Siratul Islam <email@sirat.me>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: magnetometer: add driver for QST QMC5883L
 Sensor
Message-ID: <20260612154922.00003723@gmail.com>
In-Reply-To: <20260612124557.13750-4-email@sirat.me>
References: <20260612124557.13750-1-email@sirat.me>
	<20260612124557.13750-4-email@sirat.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 18:45:27 +0600
Siratul Islam <email@sirat.me> wrote:

> Add driver for the QST QMC5883L 3-Axis Magnetic Sensor
> connected via i2c.
> 
> Signed-off-by: Siratul Islam <email@sirat.me>
> ---

Hi Siratul,

various comments inline. I've probably missed a few things
as I only took a quick look so feel free to call me out on that!

Josh

> --- /dev/null
> +++ b/drivers/iio/magnetometer/qmc5883l.c
> @@ -0,0 +1,512 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * Support for QST QMC5883L 3-Axis Magnetic Sensor on i2c bus.

Nitpick, but I'd write it I2C with capital letters.

> + *
> + * Copyright (C) 2026 Siratul Islam <email@sirat.me>
> + *
> + * Datasheet available at
> + * <https://www.qstcorp.com/upload/pdf/202512/13-52-04%20QMC5883L%20Datasheet%20Rev.%20B.pdf>
> + *
> + * Default 7-bit i2c slave address 0x0D.

You also have this as a macro, consider removing this comment.

> + *
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>

Move IIO specific headers below generic linux headers, i. e.

#include <linux/x.h>
#include <linux/y.h>

#include <linux/iio/z.h>

> +#include <linux/i2c.h>
> +#include <linux/kernel.h>

No, refrain from using kernel.h, include the actual headers
instead of relying on this (on second thought, I think you've
actually included all the required headers, so you definitely
don't need this).

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/time.h>
> +
> +#include <asm/byteorder.h>
> +
> +#define QMC5883L_REG_X_LSB	0x00
> +#define QMC5883L_REG_STATUS1	0x06
> +#define QMC5883L_REG_CTRL1	0x09
> +#define QMC5883L_REG_CTRL2	0x0A
> +#define QMC5883L_REG_SET_RESET	0x0B
> +#define QMC5883L_REG_ID		0x0D
> +
> +#define QMC5883L_CHIP_ID	0xFF
> +
> +#define QMC5883L_MODE_MASK	GENMASK(1, 0)
> +#define QMC5883L_ODR_MASK	GENMASK(3, 2)
> +#define QMC5883L_RNG_MASK	GENMASK(5, 4)
> +#define QMC5883L_OSR_MASK	GENMASK(7, 6)
> +
> +#define QMC5883L_MODE_STANDBY	FIELD_PREP_CONST(QMC5883L_MODE_MASK, 0x00)
> +#define QMC5883L_MODE_CONT	FIELD_PREP_CONST(QMC5883L_MODE_MASK, 0x01)
> +
> +#define QMC5883L_ODR_10HZ	FIELD_PREP_CONST(QMC5883L_ODR_MASK, 0x00)
> +#define QMC5883L_ODR_50HZ	FIELD_PREP_CONST(QMC5883L_ODR_MASK, 0x01)
> +#define QMC5883L_ODR_100HZ	FIELD_PREP_CONST(QMC5883L_ODR_MASK, 0x02)
> +#define QMC5883L_ODR_200HZ	FIELD_PREP_CONST(QMC5883L_ODR_MASK, 0x03)
> +
> +#define QMC5883L_RNG_2G		FIELD_PREP_CONST(QMC5883L_RNG_MASK, 0x00)
> +#define QMC5883L_RNG_8G		FIELD_PREP_CONST(QMC5883L_RNG_MASK, 0x01)
> +
> +#define QMC5883L_OSR_512	FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x00)
> +#define QMC5883L_OSR_256	FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x01)
> +#define QMC5883L_OSR_128	FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x02)
> +#define QMC5883L_OSR_64		FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x03)
> +
> +#define QMC5883L_STATUS_DRDY	BIT(0)
> +#define QMC5883L_STATUS_OVL	BIT(1)
> +
> +#define QMC5883L_SET_RESET_VAL	BIT(0)
> +#define QMC5883L_INT_DISABLE	BIT(0)
> +#define QMC5883L_SOFT_RESET	BIT(7)
> +
> +#define QMC5883L_SCALE_2G	83333
> +#define QMC5883L_SCALE_8G	333333
> +
> +/* POR completion time max per datasheet */
> +#define QMC5883L_PORT_US	350

If it's POR completion, why does the macro contain PORT instead?
> +
> +struct qmc5883l_data {
> +	struct regmap *regmap;
> +	struct mutex mutex; /* update and read regmap data */
> +	u8 range;
> +	u8 odr;
> +	u8 osr;
> +};
> +
> +enum qmc5883l_chan {
> +	QMC5883L_AXIS_X,
> +	QMC5883L_AXIS_Y,
> +	QMC5883L_AXIS_Z,
> +};
> +
> +static const int qmc5883l_odr_avail[] = { 10, 50, 100, 200 };
> +
> +static const int qmc5883l_osr_avail[] = { 512, 256, 128, 64 };
> +
> +static const int qmc5883l_rng_avail[] = {
> +	0, QMC5883L_SCALE_2G,	/* 2G */

These comments are redundant IMO, you're already mentioning
the value in the macro name.

> +	0, QMC5883L_SCALE_8G,	/* 8G */
> +};
> +
> +static int qmc5883l_take_measurement(struct iio_dev *indio_dev, int index,
> +				     int *val)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	unsigned int status;
> +	__le16 buf[3];
> +	int ret;
> +
> +	scoped_guard(mutex, &data->mutex)

Why scoped_guard? I don't see any other possible code paths in this
function etc., just regular guard() should suffice.

> +	{
> +		/* 50ms headroom over the slowest ODR (10Hz) */
> +		ret = regmap_read_poll_timeout(data->regmap,
> +					       QMC5883L_REG_STATUS1, status,
> +					       (status & QMC5883L_STATUS_DRDY),
> +					       2 * USEC_PER_MSEC,
> +					       150 * USEC_PER_MSEC);
> +		if (ret)
> +			return ret;
> +
> +		if (status & QMC5883L_STATUS_OVL)
> +			return -ERANGE;

Sashiko has a remark:

If we return -ERANGE here when the overflow flag (OVL) is set, does the
sensor get permanently stuck in an overflow state?
In typical I2C magnetometers, the Data Ready (DRDY) and Overflow (OVL)
status bits are only cleared by reading the data registers. By returning
early without reading the data registers via regmap_bulk_read(), the DRDY
and OVL flags might remain set indefinitely. 
On subsequent measurement attempts, regmap_read_poll_timeout() will return
immediately and this check will instantly fail again, potentially locking up
the sensor until a reset.

> +
> +		ret = regmap_bulk_read(data->regmap, QMC5883L_REG_X_LSB, buf,
> +				       sizeof(buf));
> +		if (ret)
> +			return ret;
> +
> +		*val = (s16)le16_to_cpu(buf[index]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int qmc5883l_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int *val,

I'd put val on the same line as val2 and mask, more logical separation.

> +			     int *val2, long mask)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret = qmc5883l_take_measurement(indio_dev, chan->address, val);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:

Again, you can probably just add guard() before the switch.

> +		scoped_guard(mutex, &data->mutex)
> +		{
> +			*val = 0;
> +			*val2 = data->range == QMC5883L_RNG_2G ?
> +					QMC5883L_SCALE_2G :
> +					QMC5883L_SCALE_8G;
> +		}
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		scoped_guard(mutex, &data->mutex)
> +		{
> +			switch (data->odr) {
> +			case QMC5883L_ODR_200HZ:
> +				*val = 200;
> +				break;
> +			case QMC5883L_ODR_100HZ:
> +				*val = 100;
> +				break;
> +			case QMC5883L_ODR_50HZ:
> +				*val = 50;
> +				break;
> +			case QMC5883L_ODR_10HZ:
> +				*val = 10;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		scoped_guard(mutex, &data->mutex)
> +		{
> +			switch (data->osr) {
> +			case QMC5883L_OSR_64:
> +				*val = 64;
> +				break;
> +			case QMC5883L_OSR_128:
> +				*val = 128;
> +				break;
> +			case QMC5883L_OSR_256:
> +				*val = 256;
> +				break;
> +			case QMC5883L_OSR_512:
> +				*val = 512;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int qmc5883l_write_raw(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan, int val,
> +			      int val2, long mask)

Same comment with val as previous function.

> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	u8 rng;
> +	u8 osr;
> +	u8 odr;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val != 0)
> +			return -EINVAL;
> +
> +		switch (val2) {
> +		case QMC5883L_SCALE_2G:
> +			rng = QMC5883L_RNG_2G;
> +			break;
> +		case QMC5883L_SCALE_8G:
> +			rng = QMC5883L_RNG_8G;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		scoped_guard(mutex, &data->mutex)

Again, guard() is probably good enough.

> +		{
> +			ret = regmap_update_bits(data->regmap,
> +						 QMC5883L_REG_CTRL1,
> +						 QMC5883L_RNG_MASK, rng);
> +			if (ret)
> +				return ret;
> +			data->range = rng;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (val) {
> +		case 200:
> +			odr = QMC5883L_ODR_200HZ;
> +			break;
> +		case 100:
> +			odr = QMC5883L_ODR_100HZ;
> +			break;
> +		case 50:
> +			odr = QMC5883L_ODR_50HZ;
> +			break;
> +		case 10:
> +			odr = QMC5883L_ODR_10HZ;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		scoped_guard(mutex, &data->mutex)
> +		{
> +			ret = regmap_update_bits(data->regmap,
> +						 QMC5883L_REG_CTRL1,
> +						 QMC5883L_ODR_MASK, odr);
> +			if (ret)
> +				return ret;
> +			data->odr = odr;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (val) {
> +		case 64:
> +			osr = QMC5883L_OSR_64;
> +			break;
> +		case 128:
> +			osr = QMC5883L_OSR_128;
> +			break;
> +		case 256:
> +			osr = QMC5883L_OSR_256;
> +			break;
> +		case 512:
> +			osr = QMC5883L_OSR_512;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		scoped_guard(mutex, &data->mutex)
> +		{
> +			ret = regmap_update_bits(data->regmap,
> +						 QMC5883L_REG_CTRL1,
> +						 QMC5883L_OSR_MASK, osr);
> +			if (ret)
> +				return ret;
> +			data->osr = osr;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qmc5883l_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = qmc5883l_odr_avail;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(qmc5883l_odr_avail);
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = qmc5883l_osr_avail;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(qmc5883l_osr_avail);
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = qmc5883l_rng_avail;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = ARRAY_SIZE(qmc5883l_rng_avail);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int qmc5883l_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT;
> +	}
> +}
> +
> +static const struct iio_info qmc5883l_info = {
> +	.read_raw = qmc5883l_read_raw,
> +	.write_raw = qmc5883l_write_raw,
> +	.read_avail = qmc5883l_read_avail,
> +	.write_raw_get_fmt = qmc5883l_write_raw_get_fmt,
> +};
> +
> +static int qmc5883l_init(struct qmc5883l_data *data)
> +{
> +	unsigned int reg;
> +	int ret;

struct regmap *regmap = data->regmap;

Makes your lines shorter.

> +	ret = regmap_read(data->regmap, QMC5883L_REG_ID, &reg);
> +	if (ret)
> +		return ret;
> +
> +	/* Not failing because rev 1.0 had this register reserved */
> +	if (reg != QMC5883L_CHIP_ID)
> +		dev_warn(regmap_get_device(data->regmap),
> +			 "unknown chip id: 0x%02x, continuing\n", reg);

I recall a conversation about using dev_warn() or dev_info() for checking
the chip ID, up to personal preference. Nevertheless, your error messages
should follow the same format, so capital letter at the beginning (nitpick).

> +
> +	ret = regmap_write(data->regmap, QMC5883L_REG_CTRL2,
> +			   QMC5883L_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(QMC5883L_PORT_US);
> +
> +	/* DRDY pin no used in this version of the driver */
> +	ret = regmap_write(data->regmap, QMC5883L_REG_CTRL2,
> +			   QMC5883L_INT_DISABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, QMC5883L_REG_SET_RESET,
> +			   QMC5883L_SET_RESET_VAL);
> +	if (ret)
> +		return ret;
> +
> +	data->odr = QMC5883L_ODR_50HZ;
> +	data->range = QMC5883L_RNG_2G;
> +	data->osr = QMC5883L_OSR_64;
> +
> +	ret = regmap_write(data->regmap, QMC5883L_REG_CTRL1,
> +			   (QMC5883L_MODE_CONT | data->odr | data->range |
> +			    data->osr));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static bool qmc5883l_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	return reg <= QMC5883L_REG_STATUS1;
> +}
> +
> +static bool qmc5883l_writable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case QMC5883L_REG_CTRL1:
> +	case QMC5883L_REG_CTRL2:
> +	case QMC5883L_REG_SET_RESET:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config qmc5883l_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = QMC5883L_REG_ID,
> +	.cache_type = REGCACHE_MAPLE,
> +	.volatile_reg = qmc5883l_volatile_reg,
> +	.writeable_reg = qmc5883l_writable_reg
> +};
> +
> +#define QMC5883L_CHANNEL(_axis)                                \
> +	{                                                      \
> +		.type = IIO_MAGN,                              \
> +		.modified = 1,                                 \
> +		.channel2 = IIO_MOD_##_axis,                   \
> +		.address = QMC5883L_AXIS_##_axis,              \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),  \
> +		.info_mask_shared_by_type =                    \
> +			BIT(IIO_CHAN_INFO_SCALE) |             \
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |         \
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +		.info_mask_shared_by_type_available =          \
> +			BIT(IIO_CHAN_INFO_SCALE) |             \
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |         \
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +	}
> +
> +static const struct iio_chan_spec qmc5883l_channels[] = {
> +	QMC5883L_CHANNEL(X),
> +	QMC5883L_CHANNEL(Y),
> +	QMC5883L_CHANNEL(Z),
> +};
> +
> +static int qmc5883l_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	struct qmc5883l_data *data;
> +	struct device *dev = &client->dev;

Reverse Christmas tree order.

> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &qmc5883l_regmap_config);
> +	if (IS_ERR(regmap)) {

No point in adding brackets if this is a single line if statement
(checkpatch.pl should warn about this IMO).

> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +	}
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable VDD regulator\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vddio");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable VDDIO regulator\n");
> +
> +	fsleep(QMC5883L_PORT_US);
> +
> +	data = iio_priv(indio_dev);
> +	data->regmap = regmap;

Blank line here.

> +	ret = devm_mutex_init(dev, &data->mutex);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "qmc5883l";
> +	indio_dev->info = &qmc5883l_info;
> +	indio_dev->channels = qmc5883l_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(qmc5883l_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = qmc5883l_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "qmc5883l init failed\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

You're using devm_* functions, however I don't see any callback on driver
unbinding or a potential error during probing. Consider adding a power off
callback.

-- 
Kind regards

CJD
