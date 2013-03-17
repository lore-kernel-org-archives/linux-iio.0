Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570Ab3CQWm2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Mar 2013 18:42:28 -0400
Message-ID: <51461D17.4050902@kernel.org>
Date: Sun, 17 Mar 2013 19:44:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
CC: linux-iio@vger.kernel.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: Re: [PATCH 1/2] iio:adc:exynos move to info_mask_(shared_by_type/separate)
References: <1362341033-9506-1-git-send-email-jic23@kernel.org> <1362341033-9506-2-git-send-email-jic23@kernel.org> <CAHfPSqC95ahh6O9Fk0N06gw9tQxGPKsU943KNYTXCM+vP465Eg@mail.gmail.com>
In-Reply-To: <CAHfPSqC95ahh6O9Fk0N06gw9tQxGPKsU943KNYTXCM+vP465Eg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/2013 11:44 PM, Naveen Krishna Ch wrote:
> On 4 March 2013 05:03, Jonathan Cameron <jic23@kernel.org> wrote:
>> The original info_mask is going away in favour of the broken out versions.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Thanks, Jonathan.
While thanks is always nice, I took that as counting as an Acked-by tag.
Shout if you would rather I didn't!
>> ---
>>  drivers/iio/adc/exynos_adc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
>> index ed6fdd7..6e968ae 100644
>> --- a/drivers/iio/adc/exynos_adc.c
>> +++ b/drivers/iio/adc/exynos_adc.c
>> @@ -198,7 +198,7 @@ static const struct iio_info exynos_adc_iio_info = {
>>         .indexed = 1,                                   \
>>         .channel = _index,                              \
>>         .address = _index,                              \
>> -       .info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,    \
>> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),   \
>>         .datasheet_name = _id,                          \
>>  }
>>
>> --
>> 1.8.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Shine bright,
> (: Nav :)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
