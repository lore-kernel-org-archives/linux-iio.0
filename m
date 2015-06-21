Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43949 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbFUNjD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:39:03 -0400
Message-ID: <5586BE75.8090602@kernel.org>
Date: Sun, 21 Jun 2015 14:39:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: vlad.dogaru@intel.com, tiberiu.a.breana@intel.com, knaack.h@gmx.de,
	lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: ABI: Clarify proximity output value
References: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com> <1434037774-22081-2-git-send-email-daniel.baluta@intel.com> <alpine.DEB.2.02.1506162234100.22088@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1506162234100.22088@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/06/15 21:41, Peter Meerwald wrote:
> Hello,
> 
>> Current description for proximity measurement is ambiguous. While
>> the first part says that proximity is measured by observing
>> reflectivity, the second part incorrectly infers that reported values
>> should behave like a distance.
>>
>> This is because of AS3935 lightning sensor which uses the proximity
>> API, while not being a true proximity sensor.
> 
> Acked-by: Peter Meerwald <pmeerw@pmeerw.net>
Thanks Peter, this will stand for the record on the mailing list, but
now the patch is in a public (non testing tree) I'm not going to rebase
to add it to the patch.

Sorry about that, but 3 days too late :(

Jonathan
>  
>> Fixes:  614e8842ddf ("iio: ABI: add clarification for proximity")
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index bbed111..70c9b1a 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1234,10 +1234,8 @@ Description:
>>  		object is near the sensor, usually be observing
> 
>>  		reflectivity of infrared or ultrasound emitted.
>>  		Often these sensors are unit less and as such conversion
>> -		to SI units is not possible.  Where it is, the units should
>> -		be meters.  If such a conversion is not possible, the reported
>> -		values should behave in the same way as a distance, i.e. lower
>> -		values indicate something is closer to the sensor.
>> +		to SI units is not possible. Higher proximity measurements
>> +		indicate closer objects, and vice versa.
>>  
>>  What:		/sys/.../iio:deviceX/in_illuminance_input
>>  What:		/sys/.../iio:deviceX/in_illuminance_raw
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
