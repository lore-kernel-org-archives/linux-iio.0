Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:45734 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757132Ab3GLHWV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2013 03:22:21 -0400
Message-ID: <51DFAE85.9060508@ahsoftware.de>
Date: Fri, 12 Jul 2013 09:21:41 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 0/4] iio: hid-sensor: add module alias for autoload
References: <1373445120-5407-1-git-send-email-holler@ahsoftware.de> <51DD7D78.2020506@linux.intel.com> <51DD848E.4050206@ahsoftware.de> <51DEEAFE.506@linux.intel.com>
In-Reply-To: <51DEEAFE.506@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 11.07.2013 19:27, schrieb Srinivas Pandruvada:
>
>
> On 07/10/2013 08:58 AM, Alexander Holler wrote:
>> Am 10.07.2013 17:27, schrieb Srinivas Pandruvada:
>>> Hi,
>>>
>>> There was no intention to prevent auto loading. Did you get chance to
>>> test these changes?
>>
>> Sure, I always test patches before I send them out.
>>
>> Ok, I haven't tested the changes with the iio HID drivers (I don't
>> have any commercial HID sensor hub, so I've just compile tested these
>> patches here, double reading them), but I've tested the similiar
>> changes with a patch for rtc-hid-sensor-time I've send out yesterday.
>> (sorry, no link, lkml.org seems dead, just search for
>> "rtc-hid-sensor-time: add module alias")
>>
>> It works just fine. An example output is now
>>
>> Jul  9 19:27:21 dockstar3 kernel: [    5.124444] rtc_hid_sensor_time
>> HID-SENSOR-2000a0.0: milliseconds supported
>> Jul  9 19:27:21 dockstar3 kernel: [    5.132864] rtc_hid_sensor_time
>> HID-SENSOR-2000a0.0: rtc core: setting system clock to 2013-07-09
>> 17:26:51:328000 UTC (1373390811)
>> Jul  9 19:27:21 dockstar3 kernel: [    5.146105] rtc_hid_sensor_time
>> HID-SENSOR-2000a0.0: rtc core: registered hid-sensor-time as rtc0
>>
>> Before the output was e.g.
>>
>> HID-SENSOR-2000a0 HID-SENSOR-2000a0.0: rtc core: registered
>> hid-sensor-time as rtc0
>>
>> instead of the above with the descriptive rtc_hid_sensor_time.
> <Agreed. This is better. >
>> Automatic loading of modules works too and it works on ARM, Intel and
>> AMD as module or static linked. ;)

Do you have tested the patches with a real device? I assume you have one. ;)

Regards,

Alexander Holler

