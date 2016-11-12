Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35837 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965364AbcKLQ2c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 11:28:32 -0500
Subject: Re: [PATCH v3 03/28] staging: iio: tsl2583: check if chip is
 suspended in in_illuminance_calibrate_store
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
 <1478769964-7065-4-git-send-email-masneyb@onstation.org>
 <36ad2571-c49d-09ca-fbc7-23a13fa15056@kernel.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b30b4883-07ff-b2aa-7034-e9713e1dfca2@kernel.org>
Date: Sat, 12 Nov 2016 16:27:32 +0000
MIME-Version: 1.0
In-Reply-To: <36ad2571-c49d-09ca-fbc7-23a13fa15056@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 16:24, Jonathan Cameron wrote:
> On 10/11/16 09:25, Brian Masney wrote:
>> in_illuminance_calibrate_store() did not check to see if the chip is
>> suspended. This patch adds the proper check. The return value from
>> taos_als_calibrate() was also not checked in this function, so the
>> proper check was also added while changes are being made here.
>>
>> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Applied.
And backed out. It doesn't build :(

drivers/staging/iio/light/tsl2583.c:511:10: error: ‘struct tsl2583_chip’ has no member named ‘suspended’
  if (chip->suspended) {
          ^~

>> ---
>>  drivers/staging/iio/light/tsl2583.c | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
>> index 1a7be12..eb59ea0 100644
>> --- a/drivers/staging/iio/light/tsl2583.c
>> +++ b/drivers/staging/iio/light/tsl2583.c
>> @@ -501,16 +501,27 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
>>  {
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
>> -	int value;
>> +	int value, ret;
>>  
>>  	if (kstrtoint(buf, 0, &value) || value != 1)
>>  		return -EINVAL;
>>  
>>  	mutex_lock(&chip->als_mutex);
>> -	taos_als_calibrate(indio_dev);
>> +
>> +	if (chip->suspended) {
>> +		ret = -EBUSY;
>> +		goto done;
>> +	}
>> +
>> +	ret = taos_als_calibrate(indio_dev);
>> +	if (ret < 0)
>> +		goto done;
>> +
>> +	ret = len;
>> +done:
>>  	mutex_unlock(&chip->als_mutex);
>>  
>> -	return len;
>> +	return ret;
>>  }
>>  
>>  static ssize_t in_illuminance_lux_table_show(struct device *dev,
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

