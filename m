Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DE2EEE7B
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785600338; cv=none; b=XJJNKP6erB2IsBqCgQDmFZ25U4VFJaZhSDaAhpfQuCe2QQOShs3ONAy99NeauuVgaQDHxWiswsw/xfNwrMFr3ZDHsy4esIg+qBRRPt+SN4Y95X7pnLHZGutiM83rz01GBUh54D17DN38gnclFfGQL4kNZGRLNWtGfXpvzT+oRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785600338; c=relaxed/simple;
	bh=oxrFo/MiPYvp3bJNzDqtZEFIdJkIlxJOdjwY6TyzoIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QA3B7uFbPgCC4QQEimw/an+36PHlslmhSnHjkVZSh2V2sKfqetV425V9AIRfZb0kgtcoRUhWTAN2yLTooRvOSrLEhozdcNx8nRUZCSWSN/5r6ija2JjWAZebOjT18/Qq+wmbN+mKq0M6+eRby9qLbHTvkcg+dA8mYKNicieZqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=S8cKgHlT; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="S8cKgHlT"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6ae409c13d5so655717eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785600335; x=1786205135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LAlQDiH7F6PqpCAq4OPB036ThlmDlEEYgk+OcTaeZ0w=;
        b=S8cKgHlTL6fk4vloCbWG7KB2hpSVNmj5nUy0Dh/7bv5SxyrLOvlvFKcwKElfON/4WY
         Ab8todnX6P+kdP80bLXuqjYinyKI41X/RUFHFROvsW5Rq/qD4VtXWxPHydISe4i5bPVN
         3GSkPO9ST4q+TxwpGd7/EW5WRpVfatCDcatrggDZqrCY5cXmkQxS0BRB0TChuH2XoS/n
         XlS1djj2b36c0LaTS08EbK1qtFMUNvg7hztZI7p5YG6OKg8eOGHaqo4HcZ4vigS+trxt
         MSchAZawVV6kG6PtPrqFcL9rU3fIKcUzjM4FERNA9W/62/jOzUapO8EzTNnN5j/YKgtb
         cpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785600335; x=1786205135;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LAlQDiH7F6PqpCAq4OPB036ThlmDlEEYgk+OcTaeZ0w=;
        b=j8XQ5I/ApWBmHAv4nfb4LaPoLVH0DchRGVX4vLzIx4fc7PaJ8+DBwjvMPwg9UhcvsP
         Ut8mLOQo7EEeFEv7lcbU8dioddSjjkcy5aJQUmy6rMij2agX10cszuQP68bydAc9X/hA
         /itE3W0p3oUTMpyeIR1lFR4iC8IKc8ZWTmj0i0qG8veb5kuCvBPUkX4VihvhRt55NCqH
         8qvF3sOVHLYP92qKTHfwHYL0c9LeCF5kE9/6eJT5ujpKm6pQdTr8wfX85wC1fIj1fKjz
         dZewQ3qv8IMTSUJlhEObynrAX1uaETz5uwT4y5WFN3nk+8VhMjqJQtcfmX7s5B00hAHq
         QcIA==
X-Forwarded-Encrypted: i=1; AHgh+RodmlWUKIT/sAtWRZSHszev46HkN4NiTwQyrr7kda+p0n+UsG1xu4YF68zR/Mo4yHvUXWvug2NBK30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCO8U1wbf/X6jzMpvtw06Kp1cK+37DNv8XuL1syj9vRwDcHjsK
	d/LWt2JYiAq5lhP5pb3m39YN0gPcET/PQsYMAgbS5HNzYxTwXt4NW38wXkR/DEKUZJk=
X-Gm-Gg: AR+sD11jPOQgnA+7qrKXSJ/FCV83n7FX6Gkl6Z/roc3sbAVczhh5jNxhPoElazTJ5j7
	vmh6g2h/XXaL7gxhJ3oB+Mhpl8pDLpm/DmYa3CJZIcGH32xkDWuNzVdPoQa3PAL6bgmRee/oOfn
	7A1OG8kcTJMuq9cFAN19YyC9f7GK2RB1oKbrsc88XnTlEs6Wv24ulAMn8eysqCYdvEjCf38NHbg
	QaCBbU0FPli4qFvVm3qlnRTlzh4M6oFDprZzpzPZvdVJpZ5YysB8ucZJT2lIBMQ73hKNmNLCu2z
	fU3wLgtHAJVEJgPgL4OwVzTe+eKJstt6lAkZMiUKrKZE+gU2DNtFI6QUIpb5YYylocNvRDB8ogJ
	IpTL6fYIWkA5skUzUjWrbZUCCULBo1wrQp4xxy5p70ubgTjB4QHE3O3fq2osyzZ/o/4GcTk4lGE
	Ilhkqz4sUs99wefaOEslJzrNbaEtuHoAnboiDgEhAKNFgTrAseCOcGK0HhLCN5yJWtZiSrajTk9
	Vs2P0ccVXrzRpk0Lpev1i/x9tpTUtADiMiP4JE=
X-Received: by 2002:a05:6820:4df1:b0:6a3:9756:b604 with SMTP id 006d021491bc7-6ae43290aaemr7429365eaf.11.1785600334483;
        Sat, 01 Aug 2026 09:05:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f664d884sm4232455fac.12.2026.08.01.09.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 09:05:33 -0700 (PDT)
Message-ID: <3688ba60-3ff3-4e61-81a5-c220afaef66f@baylibre.com>
Date: Sat, 1 Aug 2026 11:05:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
To: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jic23@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ciprian.hegbeli@analog.com, siratul.islam@linux.dev,
 u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com
References: <20260730131738.822405-1-stefan.popa@analog.com>
 <20260730131738.822405-3-stefan.popa@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260730131738.822405-3-stefan.popa@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 8:17 AM, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw, scale and hardware-gain attributes, a configurable
> oversampling (digital averaging) ratio, and PEC-protected register
> access. The current scale is derived from the shunt resistor value
> described in the device tree.
> 
> The driver operates in single-measurement mode: each raw read triggers
> an on-demand conversion via SMBus Quick Command and returns a matched
> current/voltage pair. This avoids the latency and complexity of the
> continuous FIFO mode while ensuring each read reflects the current
> state. The two selectable current-sense ranges are exposed through
> scale/scale_available.
> 
> Continuous FIFO buffering, threshold events and the alert interrupt are
> intentionally left out of this initial submission and may be added
> later.
> 
> Co-developed-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  MAINTAINERS                |   1 +
>  drivers/iio/adc/Kconfig    |  11 +
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max40080.c | 574 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 587 insertions(+)
>  create mode 100644 drivers/iio/adc/max40080.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e1170230c4bb2..467e6bbf72cde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28901,3 +28901,4 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
> +F:	drivers/iio/adc/max40080.c
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58da8255525e4..ebdbad81fbbd6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1907,3 +1907,14 @@ config XILINX_AMS
>  	  xilinx-ams.
>  
>  endmenu
> +
> +config MAX40080
> +	tristate "Analog Devices MAX40080 Current Sense Amplifier"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Analog Devices MAX40080
> +	  bidirectional current-sense amplifier with a 12-bit ADC and an I2C
> +	  interface.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max40080.
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 7cc8f9a12f763..9245a337dd935 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -166,3 +166,4 @@ obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> +obj-$(CONFIG_MAX40080) += max40080.o
> diff --git a/drivers/iio/adc/max40080.c b/drivers/iio/adc/max40080.c
> new file mode 100644
> index 0000000000000..82572536b704d
> --- /dev/null
> +++ b/drivers/iio/adc/max40080.c
> @@ -0,0 +1,574 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MAX40080 Digital Current-Sense Amplifier driver
> + *
> + * Copyright 2026 Analog Devices, Inc.
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX40080.pdf
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define MAX40080_REG_CFG		0x00
> +#define  MAX40080_CFG_MODE_MSK		GENMASK(2, 0)
> +#define  MAX40080_CFG_PEC_EN_MSK	BIT(5)
> +#define  MAX40080_CFG_RANGE_MSK		BIT(6)
> +#define  MAX40080_CFG_FILTER_MSK	GENMASK(14, 12)
> +
> +#define MAX40080_REG_FIFO_CFG		0x0A
> +#define  MAX40080_FIFO_CFG_STORE_IV_MSK	GENMASK(1, 0)
> +
> +#define MAX40080_REG_IV			0x10
> +/* Current is a 13-bit two's-complement value (magnitude + sign bit). */
> +#define  MAX40080_IV_I_MSK		GENMASK(12, 0)
> +#define  MAX40080_IV_I_SIGN_BIT		12
> +#define  MAX40080_IV_V_MAG_MSK		GENMASK(27, 16)
> +#define  MAX40080_IV_VALID_MSK		BIT(31)
> +
> +/* CFG.mode field values. */
> +#define MAX40080_CFG_MODE_STDBY		0x00
> +#define MAX40080_CFG_MODE_SINGLE	0x02
> +
> +/* CFG.range field values. */
> +#define MAX40080_CFG_RANGE_50MV		0
> +#define MAX40080_CFG_RANGE_10MV		1
> +
> +/* FIFO_CFG.store_iv field values. */
> +#define MAX40080_FIFO_CFG_STORE_I_V	0x02
> +
> +#define MAX40080_ADC_RES_BITS		12
> +#define MAX40080_INTER_VREF_MV		1250
> +#define MAX40080_V_BUFF_GAIN		30
> +#define MAX40080_CSA_50MV_GAIN		25
> +#define MAX40080_CSA_10MV_GAIN		125
> +
> +/*
> + * The RANGE field (CFG bit 6) selects one of two current-sense full-scale
> + * ranges (the MAX40080 supports exactly two: +/-50 mV and +/-10 mV). Indexed
> + * by the CFG.range field value.
> + */
> +static const int max40080_csa_gain[] = {
> +	[MAX40080_CFG_RANGE_50MV] = MAX40080_CSA_50MV_GAIN,
> +	[MAX40080_CFG_RANGE_10MV] = MAX40080_CSA_10MV_GAIN,
> +};
> +
> +#define MAX40080_NUM_RANGES	ARRAY_SIZE(max40080_csa_gain)
> +
> +struct max40080_state {
> +	struct i2c_client *client;
> +	/* Serializes read-modify-write access to the CFG register. */
> +	struct mutex lock;
> +	u32 shunt_resistor_uohm;
> +	/* Cached configuration: the selected RANGE index and oversampling ratio. */
> +	unsigned int range;
> +	int oversampling_ratio;
> +	/*
> +	 * Precomputed current scale (mA per code) for each RANGE setting, as
> +	 * {integer, nano} pairs for IIO_VAL_INT_PLUS_NANO. The range is
> +	 * selected by writing the corresponding scale.
> +	 */
> +	int current_scale[MAX40080_NUM_RANGES][2];
> +};
> +
> +static const int max40080_oversampling_avail[] = { 1, 8, 16, 32, 64, 128 };
> +
> +static int max40080_update_bits(struct max40080_state *st, u8 reg,
> +				u16 mask, u16 val)
> +{
> +	int tmp;
> +
> +	tmp = i2c_smbus_read_word_data(st->client, reg);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	tmp = (tmp & ~mask) | (val & mask);
> +
> +	return i2c_smbus_write_word_data(st->client, reg, tmp);
> +}
> +
> +/*
> + * In single-measurement mode the device sits idle until it receives an SMBus
> + * Quick Command, then performs exactly one current and one voltage conversion
> + * and returns to idle. Triggering on demand this way (rather than running the
> + * FIFO continuously in active mode) means each read returns a fresh, coherent
> + * current/voltage pair instead of the oldest queued FIFO entry.
> + */
> +static int max40080_trigger_measurement(struct max40080_state *st)
> +{
> +	return i2c_smbus_xfer(st->client->adapter, st->client->addr,
> +			      st->client->flags, I2C_SMBUS_WRITE, 0,
> +			      I2C_SMBUS_QUICK, NULL);
> +}
> +
> +/*
> + * A single measurement holds the matched current/voltage pair in one 32-bit
> + * word (MAX40080_REG_IV). Reading all four bytes in one transaction returns
> + * both from the same conversion; reading the separate current (0x0C) and
> + * voltage (0x0E) registers would decorrelate the two channels.
> + *
> + * Unlike the word accesses used elsewhere, this is a plain I2C block read: the
> + * SMBus layer does not append or verify a PEC byte for it even when PEC is
> + * otherwise enabled for the device, so this transfer is not PEC protected.
> + */
> +static int max40080_read_iv_once(struct max40080_state *st, u32 *iv)
> +{
> +	u8 buf[4];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(st->client, MAX40080_REG_IV,
> +					    sizeof(buf), buf);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;

This can't return anything other than negative error or sizeof(buf),
so this is dead code.

> +
> +	*iv = get_unaligned_le32(buf);
> +
> +	return 0;
> +}
> +
> +static int max40080_read_iv(struct max40080_state *st, u32 *iv)
> +{
> +	u32 tmp = 0;

initializing tmp is dead code.

> +	int ret, io_ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = max40080_trigger_measurement(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Wait for the conversion to complete by polling the FIFO valid bit
> +	 * (or bail out on an I2C error). Polling the device's own status makes
> +	 * this independent of the actual conversion time, which varies with the
> +	 * oversampling ratio and the bus speed. The timeout is only a safety
> +	 * ceiling: the worst case is the maximum 128x averaging on both the
> +	 * current and voltage channels at the slowest 15 ksps base rate plus the
> +	 * inter-channel switching time, i.e. roughly 20 ms; 50 ms leaves ample
> +	 * margin.
> +	 */
> +	ret = read_poll_timeout(max40080_read_iv_once, io_ret,
> +				io_ret || (tmp & MAX40080_IV_VALID_MSK),
> +				500, 50000, false, st, &tmp);
> +	/*
> +	 * Propagate the last-read value even on timeout so the caller can
> +	 * inspect it for debugging.
> +	 */
> +	*iv = tmp;
> +	if (ret)
> +		return ret;
> +
> +	return io_ret;
> +}
> +
> +static int max40080_get_current(struct max40080_state *st, int *val)
> +{
> +	u32 iv = 0;

don't need to init here either.

> +	int ret;
> +
> +	ret = max40080_read_iv(st, &iv);
> +	if (ret)
> +		return ret;
> +
> +	*val = sign_extend32(FIELD_GET(MAX40080_IV_I_MSK, iv),
> +			     MAX40080_IV_I_SIGN_BIT);
> +
> +	return 0;
> +}
> +
> +static int max40080_get_voltage(struct max40080_state *st, int *val)
> +{
> +	u32 iv = 0;
> +	int ret;
> +
> +	ret = max40080_read_iv(st, &iv);
> +	if (ret)
> +		return ret;
> +
> +	*val = FIELD_GET(MAX40080_IV_V_MAG_MSK, iv);
> +
> +	return 0;
> +}
> +
> +static int max40080_set_range(struct max40080_state *st, unsigned int range)
> +{
> +	int ret;
> +
> +	ret = max40080_update_bits(st, MAX40080_REG_CFG, MAX40080_CFG_RANGE_MSK,
> +				   FIELD_PREP(MAX40080_CFG_RANGE_MSK, range));
> +	if (ret)
> +		return ret;
> +
> +	st->range = range;
> +
> +	return 0;
> +}
> +
> +/*
> + * Precompute the current scale (mA per code) for each RANGE setting as
> + * {integer, nano} pairs. The shunt drop for a full-scale code is
> + *   Vref[mV] / ((1 << ADC_RES_BITS) * gain)
> + * and current = Vshunt / Rshunt, so with Rshunt in micro-ohms the scale in
> + * mA/code is
> + *   Vref[mV] * NANO * MICRO / ((1 << ADC_RES_BITS) * gain * Rshunt[uohm])
> + * expressed as an integer part plus a nano fractional part.
> + */
> +static void max40080_calc_current_scale(struct max40080_state *st)
> +{
> +	u32 rem;
> +	u64 tmp;
> +
> +	for (unsigned int i = 0; i < MAX40080_NUM_RANGES; i++) {
> +		tmp = (u64)MAX40080_INTER_VREF_MV * NANO * MICRO;
> +		tmp = div64_u64(tmp, (u64)(1 << MAX40080_ADC_RES_BITS) * max40080_csa_gain[i] *

					   BIT(MAX40080_ADC_RES_BITS)

> +				st->shunt_resistor_uohm);
> +		st->current_scale[i][0] = div_u64_rem(tmp, NANO, &rem);
> +		st->current_scale[i][1] = rem;
> +	}
> +}
> +
> +/*
> + * max40080_oversampling_avail[] is ordered so that its index is the FILTER
> + * field value (index 0 = no averaging, index 1 = 8x, ...). Return that index
> + * for an exact match, or -EINVAL for a value that is not on the list.
> + */
> +static int max40080_oversampling_to_filter(int val)
> +{
> +	for (unsigned int i = 0; i < ARRAY_SIZE(max40080_oversampling_avail); i++) {
> +		if (max40080_oversampling_avail[i] == val)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int max40080_set_oversampling_ratio(struct max40080_state *st, int val)
> +{
> +	int filter;
> +	int ret;
> +
> +	filter = max40080_oversampling_to_filter(val);
> +	if (filter < 0)
> +		return filter;
> +
> +	ret = max40080_update_bits(st, MAX40080_REG_CFG, MAX40080_CFG_FILTER_MSK,
> +				   FIELD_PREP(MAX40080_CFG_FILTER_MSK, filter));
> +	if (ret)
> +		return ret;
> +
> +	st->oversampling_ratio = val;
> +
> +	return 0;
> +}
> +
> +static int max40080_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);
> +	unsigned int range;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_CURRENT) {
> +			ret = max40080_get_current(st, val);
> +			if (ret)
> +				return ret;
> +		} else if (chan->type == IIO_VOLTAGE) {
> +			ret = max40080_get_voltage(st, val);
> +			if (ret)
> +				return ret;
> +		}

Looks like this could be a switch statement.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_CURRENT) {
> +			/*
> +			 * The selectable current-sense range is exposed through
> +			 * scale: each RANGE setting has its own precomputed
> +			 * mA-per-code value. Userspace picks the range by writing
> +			 * the matching scale.
> +			 *
> +			 * Take a local copy of range to ensure val and val2 come
> +			 * from the same setting even if a concurrent write changes
> +			 * st->range between the two accesses.
> +			 */
> +			range = st->range;

Local range variable is adding more characters than it saves.
Not really needed IMHO.

> +			*val = st->current_scale[range][0];
> +			*val2 = st->current_scale[range][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +		/* voltage[mV] = raw * Vref[mV] * buffer_gain / (1 << ADC_RES_BITS) */
> +		*val = MAX40080_INTER_VREF_MV * MAX40080_V_BUFF_GAIN;
> +		*val2 = MAX40080_ADC_RES_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = st->oversampling_ratio;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max40080_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Only the current channel has a selectable range/scale. */
> +		if (chan->type != IIO_CURRENT)
> +			return -EINVAL;
> +
> +		for (unsigned int i = 0; i < MAX40080_NUM_RANGES; i++) {
> +			if (val == st->current_scale[i][0] &&
> +			    val2 == st->current_scale[i][1])
> +				return max40080_set_range(st, i);
> +		}
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return max40080_set_oversampling_ratio(st, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max40080_write_raw_get_fmt(struct iio_dev *indio_dev,
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
> +static int max40080_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long info)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type != IIO_CURRENT)
> +			return -EINVAL;
> +
> +		*vals = (int *)st->current_scale;
> +		*length = MAX40080_NUM_RANGES * 2;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = max40080_oversampling_avail;
> +		*length = ARRAY_SIZE(max40080_oversampling_avail);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max40080_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			       unsigned int write_val, unsigned int *read_val)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);
> +	int val;
> +

No range checking on reg?

> +	if (read_val) {
> +		val = i2c_smbus_read_word_data(st->client, reg);
> +		if (val < 0)
> +			return val;
> +
> +		*read_val = val;
> +
> +		return 0;
> +	}
> +
> +	return i2c_smbus_write_word_data(st->client, reg, write_val);
> +}
> +
> +static const struct iio_info max40080_info = {
> +	.read_raw = max40080_read_raw,
> +	.write_raw = max40080_write_raw,
> +	.write_raw_get_fmt = max40080_write_raw_get_fmt,
> +	.read_avail = max40080_read_avail,
> +	.debugfs_reg_access = &max40080_reg_access,
> +};
> +
> +static const struct iio_chan_spec max40080_channels[] = {
> +	{
> +		.type = IIO_CURRENT,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +};
> +
> +/*
> + * Configure the device from the cached state. The device powers up in standby
> + * with PEC enabled (CFG POR = 0x0060), so PEC is kept enabled throughout.
> + */
> +static int max40080_init(struct max40080_state *st)
> +{
> +	u16 fifo_cfg, cfg;
> +	int ret, filter;
> +
> +	filter = max40080_oversampling_to_filter(st->oversampling_ratio);
> +	if (filter < 0)
> +		return filter;
> +
> +	/*
> +	 * Put the device in standby before (re)configuring the FIFO: the FIFO
> +	 * configuration register can only be written while the device is not
> +	 * converting.
> +	 */
> +	cfg = FIELD_PREP(MAX40080_CFG_MODE_MSK, MAX40080_CFG_MODE_STDBY) |
> +	      FIELD_PREP(MAX40080_CFG_PEC_EN_MSK, 1);
> +
> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	/* Store a matched current+voltage pair per conversion. */
> +	fifo_cfg = FIELD_PREP(MAX40080_FIFO_CFG_STORE_IV_MSK, MAX40080_FIFO_CFG_STORE_I_V);
> +
> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_FIFO_CFG,
> +					fifo_cfg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Use single-measurement mode: the device stays idle and converts once
> +	 * per SMBus Quick Command (see max40080_trigger_measurement()), so each
> +	 * read returns a fresh sample rather than a queued FIFO entry.
> +	 */
> +	cfg = FIELD_PREP(MAX40080_CFG_MODE_MSK, MAX40080_CFG_MODE_SINGLE) |
> +	      FIELD_PREP(MAX40080_CFG_PEC_EN_MSK, 1) |
> +	      FIELD_PREP(MAX40080_CFG_RANGE_MSK, st->range) |
> +	      FIELD_PREP(MAX40080_CFG_FILTER_MSK, filter);
> +
> +	return i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +}
> +
> +static int max40080_probe(struct i2c_client *client)
> +{
> +	const char *propname = "shunt-resistor-micro-ohms";
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max40080_state *st;
> +	int ret;
> +
> +	/*
> +	 * The device powers up with PEC enabled (CFG POR = 0x0060) and rejects
> +	 * unprotected transactions, so PEC support is mandatory, along with word
> +	 * access, the I2C block read used for the current/voltage pair, and the
> +	 * Quick Command used to trigger a conversion.
> +	 */
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_QUICK |
> +				     I2C_FUNC_SMBUS_PEC))
> +		return -EOPNOTSUPP;
> +
> +	client->flags |= I2C_CLIENT_PEC;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +

Assign propname here so we don't have to scroll to see what it is.

> +	ret = device_property_read_u32(dev, propname, &st->shunt_resistor_uohm);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "can't read %s\n", propname);
> +	if (!st->shunt_resistor_uohm)
> +		return dev_err_probe(dev, -EINVAL, "%s must be non-zero\n",
> +				     propname);
> +
> +	max40080_calc_current_scale(st);
> +
> +	/* Defaults: 50 mV range, no averaging. */
> +	st->range = MAX40080_CFG_RANGE_50MV;
> +	st->oversampling_ratio = 1;
> +
> +	indio_dev->name = "max40080";
> +	indio_dev->info = &max40080_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max40080_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max40080_channels);
> +
> +	ret = max40080_init(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id max40080_i2c_ids[] = {
> +	{ .name = "max40080" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max40080_i2c_ids);
> +
> +static const struct of_device_id max40080_of_match[] = {
> +	{ .compatible = "adi,max40080" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max40080_of_match);
> +
> +static struct i2c_driver max40080_driver = {
> +	.driver = {
> +		.name = "max40080",
> +		.of_match_table = max40080_of_match,
> +	},
> +	.probe = max40080_probe,
> +	.id_table = max40080_i2c_ids,
> +};
> +module_i2c_driver(max40080_driver);
> +
> +MODULE_AUTHOR("Ciprian Hegbeli <ciprian.hegbeli@analog.com>");
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices MAX40080 current-sense amplifier driver");
> +MODULE_LICENSE("GPL");

