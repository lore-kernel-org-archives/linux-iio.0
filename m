Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60014 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbbGEOIP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 10:08:15 -0400
Message-ID: <55993A4C.10105@kernel.org>
Date: Sun, 05 Jul 2015 15:08:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Andreas Dannenberg <dannenberg@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
CC: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/2] iio: light: add support for TI's opt3001 light
 sensor
References: <1435876079-26287-1-git-send-email-dannenberg@ti.com> <1435876079-26287-2-git-send-email-dannenberg@ti.com>
In-Reply-To: <1435876079-26287-2-git-send-email-dannenberg@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/07/15 23:27, Andreas Dannenberg wrote:
> TI's opt3001 light sensor is a simple and yet powerful
> little device. The device provides 99% IR rejection,
> automatic full-scale, very low power consumption and
> measurements from 0.01 to 83k lux.
> 
> This patch adds support for that device using the IIO
> framework.
> 
> See http://www.ti.com/product/opt3001 for more information.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Hi Andreas,

Looking pretty good to me, though I'd like to give Peter time to take
another look and give his reviewed-by etc.

One really minor suggestion from me...
<snip>
> +
> +static int opt3001_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +
> +	struct iio_dev *iio;
> +	struct opt3001 *opt;
> +	int irq = client->irq;
> +	int ret = -ENOMEM;
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*opt));
> +	if (!iio)
return -ENOMEM; would be cleaner, then there is no need to initialize
ret either.
> +		return ret;
> +
> +	opt = iio_priv(iio);
> +	opt->client = client;
> +	opt->dev = dev;
> +
> +	mutex_init(&opt->lock);
> +	init_waitqueue_head(&opt->result_ready_queue);
> +	i2c_set_clientdata(client, iio);
> +
> +	ret = opt3001_read_id(opt);
> +	if (ret)
> +		return ret;
> +
> +	ret = opt3001_configure(opt);
> +	if (ret)
> +		return ret;
> +
> +	iio->name = client->name;
> +	iio->channels = opt3001_channels;
> +	iio->num_channels = ARRAY_SIZE(opt3001_channels);
> +	iio->dev.parent = dev;
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &opt3001_info;
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret) {
> +		dev_err(dev, "failed to register IIO device\n");
> +		return ret;
> +	}
> +
> +	ret = request_threaded_irq(irq, NULL, opt3001_irq,
> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			"opt3001", iio);
> +	if (ret) {
> +		dev_err(dev, "failed to request IRQ #%d\n", irq);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int opt3001_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *iio = i2c_get_clientdata(client);
> +	struct opt3001 *opt = iio_priv(iio);
> +	int ret;
> +	u16 reg;
> +
> +	free_irq(client->irq, iio);
> +
> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	reg = ret;
> +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
> +
> +	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> +			reg);
> +	if (ret < 0) {
> +		dev_err(opt->dev, "failed to write register %02x\n",
> +				OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id opt3001_id[] = {
> +	{ "opt3001", 0 },
> +	{ } /* Terminating Entry */
> +};
> +MODULE_DEVICE_TABLE(i2c, opt3001_id);
> +
> +static const struct of_device_id opt3001_of_match[] = {
> +	{ .compatible = "ti,opt3001" },
> +	{ }
> +};
> +
> +static struct i2c_driver opt3001_driver = {
> +	.probe = opt3001_probe,
> +	.remove = opt3001_remove,
> +	.id_table = opt3001_id,
> +
> +	.driver = {
> +		.name = "opt3001",
> +		.of_match_table = of_match_ptr(opt3001_of_match),
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +module_i2c_driver(opt3001_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Andreas Dannenberg <dannenberg@ti.com>");
> +MODULE_DESCRIPTION("Texas Instruments OPT3001 Light Sensor Driver");
> 

