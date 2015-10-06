Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:45940 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbJFXTN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2015 19:19:13 -0400
Message-ID: <561456ED.5010108@denx.de>
Date: Wed, 07 Oct 2015 01:19:09 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	=?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elpromaelectronics.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: mxs-lradc: Fix temperature offset
References: <1444141347-15301-1-git-send-email-alexandre.belloni@free-electrons.com> <415576093.114803.1444157033983.JavaMail.open-xchange@oxbaltgw07.schlund.de>
In-Reply-To: <415576093.114803.1444157033983.JavaMail.open-xchange@oxbaltgw07.schlund.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/06/2015 20:43, Stefan Wahren wrote:
> Hi,
>
>> Alexandre Belloni <alexandre.belloni@free-electrons.com> hat am 6. Oktober
>> 2015 um 16:22 geschrieben:
>>
>>
>> 0° Kelvin is actually −273.15°C, not -272.15°C. Fix the temperature offset.
>>
>> Reported-by: Janusz Użycki <j.uzycki@elpromaelectronics.com>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> ---
>> drivers/staging/iio/adc/mxs-lradc.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>> b/drivers/staging/iio/adc/mxs-lradc.c
>> index 3f7715c9968b..67bfa54c4fb1 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -916,10 +916,10 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>> if (chan->type == IIO_TEMP) {
>> /* The calculated value from the ADC is in Kelvin, we
>> * want Celsius for hwmon so the offset is
>> - * -272.15 * scale
>> + * -273.15 * scale
>> */
>> - *val = -1075;
>> - *val2 = 691699;
>> + *val = -1079;
>> + *val2 = 644268;
>>
>
> i think it would be nice to break down the calculation of these magic values in
> a second patch.

Indeed, I agree. I hope Alexandre can send another patch for that soon :-)

> Regards
> Stefan
>

