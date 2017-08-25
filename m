Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:38349 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933506AbdHYPQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2017 11:16:34 -0400
Received: by mail-qk0-f175.google.com with SMTP id o184so251932qkc.5
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2017 08:16:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170825055256.GA2172@arbeit>
References: <1503618871-22446-1-git-send-email-colin.parker@aclimalabs.com> <20170825055256.GA2172@arbeit>
From: Colin Foe-Parker <colin.foeparker@aclima.io>
Date: Fri, 25 Aug 2017 08:15:52 -0700
Message-ID: <CAHeJuP-oFoDi_9P77rdE6_S-aFhjGpnp1+kpRpZBdxEyaQVudw@mail.gmail.com>
Subject: Re: [PATCH] IIO: BME280: Humidity: Changes to the humidity ctrl_hum
 require a write to ctrl_meas.
To: Andreas Klinger <ak@it-klinger.de>
Cc: Colin Parker <colin.foeparker@aclima.io>,
        linux-iio@vger.kernel.org,
        Colin Foe-Parker <foeparker.colin@gmail.com>,
        Colin Parker <colin.parker@aclima.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Andreas,

On Thu, Aug 24, 2017 at 10:52 PM, Andreas Klinger <ak@it-klinger.de> wrote:
> Hi Colin,
>
> Colin Parker <colin.foeparker@aclima.io> schrieb am Thu, 24. Aug 16:54:
>> From: Colin Parker <colin.parker@aclima.io>
>>
>> This results in inaccurate Humidity readings that tend to not fluxuate.
>>
>> Update the ordering of the register writes so that ctrl_meas is written
>> after ctrl_hum. This is taken from section 5.4.3 of the datasheet.
>>
>> "https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf"
>
> this part of the patch is already covered by commit afb2c3851b: "iio: bmp280:
> properly initialize device for humidity reading"

Thanks for pointing out the duplication of efforts!  I dug through the
fixes-togreg branch and found the changes you are referencing.

I think that there might still be an issue there.  I believe that the
regmap_update_bits function will only write to the ctrl_meas register
if there is a difference in the register value vs what is in the
regmap cache.  So in the situation where someone wanted to update the
humidity sampling configuration, I don't think the write to the
ctrl_meas write would go out on the bus.  And as a consequence, the
changes to the humidity settings wouldn't become effective.

What is your take?  I can refactor my patch to just fix that part if
you see the same bug.

-Colin

>
> Andreas
>
>>
>> Also writes to the config register can be ignored if the device is in Normal Mode.
>> Change the device to sleep mode before updating the config register.
>> This has the nice side effect of guaranteeing that the regmap_update_bits
>> function actually updates the driver and not just verifies the setting in its cache.
>>
>> Signed-off-by: Colin Parker <colin.parker@aclima.io>
>> ---
>>  drivers/iio/pressure/bmp280-core.c | 22 +++++++++++++++-------
>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
>> index d82b788..85aa24c 100644
>> --- a/drivers/iio/pressure/bmp280-core.c
>> +++ b/drivers/iio/pressure/bmp280-core.c
>> @@ -559,10 +559,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
>>                 BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
>>
>>       ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
>> -                              BMP280_OSRS_TEMP_MASK |
>> -                              BMP280_OSRS_PRESS_MASK |
>> -                              BMP280_MODE_MASK,
>> -                              osrs | BMP280_MODE_NORMAL);
>> +                              BMP280_MODE_MASK, BMP280_MODE_SLEEP);
>>       if (ret < 0) {
>>               dev_err(data->dev,
>>                       "failed to write ctrl_meas register\n");
>> @@ -578,6 +575,17 @@ static int bmp280_chip_config(struct bmp280_data *data)
>>               return ret;
>>       }
>>
>> +     ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
>> +                              BMP280_OSRS_TEMP_MASK |
>> +                              BMP280_OSRS_PRESS_MASK |
>> +                              BMP280_MODE_MASK,
>> +                              osrs | BMP280_MODE_NORMAL);
>> +     if (ret < 0) {
>> +             dev_err(data->dev,
>> +                     "failed to write ctrl_meas register\n");
>> +             return ret;
>> +     }
>> +
>>       return ret;
>>  }
>>
>> @@ -597,14 +605,14 @@ static const struct bmp280_chip_info bmp280_chip_info = {
>>
>>  static int bme280_chip_config(struct bmp280_data *data)
>>  {
>> -     int ret = bmp280_chip_config(data);
>>       u8 osrs = BMP280_OSRS_HUMIDITIY_X(data->oversampling_humid + 1);
>> +     int ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
>> +                               BMP280_OSRS_HUMIDITY_MASK, osrs);
>>
>>       if (ret < 0)
>>               return ret;
>>
>> -     return regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
>> -                               BMP280_OSRS_HUMIDITY_MASK, osrs);
>> +     return bmp280_chip_config(data);
>>  }
>>
>>  static const struct bmp280_chip_info bme280_chip_info = {
>> --
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --



-- 
Colin Parker


ACLIMA INC

Direct (415) 735-5062 |  Email colin.foeparker@aclima.io

10 Lombard St. Suite 250  |  San Francisco, CA 94111


Hello, we're Aclima.


This email and any attachments may contain private, confidential and
privileged material for the sole use of the intended recipient. If you
are not the intended recipient, please immediately delete this email
and any attachments.
