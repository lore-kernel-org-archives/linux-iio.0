Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-220.synserver.de ([212.40.185.220]:1081 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752481AbbKJLwZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Nov 2015 06:52:25 -0500
Message-ID: <5641DA6F.8070307@metafoo.de>
Date: Tue, 10 Nov 2015 12:52:15 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Florian Lobmaier <Florian.Lobmaier@ams.com>,
	"jic23@kernel.org" <jic23@kernel.org>
CC: Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V1 1/1] iio: as6200: add AS6200 temperature sensor driver
 from ams AG
References: <09675593925c4a6c99982b21fae3640a@SUX5071.office.amsiag.com>
In-Reply-To: <09675593925c4a6c99982b21fae3640a@SUX5071.office.amsiag.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/2015 10:38 AM, Florian Lobmaier wrote:
> The AS6200 is a compact temperature sensor chip with I2C interface.
> 
> Add a driver to support the AS6200 temperature sensor.
> 
> Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>

Hi,

Thanks for the patch.

As Peter already said this patch introduces a lot of custom ABI, none of
which is documented and most of which is probably not acceptable since. The
whole idea of a framework is that you expose the capabilities of a device
through a standard device independent ABI, this allows to write generic
applications and libraries that can manage the devices through this ABI.
This allows to leverage existing developments rather than starting from
scratch each time. If your device uses a complete custom ABI there is not
much point of having a driver in the first place since any application needs
device specific knowledge anyway to talk to the driver, in this case you
could just directly implement the I2C communication in the application.

Please also consider reading and following Documentation/CodingStyle

[...]
> +static int as6200_read_reg(struct i2c_client *client,
> +	u8 reg_num, u16 *reg_val)
> +{
> +	int err = 0;
> +	char tx_buf[1];
> +	char rx_buf[2];
> +
> +	if ((reg_num >= 0) & (reg_num <= 3)) {
> +		tx_buf[0] = reg_num;
> +		err = i2c_master_send(client, tx_buf, 1);
> +		if (err == 1)
> +			err = i2c_master_recv(client, rx_buf, 2);

This is not thread safe. Another thread could interrupt between
i2c_master_send() and i2c_master_recv() and cause undefined behavior. Use
i2c_smbus_read_word_swapped() which makes sure that the I2C communication
happens atomically.

> +		if (err == 2) {
> +			*reg_val = rx_buf[0];
> +			*reg_val = *reg_val << 8;
> +			*reg_val = *reg_val | rx_buf[1];
> +		}
> +		return err;
> +	} else {
> +		return -EINVAL;
> +	}
> +}
[...]
> +
> +static irqreturn_t alert_isr(int irq, void *dev_id)
> +{
> +	dev_warn(dev_id, "Temperature outside of limits!");

Please use IIO threshold events for this. Such out-of-band communication is
really not acceptable.

> +	return IRQ_HANDLED;
> +}
> +
> +static int setupIRQ(struct iio_dev *indio_dev, bool set_gpio, u8 pol)
> +{
> +	int err;
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	int gpio = -1;
> +	int irq_num;
> +	int irq_trig;
> +
> +	if (pol == 1)
> +		irq_trig = IRQF_TRIGGER_RISING;
> +	else
> +		irq_trig = IRQF_TRIGGER_FALLING;
> +
> +	if (set_gpio) {
> +		gpio = of_get_named_gpio_flags(dev->of_node,
> +			"as6200,irq-gpio", 0, 0);
> +		err = gpio_request(gpio, "as6200_irq");
> +		if (err) {
> +			dev_info(dev, "%s: requesting gpio %d failed\n",
> +				as6200_id[0].name, gpio);
> +			return err;
> +		}
> +		err = gpio_direction_input(gpio);
> +		if (err) {
> +			dev_info(dev, "%s: gpio %d cannot apply direction\n",
> +					as6200_id[0].name, gpio);
> +			return err;
> +		}
> +	}
> +	irq_num = gpio_to_irq(gpio);
> +	dev_info(dev, "%s: registering for IRQ %d\n",
> +			as6200_id[0].name, irq_num);

Please drop all these dev_info(). That's just noise in the boot log, imagine
every driver did this you wouldn't be able to spot the critical information.

> +	err = request_irq(irq_num, alert_isr, irq_trig,
> +			as6200_id[0].name, dev);

Don't do all the GPIO translation. This pin is only used as a interrupt, so
specify it directly as an interrupt and use it that way as well.

> +	if (err) {
> +		dev_info(dev, "%s: error requesting irq %d\n",
> +			as6200_id[0].name, err);

For errors use dev_err. Also the as6200_id[0].name is redundant since
dev_info/dev_err already prefixes the message with the device name.

> +		return err;
> +	}
> +	dev_info(dev, "%s: registered for IRQ %d\n",
> +			as6200_id[0].name, irq_num);
> +	mutex_lock(&data->update_lock);
> +	data->irqn = irq_num;
> +	mutex_unlock(&data->update_lock);

What exactly is protect by that mutex here?

> +
> +	return 0;
> +}
> +
[...]
> +	if (err == 0) {
> +		if ((val < -40) | (val > 150)) {
> +			dev_info(&client->dev,
> +				"Value for THIGH is invalid min = -40%cC, max = 150°C, val = %d°C",
> +				(unsigned char)(248), val);

Please no out-of-band error reporting.

> +			return count;
> +		}
> +		val = (val * 10000) / 625;
> +		reg_val = val << 4;
[...]
> +static int as6200_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev = NULL;
> +	struct as6200_data *data = NULL;

No need to initialize those here with dummy, this will just hide warnings in
case you forgot to initialize them with actual data.

> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = dev_name(&client->dev);

use id->name for this. dev_name() contains things like the I2C bus and
device address, etc. Whereas the IIO device name should describe the type of
device.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &as6200_info;
> +
> +	indio_dev->channels = as6200_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as6200_channels);
> +
> +	initClientData(data);
> +	mutex_init(&data->update_lock);
> +	setupIRQ(indio_dev, true, 0);
> +
> +	return iio_device_register(indio_dev);

Error handling is missing here, you need to free the resources that were
acquired in case of an error.

> +}
> +
[...]

