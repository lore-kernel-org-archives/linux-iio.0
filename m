Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40374028EF;
	Fri, 12 Jun 2026 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283764; cv=none; b=DgmVkAbkF2xjp9S4PljRlou3xeD8jvbdKdPO3MdB4J4PMeVrRJlOQA3qVQDS0il5yfL0EpQAu0FfeGSZC9SuMjEihZ4rsTwASNlKHiG54WLTty2oJcfV1Xf8yiKHNA38woNpvIRAw8zykaJ6uFU1kCQ+ZNurZ6KylkLhTkRGVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283764; c=relaxed/simple;
	bh=bfXZksGt1/gKOjLOR0XutDcxmFu8uHQ0nucA2A9DyXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9KNzilCdU/TaVeC2cGsfZa4qS5ftto5hKmYQHVfbNewzfdtBYqs44uTo1sun0+AJnofnW3GE24yOj/RQv9FTrBV01ZOuAdvgeRKBTs/DoRl9X+t+umHZFhTIfMyz7OAWyq4OGlBB2L95MTXpae7sSgj6kCF7Kal+2Gcv80j280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF+7xT1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF+7xT1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAE31F000E9;
	Fri, 12 Jun 2026 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781283762;
	bh=qw5jOBZvXAaMQsEzZurHqArfFAnQlzR5HfBnGZalYvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lF+7xT1jcox+U+pikA+26EqeXouyy2jIGQvuzQWe7toMWK3QwcKt574oTU9yRBNYd
	 i6meEIpP+K2wjkvui8Z5JUHMkMnWXOd7r0cbbVwHhVGeqjRlLxX9NQd67p597k3EuO
	 o9RJSD1WTlxI5BP5qdaXaSZG66KZ1wTwlEh+sIK8ACo/ju1gWc3aCd/a7Z10JdkntX
	 wbzBRJbGbleKHVMQWohUK8CaQaD8/oEVXtirg08wDMXbzIpJFQGaKcyN3vWJu+wT5q
	 hxluk8u/4WixLLsBU9KM+EEL1cchz3b9wCOQpF9EJp8PrIx9G9N9XJgCbQkMg6hP4o
	 iaWx+dXAJ0kSQ==
Date: Fri, 12 Jun 2026 18:02:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: magnetometer: add driver for QST QMC5883L
 Sensor
Message-ID: <20260612180235.3e505c66@jic23-huawei>
In-Reply-To: <20260612124557.13750-4-email@sirat.me>
References: <20260612124557.13750-1-email@sirat.me>
	<20260612124557.13750-4-email@sirat.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

Trying to avoid repeating stuff Joshua already covered.
Various comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
> new file mode 100644
> index 000000000000..055e51570635
> --- /dev/null
> +++ b/drivers/iio/magnetometer/qmc5883l.c


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
These are used for matching - normally we'd add defines for the filed value and
then use FIELD_GET() to extract it for matching.
e.g.
#define QMC5883L_OSR_512		0x0
#define QMC5883L_OSR_256		0x1
rather these.

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
> +
> +struct qmc5883l_data {
> +	struct regmap *regmap;
> +	struct mutex mutex; /* update and read regmap data */

Need more than that.  regmap has its own locks that do this bit.
Be sure to describe exactly what data you are protecting.
Usually it is something like read / modify / write cycles or
need to serialize groupd of actions.

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

I'm not sure the defines really help. Perhaps push the value down here
and then look it up from this array when matching.

> +	0, QMC5883L_SCALE_8G,	/* 8G */
> +};

> +
> +static int qmc5883l_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))

What is this serializing?  In a driver that only supports direct mode it should
never be necessary to claim it.    So this code should only be added in a patch
adding buffered modes.  If you need to serialize, most likely you should be using
a local lock as it has nothing to do with state changes from direct to buffered.

> +			return -EBUSY;
> +		ret = qmc5883l_take_measurement(indio_dev, chan->address, val);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		scoped_guard(mutex, &data->mutex)

Joshua already mentioned this, but prefer guard() and defined scope
for each of these case blocks. That just ends up easier to read.

> +		{
> +			*val = 0;
> +			*val2 = data->range == QMC5883L_RNG_2G ?
> +					QMC5883L_SCALE_2G :
> +					QMC5883L_SCALE_8G;
> +		}
> +		return IIO_VAL_INT_PLUS_NANO;
...

> +
> +static int qmc5883l_write_raw(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	u8 rng;
> +	u8 osr;
> +	u8 odr;
Can combine as
	u8 rng, osr, odr;
without loosing readability so do that to save a few lines of scrolling!

> +	int ret;

> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
Add scope by doing
case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {

Same applies for other cases.


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
then this can be a guard.

Note that if it were a scoped_guard() that should be treated like an if ()
so formatting wise it would be
		scoped_guard(mutex, &data->mutex) {

However with scope added as suggested this can be
		guard(mutex)(&data->mutex);
and avoid the need for greater indent.

> +		{
> +			ret = regmap_update_bits(data->regmap,
> +						 QMC5883L_REG_CTRL1,
> +						 QMC5883L_OSR_MASK, osr);
See above,
						 QMC5883L_OSR_MASK,
						 FIELD_PREP(QMC5883L_OSR_MASK, osr));

> +			if (ret)
> +				return ret;
> +			data->osr = osr;
Here store the field value not the shifted version.

> +		}
> +		break;
		return 0; (see below)

Close scope with 
	}
here.
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
Probably better to return in the good paths above and save us having
to go see if there is anything else to be done.


> +}


> +static int qmc5883l_init(struct qmc5883l_data *data)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, QMC5883L_REG_ID, &reg);
> +	if (ret)
> +		return ret;
> +
> +	/* Not failing because rev 1.0 had this register reserved */
> +	if (reg != QMC5883L_CHIP_ID)
> +		dev_warn(regmap_get_device(data->regmap),
> +			 "unknown chip id: 0x%02x, continuing\n", reg);
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
I don't mind if these sorts of cases go a little over 80 chars as sometimes
it helps readability.

Does it really reset with interrupts on?  That's odd.  Mind you the
INT_ENB sounds like it would be an enable but as you have named it here
it is actually a disable so all bets are off when it comes to sensible ;)


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

Generally should only set these after the write succeeds otherwise on error
these are out of sync with the device. Not that important though in an init
function as any error leads to us bailing out anyway.

> +
> +	ret = regmap_write(data->regmap, QMC5883L_REG_CTRL1,
> +			   (QMC5883L_MODE_CONT | data->odr | data->range |
> +			    data->osr));

return regmap_write();

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}


> +static const struct of_device_id qmc5883l_match[] = {
> +	{ .compatible = "qstcorp,qmc5883l" },
> +	{ },

As below, no comma.

> +};
> +MODULE_DEVICE_TABLE(of, qmc5883l_match);
> +
> +static const struct i2c_device_id qmc5883l_id[] = {
> +	{ "qmc5883l" },

Named initializers for these please. Uwe is doing some work
to ensure consistency on this across there kernel and queued
up for this kernel cycle is a patch that does that for all the
i2c_device_id tables. Uwe mentioned that a checkpatch change
to check for this was on the todo list.

> +	{ },

No trailing comma on 'terminating' entries like this. 
Whatever entries are added in the future they must not come
after this so comma here is never appropriate.

> +};
> +MODULE_DEVICE_TABLE(i2c, qmc5883l_id);
> +
> +static struct i2c_driver qmc5883l_driver = {
> +	.driver = {
> +		.name = "qmc5883l",
> +		.of_match_table = qmc5883l_match,
> +	},
> +	.id_table = qmc5883l_id,
> +	.probe = qmc5883l_probe,
> +};
> +

Trivial but a common convention (that I'm trying to encourage in IIO)
is no blank line here. It is good to keep the tighter coupling between
the structure and the macro that is its only user.

> +module_i2c_driver(qmc5883l_driver);

