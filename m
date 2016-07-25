Return-Path: <pratik.prajapati12@gmail.com>
MIME-Version: 1.0
In-Reply-To: <bb12cea3-487d-b1ec-cadc-4ca582082517@kernel.org>
References: <1469112097-6806-1-git-send-email-pratik.prajapati12@gmail.com>
 <1469112097-6806-2-git-send-email-pratik.prajapati12@gmail.com> <bb12cea3-487d-b1ec-cadc-4ca582082517@kernel.org>
From: Pratik Prajapati <pratik.prajapati12@gmail.com>
Date: Mon, 25 Jul 2016 11:50:37 +0530
Message-ID: <CAHNg1SpeevfyAeo+reNF2CsHzMpZhSLrEwRGeLQxUYd0xi7J+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: iio: vcnl4000: Replace i2c api's with regmap
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 24, 2016 at 3:56 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 21/07/16 15:41, Pratik Prajapati wrote:
>> Signed-off-by: Pratik Prajapati <pratik.prajapati12@gmail.com>
>> ---
>>  drivers/iio/light/vcnl4000.c | 91 +++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 78 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index 1378175..61e48f8 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/i2c.h>
>>  #include <linux/err.h>
>>  #include <linux/delay.h>
>> +#include <linux/regmap.h>
>>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>> @@ -52,6 +53,7 @@
>>  struct vcnl4000_data {
>>       struct i2c_client *client;
>>       struct mutex lock;
>> +     struct regmap *regmap;
> You can use the regmap_get_device to avoid having to carry the client through the whole
> driver. I haven't checked the result of applying this patch but I'm not entirely sure
> you use client at all.
I have used client for devm_regmap_init_i2c() and i2c_set_clientdata()

>>  };
>>
>>  static const struct i2c_device_id vcnl4000_id[] = {
>> @@ -66,20 +68,20 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>>       int tries = 20;
>>       __be16 buf;
>>       int ret;
>> +     unsigned int regval;
>>
>>       mutex_lock(&data->lock);
>>
>> -     ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
>> -                                     req_mask);
>> +     ret = regmap_write(data->regmap, VCNL4000_COMMAND, req_mask);
>>       if (ret < 0)
>>               goto fail;
>>
>>       /* wait for data to become ready */
>>       while (tries--) {
>> -             ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
>> +             ret = regmap_read(data->regmap, VCNL4000_COMMAND, &regval);
>>               if (ret < 0)
>>                       goto fail;
>> -             if (ret & rdy_mask)
>> +             if (regval & rdy_mask)
>>                       break;
>>               msleep(20); /* measurement takes up to 100 ms */
>>       }
>> @@ -91,8 +93,8 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>>               goto fail;
>>       }
>>
>> -     ret = i2c_smbus_read_i2c_block_data(data->client,
>> -             data_reg, sizeof(buf), (u8 *) &buf);
>> +     ret = regmap_bulk_read(data->regmap, data_reg, (u8 *) &buf,
>> +                     sizeof(buf));
>>       if (ret < 0)
>>               goto fail;
>>
>> @@ -131,23 +133,24 @@ static int vcnl4000_write_led_current_raw(struct vcnl4000_data *data, int val)
>>       if (val < 0 || val > VCNL4000_LED_CURRENT_MAX)
>>               return -ERANGE;
>>       mutex_lock(&data->lock);
>> -     ret = i2c_smbus_write_byte_data(data->client, VCNL4000_LED_CURRENT,
>> -                     val);
> Just noticed this.  You didn't do a masked write in the previous patch.
> Are you sure that wasn't overwriting something it shouldn't have been?
No.
Its overwriting, I will correct that.
