Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43543 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbaKEQBO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 11:01:14 -0500
Message-ID: <545A49C7.9030704@kernel.org>
Date: Wed, 05 Nov 2014 16:01:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>
CC: opw-kernel <opw-kernel@googlegroups.com>, linux-iio@vger.kernel.org
Subject: Re: [OPW kernel] [PATCH] iio: Add ABI documentation for scaled voltage
References: <1414261101-15590-1-git-send-email-darshanapadmadas@gmail.com> <CAEnQRZDicaPjxx-_VOXAWzgkoD1qTBUOpyapdkR3eKUcz0BKzg@mail.gmail.com>
In-Reply-To: <CAEnQRZDicaPjxx-_VOXAWzgkoD1qTBUOpyapdkR3eKUcz0BKzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/10/14 14:56, Daniel Baluta wrote:
> On Sat, Oct 25, 2014 at 9:18 PM, Darshana Padmadas
> <darshanapadmadas@gmail.com> wrote:
>> This patch adds an entry in ABI documentation for in_voltage-voltage_scale.
>> It has at least one user driver, adis16220, in accel driver.
>>
>> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index d760b02..0640118 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -251,6 +251,7 @@ Description:
>>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
>>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
>>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltage_scale
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
>>  What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
>>  What:          /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
>>  What:          /sys/bus/iio/devices/iio:deviceX/in_accel_scale
>> --
> 
> Looks good to me. Adding Jonathan and linux-iio for comments.
Looks good - can I get a direct copy for easy applying please?

Thanks,

Jonathan
