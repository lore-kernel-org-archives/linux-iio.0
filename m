Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49366 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932573AbcI0USE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2016 16:18:04 -0400
Subject: Re: [PATCH] drivers: iio: chemical: Fix sparse endianness warnings
 cast to restricted __be16
To: Lars-Peter Clausen <lars@metafoo.de>,
        Sandhya Bankar <bankarsandhya512@gmail.com>, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <20160924191621.GA18812@localhost.localdomain>
 <94d2f599-4773-5161-b176-ebbcaa44ec61@metafoo.de>
Cc: outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <10ce32ce-e0c3-ef18-a6ac-1f06eb390bd0@kernel.org>
Date: Tue, 27 Sep 2016 21:18:00 +0100
MIME-Version: 1.0
In-Reply-To: <94d2f599-4773-5161-b176-ebbcaa44ec61@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/16 16:04, Lars-Peter Clausen wrote:
> On 09/24/2016 09:16 PM, Sandhya Bankar wrote:
>> Fix the following sparse endianness warnings:
>>
>> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
>> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
>> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
>> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
>> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
>> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
>> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
>> drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
> 
> Hi,
> 
> Thanks for patches, this is all good work, thanks for doing it.
> 
> When it comes to patches like these that address issue found by code
> checkers it is useful to distinguish between whether the patch is
> 
> a) cosmetic. Meaning the code is currently correct and the behavior of the
> code will not change with the patch applied. But having the correct
> annotations will give us additional confidence that the code is correct and
> also help catch future mistakes.
> 
> b) a bug fix. Meaning the current code is not correct and the patch alters
> the behavior of the code to address it.
> 
> The distinction between the two cases should be noted in the commit message
> as it allows maintainers to decide how the patch should be handled. E.g. if
> the patch is cosmetic it will take the normal route of new patch, while if
> the patch is a bug fix it will get priority and also should be applied to
> stable trees.
> 
> E.g. this patch is a bug fix. val is a unsigned int which is a 32-bit
> variable, of which the pointer is taken and then treated as a 16-bit storage
> location by regmap_bulk_read(). This means that result is that the data is
> stored in the upper two bytes of the variable.
> 
> Now val is passed to be16_to_cpu() which expects a 16-bit variable as its
> parameter, so the 32-bit val variable is cast to a 16-bit value. Now here is
> where the behavior is different on a big-endian and a little-endian
> architecture. On a little-endian architecture the upper two bytes represent
> the 16-bit value, so all is good since that's where the data was stored. On
> a big-endian architecture the lower two bytes represent the 16-bit value.
> The lower two bytes of val have never been initialized though, so the result
> is that random data being passed to be16_to_cpu() and not the data that was
> read by regmap_bulk_read().
> 
> This means this code does not work correctly on a big-endian architecture,
> the patch message should ideally mention this and that the patch addresses
> the issue.
> 
> Some of the other patches you send were cosmetic only since the variable
> already had the correct storage size and the behavior of the code was the
> same on BE and LE systems. Ideally the commit message for those kind of
> patches would also mention this.
> 
> - Lars
Thanks Lars, I'd missed this entirely.

Now dropped from togreg and applied to fixes-togreg + marked for stable.
I've supplemented the commit message with a very short form of Lars'
analysis of the bug and a fixes tag for the patch that introduced
this.

Marked for stable.

Thanks,

Jonathan
> 
>>
>> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
>> ---
>>  drivers/iio/chemical/atlas-ph-sensor.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
>> index 407f141..a3fbdb7 100644
>> --- a/drivers/iio/chemical/atlas-ph-sensor.c
>> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
>> @@ -207,13 +207,14 @@ static int atlas_check_ec_calibration(struct atlas_data *data)
>>  	struct device *dev = &data->client->dev;
>>  	int ret;
>>  	unsigned int val;
>> +	__be16	rval;
>>  
>> -	ret = regmap_bulk_read(data->regmap, ATLAS_REG_EC_PROBE, &val, 2);
>> +	ret = regmap_bulk_read(data->regmap, ATLAS_REG_EC_PROBE, &rval, 2);
>>  	if (ret)
>>  		return ret;
>>  
>> -	dev_info(dev, "probe set to K = %d.%.2d", be16_to_cpu(val) / 100,
>> -						 be16_to_cpu(val) % 100);
>> +	val = be16_to_cpu(rval);
>> +	dev_info(dev, "probe set to K = %d.%.2d", val / 100, val % 100);
>>  
>>  	ret = regmap_read(data->regmap, ATLAS_REG_EC_CALIB_STATUS, &val);
>>  	if (ret)
>>
> 

