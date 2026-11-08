Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181643;
	b=gjKWXuqWnSdjKqv9F6UxBLcIhZt5cvI1fz/xMcdGkrPBvt/gAS32vf7fOloEhNoiq/sN
	 cYsfBZ37EXRlF9rEOcOh1N30k2Iy08h1eZEb5gxa+GxsoDIr2sVSohDmZPTvczzrkDPUJ
	 xB9kmBt9DeuO+kCxZjwBq6VMKExIqceV15OsTVuRmY46bKMiSOpoeMaUbCvKnLeeInMUg
	 Pto8eGhEIj26wTBeiZaahyoj0IzURy6IaOvSoH81H+YM96T4YkdkJ+DiecETvpr5/1Flb
	 f1ILDJRXpKf/+mby5OlJuNROEUYQmhJc29d3EP/TKczvq2b6pmzf4mmkO6mZq1yrNAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181643;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UP64zfTLF9tzwFCB408JdJLYh5zQ49iXwMbnRPTqyVY=;
	b=yZ+4ASkEXJu89QYljQrKvD9clwJ9YQ6tup4wFdCWehLKDnCeOkpS6D4vrcOTd6/RTL7X
	 j21xyMVNgFrrm4NHHIh2aCsuD0wvdlzs1IGTeVJsBLzzlJiV6/QyCdqTleWAtgQpdM5IY
	 lhsVNTaRHY427QTihFi/crzb2QXeYYMfmIQTsG85dRwENwQ8EZGDdk1gpOW3Rp9P304uF
	 arRYSZuG1Rjed4oSnn4aq0eFTJmTbsr0cIN8JPVX4wdCpuA8F/2jJ2zQ7zFDFPZiFHwTG
	 LJbFGzvYzAdz9m+fXVboCABChrM5NYl6JKVKQlJQiDIDl9eotSRUNsMf8RvZxbXNh9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0MPp3oF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B115606A32A;
	Sun,  8 Nov 2026 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0MPp3oF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878971F0089F;
	Sun,  8 Nov 2026 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794181642;
	bh=UP64zfTLF9tzwFCB408JdJLYh5zQ49iXwMbnRPTqyVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h0MPp3oF//jAiLET/XF4dib17f9UwhTWlIAfpfyMXk62i7uJz0g5Tshr2hYdZIND6
	 xj61yixRJLKVMtxsUYZJFVGPoUiUHKElCPewdN2TuXxfFilOq+EqOdvQNTo0qDhdKA
	 dX7xOaqPb8Es4+liSMndH/aUeF5I6mdCkh9JXHlj8KXBT3BWc824azl+FMkBht+Vty
	 Yi78vltPGOamXGjRl+8LSlpjaa6Bool+2srfgikgUdJjgHzCWi7JyKLqo4ZYpmvknt
	 1hc5mEKtphGdcMwg4ydNYF7k/Z/1CsadhkY6mcDiovvffdQvBCJYgsc5FdJ6jqo9g0
	 Yeb5JslTuUKwA==
Date: Sun, 8 Nov 2026 23:47:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v1 3/4] iio: adc: Add support for MAX8907 ADC cell
Message-ID: <20261108234719.42ede7b3@jic23-hlaptop>
In-Reply-To: <20261108095634.100517-4-clamor95@gmail.com>
References: <20261108095634.100517-1-clamor95@gmail.com>
	<20261108095634.100517-4-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Sun,  8 Nov 2026 11:56:33 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The MAX8907 PMIC has a dedicated ADC cell, which provides 8 ADC channels
> with information about different parts of the power system, including the
> battery, charger/plug, jack and thermal readings.

This is an unusual driver structure.  Seems like we really have
a number of different i2c devices inside one package.  Is the only
unified bit the power control?  

I appreciate you just want to add a new feature to this ancient
driver but it does feel like things would much simpler if the
i2c regmap was registered in here rather than the parent using
a platform device to wrap what seems to be a largely independent
i2c device.

I'll be looking from some input from Lee for the MFD aspects and
whether he is happy with adding stuff to this driver with its
current structure.  Doesn't make that much difference to the IIO
part either way.

> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Other than that various minor things inline.


> diff --git a/drivers/iio/adc/max8907-adc.c b/drivers/iio/adc/max8907-adc.c
> new file mode 100644
> index 0000000000000..d1acb5bc95c15
> --- /dev/null
> +++ b/drivers/iio/adc/max8907-adc.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>

Don't include that.  Figure out which more specific
headers in are in use and include those instead.

> +#include <linux/module.h>
> +#include <linux/mfd/max8907.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +/* MAX8907_ADC_RES_CNFG1 */
> +#define RES_AUX1			BIT(7)
> +#define RES_AUX2			BIT(6)
> +#define RES_VCHG			BIT(5)
> +#define RES_VBBATT			BIT(4)
> +#define RES_VMBATT			BIT(3)
> +#define RES_ISNS			BIT(2)
> +#define RES_THM				BIT(1)
> +#define RES_TDIE			BIT(0)
> +
> +/* MAX8907_ADC_AVG_CNFG1 */
> +#define AVG_AUX1_EN			BIT(7)
> +#define AVG_AUX2_EN			BIT(6)
> +#define AVG_VCHG_EN			BIT(5)
> +#define AVG_VBBATT_EN			BIT(4)
> +#define AVG_VMBATT_EN			BIT(3)
> +#define AVG_ISNS_EN			BIT(2)
> +#define AVG_THM_EN			BIT(1)
> +#define AVG_TDIE_EN			BIT(0)
> +
> +/* MAX8907_ADC_ACQ_CNFG1 */
> +#define T_ACQ_AUX1			BIT(7)
> +#define T_ACQ_AUX2			BIT(5)
> +#define T_ACQ_VCHG			BIT(3)
> +#define T_ACQ_VBBATT			BIT(1)
> +
> +/* MAX8907_ADC_ACQ_CNFG2 */
> +#define T_ACQ_VMBATT			BIT(6)
> +#define T_ACQ_ISNS			BIT(4)
> +#define T_ACQ_THM			BIT(2)
> +#define T_ACQ_TDIE			BIT(0)
> +
> +/* MAX8907_ADC_SCHED */
> +#define AUTOSCH_ENABLE			BIT(1)
> +#define AUTOSCH_TIME			BIT(0)
> +
> +#define TO_REG(n)			((n) & 0xff)
> +#define TO_MEASURE(n)			(((n) >> 8) & 0xff)

Similar to below, Give this a prefix.  Same for all the defines
above.

> +
> +enum {
> +	TDIE, THM, ISNS, VMBATT, VBBATT, VCHG, AUX2, AUX1

I'd prefix these. Chances of a naming clash in the long
run are high enough that usual IIO style is to prefix pretty
much everything with the driver name.

> +};
> +
> +static const u32 max8907_default_ref[] = {
Index these off the enum. Makes it easier to check what
the value is for a specific channel.
	[MAX8907_TDIE] = 4096,
	[...]

> +	4096, 4096, 4096, 8192, 8192, 8192, 2500, 4096
> +};
> +
> +#define MAX8907_CHAN(_type, _idname, _datasheet_name) {		\
> +	.type = (_type),					\
> +	.address = MAX8907_REG_##_idname##_MSB |		\
> +		   MAX8907_REG_##_idname##_MEASURE << 8,	\
> +	.indexed = 1,						\
> +	.channel = (_idname),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index = (_idname),				\
> +	.scan_type = {						\
> +		.format = IIO_SCAN_FORMAT_UNSIGNED_INT,		\
> +		.realbits = 12,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +	.datasheet_name = (_datasheet_name),			\
> +}
> +
> +static const struct iio_chan_spec max8907_adc_channels[] = {
> +	MAX8907_CHAN(IIO_VOLTAGE, TDIE,   "tdiode"),
> +	MAX8907_CHAN(IIO_VOLTAGE, THM,    "thermistor"),
> +	MAX8907_CHAN(IIO_CURRENT, ISNS,   "isense"),
> +	MAX8907_CHAN(IIO_VOLTAGE, VMBATT, "vmbatt"),
> +	MAX8907_CHAN(IIO_VOLTAGE, VBBATT, "vbbatt"),
> +	MAX8907_CHAN(IIO_VOLTAGE, VCHG,   "vcharge"),
> +	MAX8907_CHAN(IIO_VOLTAGE, AUX2,   "aux2"),
> +	MAX8907_CHAN(IIO_VOLTAGE, AUX1,   "aux1"),
> +};
> +
> +static int max8907_adc_read(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct regmap **regmap = iio_priv(indio_dev);
> +	unsigned char data[2] = { 0, 0 };

No need for those 0.  = { }; is defined to do the same thing.
There are some subtleties around that, but the kernel has used
build options for a long time (and self tests to ensure that form
is fine).  It is also part of more recent C specs.

Use u8 rather than char.


> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_write(*regmap, TO_MEASURE(chan->address), 0);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_bulk_read(*regmap, TO_REG(chan->address), data, 2);

sizeof(data);

> +		if (ret)
> +			return ret;
> +
> +		*val = ((data[0] << 8) | data[1]) >> 4;

Use get_unaligned_be16() then a shift.
better still use a __be16 as the buffer.

> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = max8907_default_ref[chan->channel];
> +		*val2 = chan->scan_type.realbits;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info max8907_adc_info = {
> +	.read_raw = &max8907_adc_read,
> +};
> +
> +static int max8907_adc_init(struct regmap *regmap)
> +{
> +	u32 value;
> +	int ret;
> +
> +	/* Enable internal voltage reference. Exact purpose of bits is not known. */
> +	ret = regmap_update_bits(regmap, MAX8907_REG_TSC_CNFG1, GENMASK(1, 0), BIT(1));
> +	if (ret)
> +		return ret;
> +
> +	/* Check for internal reference IRQ */
> +	ret = regmap_read_poll_timeout(regmap, MAX8907_REG_TSC_STA_INT, value,
> +				       !(value & MAX8907_MASK_NREF_OK), 0, 1000);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable ADC scheduler with 1 second interval */
> +	ret = regmap_update_bits(regmap, MAX8907_REG_ADC_SCHED,
> +				 AUTOSCH_ENABLE | AUTOSCH_TIME, AUTOSCH_TIME);

return regmap_update_bits()

Bit odd to unset AUTOSCH_ENABLE in something that is commented as turning
it on.  That is probably a field that needs a rename. 
I'd also like those field names to reflect that they are in ADC_SCHED.


> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int max8907_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct max8907 *max8907 = dev_get_drvdata(dev->parent);
> +	struct iio_dev *indio_dev;
> +	struct regmap **regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*regmap));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = iio_priv(indio_dev);
> +
> +	*regmap = max8907->regmap_adc;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max8907_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max8907_adc_channels);
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &max8907_adc_info;
> +
> +	iio_device_set_parent(indio_dev, dev->parent);

Why this choice for the parent?  What is wrong with having the
platform device in between?  Needs a comment.

> +
> +	/* Enable ADCREF */
If it's called ADCREF can we just include that as part of the field
name and remove need for the comment?
> +	ret = regmap_set_bits(max8907->regmap_gen, MAX8907_REG_RESET_CNFG,
> +			      MAX8907_MASK_RST_CFG_INT_REF_EN);

Need to be more consistent with register vs field names. I'm fine
with either form but it should be the same for how you shorten
RESET_CONFIG


> +	if (ret)
> +		return ret;
> +
> +	ret = max8907_adc_init(max8907->regmap_adc);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


