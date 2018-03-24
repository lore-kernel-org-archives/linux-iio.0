Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37296 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeCXMgr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Mar 2018 08:36:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id r131so1071001wmb.2
        for <linux-iio@vger.kernel.org>; Sat, 24 Mar 2018 05:36:46 -0700 (PDT)
References: <cover.1521379685.git.davidjulianveenstra@gmail.com> <73912d42bd2718325313ec792f8402a20f47405c.1521379685.git.davidjulianveenstra@gmail.com> <20180323142748.00005fec@huawei.com>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lars@metafoo.de, jic23@kernel.org, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 10/11] staging: iio: ad2s1200: Replace angle channel with inclination channel
In-reply-to: <20180323142748.00005fec@huawei.com>
Date: Sat, 24 Mar 2018 13:36:44 +0100
Message-ID: <87bmfdmyzn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23, March 2018 14:27, Jonathan Cameron wrote:

> On Sun, 18 Mar 2018 14:37:04 +0100
> David Veenstra <davidjulianveenstra@gmail.com> wrote:
>
>> The angle channel is not defined in sysfs iio ABI. So it is replaced
>> with an inclination channel, because it is defined in the ABI, and has the
>> semantics of an angle.
>> 
>> In addition, a fractional scaling factor of 360 / (2^12 -1) is added,
>> to scale the 12-bits angular position to degrees, conform the ABI.
>> 
>> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
> No, please do not blugeon a device into the existing documented ABI.
>
> A resolver does not measure something that can be remotely
> sensibly mapped to inclination.  Inclination is relative to 'down'.
> A resolver doesn't care about down.
>
> Add an angle type to the ABI docs. It simply hasn't been documented
> before because there were no drivers outside staging that use it.

I'm sorry, I misunderstood our previous discussing on this topic
(https://marc.info/?l=linux-iio&m=152087432322446&w=2) as saying:
"there already exists another channel type that is a good enough match".

The in_incli and in_rot_from_* family all use degrees as their unit.
For V2 I'll change it back to an angle channel and use angle as its
unit.

Best regards,
David Veenstra

>
> Jonathan
>
>> ---
>>  drivers/staging/iio/resolver/ad2s1200.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
>> index 4b97a106012c..937676bcc0d4 100644
>> --- a/drivers/staging/iio/resolver/ad2s1200.c
>> +++ b/drivers/staging/iio/resolver/ad2s1200.c
>> @@ -64,6 +64,10 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>>  	switch (m) {
>>  	case IIO_CHAN_INFO_SCALE:
>>  		switch (chan->type) {
>> +		case IIO_INCLI:
>> +			*val = 360;
>> +			*val2 = 0xFFF;
>> +			return IIO_VAL_FRACTIONAL;
>>  		case IIO_ANGL_VEL:
>>  			/*
>>  			 * 2 * Pi is almost equal to
>> @@ -91,7 +95,7 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>>  		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
>>  		udelay(1);
>>  		gpiod_set_value(st->sample, 1);
>> -		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
>> +		gpiod_set_value(st->rdvel, !!(chan->type == IIO_INCLI));
>>  
>>  		ret = spi_read(st->sdev, st->rx, 2);
>>  		if (ret < 0) {
>> @@ -101,7 +105,7 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>>  
>>  		vel = be16_to_cpup((__be16 *)st->rx);
>>  		switch (chan->type) {
>> -		case IIO_ANGL:
>> +		case IIO_INCLI:
>>  			*val = vel >> 4;
>>  			ret = IIO_VAL_INT;
>>  			break;
>> @@ -128,10 +132,11 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>>  
>>  static const struct iio_chan_spec ad2s1200_channels[] = {
>>  	{
>> -		.type = IIO_ANGL,
>> +		.type = IIO_INCLI,
>>  		.indexed = 1,
>>  		.channel = 0,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>>  	}, {
>>  		.type = IIO_ANGL_VEL,
>>  		.indexed = 1,

