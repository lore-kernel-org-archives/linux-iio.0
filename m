Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44610 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbaLZLDv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 06:03:51 -0500
Message-ID: <549D4095.3090901@kernel.org>
Date: Fri, 26 Dec 2014 11:03:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ABI: add clarification for proximity
References: <1418656489-13190-1-git-send-email-vlad.dogaru@intel.com> <54934CF8.1090809@gmx.de>
In-Reply-To: <54934CF8.1090809@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/12/14 21:54, Hartmut Knaack wrote:
> Vlad Dogaru schrieb am 15.12.2014 um 16:14:
>> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git - thanks.
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index df5e69e..831db86 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1068,7 +1068,9 @@ Description:
>>  		reflectivity of infrared or ultrasound emitted.
>>  		Often these sensors are unit less and as such conversion
>>  		to SI units is not possible.  Where it is, the units should
>> -		be meters.
>> +		be meters.  If such a conversion is not possible, the reported
>> +		values should behave in the same way as a distance, i.e. lower
>> +		values indicate something is closer to the sensor.
>>  
>>  What:		/sys/.../iio:deviceX/in_illuminanceY_input
>>  What:		/sys/.../iio:deviceX/in_illuminanceY_raw
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

