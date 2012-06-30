Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47689 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab2F3Ior (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2012 04:44:47 -0400
Message-ID: <4FEEBC7C.4080804@kernel.org>
Date: Sat, 30 Jun 2012 09:44:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/8] staging:iio:accel:adis16204 fix bug in channel modifier
 handling
References: <1338406866-3833-1-git-send-email-jic23@kernel.org> <1338406866-3833-6-git-send-email-jic23@kernel.org> <544AC56F16B56944AEC3BD4E3D59177150C0FE65C5@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177150C0FE65C5@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/01/2012 10:23 AM, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2012-05-30:
>> Will result in the correct scale value for the x axis.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/accel/adis16204_core.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/staging/iio/accel/adis16204_core.c
>> b/drivers/staging/iio/accel/adis16204_core.c index 5c02bc6..a36135d
>> 100644 --- a/drivers/staging/iio/accel/adis16204_core.c +++
>> b/drivers/staging/iio/accel/adis16204_core.c @@ -362,7 +362,7 @@ static
>> int adis16204_read_raw(struct iio_dev *indio_dev,
>>                       return IIO_VAL_INT_PLUS_MICRO;
>>               case IIO_ACCEL:
>>                       *val = 0;
>> -                     if (chan->channel == 'x')
>> +                     if (chan->channel2 == IIO_CHAN_MOD_X)
Should be IIO_MOD_X oops.  Was wiped out in the next patch.
Picked up doing some final compile tests on this set.

>>                               *val2 = 17125;
>>                       else
>>                               *val2 = 8407;
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


