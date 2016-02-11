Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65235 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbcBKIcZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Feb 2016 03:32:25 -0500
Subject: Re: [PATCH v4 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6000
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
References: <1455115303-16008-1-git-send-email-adriana.reus@intel.com>
 <1455115303-16008-5-git-send-email-adriana.reus@intel.com>
 <CAKi4VAJJN0zf+tdo6ZRgh1_A8g4wtEBkU0W4+8h7OQYvQBSHLw@mail.gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	Michael Welling <mwelling@ieee.org>, lars@metafoo.de,
	Daniel Baluta <daniel.baluta@intel.com>, adi.reus@gmail.com,
	cmo@melexis.com
From: Adriana Reus <adriana.reus@intel.com>
Message-ID: <56BC46D7.2020503@intel.com>
Date: Thu, 11 Feb 2016 10:31:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAKi4VAJJN0zf+tdo6ZRgh1_A8g4wtEBkU0W4+8h7OQYvQBSHLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 11.02.2016 07:39, Lucas De Marchi wrote:
> Hi Adriana,
>
> On Wed, Feb 10, 2016 at 12:41 PM, Adriana Reus <adriana.reus@intel.com> wrote:
>> -int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name)
>> +int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>> +                      int (*inv_mpu_bus_setup)(struct iio_dev *))
>>   {
>>          struct inv_mpu6050_state *st;
>>          struct iio_dev *indio_dev;
>> @@ -700,6 +702,9 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name)
>>          if (result)
>>                  return result;
>>
>> +       if (inv_mpu_bus_setup)
>> +               inv_mpu_bus_setup(indio_dev);
>
> ok
>
>> +static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
>> +{
>> +       struct inv_mpu6050_state *st = iio_priv(indio_dev);
>> +       int ret = 0;
>> +
>> +       ret = inv_mpu6050_set_power_itg(st, true);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = regmap_write(st->map, INV_MPU6050_REG_USER_CTRL,
>> +                             INV_MPU6050_BIT_I2C_IF_DIS);
>> +       if (ret) {
>> +               inv_mpu6050_set_power_itg(st, false);
>> +               return ret;
>> +       }
>
> ok
>
>> +static int inv_mpu_probe(struct spi_device *spi)
>> +{
>> +       struct regmap *regmap;
>> +       const struct spi_device_id *id = spi_get_device_id(spi);
>> +       const char *name = id ? id->name : NULL;
>> +       int result;
>> +
>> +       regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
>> +       if (IS_ERR(regmap)) {
>> +               dev_err(&spi->dev, "Failed to register spi regmap %d\n",
>> +                       (int)PTR_ERR(regmap));
>> +               return PTR_ERR(regmap);
>> +       }
>> +
>> +       result = regmap_write(regmap, INV_MPU6050_REG_USER_CTRL,
>> +                             INV_MPU6050_BIT_I2C_IF_DIS);
>> +       if (result) {
>> +               dev_err(&spi->dev, "Failed to disable I2C interface\n");
>> +               return result;
>> +       }
>
> leftover from previous patch?
indeed... thanks
>
>
> Lucas De Marchi
>
