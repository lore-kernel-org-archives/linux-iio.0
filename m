Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57179 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbcGCJyQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 05:54:16 -0400
Subject: Re: [PATCH 04/10 v4] iio: pressure: bmp280: support supply regulators
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
 <1467251334-30594-5-git-send-email-linus.walleij@linaro.org>
 <738a706e-57e3-5699-317c-a43e7db77542@kernel.org>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>, Mark Brown <broonie@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <affa5126-9f23-0053-701c-52f004737276@kernel.org>
Date: Sun, 3 Jul 2016 10:54:11 +0100
MIME-Version: 1.0
In-Reply-To: <738a706e-57e3-5699-317c-a43e7db77542@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/16 20:30, Jonathan Cameron wrote:
> On 30/06/16 02:48, Linus Walleij wrote:
>> The BMP085/BMP180/BMP280 is supplied with two power sources:
>> VDDA (analog power) and VDDD (digital power). As these may come
>> from regulators (as on the APQ8060 Dragonboard) we need the driver
>> to attempt to fetch and enable these regulators.
>>
>> We FAIL if we cannot: boards should either define:
>> - Proper regulators if present
>> - Define fixed regulators if power is hardwired to the component
>> - Rely on dummy regulators (will be present on all DT systems and
>>   any boardfile system that calls regulator_has_full_constraints().
>>
>> Cc: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Goes to show how well I read this earlier. Coincidentally it
> doesn't apply cleanly due to a fix that's made it into the togreg
> branch via a fast forward merge.
> 
> This one introduces a race, by potentially turning off the
> regulators before we have removed the various interfaces that
> allow for reading from the iio device.
> 
> You need to change the devm_iio_device_register into the non
> devm version and unwind it in the remove function.
I'm in an odd mood this morning so will fix this up (mostly to try
and avoid having to see a v5 ;)

Jonathan

Applied this one with the changes mentioned below.  Please check the
result as I may well have messed it up.

The next patch is going to be 'fun'. 


> 
> Jonathan
>> ---
>> ChangeLog v3->v4:
>> - Fix missing "regulator" string in enablement message.
>> - Fix BMP058->BMP085 in commit message
>> ChangeLog v2->v3:
>> - Encode a start-up time for each sensor type (from the datasheets)
>>   this is necessary when coldstarting the sensor with a regulator
>>   to be sure it is on before we try to use it.
>> - Introduce a try/catch-style set of goto clauses in the probe
>>   function to make sure the regulators are properly disabled.
>> ChangeLog v1->v2:
>> - Make the regulators non-optional: an optional supply is one you
>>   can choose not to supply ELECTRICALLY as in an internal charge
>>   pump taking its place or so.
>> - Bail out if not present and add some notices to the commit that
>>   boards need to think about their regulator usage.
>> - Make sure we disable the regulators, and introduce a .remove()
>>   call to do that if/when the module is removed.
>> ---
>>  drivers/iio/pressure/bmp280.c | 64 ++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 60 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
>> index 1618968f8889..5245bc598187 100644
>> --- a/drivers/iio/pressure/bmp280.c
>> +++ b/drivers/iio/pressure/bmp280.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>>  #include <linux/gpio/consumer.h>
>> +#include <linux/regulator/consumer.h>
>>  
>>  /* BMP280 specific registers */
>>  #define BMP280_REG_HUMIDITY_LSB		0xFE
>> @@ -124,6 +125,9 @@ struct bmp280_data {
>>  	struct mutex lock;
>>  	struct regmap *regmap;
>>  	const struct bmp280_chip_info *chip_info;
>> +	struct regulator *vddd;
>> +	struct regulator *vdda;
>> +	unsigned int start_up_time; /* in milliseconds */
>>  
>>  	/* log of base 2 of oversampling rate */
>>  	u8 oversampling_press;
>> @@ -1047,12 +1051,14 @@ static int bmp280_probe(struct i2c_client *client,
>>  		data->chip_info = &bmp180_chip_info;
>>  		data->oversampling_press = ilog2(8);
>>  		data->oversampling_temp = ilog2(1);
>> +		data->start_up_time = 10;
>>  		break;
>>  	case BMP280_CHIP_ID:
>>  		indio_dev->num_channels = 2;
>>  		data->chip_info = &bmp280_chip_info;
>>  		data->oversampling_press = ilog2(16);
>>  		data->oversampling_temp = ilog2(2);
>> +		data->start_up_time = 2;
>>  		break;
>>  	case BME280_CHIP_ID:
>>  		indio_dev->num_channels = 3;
>> @@ -1060,11 +1066,37 @@ static int bmp280_probe(struct i2c_client *client,
>>  		data->oversampling_press = ilog2(16);
>>  		data->oversampling_humid = ilog2(16);
>>  		data->oversampling_temp = ilog2(2);
>> +		data->start_up_time = 2;
>>  		break;
>>  	default:
>>  		return -EINVAL;
>>  	}
>>  
>> +	/* Bring up regulators */
>> +	data->vddd = devm_regulator_get(&client->dev, "vddd");
>> +	if (IS_ERR(data->vddd)) {
>> +		dev_err(&client->dev, "failed to get VDDD regulator\n");
>> +		return PTR_ERR(data->vddd);
>> +	}
>> +	ret = regulator_enable(data->vddd);
>> +	if (ret) {
>> +		dev_err(&client->dev, "failed to enable VDDD regulator\n");
>> +		return ret;
>> +	}
>> +	data->vdda = devm_regulator_get(&client->dev, "vdda");
>> +	if (IS_ERR(data->vdda)) {
>> +		dev_err(&client->dev, "failed to get VDDA regulator\n");
>> +		ret = PTR_ERR(data->vddd);
>> +		goto out_disable_vddd;
>> +	}
>> +	ret = regulator_enable(data->vdda);
>> +	if (ret) {
>> +		dev_err(&client->dev, "failed to enable VDDA regulator\n");
>> +		goto out_disable_vddd;
>> +	}
>> +	/* Wait to make sure we started up properly */
>> +	mdelay(data->start_up_time);
>> +
>>  	/* Bring chip out of reset if there is an assigned GPIO line */
>>  	gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
>>  	/* Deassert the signal */
>> @@ -1077,7 +1109,8 @@ static int bmp280_probe(struct i2c_client *client,
>>  					data->chip_info->regmap_config);
>>  	if (IS_ERR(data->regmap)) {
>>  		dev_err(&client->dev, "failed to allocate register map\n");
>> -		return PTR_ERR(data->regmap);
>> +		ret = PTR_ERR(data->regmap);
>> +		goto out_disable_vdda;
>>  	}
>>  
>>  	ret = regmap_read(data->regmap, BMP280_REG_ID, &chip_id);
>> @@ -1086,14 +1119,36 @@ static int bmp280_probe(struct i2c_client *client,
>>  	if (chip_id != id->driver_data) {
>>  		dev_err(&client->dev, "bad chip id.  expected %x got %x\n",
>>  			BMP280_CHIP_ID, chip_id);
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto out_disable_vdda;
>>  	}
>>  
>>  	ret = data->chip_info->chip_config(data);
>>  	if (ret < 0)
>> -		return ret;
>> +		goto out_disable_vdda;
>> +
>> +	i2c_set_clientdata(client, data);
>>  
>> -	return devm_iio_device_register(&client->dev, indio_dev);
>> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>> +	if (ret)
>> +		goto out_disable_vdda;
>> +
>> +	return 0;
>> +
>> +out_disable_vdda:
>> +	regulator_disable(data->vdda);
>> +out_disable_vddd:
>> +	regulator_disable(data->vddd);
>> +	return ret;
>> +}
>> +
>> +static int bmp280_remove(struct i2c_client *client)
>> +{
>> +	struct bmp280_data *data = i2c_get_clientdata(client);
>> +
>> +	regulator_disable(data->vdda);
>> +	regulator_disable(data->vddd);
> Race condition as the userspace and in kernel interfaces to
> use the device haven't been removed, but we've turned off the
> lights...
>> +	return 0;
>>  }
>>  
>>  static const struct acpi_device_id bmp280_acpi_match[] = {
>> @@ -1134,6 +1189,7 @@ static struct i2c_driver bmp280_driver = {
>>  		.of_match_table = of_match_ptr(bmp280_of_match),
>>  	},
>>  	.probe		= bmp280_probe,
>> +	.remove		= bmp280_remove,
>>  	.id_table	= bmp280_id,
>>  };
>>  module_i2c_driver(bmp280_driver);
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

