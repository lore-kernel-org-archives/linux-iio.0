Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50995 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754881AbcKEQcS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 12:32:18 -0400
Subject: Re: [PATCH] iio: hid-sensor-attributes: Check
 sample_frequency/hysteresis write data legitimacy
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1478133948-16089-1-git-send-email-hongyan.song@intel.com>
 <1478282145.14557.14.camel@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3b9b5b27-31ee-dfb7-deef-a93e83399324@kernel.org>
Date: Sat, 5 Nov 2016 16:32:14 +0000
MIME-Version: 1.0
In-Reply-To: <1478282145.14557.14.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/11/16 17:55, Pandruvada, Srinivas wrote:
> On Thu, 2016-11-03 at 00:45 +0000, Song Hongyan wrote:
>>
>> Neither sample frequency value nor hysteresis value can be set to be
>> a
>> negative number, check and return "Invalid argument" if they are
>> negative.
>>
>> If not do this change, sample_frequency will be set into some unknown
>> value, read hysteresis value after write negative number will return
>> "Invalid argument".
>>
>> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>From the description I'm reading this as a minor issue and not a
regression (it never worked right).  As such with Linus getting
irritated about fixes for stuff that has been long broken I'm
going to take this the slow route (i.e. next merge window).

Applied to the togreg branch of iio.git. Will be initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
>>
>> ---
>>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> index dc33c1d..4509f8475 100644
>> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> @@ -201,7 +201,7 @@ int hid_sensor_write_samp_freq_value(struct
>> hid_sensor_common *st,
>>  	int ret;
>>  
>>  	if (val1 < 0 || val2 < 0)
>> -		ret = -EINVAL;
>> +		return -EINVAL;
>>  
>>  	value = val1 * pow_10(6) + val2;
>>  	if (value) {
>> @@ -250,6 +250,9 @@ int hid_sensor_write_raw_hyst_value(struct
>> hid_sensor_common *st,
>>  	s32 value;
>>  	int ret;
>>  
>> +	if (val1 < 0 || val2 < 0)
>> +		return -EINVAL;
>> +
>>  	value = convert_to_vtf_format(st->sensitivity.size,
>>  				st->sensitivity.unit_expo,
>>  				val1, val2);N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==

