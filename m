Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51312 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaJRMYk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Oct 2014 08:24:40 -0400
Message-ID: <54425C06.9090404@kernel.org>
Date: Sat, 18 Oct 2014 13:24:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: add ABI documentation for scaled pressure
References: <1413208420-12226-1-git-send-email-vlad.dogaru@intel.com> <CAEnQRZCo_sMp+ySPBfsD+vTpcCyfK2JEqvnbnxuDrNqBy7io8w@mail.gmail.com>
In-Reply-To: <CAEnQRZCo_sMp+ySPBfsD+vTpcCyfK2JEqvnbnxuDrNqBy7io8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/10/14 10:35, Daniel Baluta wrote:
> On Mon, Oct 13, 2014 at 4:53 PM, Vlad Dogaru <vlad.dogaru@intel.com> wrote:
>> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git

Thanks,
> 
>> ---
>> Since v1: also mention channel Y, for uniformity with the description of
>> the raw channel above.
>>
>>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index d760b02..d3d67b6 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -200,6 +200,13 @@ Description:
>>                 Raw pressure measurement from channel Y. Units after
>>                 application of scale and offset are kilopascal.
>>
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_pressureY_input
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_pressure_input
>> +KernelVersion: 3.8
>> +Contact:       linux-iio@vger.kernel.org
>> +Description:
>> +               Scaled pressure measurement from channel Y, in kilopascal.
>> +
>>  What:          /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
>>  KernelVersion: 3.14
>>  Contact:       linux-iio@vger.kernel.org
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
