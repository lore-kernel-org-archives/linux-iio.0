Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41005 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaBHLkW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 06:40:22 -0500
Message-ID: <52F617C4.2010303@kernel.org>
Date: Sat, 08 Feb 2014 11:40:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: Kravchenko Oleksandr <x0199363@ti.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] iio:accel:bma180: Make LOW_PASS_FILTER_3DB_FREQUENCY
 shared_by_type
References: <1389389841-7389-1-git-send-email-pmeerw@pmeerw.net> <1389389841-7389-2-git-send-email-pmeerw@pmeerw.net> <52D12E83.9080807@kernel.org>
In-Reply-To: <52D12E83.9080807@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/14 11:44, Jonathan Cameron wrote:
>
>
> On 10/01/14 21:37, Peter Meerwald wrote:
>> the property is not per-channel, but shared by type
>>
> Now this one is in a sense even more interesting.
>
> 1) Your fix is correct.
> 2) Other than poluting sysfs with extra attributes and setting a bad
>     example, it doesn't actually matter as any attribute is defined
>     as being able to effect any other. e.g. if we had two different
>     filters, one for the z axis and another effecting both x and y
>     we would have to define all 3 as separate.
> 3) In theory correctly written generic userspace code should not care
>     as it should handle both cases without a user being any the wiser.
>     Hence this should fall into the category of being able to change
>     userspace ABI if no one notices...
>
> So what shall we do?
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> Cc: Kravchenko Oleksandr <x0199363@ti.com>
Peter, I'm not going to put this one through as a fix as the current interface
is fine, if messy.  Given it's dependency on patch 1 of this series, I'll  wait
for that to propogate through. Could you remind me to apply this if I forget!
>> ---
>>   drivers/iio/accel/bma180.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
>> index bfec313..a7e68c8 100644
>> --- a/drivers/iio/accel/bma180.c
>> +++ b/drivers/iio/accel/bma180.c
>> @@ -451,9 +451,9 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
>>       .type = IIO_ACCEL,                        \
>>       .modified = 1,                            \
>>       .channel2 = IIO_MOD_##_axis,                    \
>> -    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |            \
>> +    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),            \
>> +    .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |        \
>>           BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),    \
>> -    .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),        \
>>       .scan_index = AXIS_##_axis,                    \
>>       .scan_type = {                            \
>>           .sign = 's',                        \
>>
