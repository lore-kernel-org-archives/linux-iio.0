Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595495;
	b=OZ7hcMz9PyGo3odmvez0CfigZyeUQgKlzuswZawqBb5Lgiqlaj4Oufmak4NteCudkrfE
	 6WoJsFryZZNFrLQb5cd4Cjh860S7wwRay78M31J/pWsmdFNRrKo8RvIbXsurPsY4Oz9Rt
	 m7CB4ndftDTVrzWHQc1dMjdugVV8T1oy40RCYzttkntelNjMtpoyhNDXGJmuwEDefUr4A
	 tE17vzXdpkBcnc9byyJFsb4ndW4C504t+BDoweBpSwuzXuzH/1p4Ur7IxB5+fRe7soCRn
	 arrYFGM9ha1wYPSpA6FlRxWxYxBcylkqURbBQclTPP/Erhw2ITmMYFZicHHSyHr2g1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595495;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=orkqkN9k0NvO+k3q6u67IvXNksIJl6E1WSlIId6lXvg=;
	b=CE/hlRc11NPK/Bn50EH6qSSs562cNQn3bcSbTgJq3tG6tbrcC5Qiz5HiECyxup0+BtyP
	 qvwZ53kDE/sZMobVwu8Nxi1MD00VSIWi4a6Y2AZhuAZjW5uPeRD7kfbBW1OaAw/KpjVLZ
	 nIN9fM3m7IHlHrMXl0iECZR/tMWxebp4nWpH58X7hNBtANUVAX6mEOC6G6ihI6Epe68Em
	 FauoP9i4nqrbfcxdC/yT5qieUs1PFIgu5QAmPb1dMiDd5GD7esQEkzihX1tow00/TaHrA
	 aHcj1W2DRhrD8GeNiTnIHd75NAe3awBDiwJYH3hbkJMyKIly1ZbTokC3NmVm4BlOBQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O/fjzGlN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C0606A31E;
	Wed, 25 Nov 2026 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/fjzGlN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C04A1F000CF;
	Wed, 25 Nov 2026 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795595494;
	bh=orkqkN9k0NvO+k3q6u67IvXNksIJl6E1WSlIId6lXvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O/fjzGlN6oVvhVvoBqjCKbVNEmy452qiZxK82fL/SIkZ+lx52h8kWBKa6zRgpOSzS
	 tusHyXoHdckAwHtLoh+p3GjZUskzZqimw0CY7Cd0PS9pOdg4dHaeTeUHJg5Z/fuxlv
	 nANs5ll3OY5hDUypEmejv/3hZ+RmcGuI98CQPUPeMwEOshNbk3Fm7ipYDg6blMO0lY
	 yVYhbBp2NjznoH6ciXoid7kcU6Mzf4ehqApTNNhdIxBsbVdIXP2mNzfHc+nWKtDa8e
	 ZKQ8jf4HkgBGptdtJzZRNNan8iX5+sSLcEivBPbqJ/MSE3pyzyZp/UrDR3S9u95799
	 imJDBy40J+NPQ==
Message-ID: <14111935-b991-457f-88d4-f5c06ae68df8@kernel.org>
Date: Wed, 25 Nov 2026 09:31:31 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] iio: light: add ams OSRAM TCS3430 XYZ and ambient
 light sensor driver
To: robertijtsma@gmail.com, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261124-iio-tcs3430-v1-0-0f2a38a6a4c1@gmail.com>
 <20261124-iio-tcs3430-v1-2-0f2a38a6a4c1@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261124-iio-tcs3430-v1-2-0f2a38a6a4c1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24-Nov-26 23:46, Robert Ijtsma via B4 Relay wrote:

...

> diff --git a/drivers/iio/light/tcs3430.c b/drivers/iio/light/tcs3430.c
> new file mode 100644
> index 0000000..138c8ab
> --- /dev/null
> +++ b/drivers/iio/light/tcs3430.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IIO driver for ams OSRAM TCS3430 Ambient Light and CIE 1931 XYZ Sensor
> + *
> + * Copyright (C) 2026 Robert Ijtsma <robertijtsma@gmail.com>
> + *
> + * Datasheet:
> + *   https://look.ams-osram.com/m/43d518b4cd81e3f2/original/TCS3430-DS000539.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>

No need for this, the device tables required will be pulled in
via the respective bus headers.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +

..

> +static int tcs3430_apply_gain(struct tcs3430_data *data, u8 gain_idx)
> +{
> +	u8 cfg1, cfg2;
> +	int ret;
> +
> +	if (gain_idx == 4) {
> +		cfg1 = FIELD_PREP(TCS3430_CFG1_AGAIN_MASK, 3);
> +		cfg2 = TCS3430_CFG2_DEFAULT | TCS3430_CFG2_HGAIN;
> +	} else {
> +		cfg1 = FIELD_PREP(TCS3430_CFG1_AGAIN_MASK, gain_idx);
> +		cfg2 = TCS3430_CFG2_DEFAULT;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3430_REG_CFG1, cfg1);

Why not use regmap for read/write operations?

> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3430_REG_CFG2, cfg2);
> +	if (ret)
> +		return ret;
> +
> +	data->gain_idx = gain_idx;
> +	return 0;
> +}
> +
> +static int tcs3430_init_hw(struct tcs3430_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, TCS3430_REG_ENABLE, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, TCS3430_REG_ATIME,
> +					TCS3430_DEFAULT_ATIME_CYCLES - 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = tcs3430_apply_gain(data, data->gain_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, TCS3430_REG_CFG3,
> +					TCS3430_CFG3_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, TCS3430_REG_INTENAB, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	return i2c_smbus_write_byte_data(client, TCS3430_REG_ENABLE,
> +					 TCS3430_ENABLE_PON |
> +					 TCS3430_ENABLE_AEN);
> +}
> +
> +static void tcs3430_power_off(void *priv)
> +{
> +	struct tcs3430_data *data = priv;
> +
> +	i2c_smbus_write_byte_data(data->client, TCS3430_REG_ENABLE, 0x00);
> +}
> +
> +static int tcs3430_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct tcs3430_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		guard(mutex)(&data->lock);

cleanup.h magic works thanks to local variables and a scope. When using
guard() in a switch case it has to be surrounded by brackets to define
the scope (this is what the email from lkp is warning about).

> +		ret = i2c_smbus_read_word_data(data->client, chan->address);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE: {
> +		u32 itime_us = TCS3430_DEFAULT_ATIME_CYCLES * TCS3430_ATIME_STEP_US;
> +		u64 scale_nano;
> +		u32 rem;
> +		int gain;
> +
> +		scoped_guard(mutex, &data->lock)
> +			gain = tcs3430_gains[data->gain_idx];
> +
> +		scale_nano = div_u64(TCS3430_LUX_FACTOR * NSEC_PER_SEC * USEC_PER_MSEC,
> +				     (u32)gain * itime_us);
> +		*val = div_u64_rem(scale_nano, NSEC_PER_SEC, &rem);
> +		*val2 = rem;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	}
> +
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		guard(mutex)(&data->lock);

Same here.

> +		*val = tcs3430_gains[data->gain_idx];
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = TCS3430_DEFAULT_ATIME_CYCLES * TCS3430_ATIME_STEP_US;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int tcs3430_read_avail(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	if (mask != IIO_CHAN_INFO_HARDWAREGAIN)
> +		return -EINVAL;
> +
> +	*vals = tcs3430_gains;
> +	*type = IIO_VAL_INT;
> +	*length = ARRAY_SIZE(tcs3430_gains);
> +	return IIO_AVAIL_LIST;

For IIO macros we usually use a switch, even if we're only checking
for one case.

-- 
Kind regards,
Joshua Crofts

