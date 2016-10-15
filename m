Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48741 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbcJOPNy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 11:13:54 -0400
Subject: Re: [PATCH v2 7/8] staging: iio: isl29018: add ABI documentation for
 infrared suppression
To: Brian Masney <masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
 <1476084002-29683-8-git-send-email-masneyb@onstation.org>
 <f3f7db73-4eb4-3b40-d059-cf745b817321@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fd8556d6-466c-402f-9502-dd234cb1f448@kernel.org>
Date: Sat, 15 Oct 2016 16:13:52 +0100
MIME-Version: 1.0
In-Reply-To: <f3f7db73-4eb4-3b40-d059-cf745b817321@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 21:57, Jonathan Cameron wrote:
> On 10/10/16 08:20, Brian Masney wrote:
>> Add ABI documentation from the ISL29018 Data Sheet (FN6619.4, Oct 8,
>> 2012) about the infrared suppression that can be controlled
>> with the proximity_on_chip_ambient_infrared_suppression sysfs attribute.
>>
>> Signed-off-by: Brian Masney <masneyb@onstation.org>
> I'm going to let this and the final move out of staging sit on the
> list a while longer to gather reviews.
Meh. Long enough ;)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore it.

Thanks,

Jonathan
> 
> It does feel like the below is rather cryptic and it might be possible
> to use a simpler description...  Maybe this is the best we can do.
> The naming makes it sound generic, but in reality it's a nasty bit
> of custom filtering that is not well described anywhere.
> 
> Jonathan
>> ---
>>  .../ABI/testing/sysfs-bus-iio-light-isl29018          | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-isl29018
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-isl29018 b/Documentation/ABI/testing/sysfs-bus-iio-light-isl29018
>> new file mode 100644
>> index 0000000..f0ce0a0
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-isl29018
>> @@ -0,0 +1,19 @@
>> +What:		/sys/bus/iio/devices/iio:deviceX/proximity_on_chip_ambient_infrared_suppression
>> +Date:		January 2011
>> +KernelVersion:	2.6.37
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		From ISL29018 Data Sheet (FN6619.4, Oct 8, 2012) regarding the
>> +		infrared suppression:
>> +
>> +		Scheme 0, makes full n (4, 8, 12, 16) bits (unsigned) proximity
>> +		detection. The range of Scheme 0 proximity count is from 0 to
>> +		2^n. Logic 1 of this bit, Scheme 1, makes n-1 (3, 7, 11, 15)
>> +		bits (2's complementary) proximity_less_ambient detection. The
>> +		range of Scheme 1 proximity count is from -2^(n-1) to 2^(n-1).
>> +		The sign bit is extended for resolutions less than 16. While
>> +		Scheme 0 has wider dynamic range, Scheme 1 proximity detection
>> +		is less affected by the ambient IR noise variation.
>> +
>> +		0 Sensing IR from LED and ambient
>> +		1 Sensing IR from LED with ambient IR rejection
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

