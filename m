Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55674 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbaDGSFM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Apr 2014 14:05:12 -0400
Message-ID: <5342E924.9050105@kernel.org>
Date: Mon, 07 Apr 2014 19:06:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 2/6] staging:iio:adc:spear_adc drop initialization of
 unused scan_type
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-3-git-send-email-jic23@kernel.org> <53412836.1010802@gmx.de>
In-Reply-To: <53412836.1010802@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/14 11:11, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> As the driver does not support the buffered interfaces of IIO this is
>> not used.
> I trust you in this one, but I can't assess it right now with my
> limited IIO-buffer background knowledge. So, regard it as a silent
> ack, to not hold you back.>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Acked-by: Stefan Roese <sr@denx.de>
Thanks,

Applied to the togreg branch of iio.git
>> ---
>>   drivers/staging/iio/adc/spear_adc.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
>> index 49293f9..c4e928b 100644
>> --- a/drivers/staging/iio/adc/spear_adc.c
>> +++ b/drivers/staging/iio/adc/spear_adc.c
>> @@ -179,10 +179,6 @@ static int spear_read_raw(struct iio_dev *indio_dev,
>>   	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>>   	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>>   	.channel = idx,					\
>> -	.scan_type = {					\
>> -		.sign = 'u',				\
>> -		.storagebits = 16,			\
>> -	},						\
>>   }
>>
>>   static const struct iio_chan_spec spear_adc_iio_channels[] = {
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

