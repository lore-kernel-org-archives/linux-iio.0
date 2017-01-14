Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:36398 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdANSJm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Jan 2017 13:09:42 -0500
Subject: Re: [PATCH 3/3] iio: adc: ti-ads7950: Change regulator matching
 string to "vref"
To: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <1484157171-15571-1-git-send-email-david@lechnology.com>
 <1484157171-15571-4-git-send-email-david@lechnology.com>
 <47d15fe8-85c5-6e1c-cd89-71398ad79def@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
From: David Lechner <david@lechnology.com>
Message-ID: <e17acc8c-01b9-284c-a321-5135de80c2b7@lechnology.com>
Date: Sat, 14 Jan 2017 12:09:33 -0600
MIME-Version: 1.0
In-Reply-To: <47d15fe8-85c5-6e1c-cd89-71398ad79def@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/14/2017 06:52 AM, Jonathan Cameron wrote:
> On 11/01/17 17:52, David Lechner wrote:
>> This changes the reference voltage regulator matching string from "refin"
>> to "vref". This is to be consistent with other A/DC chips that also use
>> "vref-supply" in their device tree bindings.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>  drivers/iio/adc/ti-ads7950.c | 6 +++---
> Again, we missed this before and it would have been nice to have
> had it as vref (which is matches the datasheet).  The question
> becomes how do we handle this going forward with no risk of breaking
> existing device trees.  We may have to do an optional get on one
> name and then a non optional on the second. It's ugly, but
> would fix this up in a 'safe' way.
>

Again, I don't think it is too late since this driver only exists in the 
iio/testing branch.

> Jonathan
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
>> index b587fa6..16a0663 100644
>> --- a/drivers/iio/adc/ti-ads7950.c
>> +++ b/drivers/iio/adc/ti-ads7950.c
>> @@ -411,15 +411,15 @@ static int ti_ads7950_probe(struct spi_device *spi)
>>  	spi_message_init_with_transfers(&st->scan_single_msg,
>>  					st->scan_single_xfer, 3);
>>
>> -	st->reg = devm_regulator_get(&spi->dev, "refin");
>> +	st->reg = devm_regulator_get(&spi->dev, "vref");
>>  	if (IS_ERR(st->reg)) {
>> -		dev_err(&spi->dev, "Failed get get regulator \"refin\"\n");
>> +		dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
>>  		return PTR_ERR(st->reg);
>>  	}
>>
>>  	ret = regulator_enable(st->reg);
>>  	if (ret) {
>> -		dev_err(&spi->dev, "Failed to enable regulator \"refin\"\n");
>> +		dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
>>  		return ret;
>>  	}
>>
>>
>

