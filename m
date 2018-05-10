Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:54719 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756306AbeEJCWB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2018 22:22:01 -0400
Subject: Re: [PATCH v3] iio: accell: mma8452: Reduce sleep time when data not
 ready
To: Martin Kepplinger <martink@posteo.de>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, harinath922@gmail.com
References: <4a845aca-600d-2473-9b66-51dea9d1651b@electromag.com.au>
 <5aad5eff-b0f4-4795-7c19-e177d415ed8b@electromag.com.au>
 <58db7210-1c84-3f5e-472d-8fae2b77bdd0@posteo.de>
 <8128071e-3b73-e0b1-eb2a-f1b245aea3e4@electromag.com.au>
 <939563a6-19ff-b51a-3a26-e90f10c7bae1@posteo.de>
 <cd307679-19c5-1132-79dc-b28c96cc537e@electromag.com.au>
 <7dc844c6-8666-c381-e6fe-d70dfebf2eeb@posteo.de>
From: Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <24930ae9-ec06-13bc-45ec-edbf97cbe2b5@electromag.com.au>
Date: Thu, 10 May 2018 10:21:54 +0800
MIME-Version: 1.0
In-Reply-To: <7dc844c6-8666-c381-e6fe-d70dfebf2eeb@posteo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I'll take a look at the CRLF issue, seems the mail client is doing
it.... strike 3 for thunderbird..
Yes did run checkpatch
Yes did note that line was 3 chars longer than 80 "0);"
Aware that the coding standards allow this where it doesn't hide
anything substantial and I think it's more readable..
I'm ok to change it, just think it looks messy when split given it's in
an un-bracketed if else statement.
Theres over 100 of lines in the iio code alone that currently do the
same thing on the last variable (including this file), so I thought it'd
be ok.

Cheers
   Richard
On 9/05/2018 5:57 PM, Martin Kepplinger wrote:
> On 2018-05-08 10:19, Richard Tresidder wrote:
>> Modified the sleep method when data is not ready to allow for
sampling > 50sps to work.
>>
>> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
>> ---
>> v3: Changes from v2
>>   * Removed fallthrough fix (will submit separately)
>>   * Fixed some blank lines, trailing white spaces.
>>
>> v2: Changes from v1
>>   * Remove whitespace changes
>>   * Added fallthrough fix (subsequently removed)
>>
>> drivers/iio/accel/mma8452.c | 23 ++++++++++++++++++++++-
>> 1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 7a2da7f..5650b59 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -106,6 +106,7 @@ struct mma8452_data {
>>      u8 ctrl_reg1;
>>      u8 data_cfg;
>>      const struct mma_chip_info *chip_info;
>> +    int sleep_val;
>>  };
>>
>>   /**
>> @@ -193,7 +194,10 @@ static int mma8452_drdy(struct mma8452_data *data)
>>          if ((ret & MMA8452_STATUS_DRDY) == MMA8452_STATUS_DRDY)
>>              return 0;
>>
>> -        msleep(20);
>> +        if (data->sleep_val <= 20)
>> +            usleep_range(data->sleep_val * 250, data->sleep_val * 500);
>
> line over 80 chars. please use 2 lines.
>
> Also, have you run checkpatch on this? You seem to have DOS line-endlings.
>
>> +        else
>> +            msleep(20);
>>      }
>>
>>      dev_err(&data->client->dev, "data not ready\n");
>> @@ -544,6 +548,18 @@ static int mma8452_read_raw(struct iio_dev
*indio_dev,
>>      return -EINVAL;
>>  }
>>
>> +static int mma8452_calculate_sleep(struct mma8452_data *data)
>> +{
>> +    int ret, i = mma8452_get_odr_index(data);
>> +
>> +    if (mma8452_samp_freq[i][0] > 0)
>> +        ret = 1000 / mma8452_samp_freq[i][0];
>> +    else
>> +        ret = 1000;
>> +
>> +    return ret == 0 ? 1 : ret;
>> +}
>> +
>>  static int mma8452_standby(struct mma8452_data *data)
>>  {
>>      return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
>> @@ -700,6 +716,8 @@ static int mma8452_write_raw(struct iio_dev
*indio_dev,
>>          data->ctrl_reg1 &= ~MMA8452_CTRL_DR_MASK;
>>          data->ctrl_reg1 |= i << MMA8452_CTRL_DR_SHIFT;
>>
>> +        data->sleep_val = mma8452_calculate_sleep(data);
>> +
>>          ret = mma8452_change_config(data, MMA8452_CTRL_REG1,
>>                          data->ctrl_reg1);
>>          break;
>> @@ -1593,6 +1611,9 @@ static int mma8452_probe(struct i2c_client *client,
>>
>>      data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
>>                (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
>> +
>> +    data->sleep_val = mma8452_calculate_sleep(data);
>> +
>>      ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
>>                      data->ctrl_reg1);
>>      if (ret < 0)
>>
>
>
>



