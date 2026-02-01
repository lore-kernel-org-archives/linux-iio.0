Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE210224AE8
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769971529; cv=none; b=Q7DLmOXEbeDb9jPyAWT2mFSwff8I+qOAAMlSfGQVPQmTZQnpudsmmV/Qz7nnnxRSd2DKjkJxluIQQqGz532vCOUV+qj524ocGKKfFkYuThygW2MBcEnY01LfmQ5t5LjCvzjUcDwFuWuzBTPCENHClMIrab6CXz2jG/nE3WL8/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769971529; c=relaxed/simple;
	bh=aZbaqyvhzNoq8R4AQBepijVmz+G3IqWX9vH5VvPb+NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLkGe54V0wBQwZ1gNNu8Qp1uaj7m6IJud2Vx4PHvdrgk/dBxvdyGC8jEhIqP5VwmgXlBgusNF9jFtlhMz2C3rssFEs9cBuhQb4wm662r8KdYABImWt4mb1/wKrt2pHGuC+uAlOptXzEwah/hLddDxJN4B6dDI8od7QwXkgVBZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WDiUDoId; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WDiUDoId"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7cfdf0c8908so2322149a34.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 10:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769971525; x=1770576325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPKDMX7mgYuok3kbSi0d2krGfExzSZQ/EK8j/KlADR0=;
        b=WDiUDoIdKrIlUwRegbysjWWgP+yfX7JblE37bOPuMxX4wLLUbHOjiXecDmQheGliqI
         XgUKrr3ennf1KLNvlEbc4A6iuQVt5Nbg76xWR0zlMtBf5K8GOrG+bYOqpf0R3+nd49EU
         IRDbgBBAdGCMg4iCro9nxIJzeIWja9o69Dfz+gzgpo+BXf5zMzzCfvoBJlTcQMKEuJXc
         1HtcT61yTYwTltUHqNnp6jAA275dLLxdyGYGYiOXZfYV/a8JsjrxqanssuLMwL+5ezW4
         Pgx7XQqkhi+g5LcHA/jmo9y8Y+EGzsFdTgxoPMdG/Swtm+bMKDsxofYkRbQJcHp9C7UT
         iV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769971525; x=1770576325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPKDMX7mgYuok3kbSi0d2krGfExzSZQ/EK8j/KlADR0=;
        b=NgqLnLUAXLKHmwkmZlfQd7YE+7WnxNyYY0/NQtuhofFgDDhdDqo4T9QkbqV4rYqAe4
         dPK8guAuvbBHqZfB40J9hsSiUs6WTZ4P5gqVjP+ENVLMhxXQXYCah9naJ4Uz+y4a/LCc
         F0Wyg7AvClcqw5lH9ojpVly56qEkousrL8DDXe6cJ3EA5qrchsIjPQwD9inLXyUUyy5h
         j7QFlfbyXVCCQDBpU8EeXkDeS5D15fyWXm3S5v7o0qc91WcmcRFxgZyAEGEF5gbM7AGJ
         FSdRzvON9gpqCZnUiwNsc/UNs+jWhWve4n9bbRiJM8kvs4KoArgXM+C90RolxQ2AXEpN
         WK6g==
X-Gm-Message-State: AOJu0Ywh9GW0/3m5W8WNO4UI7LUMPghTa5x29AT3DMO2S0+UqmQHWM2E
	cbF+89qhjpndJ9rkWyjSqQYXUzjJ39YjYcDkOcwY+HKUBd5mpT6y/zRTN/10F68qcfw=
X-Gm-Gg: AZuq6aKgqpnO77CNQfi9hqUR/GSnhNA+hkjRIkYWPI5cJP3LYGbdBMf/VusmvgH+BlJ
	sZlZveR1eJy5ra2ZuQ/GGEaKOxJ6Pha+Of5aUl0b43f0crMrV5gnV3PHEa5skXYWIsk842AY5K3
	DF05U0r7lqfsHLHYaXQG0DiHw29kfvdfqlFBP0WT8FYr/yW4gPmsGwb8FxaFc4uSAG1wAOdyT7w
	LkZPJHkXLPblC5BrexgsCU4JTEPIrNO6X2laPKoZ3/s5M1Tp4tcuVGhCBpTCHI1WLXVJBJt2KXI
	aaIw4Ea+hduJ/gCMINfpmMd+0Qu6ujQngCofj+VHO9VYBOSfy5sJ7QG9dy/u/E3JV76UWGBTQfC
	G4GmMJASWHYMN9nlBarn/ywUtyT+gIZjn5dxSZarjHPEKgQgPB1NLrqIVX8zdqtFI+CG8aBP5jp
	2h328d6Ljex4xOT+RSJ0K/lKZ0M4lHArgC50uuOmXNGjk3oH/I50qCV/cAxyax
X-Received: by 2002:a05:6830:4ac9:b0:7cf:d14c:c402 with SMTP id 46e09a7af769-7d1a5233451mr6046406a34.6.1769971524552;
        Sun, 01 Feb 2026 10:45:24 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:66ee:10f7:4858:7df6? ([2600:8803:e7e4:500:66ee:10f7:4858:7df6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095756cb0bsm9945826fac.18.2026.02.01.10.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 10:45:23 -0800 (PST)
Message-ID: <eb922433-3951-409a-a397-b48efef57b7b@baylibre.com>
Date: Sun, 1 Feb 2026 12:45:21 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
To: Erikas Bitovtas <xerikasxx@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260201-cm36686-v1-0-4949a2a9ba63@gmail.com>
 <20260201-cm36686-v1-2-4949a2a9ba63@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260201-cm36686-v1-2-4949a2a9ba63@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/26 11:03 AM, Erikas Bitovtas wrote:
> This driver adds the initial support for the Capella cm36686
> ambient light and proximity sensor and cm36672p proximity sensor.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  drivers/iio/light/Kconfig   |  11 +
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/cm36686.c | 810 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 822 insertions(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index ac1408d374c9..b1d1943dec33 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -220,6 +220,17 @@ config CM36651
>  	  To compile this driver as a module, choose M here:
>  	  the module will be called cm36651.
>  
> +config CM36686
> +	depends on I2C
> +	tristate "CM36686 driver"
> +	help
> +	  Say Y here if you use cm36686.
> +	  This option enables ambient light & proximity sensor using
> +	  Capella cm36686 device driver.
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called cm36686.
> +
>  config IIO_CROS_EC_LIGHT_PROX
>  	tristate "ChromeOS EC Light and Proximity Sensors"
>  	depends on IIO_CROS_EC_SENSORS_CORE
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c0048e0d5ca8..806df80f6454 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_CM3232)		+= cm3232.o
>  obj-$(CONFIG_CM3323)		+= cm3323.o
>  obj-$(CONFIG_CM3605)		+= cm3605.o
>  obj-$(CONFIG_CM36651)		+= cm36651.o
> +obj-$(CONFIG_CM36686)		+= cm36686.o
>  obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
>  obj-$(CONFIG_GP2AP002)		+= gp2ap002.o
>  obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
> diff --git a/drivers/iio/light/cm36686.c b/drivers/iio/light/cm36686.c
> new file mode 100644
> index 000000000000..eb108af7226d
> --- /dev/null
> +++ b/drivers/iio/light/cm36686.c
> @@ -0,0 +1,810 @@
> +// SPDX-License-Identifier: GPL-2.0-only

I would expect copyright statements to be preserved here since the cover
letter mentions much of this was derived from existing code.

> +
> +#include <asm-generic/errno-base.h>

Should not be using generic, it may be different from arch-specific.

Generally we #include <linux/err.h> instead.

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device/devres.h>
> +#include <linux/iio/types.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/i2c.h>

Alphabetial order please.

> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/interrupt.h>

linux/iio/*.h can be grouped seperately.

> +
> +/* Device registers */
> +#define CM36686_REG_ALS_CONF		0x00
> +#define CM36686_REG_PS_CONF1		0x03
> +#define CM36686_REG_PS_CONF3		0x04
> +#define CM36686_REG_PS_THDL		0x06
> +#define CM36686_REG_PS_THDH		0x07
> +#define CM36686_REG_PS_DATA		0x08
> +#define CM36686_REG_ALS_DATA		0x09
> +#define CM36686_REG_INT_FLAG		0x0B
> +#define CM36686_REG_ID_FLAG		0x0C
> +
> +/* ALS_CONF */
> +#define CM36686_ALS_IT			GENMASK(7, 6)
> +#define CM36686_ALS_GAIN		GENMASK(3, 2)
> +#define CM36686_ALS_INT_EN		BIT(1)
> +#define CM36686_ALS_SD			BIT(0)
> +
> +/* PS_CONF1 */
> +#define CM36686_PS_DR			GENMASK(7, 6)
> +#define CM36686_PS_PERS			GENMASK(5, 4)
> +#define CM36686_PS_IT			GENMASK(3, 1)
> +#define CM36686_PS_SD			BIT(0)
> +
> +#define CM36686_PS_INT_OUT		BIT(9)
> +#define CM36686_PS_INT_IN		BIT(8)
> +
> +/* PS_CONF3 */
> +#define CM36686_PS_SMART_PERS_ENABLE	BIT(4)
> +
> +#define CM36686_LED_I			GENMASK(10, 8)
> +
> +/* INT_FLAG */
> +#define CM36686_PS_IF			GENMASK(9, 8)
> +
> +/* Default values */
> +#define CM36686_ALS_ENABLE		0x00
> +#define CM36686_PS_DR_1_320		FIELD_PREP(CM36686_PS_DR, 3)
> +#define CM36686_PS_PERS_2		FIELD_PREP(CM36686_PS_PERS, 1)
> +#define CM36686_PS_IT_2_5T		FIELD_PREP(CM36686_PS_IT, 3)
> +#define CM36686_LED_I_100		FIELD_PREP(CM36686_LED_I, 2)
> +
> +/* Shifts */
> +#define CM36686_INT_FLAG_SHIFT		8
> +
> +/* Max proximity thresholds */
> +#define CM36686_MAX_PS_VALUE		(BIT(12) - 1)
> +
> +#define CM36686_DEVICE_ID		0x86
> +
> +enum {
> +	CM36686,
> +	CM36672P,
> +};

We try to avoid an ID enum in new drivers.

> +
> +enum cm36686_distance {
> +	CM36686_AWAY = 1,
> +	CM36686_CLOSE,
> +	CM36686_BOTH
> +};
> +
> +enum {
> +	CM36686_PS_CONF1,
> +	CM36686_PS_CONF3,
> +	CM36686_PS_CONF_NUM
> +};
> +
> +enum {
> +	CM36686_SUPPLY_VDD,
> +	CM36686_SUPPLY_VDDIO,
> +	CM36686_SUPPLY_VLED,
> +	CM36686_SUPPLY_NUM,
> +};
> +
> +static const int cm36686_als_it_times[][2] = {
> +	{0, 80000},
> +	{0, 160000},
> +	{0, 320000},
> +	{0, 640000}
> +};

We try to keep a consistent style of spaces inside of braces and
trailing common on the last item (unless it is a sentinl value).

	{ 0, 640000 },

> +
> +static const int cm36686_ps_it_times[][2] = {
> +	{0, 320},
> +	{0, 480},
> +	{0, 640},
> +	{0, 800},
> +	{0, 960},
> +	{0, 1120},
> +	{0, 1280},
> +	{0, 2560}
> +};
> +
> +static const int cm36686_ps_led_current[] = {

We try to always include the units in the identifier name.
Is this milliamps or microamps?

> +	50,
> +	75,
> +	100,
> +	120,
> +	140,
> +	160,
> +	180,
> +	200
> +};
> +
> +struct cm36686_data {
> +	struct mutex lock;

Locks need to always have a comment explaining what they are protecting.

> +	struct i2c_client *client;
> +	struct regulator_bulk_data supplies[CM36686_SUPPLY_NUM];
> +	int als_conf;
> +	int ps_conf[CM36686_PS_CONF_NUM];
> +	int ps_close;
> +	int ps_away;
> +};
> +
> +struct cm36686_chip_info {
> +	const char *name;
> +	const struct iio_chan_spec *channels;
> +	const int num_channels;
> +};
> +
> +static int cm36686_current_to_index(int led_current)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cm36686_ps_led_current); i++)
> +		if (led_current < cm36686_ps_led_current[i])
> +			break;
> +
> +	return i > 0 ? i - 1 : -EINVAL;

Not sure I follow the logic here. Shouldn't this just `return i;`
instead of `break;` and then unconditnionally `return -EINVAL;` at
the end?

If not, it could use some comments to explain.

> +}
> +
> +static ssize_t cm36686_read_near_level(struct iio_dev *indio_dev,
> +				       uintptr_t priv,
> +				       const struct iio_chan_spec *chan,
> +				       char *buf)
> +{
> +	struct cm36686_data *chip = iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%u\n", chip->ps_close);
> +}
> +
> +static const struct iio_chan_spec_ext_info cm36686_ext_info[] = {
> +	{
> +		.name = "nearlevel",
> +		.shared = IIO_SEPARATE,
> +		.read = cm36686_read_near_level,
> +	},
> +	{}

IIO style for sentinil values is `{ }` (with space in between).

> +};
> +
> +static const struct iio_event_spec cm36686_proximity_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	}

All of these should have trailing comma.

> +};
> +
> +static const struct iio_chan_spec cm36686_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |

IIO_LIGHT should have IIO_CHAN_INFO_SCALE to convert raw to convert the
raw value to lux. If we don't have that info due to lack of documentation,
then we should add a comment to explain that. Or maybe we can make an
educated guess?

> +				      BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = CM36686_REG_ALS_DATA,
> +	},
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = CM36686_REG_PS_DATA,
> +		.event_spec = cm36686_proximity_event_spec,
> +		.num_event_specs = ARRAY_SIZE(cm36686_proximity_event_spec),
> +		.ext_info = cm36686_ext_info
> +	}
> +};
> +
> +static const struct iio_chan_spec cm36672p_channels[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = CM36686_REG_PS_DATA,
> +		.event_spec = cm36686_proximity_event_spec,
> +		.num_event_specs = ARRAY_SIZE(cm36686_proximity_event_spec),
> +		.ext_info = cm36686_ext_info
> +	}
> +};
> +
> +static int cm36686_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	if (mask != IIO_CHAN_INFO_INT_TIME)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		*vals = (int *)(cm36686_als_it_times);
> +		*length = 2 * ARRAY_SIZE(cm36686_als_it_times);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_PROXIMITY:
> +		*vals = (int *)(cm36686_ps_it_times);
> +		*length = 2 * ARRAY_SIZE(cm36686_ps_it_times);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cm36686_read_channel(struct cm36686_data *chip,
> +				struct iio_chan_spec const *chan, int *val)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret = IIO_VAL_INT;
> +
> +	int data = i2c_smbus_read_word_data(client, chan->address);
> +
> +	if (data < 0) {
> +		dev_err(&client->dev, "Failed to read register: %pe", ERR_PTR(data));

The error is passed to userspace, so this error message doesn't
seem useful (could end up flooding logs if userspace keeps reading).

> +		ret = -EIO;

Can just return directly here and avoid the local variable.

> +	} else {
> +		*val = data;
> +	}
> +	return ret;
> +}
> +
> +static int cm36686_read_int_time(struct cm36686_data *chip,
> +				 struct iio_chan_spec const *chan, int *val,
> +				 int *val2)
> +{
> +	int als_it_index, ps_it_index;
> +
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		als_it_index = FIELD_GET(CM36686_ALS_IT, chip->als_conf);
> +		*val = cm36686_als_it_times[als_it_index][0];
> +		*val2 = cm36686_als_it_times[als_it_index][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_PROXIMITY:
> +		ps_it_index = FIELD_GET(CM36686_PS_IT,
> +			chip->ps_conf[CM36686_PS_CONF1]);
> +		*val = cm36686_ps_it_times[ps_it_index][0];
> +		*val2 = cm36686_ps_it_times[ps_it_index][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cm36686_write_light_int_time(struct cm36686_data *chip, int val2)
> +{
> +	struct i2c_client *client = chip->client;
> +	int index = -1, ret, new_it_time;
> +
> +	for (int i = 0; i < ARRAY_SIZE(cm36686_als_it_times); i++) {
> +		if (cm36686_als_it_times[i][1] == val2) {
> +			index = i;
> +			break;
> +		}
> +	}
> +
> +	if (index == -1)
> +		return -EINVAL;
> +
> +	new_it_time = chip->als_conf & ~CM36686_ALS_IT;
> +	new_it_time |= FIELD_PREP(CM36686_ALS_IT, index);

Can use FIELD_MODIFY()?

> +
> +	ret = i2c_smbus_write_word_data(chip->client, CM36686_REG_ALS_CONF,
> +					new_it_time);
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"Failed to set ALS integration time: %pe", ERR_PTR(ret));

This error message can go too.

> +	else
> +		chip->als_conf = new_it_time;
> +
> +	return ret;
> +}
> +
> +static int cm36686_write_prox_int_time(struct cm36686_data *chip, int val2)
> +{
> +	struct i2c_client *client = chip->client;
> +	int index = -1, ret, new_it_time;
> +
> +	for (int i = 0; i < ARRAY_SIZE(cm36686_ps_it_times); i++) {
> +		if (cm36686_ps_it_times[i][1] == val2) {
> +			index = i;
> +			break;
> +		}
> +	}
> +
> +	if (index == -1)
> +		return -EINVAL;
> +
> +	new_it_time = chip->ps_conf[CM36686_PS_CONF1] & ~CM36686_PS_IT;
> +	new_it_time |= FIELD_PREP(CM36686_PS_IT, index);
> +
> +	ret = i2c_smbus_write_word_data(chip->client, CM36686_REG_PS_CONF1,
> +					new_it_time);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to set PS integration time: %pe",
> +			ERR_PTR(ret));
> +	else
> +		chip->ps_conf[CM36686_PS_CONF1] = new_it_time;
> +
> +	return ret;
> +}
> +
> +static int cm36686_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct cm36686_data *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&chip->lock);

Can use linux/cleanup.h `guard(mutex)(&chip->lock);`. Then we can return
directly below and get rid of ret.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = cm36686_read_channel(chip, chan, val);
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = cm36686_read_int_time(chip, chan, val, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&chip->lock);
> +	return ret;
> +}
> +
> +static int cm36686_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct cm36686_data *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (val) /* Integration time more than 1s is not supported */
> +		return -EINVAL;
> +
> +	if (mask != IIO_CHAN_INFO_INT_TIME)
> +		return -EINVAL;
> +
> +	mutex_lock(&chip->lock);
> +
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		ret = cm36686_write_light_int_time(chip, val2);
> +		break;
> +	case IIO_PROXIMITY:
> +		ret = cm36686_write_prox_int_time(chip, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&chip->lock);
> +	return ret;
> +}
> +
> +static int cm36686_read_prox_thresh(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int *val,
> +				    int *val2)
> +{
> +	struct cm36686_data *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_PROXIMITY)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		*val = chip->ps_close;
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		*val = chip->ps_away;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int cm36686_write_prox_thresh(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info, int val,
> +				     int val2)
> +{
> +	struct cm36686_data *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ret = 0, address, *thresh;
> +
> +	if (chan->type != IIO_PROXIMITY)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_FALLING:
> +		if (val > chip->ps_close || val < 0)
> +			return -EINVAL;
> +
> +		address = CM36686_REG_PS_THDL;
> +		thresh = &chip->ps_away;
> +		break;
> +	case IIO_EV_DIR_RISING:
> +		if (val < chip->ps_away || val > CM36686_MAX_PS_VALUE)
> +			return -EINVAL;
> +
> +		address = CM36686_REG_PS_THDH;
> +		thresh = &chip->ps_close;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&chip->lock);
> +
> +	ret = i2c_smbus_write_word_data(client, address, val);
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"Failed to set PS threshold value: %pe", ERR_PTR(ret));
> +	else
> +		*thresh = val;
> +
> +	mutex_unlock(&chip->lock);
> +	return ret;

In case it isn't obvious, previous comments about error messages and locks
apply here and elsewhere too.

> +}
> +
> +static int cm36686_read_prox_event_config(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir)
> +{
> +	struct cm36686_data *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_PROXIMITY)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_FALLING:
> +		return FIELD_GET(CM36686_PS_INT_OUT, chip->ps_conf[CM36686_PS_CONF1]);
> +	case IIO_EV_DIR_RISING:
> +		return FIELD_GET(CM36686_PS_INT_IN, chip->ps_conf[CM36686_PS_CONF1]);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cm36686_write_prox_event_config(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   enum iio_event_type type,
> +					   enum iio_event_direction dir,
> +					   bool state)
> +{
> +	struct cm36686_data *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ret = 0, new_ps_conf;
> +
> +	if (chan->type != IIO_PROXIMITY)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_FALLING:
> +		new_ps_conf = chip->ps_conf[CM36686_PS_CONF1] & ~CM36686_PS_INT_OUT;
> +		new_ps_conf |= FIELD_PREP(CM36686_PS_INT_OUT, state);
> +		break;
> +	case IIO_EV_DIR_RISING:
> +		new_ps_conf = chip->ps_conf[CM36686_PS_CONF1] & ~CM36686_PS_INT_IN;
> +		new_ps_conf |= FIELD_PREP(CM36686_PS_INT_IN, state);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&chip->lock);
> +
> +	ret = i2c_smbus_write_word_data(chip->client, CM36686_REG_PS_CONF1, new_ps_conf);
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"Failed to set proximity event interrupt config: %pe", ERR_PTR(ret));
> +	else
> +		chip->ps_conf[CM36686_PS_CONF1] = new_ps_conf;
> +
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static int cm36686_fallback_read_ps(struct iio_dev *indio_dev)
> +{
> +	struct cm36686_data *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int data = i2c_smbus_read_word_data(client, CM36686_REG_PS_DATA);
> +
> +	if (data < 0)
> +		return data;
> +
> +	if (data < chip->ps_away)
> +		return IIO_EV_DIR_FALLING;
> +	else if (data > chip->ps_close)

Don't need else after if with unconditinoal return.

> +		return IIO_EV_DIR_RISING;
> +	else
> +		return IIO_EV_DIR_EITHER;
> +}
> +
> +static irqreturn_t cm36686_irq_handler(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct cm36686_data *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ev_dir, ret;
> +	u64 ev_code;
> +
> +	/* Reading the interrupt flag acknowledges the interrupt */
> +	ret = i2c_smbus_read_word_data(client, CM36686_REG_INT_FLAG);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Interrupt flag register read failed: %pe", ERR_PTR(ret));

Error messages in interrupt handlers should probably be rate-limited.

> +		return IRQ_HANDLED;
> +	}
> +
> +	ret >>= CM36686_INT_FLAG_SHIFT;

I think a FIELD_GET() would make more sense here.

> +	switch (ret) {
> +	case CM36686_CLOSE:
> +		ev_dir = IIO_EV_DIR_RISING;
> +		break;
> +	case CM36686_AWAY:
> +		ev_dir = IIO_EV_DIR_FALLING;
> +		break;
> +	case CM36686_BOTH:
> +		ev_dir = cm36686_fallback_read_ps(indio_dev);
> +		if (ev_dir < 0) {
> +			dev_err(&client->dev, "Failed to settle interrupt state: %pe",
> +				ERR_PTR(ret));
> +			return IRQ_HANDLED;
> +		}
> +		break;
> +	default:
> +		dev_err(&client->dev, "Unknown interrupt state: %x", ret);
> +		return IRQ_HANDLED;
> +	}
> +	ev_code = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, IIO_EV_INFO_VALUE,
> +				       IIO_EV_TYPE_THRESH, ev_dir);
> +
> +	iio_push_event(indio_dev, ev_code, iio_get_time_ns(indio_dev));
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info cm36686_info = {
> +	.read_avail =		cm36686_read_avail,
> +	.read_raw =		cm36686_read_raw,
> +	.write_raw =		cm36686_write_raw,
> +	.read_event_value =	cm36686_read_prox_thresh,
> +	.write_event_value =	cm36686_write_prox_thresh,
> +	.read_event_config =	cm36686_read_prox_event_config,
> +	.write_event_config =	cm36686_write_prox_event_config,
> +};
> +
> +static struct cm36686_chip_info cm36686_chip_info_tbl[] = {
> +	[CM36686] = {
> +		.name = "cm36686",
> +		.channels = cm36686_channels,
> +		.num_channels = ARRAY_SIZE(cm36686_channels),
> +	},
> +	[CM36672P] = {
> +		.name = "cm36672p",
> +		.channels = cm36672p_channels,
> +		.num_channels = ARRAY_SIZE(cm36672p_channels),
> +	},
> +};

We avoid this array style in new drivers in favor of individual struct
per chip.

> +
> +static int cm36686_setup(struct cm36686_data *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret, led_current, led_index;
> +
> +	chip->als_conf = CM36686_ALS_ENABLE;
> +
> +	ret = i2c_smbus_write_word_data(client, CM36686_REG_ALS_CONF,
> +					chip->als_conf);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to enable ambient light sensor: %pe", ERR_PTR(ret));
> +		return ret;

This setup function is only called from probe, so we can use

		return dev_err_probe() here and below.

> +	}
> +

Wouldn't mind a comment here explaining why these values were chosen as
the default.

> +	chip->ps_conf[CM36686_PS_CONF1] = CM36686_PS_INT_IN |
> +		CM36686_PS_INT_OUT | CM36686_PS_DR_1_320 |
> +		CM36686_PS_PERS_2 | CM36686_PS_IT_2_5T;
> +
> +	ret = i2c_smbus_write_word_data(client, CM36686_REG_PS_CONF1,
> +					chip->ps_conf[CM36686_PS_CONF1]);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to enable proximity sensor: %pe", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	chip->ps_conf[CM36686_PS_CONF3] = CM36686_PS_SMART_PERS_ENABLE;
> +
> +	ret = device_property_read_u32(&client->dev,
> +		"capella,proximity-led-current", &led_current);

Only -EINVAL means the property was not present. Other errors can be
propigated. Also, handling of the default value if the property isn't
present isn't clear.

> +	if (!ret) {
> +		led_index = cm36686_current_to_index(led_current);
> +		if (led_index < 0) {
> +			dev_err(&client->dev, "No appropriate current for IR LED found.");
> +			return led_index;
> +		}
> +
> +		chip->ps_conf[CM36686_PS_CONF3] &= ~CM36686_LED_I;
> +		chip->ps_conf[CM36686_PS_CONF3] |= FIELD_PREP(CM36686_LED_I, led_index);
> +	}
> +
> +	ret = i2c_smbus_write_word_data(client, CM36686_REG_PS_CONF3,
> +					chip->ps_conf[CM36686_PS_CONF3]);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to enable proximity sensor: %pe", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(&client->dev, "proximity-near-level",
> +					    &chip->ps_close);
> +	if (ret < 0)
> +		chip->ps_close = 0;
> +
> +	ret = i2c_smbus_write_word_data(client, CM36686_REG_PS_THDH,
> +		chip->ps_close);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to set close proximity threshold: %pe", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	chip->ps_away = chip->ps_close;
> +
> +	ret = i2c_smbus_write_word_data(client, CM36686_REG_PS_THDL,
> +		chip->ps_away);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to set away proximity threshold: %pe", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cm36686_shutdown(void *data)
> +{
> +	struct cm36686_data *chip = data;
> +	struct i2c_client *client = chip->client;
> +	int ret, als_shutdown, ps_shutdown;
> +
> +	als_shutdown = chip->als_conf | CM36686_ALS_SD;
> +
> +	ret = i2c_smbus_write_word_data(client, CM36686_REG_ALS_CONF,
> +					als_shutdown);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to shutdown ALS");
> +
> +	ps_shutdown = chip->ps_conf[CM36686_PS_CONF1] | CM36686_PS_SD;
> +
> +	ret = i2c_smbus_write_word_data(client, CM36686_REG_PS_CONF1,
> +					ps_shutdown);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to shutdown PS");
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(chip->supplies), chip->supplies);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to disable regulators");

If we use devm_regulator_bulk_get_enable(), then we don't need to disable
regulators here and we can drop the chip->supplies field from the struct.

> +}
> +
> +static int cm36686_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct cm36686_data *chip;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev,
> +					  sizeof(struct cm36686_data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +

> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +
> +	const struct cm36686_chip_info *info =
> +		&cm36686_chip_info_tbl[id->driver_data];

After getting rid of the array, this is replaced with i2c_get_match_data().

> +
> +	ret = i2c_smbus_read_byte_data(client, CM36686_REG_ID_FLAG);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret, "Failed to read device ID");
> +
> +	if (ret != CM36686_DEVICE_ID)
> +		return dev_err_probe(&client->dev, -ENODEV, "Device not recognized!");

If anything, this should only be a warning. Too many times, we get a chip that
doesn't have the "right" ID but is still compatible.

> +
> +	i2c_set_clientdata(client, indio_dev);
> +	chip->client = client;
> +	ret = devm_mutex_init(&client->dev, &chip->lock);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +		       "Failed to initialize mutex");
> +
> +	chip->supplies[CM36686_SUPPLY_VDD].supply = "vdd";
> +	chip->supplies[CM36686_SUPPLY_VDDIO].supply = "vddio";
> +	chip->supplies[CM36686_SUPPLY_VLED].supply = "vled";
> +
> +	ret = devm_regulator_bulk_get(&client->dev,

This needs to be devm_regulator_bulk_get_enable(), or it doesn't actually
enable the regulators.

> +		ARRAY_SIZE(chip->supplies), chip->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to enable regulators");
> +
> +	ret = devm_add_action_or_reset(&client->dev, cm36686_shutdown, chip);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to set shutdown action");

This cleanup action should not be added until after the setup function
since that is what it is undoing.

> +
> +	ret = cm36686_setup(chip);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to set up registers");
> +
> +	indio_dev->name = info->name;
> +	indio_dev->channels = info->channels;
> +	indio_dev->num_channels = info->num_channels;
> +	indio_dev->info = &cm36686_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					cm36686_irq_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to request irq");

It should be OK to make the interrupt optional since that only affects
events AFAICT. There would need to be a second cm36686_info struct without
the events to handle this.

> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to register iio device");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id cm36686_id[] = {
> +	{ "cm36686", CM36686 },
> +	{ "cm36672p", CM36672P },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, cm36686_id);
> +
> +static const struct of_device_id cm36686_of_match[] = {
> +	{ .compatible = "capella,cm36686" },
> +	{ .compatible = "capella,cm36672p" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cm36686_of_match);
> +
> +static struct i2c_driver cm36686_driver = {
> +	.driver = {
> +		.name = "cm36686",
> +		.of_match_table = cm36686_of_match,
> +	},
> +	.probe = cm36686_probe,
> +	.id_table = cm36686_id

Trailing comma here.

> +};
> +

Usually no blank line here.

> +module_i2c_driver(cm36686_driver);
> +
> +MODULE_AUTHOR("Erikas Bitovtas <xerikasxx@gmail.com>");
> +MODULE_DESCRIPTION("CM36686 ambient light and proximity sensor driver");
> +MODULE_LICENSE("GPL");
> 

