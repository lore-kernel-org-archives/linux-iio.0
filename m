Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B930568E
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252069; cv=none; b=f1mBy1V3pkLQaXEA2z4vHj5zF23V+g6FN23QDSOzsbfiHLSOlWAp1N+czSymJ0AiF+2O4FKOGiiC7cmU5JSSdH4ZoFbt1OH/Jp+C10XwDmCOw8ZXCbLqHpNLBDzhfYl42keT04VnV0gd28m0L3FEpBf2VjcV7i9K8VsBq1n00+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252069; c=relaxed/simple;
	bh=sB12rjZQvfY+0nqCMGm5/eS7Tm/IKJtbPcsZAkbTUlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcDRK+9fe+bFL3GsK9ymW+lSxcxTwR31hfiJ+iNnVUbFKx4mRe4FhmWzon1xzfNA8dyoTES8SuJDhdHn1tL0Kn1dYz4FdEA30PNvB6XjsOasM4ajqBiBx0w4JwYdWZXVDZi5VfoJdDz1kcb420waSZoaaGpP5XJUL0jZmEK+8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Wo7hV34f; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Wo7hV34f"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6ab021f1daeso973124eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785252065; x=1785856865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TEbQx9iVU/oigH5jqnaSPZ5/iglekXSxvxq3fbiCe6c=;
        b=Wo7hV34fZNAPDhnY7oQEgSM2ls6MpVjabpHsxySacazRm2QglAkIdVigrOOZPhjn8+
         mPuZVV0sT2syO6+FpSRVCj/wRkSU55OMD9wB7z7lyk3zyJzn53cPAjyZo9U2NuAL/kPY
         OrrOQXBIhIVIV9sB6jyONxZ0Cf0dQmRhDR7Kvg31erGE6lFaB/iLiGpVcuRRuqRXA1ba
         3Tlr2929Da0mDpAH+iPq4rOPtX41DhDkHZjaBYlCYK08hmFtcaT4gX2KYH36ISk08Snr
         jzQEF6xy6aNq7y4vHS3CWkl1tEo6OkA60POJqVJT2br83VM0NUZ2btjT8P0biuxHoZo+
         gCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785252065; x=1785856865;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEbQx9iVU/oigH5jqnaSPZ5/iglekXSxvxq3fbiCe6c=;
        b=V9IJ2r7cy5S0OSl+eOsz9es1+Dn0kBMrdG11nISg4Jftr8CsIjhuvaEESPZpTiqbxV
         Ene5gDwQNDFDlHuKfaA6MSfiqOlwPYgZ4Tb7iOS3+8CkuS+zEJ0a0ZLyYkwct9z2qrdW
         kekCEPwKthchmptg1ruHUNR4Ms0rPCrO3TC5vRcT5BPI/xsHpiVq7xn0vb6DvVMZ5a7h
         lTUbpj9/DNt+lcoNNv8KyiQPmkkYAAXWE/9x1RS5cjyLGDrqgD1nVtbdNFdQEoFznftl
         VK03vrp92NX1bC5wn+Bay+ZdQmZxlGjfSWNkj1dS9vvE3vsV74vR26+LZub1cG41QJT7
         t29g==
X-Gm-Message-State: AOJu0Yxh+SGzT5TGaCUV870TRJTL1InPFWh1eovW0CwA3AKYYsC19hxf
	RP2pCVKJytPH68DzcAYb6wSzDr6p1uxls6jYuQ0qppLG9pd8PHEe87P1XtQsocqqdpk=
X-Gm-Gg: AR+sD11d8DrJ6GGE9PpxEnCdULoxH4Dan6GuVpBDmz4DP0y7087prZ0JlkZ8M2+Kk+a
	LCj5f4rXxaPGBm+PCEeUTr3V1NralH/yavSoGG3doV15xgG86ZAeKR/Gg0NwL6tivByGL+F9FuD
	0F3WfxMiSNg1pId5r5TDkdsiuL+DIYU037mK0hQwHbEuTvwFQmzK6Cjk4Vzb+Fdm+Z/wfTv5mSL
	wU3k3smlBo8HR0xGO9ARW68l2rpykbSUVWzFeIS0FNQtvOPDznYkNoyC2YNtxMGar/ivZji+0X5
	lXn6n6idolxmQdtaKh6s5/0lj0BC+q8PjnffRq8owKqtFCePIZti760ZQEEhAQqs6iNDwwE0/KR
	Lw+GneO5mlVgFHBipD1F3nQBznwMzaK3yzMDfyiQTxUrF1ENt25IUOHcve/YhQp8iY73hz8sHWc
	llcpJJHM6llnxYusYCan3vgN5hKxY1+j5CUUxvLovXoxxkjrYrP34e
X-Received: by 2002:a05:6820:206:b0:6a3:7ad9:c851 with SMTP id 006d021491bc7-6ac96dd866amr982812eaf.65.1785252065034;
        Tue, 28 Jul 2026 08:21:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3026:75d1:db9d:8984? ([2600:8803:e7e4:500:3026:75d1:db9d:8984])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00c645889sm130308a34.26.2026.07.28.08.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 08:21:04 -0700 (PDT)
Message-ID: <2f2d7ae4-1923-4a57-9939-63361f2ff5ca@baylibre.com>
Date: Tue, 28 Jul 2026 10:21:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com>
 <20260728-ti-ads112c04-driver-v1-2-475efe4e2b78@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-ti-ads112c04-driver-v1-2-475efe4e2b78@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 3:01 AM, Kyle Hsieh wrote:
> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> delta-sigma ADCs.
> 
> The driver implements:
> - Single-shot conversions using the IIO raw read interface.
> - MUX configuration for single-ended and differential channels.
> - Hardware interrupt support via the DRDY pin, falling back to
>   software polling of the configuration register if no IRQ is provided.
> - Scale calculation based on the internal 2.048V reference.
> - Dynamic reference voltage scaling via the regulator subsystem
>   (vref-supply), falling back to the internal 2.048V reference
>   if not specified.

Nice to see it starting with a minimal feature set like this. Makes it easy
to review.

In the cover letter, it would be nice to know if this is all the features
you need or if you plan to add more soon.

> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  drivers/iio/adc/Kconfig        |  10 ++
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/ti-ads112c04.c | 317 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 328 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3755a81c1efd..402e841bc083 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1789,6 +1789,16 @@ config TI_ADS1119
>           This driver can also be built as a module. If so, the module will be
>           called ti-ads1119.
>  
> +config TI_ADS112C04
> +	tristate "Texas Instruments ADS112C04 ADC"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Texas Instruments
> +	  ADS112C04 (16-bit) I2C analog to digital converters.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads112c04.
> +
>  config TI_ADS124S08
>  	tristate "Texas Instruments ADS124S08"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 707dd708912f..ebf9d4047a5a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -153,6 +153,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>  obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
>  obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
>  obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
> +obj-$(CONFIG_TI_ADS112C04)	+= ti-ads112c04.o
>  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
>  obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
> diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112c04.c
> new file mode 100644
> index 000000000000..0f1d415e3f21
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads112c04.c
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: GPL-2.0

Prefer either GPL-2.0-only or GPL-2.0-or-later (your choice).

> +/*
> + * Texas Instruments ADS112C04 16-bit I2C ADC driver
> + * Based on TI Reference Code and standard Linux IIO framework.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* ADS112C04 Commands */
> +#define ADS112C04_CMD_RESET         0x06
> +#define ADS112C04_CMD_START_SYNC    0x08
> +#define ADS112C04_CMD_POWERDOWN     0x02
> +#define ADS112C04_CMD_RDATA         0x10
> +#define ADS112C04_CMD_RREG(reg)     (0x20 | ((reg) << 2))
> +#define ADS112C04_CMD_WREG(reg)     (0x40 | ((reg) << 2))
> +
> +/* Registers */
> +#define ADS112C04_REG_CONFIG0       0x00
> +#define ADS112C04_REG_CONFIG1       0x01
> +#define ADS112C04_REG_CONFIG2       0x02
> +#define ADS112C04_REG_CONFIG3       0x03
> +
> +/* Config2 Masks */
> +#define ADS112C04_DRDY_MASK         BIT(7)
> +
> +struct ads112c04_state {
> +	struct i2c_client *client;
> +	/* Protects concurrent ADC reads and device configuration */
> +	struct mutex lock;
> +	struct completion completion;
> +	struct regulator *vref_reg;
> +	int vref_mv;
> +	u8 config0;
> +	u8 config1;
> +};
> +
> +static int ads112c04_write_cmd(struct i2c_client *client, u8 cmd)
> +{
> +	return i2c_master_send(client, &cmd, 1);
> +}
> +
> +static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 *val)
> +{
> +	u8 cmd = ADS112C04_CMD_RREG(reg);
> +	int ret;
> +
> +	ret = i2c_master_send(client, &cmd, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(client, val, 1);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int ads112c04_write_reg(struct i2c_client *client, u8 reg, u8 val)
> +{
> +	u8 buf[2] = { ADS112C04_CMD_WREG(reg), val };
> +	int ret;
> +
> +	ret = i2c_master_send(client, buf, 2);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int ads112c04_wait_for_data(struct ads112c04_state *st)
> +{
> +	int ret, timeout = 50;

Why is poll timeout 50x longer than interrupt timeout?

> +	u8 val;
> +
> +	/* If IRQ is available, wait for DRDY interrupt completion */
> +	if (st->client->irq > 0) {
> +		ret = wait_for_completion_timeout(&st->completion, msecs_to_jiffies(1000));
> +		if (!ret)
> +			return -ETIMEDOUT;
> +		return 0;
> +	}
> +
> +	/* Fallback: Poll DRDY bit in CONFIG2 */

Use read_poll_timeout() or if you convert to use regmap, regmap_read_poll_timeout().

> +	while (timeout--) {
> +		ret = ads112c04_read_reg(st->client, ADS112C04_REG_CONFIG2, &val);
> +		if (ret < 0)
> +			return ret;
> +		if (val & ADS112C04_DRDY_MASK)
> +			return 0;
> +		usleep_range(1000, 2000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int ads112c04_read_data(struct ads112c04_state *st, int *val)
> +{
> +	u8 cmd = ADS112C04_CMD_RDATA;
> +	u8 buf[2];

Use __be16 buf;

> +	int ret;
> +
> +	ret = i2c_master_send(st->client, &cmd, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(st->client, buf, 2);
> +	if (ret < 0)
> +		return ret;

Can be simplified by using smbus APIs. It would just be one call.

> +
> +	/* 16-bit 2's complement conversion */
> +	*val = (s16)((buf[0] << 8) | buf[1]);

And here use be16_to_cpu() and sign_extend32(). Then no comments needed.

> +	return 0;
> +}
> +
> +static int ads112c04_get_adc_result(struct ads112c04_state *st,
> +				    struct iio_chan_spec const *chan,
> +				    int *val)
> +{
> +	int ret;
> +	u8 mux;
> +
> +	mux = (chan->address << 4) & 0xF0;

Use FIELD_PREP().

> +	if ((st->config0 & 0xF0) != mux) {

Another option would be to use regmap with cache so that we don't
have to keep track of the current config ourselves.

> +		st->config0 = (st->config0 & 0x0F) | mux;
> +		ads112c04_write_reg(st->client, ADS112C04_REG_CONFIG0, st->config0);
> +	}
> +
> +	reinit_completion(&st->completion);
> +
> +	ret = ads112c04_write_cmd(st->client, ADS112C04_CMD_START_SYNC);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ads112c04_wait_for_data(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ads112c04_read_data(st, val);
> +}
> +
> +static int ads112c04_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct ads112c04_state *st = iio_priv(indio_dev);
> +	int ret, raw;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = ads112c04_get_adc_result(st, chan, val);
> +		mutex_unlock(&st->lock);
> +
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mv;
> +		*val2 = 15; /* 2^15 */
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t ads112c04_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ads112c04_state *st = iio_priv(indio_dev);
> +
> +	complete(&st->completion);

nit: add blank line here.

> +	return IRQ_HANDLED;
> +}
> +
> +#define ADS112C04_V_CHAN(_chan, _addr) {			\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = _chan,					\
> +	.address = _addr,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +#define ADS112C04_V_DIFF_CHAN(_chan, _chan2, _addr) {		\
> +	.type = IIO_VOLTAGE,					\
> +	.differential = 1,					\
> +	.indexed = 1,						\
> +	.channel = _chan,					\
> +	.channel2 = _chan2,					\
> +	.address = _addr,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec ads112c04_channels[] = {
> +	ADS112C04_V_DIFF_CHAN(0, 1, 0x00),
> +	ADS112C04_V_DIFF_CHAN(0, 2, 0x01),
> +	ADS112C04_V_DIFF_CHAN(0, 3, 0x02),
> +	ADS112C04_V_DIFF_CHAN(1, 0, 0x03),
> +	ADS112C04_V_DIFF_CHAN(1, 2, 0x04),
> +	ADS112C04_V_DIFF_CHAN(1, 3, 0x05),
> +	ADS112C04_V_DIFF_CHAN(2, 3, 0x06),
> +	ADS112C04_V_DIFF_CHAN(3, 2, 0x07),
> +	ADS112C04_V_CHAN(0, 0x08),
> +	ADS112C04_V_CHAN(1, 0x09),
> +	ADS112C04_V_CHAN(2, 0x0A),
> +	ADS112C04_V_CHAN(3, 0x0B),
> +};
> +
> +static const struct iio_info ads112c04_info = {
> +	.read_raw = ads112c04_read_raw,
> +};
> +
> +static void ads112c04_regulator_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static int ads112c04_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads112c04_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +	mutex_init(&st->lock);

	ret = devm_mutex_init(&st->lock);
	if (ret)
		return ret;

> +	init_completion(&st->completion);
> +
> +	indio_dev->name = "ads112c04";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads112c04_info;
> +	indio_dev->channels = ads112c04_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads112c04_channels);

We need more information to know how to configure each channel, so we
probably won't be able to use fixed channels like this.

> +
> +	st->vref_reg = devm_regulator_get_optional(&client->dev, "vref");

This is gonig to be more compilicated. See ti-ads112c14 driver.

> +	if (IS_ERR(st->vref_reg)) {
> +		ret = PTR_ERR(st->vref_reg);
> +		if (ret == -ENODEV) {
> +			st->vref_mv = 2048;
> +			st->config1 = 0x00; /* VREF[1:0] = 00 */
> +		} else {
> +			return ret;
> +		}
> +	} else {
> +		ret = regulator_enable(st->vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&client->dev, ads112c04_regulator_disable,
> +					       st->vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(st->vref_reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->vref_mv = ret / 1000;
> +		st->config1 = 0x02;
> +	}
> +
> +	/* Reset device to defaults */

There is a hardware reset, so the way we usually do that is to use
devm_reset_control_get_optional_exclusive() to see if the gpio is
wired up. If it is, use that to do the reset, otherwise fall back
to the software reset.

> +	ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> +	usleep_range(1000, 2000);

	fsleep(1000);

> +
> +	/* Set defaults: PGA Disabled (For single-ended safety), Gain=1 */
> +	st->config0 = 0x01;
> +
> +	ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);

Check return value.

> +
> +	if (client->irq > 0) {
> +		ret = devm_request_irq(&client->dev, client->irq,
> +				       ads112c04_irq_handler,
> +				       IRQF_TRIGGER_FALLING,

This flag already comes from the devicetree and should not be hard-coded
here.

> +				       indio_dev->name, indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "Failed to request DRDY IRQ\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id ads112c04_id[] = {
> +	{ "ads112c04", 0 },

	{ .name = "ads112c04" },

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ads112c04_id);
> +
> +static const struct of_device_id ads112c04_of_match[] = {
> +	{ .compatible = "ti,ads112c04" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ads112c04_of_match);
> +
> +static struct i2c_driver ads112c04_driver = {
> +	.driver = {
> +		.name = "ads112c04",
> +		.of_match_table = ads112c04_of_match,
> +	},
> +	.probe = ads112c04_probe,
> +	.id_table = ads112c04_id,
> +};
> +module_i2c_driver(ads112c04_driver);
> +
> +MODULE_AUTHOR("Kyle Hsieh <kylehsieh1995@gmail.com>");
> +MODULE_DESCRIPTION("Texas Instruments ADS112C04 ADC driver");
> +MODULE_LICENSE("GPL");
> 

