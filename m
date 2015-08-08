Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58074 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbbHHLmg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:42:36 -0400
Subject: Re: [PATCH v2] iio: Documentation: Add trigger name attribute ABI
 documentation
To: Daniel Baluta <daniel.baluta@intel.com>,
	Cristina Opriceana <cristina.opriceana@gmail.com>
References: <7d408fb8def6478565e30d01edcfc98d9cf42b48.1438859058.git.cristina.opriceana@gmail.com>
 <CAEnQRZDH3Gu_FSiSrceC3nK4SOwKj+6WCzxdc9iU9DMsZmmrTA@mail.gmail.com>
Cc: linux-api@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5EB29.8020507@kernel.org>
Date: Sat, 8 Aug 2015 12:42:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDH3Gu_FSiSrceC3nK4SOwKj+6WCzxdc9iU9DMsZmmrTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/08/15 13:00, Daniel Baluta wrote:
> On Thu, Aug 6, 2015 at 2:17 PM, Cristina Opriceana
> <cristina.opriceana@gmail.com> wrote:
>> This patch adds an entry in ABI Documentation for the name attribute
>> issued when a trigger is created.
>>
>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied.

Thanks,
> 
>> ---
>> Changes in v2:
>>  - deviceX to deviceY, to avoid confusion
>>  - clearer description
>>
>>  Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>> index 5235e6c..0c1e843 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>> @@ -9,3 +9,12 @@ Description:
>>                 automated testing or in situations, where other trigger methods
>>                 are not applicable. For example no RTC or spare GPIOs.
>>                 X is the IIO index of the trigger.
>> +
>> +What:          /sys/bus/iio/devices/triggerX/name
>> +KernelVersion: 2.6.39
>> +Contact:       linux-iio@vger.kernel.org
>> +Description:
>> +               The name attribute holds a description string for the current
>> +               trigger. In order to associate the trigger with an IIO device
>> +               one should write this name string to
>> +               /sys/bus/iio/devices/iio:deviceY/trigger/current_trigger.
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

