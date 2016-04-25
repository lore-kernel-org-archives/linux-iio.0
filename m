Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:45149 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbcDYPVu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2016 11:21:50 -0400
Message-ID: <571E1241.3050101@denx.de>
Date: Mon, 25 Apr 2016 14:49:05 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH V4] iio: pressure: hp03: Add Hope RF HP03 sensor support
References: <1460988324-7494-1-git-send-email-marex@denx.de> <ae85624e-23ba-3ced-ca7d-c8bf98a85efb@kernel.org>
In-Reply-To: <ae85624e-23ba-3ced-ca7d-c8bf98a85efb@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/24/2016 10:48 AM, Jonathan Cameron wrote:
> On 18/04/16 15:05, Marek Vasut wrote:
>> Add support for HopeRF pressure and temperature sensor.
>>
>> This device uses two fixed I2C addresses, one for storing
>> calibration coefficients and another for accessing the ADC.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Matt Ranostay <mranostay@gmail.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
> Not sure how I missed this earlier (sorry!) but you have some ordering issues
> in the probe vs remove functions that need sorting out.

I will comment on that below. Thanks for spotting this.

> As they were easily fixed, I've done it and applied the result to the
> togreg branch of iio.git.  Please check I didn't mess anything up.

You mean 'testing' branch :)

> The binding is straight forward enough that I don't feel I need a devicetree
> ack, though of course one is always welcome!
> 
> Thanks,

[...]

>> +static int hp03_probe(struct i2c_client *client,
>> +		      const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct hp03_priv *priv;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	priv = iio_priv(indio_dev);
>> +	priv->client = client;
>> +	mutex_init(&priv->lock);
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->name = id->name;
>> +	indio_dev->channels = hp03_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(hp03_channels);
>> +	indio_dev->info = &hp03_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	/*
>> +	 * Allocate another device for the on-sensor EEPROM,
>> +	 * which has it's dedicated I2C address and contains
>> +	 * the calibration constants for the sensor.
>> +	 */
>> +	priv->eeprom_client = i2c_new_dummy(client->adapter, HP03_EEPROM_ADDR);
>> +	if (!priv->eeprom_client) {
>> +		dev_err(dev, "New EEPROM I2C device failed\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	priv->eeprom_regmap = devm_regmap_init_i2c(priv->eeprom_client,
>> +						   &hp03_regmap_config);
>> +	if (IS_ERR(priv->eeprom_regmap)) {
>> +		dev_err(dev, "Failed to allocate EEPROM regmap\n");
>> +		ret = PTR_ERR(priv->eeprom_regmap);
>> +		goto err;
>> +	}
>> +
>> +	priv->xclr_gpio = devm_gpiod_get_index(dev, "xclr", 0, GPIOD_OUT_HIGH);
>> +	if (IS_ERR(priv->xclr_gpio)) {
>> +		dev_err(dev, "Failed to claim XCLR GPIO\n");
>> +		ret = PTR_ERR(priv->xclr_gpio);
>> +		goto err;
>> +	}
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register IIO device\n");
>> +		goto err;
>> +	}
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	return 0;
>> +
>> +err:
>> +	i2c_unregister_device(priv->eeprom_client);
>> +	return ret;
>> +}
>> +
>> +static int hp03_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +	struct hp03_priv *priv = iio_priv(indio_dev);
>> +
>> +	i2c_unregister_device(priv->eeprom_client);
> There is a race here unfortunately.

After reading the explanation, I agree. It's subtle and quite nasty.

> As you have used devm_iio_device_register the usespace interaces are still
> exposed at this point.  So can they cause any use of the eeprom i2c device?
> Yes, they can so if we happen to get a userspace read between here and
> the devm initiallised unregister it will crash...

Yes, true.

> It is less obvious whether we can even use the devm_ regmap call for the
> eeprom i2c device.  It can't be accessed as long as the iio_device
> has been deregistered.  However, this isn't immediately obvious when
> reviewing so on that basis alone it should be unwound here rather than
> relying on devm...
> 
> You will also want to reorganise the probe function to move the registration
> of this bus past the gpio stuff so as to avoid needing to unwind that by hand
> as well.
> 
> Anyhow, rule of thumb is that probe order must be reversed in remove
> including devm related cleanup.

Right. I went through the updated HP03 code and it does make sense.
Thanks for catching this race and explaining it in this much detail,
I enjoyed reading this breakdown. And sorry for the hassle, I'll be
more careful next time.

>> +
>  > +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id hp03_id[] = {
>> +	{ "hp03", 0 },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, hp03_id);
>> +
>> +static struct i2c_driver hp03_driver = {
>> +	.driver = {
>> +		.name	= "hp03",
>> +	},
>> +	.probe		= hp03_probe,
>> +	.remove		= hp03_remove,
>> +	.id_table	= hp03_id,
>> +};
>> +module_i2c_driver(hp03_driver);
>> +
>> +MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
>> +MODULE_DESCRIPTION("Driver for Hope RF HP03 pressure and temperature sensor");
>> +MODULE_LICENSE("GPL v2");
>>
> 


-- 
Best regards,
Marek Vasut
