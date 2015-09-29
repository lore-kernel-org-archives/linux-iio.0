Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.gravity.jabatus.fr ([109.234.163.67]:53639 "EHLO
	mail.gravity.jabatus.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933513AbbI2Jg1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2015 05:36:27 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 2/6] Add tsys01 meas-spec driver support
From: "ludovic.tancerel@maplehightech.com"
	<ludovic.tancerel@maplehightech.com>
In-Reply-To: <56081F9C.7070500@kernel.org>
Date: Tue, 29 Sep 2015 11:36:01 +0200
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	William.Markezana@meas-spec.com
Message-Id: <896942C8-3780-4758-920F-6FFBA2078A43@maplehightech.com>
References: <1443189405-18516-1-git-send-email-ludovic.tancerel@maplehightech.com> <1443189405-18516-3-git-send-email-ludovic.tancerel@maplehightech.com> <56081F9C.7070500@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Thank you for reviewing
Please have a look at comments below,

Regards,
Ludovic

Le 27 sept. 2015 à 18:55, Jonathan Cameron <jic23@kernel.org> a écrit :

> On 25/09/15 14:56, Ludovic Tancerel wrote:
>> Support for TSYS01 temperature sensor
>> 
>> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
> This is fine as far as i am concerned, though I would like to leave it
> on the list for a little while for others to have a chance to comment.
>> ---
>> drivers/iio/temperature/Kconfig  |  11 ++
>> drivers/iio/temperature/Makefile |   1 +
>> drivers/iio/temperature/tsys01.c | 231 +++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 243 insertions(+)
>> create mode 100644 drivers/iio/temperature/tsys01.c
>> 
>> 
…

>> +static int tsys01_i2c_probe(struct i2c_client *client,
>> +			    const struct i2c_device_id *id)
>> +{
>> +	struct tsys01_dev *dev_data;
>> +	struct iio_dev *indio_dev;
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_SMBUS_WORD_DATA |
>> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
>> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> +		dev_err(&client->dev,
>> +			"Adapter does not support some i2c transaction\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	dev_data = iio_priv(indio_dev);
>> +	dev_data->client = client;
>> +	dev_data->reset = ms_sensors_i2c_reset;
>> +	dev_data->read_prom_word = ms_sensors_i2c_read_prom_word;
>> +	dev_data->convert_and_read = ms_sensors_i2c_convert_and_read;
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
> This separation into i2c probe and main probe is something one would
> generally only introduce at the point of adding support for another bus.
> It just adds complexity here for little gain.  If there is intent
> to add spi support shortly then fair enough, leave it as it is.

I don’t plan on doing the SPI stuff myself,
so if you feel I should simplify as there is no plan to do it, please let me know.

I prefer to keep it as I made this change especially to comply a request to have this similar to other existing meas-spec drivers (ms5611).


>> +	return tsys01_probe(indio_dev, &client->dev);
>> +}
>> +
>> +static const struct i2c_device_id tsys01_id[] = {
>> +	{"tsys01", 0},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, tsys01_id);
>> +
>> +static struct i2c_driver tsys01_driver = {
>> +	.probe = tsys01_i2c_probe,
>> +	.id_table = tsys01_id,
>> +	.driver = {
>> +		   .name = "tsys01",
>> +		   },
>> +};
>> +
>> +module_i2c_driver(tsys01_driver);
>> +
>> +MODULE_DESCRIPTION("Measurement-Specialties tsys01 temperature driver");
>> +MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
>> +MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
>> +MODULE_LICENSE("GPL v2");
>> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

