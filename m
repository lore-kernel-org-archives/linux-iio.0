Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48107 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbdCWLFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 07:05:20 -0400
Subject: Re: [PATCH] iio/adc/ltc2497: Driver for Linear Technology LTC2497 ADC
To: michael.hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
References: <1490265310-6162-1-git-send-email-michael.hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6774c073-7fe4-e259-306e-3cf4621f7c69@metafoo.de>
Date: Thu, 23 Mar 2017 12:05:10 +0100
MIME-Version: 1.0
In-Reply-To: <1490265310-6162-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The subject should follow the standard subsystem subject scheme. E.g. in
this case "iio: adc: Add driver for ..."

On 03/23/2017 11:35 AM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>

Needs a commit message.

> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/ltc2497.txt        |  13 +
>  MAINTAINERS                                        |   1 +
>  drivers/iio/adc/Kconfig                            |  11 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ltc2497.c                          | 263 +++++++++++++++++++++
>  5 files changed, 289 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ltc2497.txt
>  create mode 100644 drivers/iio/adc/ltc2497.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ltc2497.txt b/Documentation/devicetree/bindings/iio/adc/ltc2497.txt
> new file mode 100644
> index 0000000..c2829c19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ltc2497.txt
> @@ -0,0 +1,13 @@
> +* Linear Technology / Analog Devices LTC2497 ADC
> +
> +Required properties:
> + - compatible: Should be "lltc,ltc2497"

Replace 'should' with 'must'. It won't work if it isn't.

> + - reg: Should contain the ADC I2C address

Same here.

> + - vref-supply: The regulator supply for ADC reference voltage
> +
> +Example:
> +	ltc2497: adc@76 {
> +		compatible = "lltc,ltc2497";
> +		reg = <0x76>;
> +		vref-supply = <&ltc2497_reg>;
> +	};
[...]
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> new file mode 100644
> index 0000000..0452715
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -0,0 +1,263 @@
> +/*
> + * ltc2497.c - Driver for Linear Technology LTC2497 ADC

That's the "Analog Devices LTC2497 ADC" now ;)

> + *
> + * Copyright (C) 2017 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + *
> + * Datasheet: http://cds.linear.com/docs/en/datasheet/2497fd.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of.h>

Sorting alphabetically is preferred.

> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define LTC2497_ENABLE			0xA0
> +#define LTC2497_SGL			(1 << 4)

I'm sure 5 minutes after the patch has been applied somebody will send a
patch to replace this with BIT(4)

> +#define LTC2497_DIFF			(0 << 4)
> +#define LTC2497_SIGN			(1 << 3)
> +#define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
> +#define LTC2497_CONVERSION_TIME_MS	150ULL
> +
> +struct ltc2497_st {
> +	struct i2c_client *client;
> +	struct regulator *ref;
> +	ktime_t	time_prev;
> +	u8 addr_prev;
> +};
> +
> +static int ltc2497_wait_conv(struct ltc2497_st *st)
> +{
> +	s64 time_elapsed;
> +
> +	time_elapsed = ktime_ms_delta(ktime_get(), st->time_prev);
> +
> +	if (time_elapsed < LTC2497_CONVERSION_TIME_MS) {
> +		/* delay if conversion time not passed
> +		 * since last read or write
> +		 */
> +		msleep(LTC2497_CONVERSION_TIME_MS - time_elapsed);

Considering how long this sleeps msleep_interruptible() might be the better
choice.

> +		return 0;
> +	}
> +
> +	if (time_elapsed - LTC2497_CONVERSION_TIME_MS <= 0) {
> +		/* We're in automatic mode -
> +		 * so the last reading is stil not outdated
> +		 */
> +		return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int ltc2497_read(struct ltc2497_st *st, u8 address, int *val)
> +{
> +	struct i2c_client *client = st->client;
> +	__be32 buf = 0;

transfer buffers must not be on the stack to avoid issues if the controller
should use DMA.

> +	int ret;
> +
> +	ret = ltc2497_wait_conv(st);
> +	if (ret < 0 || st->addr_prev != address) {
> +		ret = i2c_smbus_write_byte(st->client, 0xA0 | address);
> +		if (ret < 0)
> +			return ret;
> +		st->addr_prev = address;
> +		msleep(LTC2497_CONVERSION_TIME_MS);
> +	}
> +	ret = i2c_master_recv(client, (char *)&buf, 3);
> +	if (ret < 0)  {
> +		dev_err(&client->dev, "i2c_master_recv failed\n");
> +		return ret;
> +	}
> +	st->time_prev = ktime_get();
> +	*val = (be32_to_cpu(buf) >> 14) - (1 << 17);
> +
> +	return ret;
> +}
[...]
