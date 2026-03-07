Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3E280CE5;
	Sat,  7 Mar 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772891967; cv=none; b=m07NO8pS4wqlHbzCrIwQc/kXSm3N0eI57uJj+8dFR8dniIxoHUb2VIwpnn8Hk5/H8JXWLa590A4hOiq1S63gXo08QnHSurct4Q20XBGDGWFPqEAmDDYHuiDS7jOrrqgSNcQls7BFm6HZcJ5iyPAKxEQyHPsUNmjI9x1/mh3F9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772891967; c=relaxed/simple;
	bh=PUTRIVezkb5GX+Pg94WJqy+mP/J2MJzdrwiCby0UaSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBtenQuN57IVWAJO5Vd6iBe9/X/4kB7aXXWq4RIc2Dv9Y0kCU1CO112XHFVrqcABVSeyNAeZ9VBFqxHDEgoPHtAYpuowLoHHBda3sdGLoFhm3mH1WTLPxMvdehcCunJmiRGuCcmOAFRihRXer8wpGikvWXjY0nTwHus+tMHrmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbzyU77U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbzyU77U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DD1C19422;
	Sat,  7 Mar 2026 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772891967;
	bh=PUTRIVezkb5GX+Pg94WJqy+mP/J2MJzdrwiCby0UaSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GbzyU77UiBKB5adt0Bht9RWYrl0Cr/AIuqGR9Rzf81d9gzoCfBRtR01ygHtPK6hw9
	 64KWlJhaEMiY2DuCdEvqprGw0+qmlwanecWCZimxE+/sDb2uu/kVWxVvFMs5+IlDUq
	 hnxMiwsjhy9NhLZIBeatVvbM+jZWFSYbcbzKmaLCxDg2Y0hu7dptvFfxw1tWpph4AL
	 g6JWg6V8roMhkMU3Fz6naZQsAKoAic0tULs2pCWd2LSjXuSDfIpDiDwlD1ZxYNVZVZ
	 ZMdT+c5YECbWjN/mlRr/op9lRbZTzLSALVWfmzrOpXFcI8oYTZAL6IfKe7kYFnJZNj
	 Gs3HwX9gJpKXg==
Date: Sat, 7 Mar 2026 13:59:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <20260307135917.398891db@jic23-huawei>
In-Reply-To: <20260303090253.42076-3-email@sirat.me>
References: <20260303090253.42076-1-email@sirat.me>
	<20260303090253.42076-3-email@sirat.me>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 15:02:41 +0600
Siratul Islam <email@sirat.me> wrote:

> Add support for the STMicroelectronics VL53L1X Time-of-Flight
> ranging sensor with I2C interface.
> 
> Signed-off-by: Siratul Islam <email@sirat.me>

Hi,

Various comments inline.

Pretty nice for a v1 ;)

Jonathan



> diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
> new file mode 100644
> index 000000000000..b4122fce0de1
> --- /dev/null
> +++ b/drivers/iio/proximity/vl53l1x-i2c.c

> + * ST's VL53L1X Ultra Lite Driver (STSW-IMG009).
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

Check that you have includes for all things used directly in this
driver. For example dev_err()

We use a slightly relaxed version of include what you use for IIO
(and the kernel in general). So sometimes there are headers that
are well documented as including others, but when that's not true
we don't make assumptions and so include everything relevant even
if it happens to be included via another path today.


> +#define VL53L1X_SOFT_RESET 0x0000
> +#define VL53L1X_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND 0x0008
> +#define VL53L1X_VHV_CONFIG__INIT 0x000B
> +#define VL53L1X_GPIO_HV_MUX__CTRL 0x0030
> +#define VL53L1X_GPIO__TIO_HV_STATUS 0x0031
> +#define VL53L1X_SYSTEM__INTERRUPT_CONFIG_GPIO 0x0046
> +#define VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP 0x004B
> +#define VL53L1X_RANGE_CONFIG__TIMEOUT_MACROP_A 0x005E
> +#define VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A 0x0060
> +#define VL53L1X_RANGE_CONFIG__TIMEOUT_MACROP_B 0x0061
> +#define VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B 0x0063
> +#define VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH 0x0069
> +#define VL53L1X_SYSTEM__INTERMEASUREMENT_PERIOD 0x006C
> +#define VL53L1X_SD_CONFIG__WOI_SD0 0x0078
> +#define VL53L1X_SD_CONFIG__WOI_SD1 0x0079
> +#define VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0 0x007A
> +#define VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1 0x007B
> +#define VL53L1X_SYSTEM__INTERRUPT_CLEAR 0x0086
> +#define VL53L1X_SYSTEM__MODE_START 0x0087
> +#define VL53L1X_RESULT__RANGE_STATUS 0x0089
> +#define VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0 0x0096
> +#define VL53L1X_RESULT__OSC_CALIBRATE_VAL 0x00DE
> +#define VL53L1X_FIRMWARE__SYSTEM_STATUS 0x00E5
> +#define VL53L1X_IDENTIFICATION__MODEL_ID 0x010F

Register addresses are a case where it can be helpful to use tabs
to make the addresses all line up.

>
> +static const struct regmap_config vl53l1x_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,

8 bit registers don't really have an endian. This doesn't (I think)
apply to multiregister writes.

> +};


> +static int vl53l1x_chip_init(struct vl53l1x_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	unsigned int val;
> +	u16 model_id;
> +	int tries = 200;
> +	bool ready;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, VL53L1X_SOFT_RESET, 0x00);
Is this useful if we have a hardware reset? It's common to do 
hardware if possible and software only if it isn't.

> +	if (ret)
> +		return ret;
> +	usleep_range(100, 200);
fsleep() and ideally a spec reference in a comment for why this value.
> +
> +	ret = regmap_write(data->regmap, VL53L1X_SOFT_RESET, 0x01);
> +	if (ret)
> +		return ret;
> +	usleep_range(1000, 2000);
fsleep

> +
> +	ret = regmap_read_poll_timeout(data->regmap,
> +				       VL53L1X_FIRMWARE__SYSTEM_STATUS, val,
> +				       val & BIT(0), 1000, 100000);
> +	if (ret) {
> +		dev_err(dev, "firmware boot timeout\n");
> +		return ret;
> +	}
> +
> +	ret = vl53l1x_read_u16(data, VL53L1X_IDENTIFICATION__MODEL_ID,
> +			       &model_id);
> +	if (ret)
> +		return ret;
> +
> +	if (model_id != VL53L1X_MODEL_ID_VAL) {
> +		dev_err(dev, "unknown model id: 0x%04x\n", model_id);

Don't error out in this case. It breaks any possibility of a future
backwards compatible chip being supported by this driver via a fallback
dt compatible.  The most we do is print an informational message
to help with debug.

We do have some old drivers that we still need to fix up that are
doing this sort of hard check on an who am I register.


> +		return -ENODEV;
> +	}
...

> +
> +static int vl53l1x_set_distance_mode(struct vl53l1x_data *data,
> +				     enum vl53l1x_distance_mode mode)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case VL53L1X_SHORT:
Can we encode all the values into a structure.  Then make this just
a pick of the structure, followed by writing the values out.
should end up more compact that this due to the reuse of all the regmap
calls and error handling.

> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP,
> +				   0x14);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A, 0x07);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B, 0x05);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH,
> +				   0x38);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap, VL53L1X_SD_CONFIG__WOI_SD0,
> +				   0x07);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap, VL53L1X_SD_CONFIG__WOI_SD1,
> +				   0x05);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0, 6);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1, 6);
> +		break;
> +	case VL53L1X_LONG:
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP,
> +				   0x0A);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A, 0x0F);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B, 0x0D);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH,
> +				   0xB8);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap, VL53L1X_SD_CONFIG__WOI_SD0,
> +				   0x0F);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap, VL53L1X_SD_CONFIG__WOI_SD1,
> +				   0x0D);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0, 14);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1, 14);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	data->distance_mode = mode;
> +	return 0;
> +}
> +
> +static int vl53l1x_set_timing_budget(struct vl53l1x_data *data, u16 budget_ms)
Add some documentation as it's not obvious what this is doing.

> +{
> +	u16 timeout_a, timeout_b;
> +	int ret;
> +
> +	switch (data->distance_mode) {
> +	case VL53L1X_SHORT:
> +		switch (budget_ms) {
> +		case 15:
> +			timeout_a = 0x001D;
> +			timeout_b = 0x0027;
> +			break;
> +		case 20:
> +			timeout_a = 0x0051;
> +			timeout_b = 0x006E;
> +			break;
> +		case 33:
> +			timeout_a = 0x00D6;
> +			timeout_b = 0x006E;
> +			break;
> +		case 50:
> +			timeout_a = 0x01AE;
> +			timeout_b = 0x01E8;
> +			break;

...

> +
> +static int vl53l1x_read_proximity(struct vl53l1x_data *data, int *val)
> +{
> +	unsigned long time_left;
> +	unsigned int range_status;
> +	u16 distance;
> +	int tries = 200;
> +	bool ready;
> +	int ret;
> +
> +	if (data->client->irq) {
> +		reinit_completion(&data->completion);
> +
> +		ret = vl53l1x_clear_irq(data);
> +		if (ret)
> +			return ret;
> +
> +		time_left = wait_for_completion_timeout(&data->completion, HZ);
> +		if (time_left == 0)
> +			return -ETIMEDOUT;
> +	} else {
> +		do {
> +			ret = vl53l1x_data_ready(data, &ready);
> +			if (ret)
> +				return ret;
> +
> +			if (ready)
> +				break;
> +
> +			usleep_range(1000, 5000);

fsleep()

Also add a comment to say why this many tries with this sleep.
Check for all other places this comment applies.



> +		} while (--tries);
> +
> +		if (!tries)
> +			return -ETIMEDOUT;
> +	}
> +
> +	ret = regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
> +			  &range_status);
> +	if (ret)
> +		goto clear_irq;
> +
> +	range_status &= VL53L1X_RANGE_STATUS_MASK;
> +
> +	ret = vl53l1x_read_u16(data,
> +			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
> +				   &distance);
> +	if (ret)
> +		goto clear_irq;
> +
> +	dev_dbg(&data->client->dev, "distance=%u status=%u\n", distance,
> +		range_status);
> +
> +	if (range_status != VL53L1X_RANGE_STATUS_VALID) {
> +		ret = -EIO;
> +		goto clear_irq;
> +	}
> +
> +	*val = distance;
> +
> +clear_irq:
> +	vl53l1x_clear_irq(data);
> +	return ret;
> +}

> +
> +static int vl53l1x_validate_trigger(struct iio_dev *indio_dev,
> +				    struct iio_trigger *trig)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +
> +	return data->trig == trig ? 0 : -EINVAL;

Can we use the generic iio_validate_own_trigger()?

Cheats a bit and relies on the parents being the same (which they
always should be as it's one device.  Advantage
is no need for a trig variable in data.

> +}
> +
> +static const struct iio_info vl53l1x_info = {
> +	.read_raw = vl53l1x_read_raw,
> +	.validate_trigger = vl53l1x_validate_trigger,
> +};
> +
> +static irqreturn_t vl53l1x_trigger_handler(int irq, void *priv)
> +{
> +	struct iio_poll_func *pf = priv;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	struct {
> +		u16 distance;
> +		aligned_s64 timestamp;
> +	} scan = {};
> +	unsigned int range_status;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
> +			  &range_status);
> +	if (ret || (range_status & VL53L1X_RANGE_STATUS_MASK) !=
> +			   VL53L1X_RANGE_STATUS_VALID)
> +		goto done;
> +
> +	ret = vl53l1x_read_u16(data,
> +			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
> +				   &scan.distance);

Another odd bit of alignment. Should match the line above.

> +	if (ret)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	vl53l1x_clear_irq(data);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t vl53l1x_threaded_irq(int irq, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
Neither of these needs to be done in a threaded hander.
I'd make this a non threaded irq handler and mark the irq
as IRQF_NO_THREAD as you'll then be using iio_trigger_poll()

The advantage of that is it allows better timestamp gathering
as nearer the interrupt.

> +		iio_trigger_poll_nested(indio_dev->trig);
> +	else
> +		complete(&data->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int vl53l1x_configure_irq(struct i2c_client *client,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	int irq_flags = irq_get_trigger_type(client->irq);
> +	int ret;
> +
> +	if (!irq_flags)
> +		irq_flags = IRQF_TRIGGER_FALLING;
Leave that to firmware.  We used to do this a lot in drivers, but it
was always the wrong approach. The snag is we can't fix drivers that do
it now without risking regressions. However we don't want to introduce
new ones.

> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					vl53l1x_threaded_irq,
> +					irq_flags | IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CONFIG_GPIO,
> +			   VL53L1X_INT_NEW_SAMPLE_READY);
> +	if (ret)
> +		dev_err(&client->dev, "failed to configure IRQ: %d\n", ret);
> +
> +	return ret;
> +}


> +
> +static void vl53l1x_power_off(void *_data)

> +{
> +	struct vl53l1x_data *data = _data;
> +
> +	vl53l1x_stop_ranging(data);

This looks to be undoing something that wasn't done in power_on?
If so probably wants to be a separate devm cleanup.

Whilst it may not matter as turning things off tends to be idempotent
it will be easier to follow the code if we only stop what we started.


> +	gpiod_set_value_cansleep(data->reset_gpio, 1);

It's unusual to put a device into reset on power down.  Is this
pin perhaps misnamed?

If it is just a reset, we'd normally break that out as separate
from the power control and force a reset sequence in probe.

> +	regulator_disable(data->vdd_supply);
> +}
> +
> +static int vl53l1x_power_on(struct vl53l1x_data *data)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd_supply);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value_cansleep(data->reset_gpio, 0);
> +	usleep_range(3200, 5000);

fsleep() preferred.  Adds a standard amount of slack.

> +
> +	return 0;
> +}
> +
> +static int vl53l1x_probe(struct i2c_client *client)
> +{
> +	struct vl53l1x_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> +					     I2C_FUNC_SMBUS_BYTE_DATA))
Align this as:
	if (!i2c_check_functionality(client->adapter,
				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
				     I2C_FUNC_SMBUS_BYTE_DATA))

Seems like an extra tab snuck in from somewhere.


> +		return -EOPNOTSUPP;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &vl53l1x_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +				     "regmap initialization failed\n");
> +
> +	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get VDD regulator\n");
> +
> +	data->reset_gpio =
> +		devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->reset_gpio))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
> +				     "Cannot get reset GPIO\n");
> +
> +	ret = vl53l1x_power_on(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to power on the chip\n");
> +
> +	ret = devm_add_action_or_reset(&client->dev, vl53l1x_power_off, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_set_distance_mode(data, VL53L1X_LONG);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_set_timing_budget(data, 50);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_set_inter_measurement_ms(data, 50);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_start_ranging(data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "vl53l1x";
> +	indio_dev->info = &vl53l1x_info;
> +	indio_dev->channels = vl53l1x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(vl53l1x_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	if (client->irq) {
> +		init_completion(&data->completion);
> +
> +		data->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +						    indio_dev->name,
> +						    iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return -ENOMEM;
> +
> +		data->trig->ops = &vl53l1x_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +		ret = devm_iio_trigger_register(&client->dev, data->trig);
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(data->trig);
> +
> +		ret = vl53l1x_configure_irq(client, indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_iio_triggered_buffer_setup(&client->dev,
> +						      indio_dev, NULL,
> +							  &vl53l1x_trigger_handler,
> +							  &vl53l1x_buffer_setup_ops);

Strange alignment.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id vl53l1x_id[] = { { "vl53l1x" }, { } };
Format this same as

static const struct i2c_device_id vl53l1x_id[] = {
	{ "vl53l1x" },
	{ }
};

> +MODULE_DEVICE_TABLE(i2c, vl53l1x_id);
> +
> +static const struct of_device_id st_vl53l1x_dt_match[] = {
> +	{ .compatible = "st,vl53l1x" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, st_vl53l1x_dt_match);
> +
> +static struct i2c_driver vl53l1x_driver = {
> +	.driver = {
> +		.name = "vl53l1x-i2c",
> +		.of_match_table = st_vl53l1x_dt_match,
> +	},
> +	.probe = vl53l1x_probe,
> +	.id_table = vl53l1x_id,
> +};
> +module_i2c_driver(vl53l1x_driver);
> +
> +MODULE_AUTHOR("Siratul Islam <email@sirat.me>");
> +MODULE_DESCRIPTION("ST VL53L1X ToF ranging sensor driver");
> +MODULE_LICENSE("Dual BSD/GPL");

