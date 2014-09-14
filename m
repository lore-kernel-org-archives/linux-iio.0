Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56426 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbaINTZ1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 15:25:27 -0400
Message-ID: <5415EBA5.4090901@kernel.org>
Date: Sun, 14 Sep 2014 20:25:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH v2 08/11] iio:bma180: Introduce part-specific _config()
 and disable() code
References: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net> <1408488206-2633-9-git-send-email-pmeerw@pmeerw.net> <5415EA84.6050005@kernel.org>
In-Reply-To: <5415EA84.6050005@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/09/14 20:20, Jonathan Cameron wrote:
> On 19/08/14 23:43, Peter Meerwald wrote:
>> move part of bma180_init() to bma180_config() (split initialization and
>> configuration code); configuration is heavily chip-specific
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> applied
Actually - minor fixlet in here as well.
>> ---
>>  drivers/iio/accel/bma180.c | 31 +++++++++++++++++++++----------
>>  1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
>> index fc7c7b8..a25b060 100644
>> --- a/drivers/iio/accel/bma180.c
>> +++ b/drivers/iio/accel/bma180.c
>> @@ -37,6 +37,8 @@ struct bma180_part_info {
>>  	unsigned num_scales;
>>  	const int *bw_table;
>>  	unsigned num_bw;
>> +	int (*chip_config)(struct bma180_data *data);
>> +	void (*chip_disable)(struct bma180_data *data);
struct bma180_data hasn't been defined yet.  I've added a forward definition above this
to fix that up rather that reordering the rest of the file.

Jonathan
>>  };
>>  
>>  /* Register set */
>> @@ -279,21 +281,28 @@ static int bma180_chip_init(struct bma180_data *data)
>>  	int ret = i2c_smbus_read_byte_data(data->client, BMA180_CHIP_ID);
>>  
>>  	if (ret < 0)
>> -		goto err;
>> -	if (ret != BMA180_ID_REG_VAL) {
>> -		ret = -ENODEV;
>> -		goto err;
>> -	}
>> +		return ret;
>> +	if (ret != BMA180_ID_REG_VAL)
>> +		return -ENODEV;
>>  
>>  	ret = bma180_soft_reset(data);
>>  	if (ret)
>> -		goto err;
>> +		return ret;
>>  	/*
>>  	 * No serial transaction should occur within minimum 10 us
>>  	 * after soft_reset command
>>  	 */
>>  	msleep(20);
>>  
>> +	return 0;
>> +}
>> +
>> +static int bma180_chip_config(struct bma180_data *data)
>> +{
>> +	int ret = bma180_chip_init(data);
>> +
>> +	if (ret)
>> +		goto err;
>>  	ret = bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_DIS_WAKE_UP, 1);
>>  	if (ret)
>>  		goto err;
>> @@ -319,7 +328,7 @@ static int bma180_chip_init(struct bma180_data *data)
>>  	return 0;
>>  
>>  err:
>> -	dev_err(&data->client->dev, "failed to init the chip\n");
>> +	dev_err(&data->client->dev, "failed to config the chip\n");
>>  	return ret;
>>  }
>>  
>> @@ -507,6 +516,8 @@ static const struct bma180_part_info bma180_part_info[] = {
>>  		bma180_channels, ARRAY_SIZE(bma180_channels),
>>  		bma180_scale_table, ARRAY_SIZE(bma180_scale_table),
>>  		bma180_bw_table, ARRAY_SIZE(bma180_bw_table),
>> +		bma180_chip_config,
>> +		bma180_chip_disable,
>>  	},
>>  };
>>  
>> @@ -578,7 +589,7 @@ static int bma180_probe(struct i2c_client *client,
>>  	data->client = client;
>>  	data->part_info = &bma180_part_info[id->driver_data];
>>  
>> -	ret = bma180_chip_init(data);
>> +	ret = data->part_info->chip_config(data);
>>  	if (ret < 0)
>>  		goto err_chip_disable;
>>  
>> @@ -640,7 +651,7 @@ err_trigger_unregister:
>>  err_trigger_free:
>>  	iio_trigger_free(data->trig);
>>  err_chip_disable:
>> -	bma180_chip_disable(data);
>> +	data->part_info->chip_disable(data);
>>  
>>  	return ret;
>>  }
>> @@ -658,7 +669,7 @@ static int bma180_remove(struct i2c_client *client)
>>  	}
>>  
>>  	mutex_lock(&data->mutex);
>> -	bma180_chip_disable(data);
>> +	data->part_info->chip_disable(data);
>>  	mutex_unlock(&data->mutex);
>>  
>>  	return 0;
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
