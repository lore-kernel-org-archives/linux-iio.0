Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39386 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbcJIIvq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 04:51:46 -0400
Subject: Re: [PATCH 1/4] staging: iio: isl29018: add documentation about the
 infrared suppression
To: Brian Masney <masneyb@onstation.org>
References: <1475801317-29449-1-git-send-email-masneyb@onstation.org>
 <f6c89f7b-b048-a119-c3d2-080715bb271a@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <33a941c1-84eb-395a-9193-4bf82c242634@kernel.org>
Date: Sun, 9 Oct 2016 09:51:43 +0100
MIME-Version: 1.0
In-Reply-To: <f6c89f7b-b048-a119-c3d2-080715bb271a@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/10/16 09:43, Jonathan Cameron wrote:
> On 07/10/16 01:48, Brian Masney wrote:
>> Add documentation from the ISL29018 Data Sheet (FN6619.4, Oct 8, 2012)
>> about the infrared suppression that can be controlled
>> with the proximity_on_chip_ambient_infrared_suppression sysfs attribute.
>>
>> Signed-off-by: Brian Masney <masneyb@onstation.org>
>> ---
>>  drivers/staging/iio/light/isl29018.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
>> index 51226bd..52bfb1cb 100644
>> --- a/drivers/staging/iio/light/isl29018.c
>> +++ b/drivers/staging/iio/light/isl29018.c
>> @@ -307,6 +307,24 @@ static ssize_t in_illuminance_integration_time_available_show
>>  	return len;
>>  }
>>  
>> +/*
>> + * From ISL29018 Data Sheet (FN6619.4, Oct 8, 2012) regarding the
>> + * infrared suppression:
>> + *
>> + *   Proximity Sensing Scheme: Bit 7. This bit programs the function
>> + * of the proximity detection. Logic 0 of this bit, Scheme 0, makes
>> + * full n (4, 8, 12, 16) bits (unsigned) proximity detection. The range
>> + * of Scheme 0 proximity count is from 0 to 2^n. Logic 1 of this bit,
>> + * Scheme 1, makes n-1 (3, 7, 11, 15) bits (2's complementary)
>> + * proximity_less_ambient detection. The range of Scheme 1
>> + * proximity count is from -2^(n-1) to 2^(n-1) . The sign bit is extended
>> + * for resolutions less than 16. While Scheme 0 has wider dynamic
>> + * range, Scheme 1 proximity detection is less affected by the
>> + * ambient IR noise variation.
>> + *
>> + * 0 Sensing IR from LED and ambient
>> + * 1 Sensing IR from LED with ambient IR rejection
>> + */
> Hi Brian,
> 
> This is good stuff, but the home of ABI docs (where it 'has' to be as
> opposed to here where it is nice to have) is
> Documentation/ABI/testing/sysfs-bus-iio-* (here isl29018 until we
> see if this becomes generic enough to promote to a more generic file)
> 
Forgot to say, I applied this as it is a good addition in it's own right.
Just looking for a follow up patch adding the ABI docs.

Thanks,

Jonathan
> Jonathan
>>  static ssize_t proximity_on_chip_ambient_infrared_suppression_show
>>  			(struct device *dev, struct device_attribute *attr,
>>  			 char *buf)
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

