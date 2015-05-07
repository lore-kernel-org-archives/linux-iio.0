Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46191 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbEGXdn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:43 -0400
Message-ID: <554BE9A5.305@kernel.org>
Date: Thu, 07 May 2015 23:39:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad7606_par: Constify platform_device_id
References: <1430495002-31057-1-git-send-email-k.kozlowski.k@gmail.com> <55450E00.6050403@metafoo.de>
In-Reply-To: <55450E00.6050403@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/15 18:48, Lars-Peter Clausen wrote:
> On 05/01/2015 05:43 PM, Krzysztof Kozlowski wrote:
>> The platform_device_id is not modified by the driver and core uses it as
>> const.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Thanks.
Applied to the togreg branch of iio.git which will be pushed out as
testing sometime soonish...

Thanks,

Jonathan
> 
>> ---
>>   drivers/staging/iio/adc/ad7606_par.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
>> index 9e24b4d4455f..1d48ae381d16 100644
>> --- a/drivers/staging/iio/adc/ad7606_par.c
>> +++ b/drivers/staging/iio/adc/ad7606_par.c
>> @@ -119,7 +119,7 @@ static const struct dev_pm_ops ad7606_pm_ops = {
>>   #define AD7606_PAR_PM_OPS NULL
>>   #endif  /* CONFIG_PM */
>>
>> -static struct platform_device_id ad7606_driver_ids[] = {
>> +static const struct platform_device_id ad7606_driver_ids[] = {
>>       {
>>           .name        = "ad7606-8",
>>           .driver_data    = ID_AD7606_8,
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

