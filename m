Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33299 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286AbcCKP0z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2016 10:26:55 -0500
Received: by mail-wm0-f53.google.com with SMTP id l68so22584935wml.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2016 07:26:54 -0800 (PST)
Subject: Re: [PATCH-vs-togreg 1/2] iio: ina2xx-adc: update the CALIB. register
 when RShunt changes
To: "Andrew F. Davis" <afd@ti.com>, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1457707950-17593-1-git-send-email-marc.titinger@baylibre.com>
 <56E2DE7E.5090905@ti.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <56E2E3BC.6090405@baylibre.com>
Date: Fri, 11 Mar 2016 16:26:52 +0100
MIME-Version: 1.0
In-Reply-To: <56E2DE7E.5090905@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 11/03/2016 16:04, Andrew F. Davis wrote:
...

>>
>> @@ -599,6 +621,8 @@ static const struct iio_info ina2xx_info = {
>>   	.debugfs_reg_access = ina2xx_debug_reg,
>>   };
>>
>> +
>> +
>
> ?
>

Ok, will fix in v2, thanks !

M.

>>   /* Initialize the configuration and calibration registers. */
>>   static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
>>   {
>> @@ -609,17 +633,7 @@ static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
>>   	if (ret)
>>   		return ret;
>>
>> -	/*
>> -	 * Set current LSB to 1mA, shunt is in uOhms
>> -	 * (equation 13 in datasheet). We hardcode a Current_LSB
>> -	 * of 1.0 x10-6. The only remaining parameter is RShunt.
>> -	 * There is no need to expose the CALIBRATION register
>> -	 * to the user for now.
>> -	 */
>> -	regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
>> -				   chip->shunt_resistor);
>> -
>> -	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
>> +	return ina2xx_set_calibration(chip);
>>   }
>>
>>   static int ina2xx_probe(struct i2c_client *client,
>>
