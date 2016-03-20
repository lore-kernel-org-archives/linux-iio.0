Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56764 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273AbcCTKk5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2016 06:40:57 -0400
Subject: Re: [PATCH 1/3] iio: imu: mpu6050: Fix name/chip_id when using ACPI
To: Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>
References: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com>
 <1458232366-12773-2-git-send-email-daniel.baluta@intel.com>
 <CAKzfze-nFeMJhp7oRrKaCuM+CRJpokFevCEdxB1Mu96H+pUT6A@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>, cmo@melexis.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	ggao@invensense.com, srinivas.pandruvada@linux.intel.com,
	adi.reus@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56EE7E34.8040608@kernel.org>
Date: Sun, 20 Mar 2016 10:40:52 +0000
MIME-Version: 1.0
In-Reply-To: <CAKzfze-nFeMJhp7oRrKaCuM+CRJpokFevCEdxB1Mu96H+pUT6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/16 17:21, Matt Ranostay wrote:
> Reviewed-By: Matt Ranostay <matt.ranostay@intel.com>
I'm guessing this may at some point want backporting, but right now it only
applies to my togreg branch (due to prior changes) so that's where I've applied
this.  If you want a faster path to mainline, the please send me the backport.

Jonathan
> 
> On Thu, Mar 17, 2016 at 9:32 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>> When using ACPI, id is NULL and the current code automatically
>> defaults name to NULL and chip id to 0. We should instead use
>> the data provided in the ACPI device table.
>>
>> Fixes: c816d9e7a57b ("iio: imu: mpu6050: fix possible NULL dereferences")
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> ---
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 29 ++++++++++++++++++++++++++---
>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> index d0c0e20..5ee4e0d 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> @@ -104,6 +104,19 @@ static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
>>         return 0;
>>  }
>>
>> +static const char *inv_mpu_match_acpi_device(struct device *dev, int *chip_id)
>> +{
>> +       const struct acpi_device_id *id;
>> +
>> +       id = acpi_match_device(dev->driver->acpi_match_table, dev);
>> +       if (!id)
>> +               return NULL;
>> +
>> +       *chip_id = (int)id->driver_data;
>> +
>> +       return dev_name(dev);
>> +}
>> +
>>  /**
>>   *  inv_mpu_probe() - probe function.
>>   *  @client:          i2c client.
>> @@ -115,15 +128,25 @@ static int inv_mpu_probe(struct i2c_client *client,
>>                          const struct i2c_device_id *id)
>>  {
>>         struct inv_mpu6050_state *st;
>> -       int result;
>> -       const char *name = id ? id->name : NULL;
>> -       const int chip_type = id ? id->driver_data : 0;
>> +       int result, chip_type;
>>         struct regmap *regmap;
>> +       const char *name;
>>
>>         if (!i2c_check_functionality(client->adapter,
>>                                      I2C_FUNC_SMBUS_I2C_BLOCK))
>>                 return -EOPNOTSUPP;
>>
>> +       if (id) {
>> +               chip_type = (int)id->driver_data;
>> +               name = id->name;
>> +       } else if (ACPI_HANDLE(&client->dev)) {
>> +               name = inv_mpu_match_acpi_device(&client->dev, &chip_type);
>> +               if (!name)
>> +                       return -ENODEV;
>> +       } else {
>> +               return -ENOSYS;
>> +       }
>> +
>>         regmap = devm_regmap_init_i2c(client, &inv_mpu_regmap_config);
>>         if (IS_ERR(regmap)) {
>>                 dev_err(&client->dev, "Failed to register i2c regmap %d\n",
>> --
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

