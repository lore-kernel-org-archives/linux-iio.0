Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47056 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbcFZOEW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 10:04:22 -0400
Subject: Re: [PATCH 1/6 v2] iio: magn: ak8975: fix regulator usage
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1466759516-20586-1-git-send-email-linus.walleij@linaro.org>
 <1466759516-20586-2-git-send-email-linus.walleij@linaro.org>
 <15061ebe-0401-fb55-73a5-a95e74225d02@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Mark Brown <broonie@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <21204448-2cb6-3a67-1877-095d8f5d2b2d@kernel.org>
Date: Sun, 26 Jun 2016 15:04:19 +0100
MIME-Version: 1.0
In-Reply-To: <15061ebe-0401-fb55-73a5-a95e74225d02@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/06/16 15:01, Jonathan Cameron wrote:
> On 24/06/16 10:11, Linus Walleij wrote:
>> IS_ERR_OR_NULL() should never be used with regulators because
>> a NULL pointer may be a perfectly valid dummy regulator
>>
>> We should always succeed to fetch and enable a regulator, but
>> it may be a dummy. That is fine, so bail out for any real
>> errors or probe deferrals
>>
>> Include the error code in the warning print so we know what
>> kind of problem we're dealing with (for example it is nice to
>> see if it is a probe deferral).
>>
>> As we will bail out of probe if the regulator is erroneous,
>> just issue regulator_disable() on the poweroff path: it will
>> succeed.
>>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Lars-Peter Clausen Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Umm. Linus - something went wrong here... See below...
Pah, I decided the fixup was obvious and have applied this to the
togreg branch of iio.git.  Usual pushed out as testing etc etc.

Jonathan
>> ---
>> ChangeLog v1->v2:
>> - No changes
>> ---
>>  drivers/iio/magnetometer/ak8975.c | 22 ++--------------------
>>  1 file changed, 2 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
>> index e0e43f497f40..05e9d5041e7a 100644
>> --- a/drivers/iio/magnetometer/ak8975.c
>> +++ b/drivers/iio/magnetometer/ak8975.c
>> @@ -390,10 +390,8 @@ static int ak8975_power_on(struct i2c_client *client)
>>  	int ret;
>>  
>>  	data->vdd = devm_regulator_get(&client->dev, "vdd");
>> -	if (IS_ERR_OR_NULL(data->vdd)) {
>> +	if (IS_ERR(data->vdd)) {
>>  		ret = PTR_ERR(data->vdd);
>> -		if (ret == -ENODEV)
>> -			ret = 0;
>>  	} else {
>>  		ret = regulator_enable(data->vdd);
>>  	}
>> @@ -402,21 +400,6 @@ static int ak8975_power_on(struct i2c_client *client)
>>  			 "Failed to enable specified Vdd supply\n");
>>  		return ret;
>>  	}
> 
> Where did the next block come from?  You introduce one of these in
> the following patch, but there isn't one currently in the driver.
>> -
>> -	data->vid = devm_regulator_get(&client->dev, "vid");
>> -	if (IS_ERR_OR_NULL(data->vid)) {
>> -		ret = PTR_ERR(data->vdd);
>> -		if (ret == -ENODEV)
>> -			ret = 0;
>> -	} else {
>> -		ret = regulator_enable(data->vdd);
>> -	}
>> -	if (ret) {
>> -		dev_warn(&client->dev,
>> -			 "Failed to enable specified Vid supply\n");
>> -		return ret;
>> -	}
>> -	return 0;
>>  }
>>  
>>  /* Disable attached power regulator if any. */
>> @@ -425,8 +408,7 @@ static void ak8975_power_off(const struct i2c_client *client)
>>  	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>  	const struct ak8975_data *data = iio_priv(indio_dev);
>>  
>> -	if (!IS_ERR_OR_NULL(data->vdd))
>> -		regulator_disable(data->vdd);
>> +	regulator_disable(data->vdd);
>>  }
>>  
>>  /*
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

