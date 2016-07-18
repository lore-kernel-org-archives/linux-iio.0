Return-Path: <linux@roeck-us.net>
Subject: Re: [v2,1/4] hwmon: iio_hwmon: defer probe when no channel is found
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <1468576754-3273-2-git-send-email-quentin.schulz@free-electrons.com>
 <20160716170013.GA27490@roeck-us.net> <20160718100232.GE4199@lukather>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, jdelvare@suse.com,
 jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 wens@csie.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com,
 antoine.tenart@free-electrons.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578CD99E.5000406@roeck-us.net>
Date: Mon, 18 Jul 2016 06:29:02 -0700
MIME-Version: 1.0
In-Reply-To: <20160718100232.GE4199@lukather>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/18/2016 03:02 AM, Maxime Ripard wrote:
> Hi Guenter,
>
> On Sat, Jul 16, 2016 at 10:00:13AM -0700, Guenter Roeck wrote:
>> On Fri, Jul 15, 2016 at 11:59:11AM +0200, Quentin Schulz wrote:
>>> iio_channel_get_all returns -ENODEV when it cannot find either phandles and
>>> properties in the Device Tree or channels whose consumer_dev_name matches
>>> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
>>> which might be probed after iio_hwmon.
>>>
>>> It is better to defer the probe of iio_hwmon if such error is returned by
>>> iio_channel_get_all in order to let a chance to iio drivers to expose
>>> channels in iio_map_list.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>> ---
>>>
>>> No modifications for this patch since we did not settled for a solution.
>>> What should we do?
>>>
>> AFAICS the only thing we can do is to replace module_platform_driver() with
>> its explicitly coded variant, and to use use late_initcall() instead of
>> module_init().
>
> I thought this kind of changes to the driver init time were
> discouraged these days?
>

Blindly converting -ENODEV to -EPROBEDEFER doesn't sound like a good idea
either.

>> Anything else would result in endless probe deferrals if there are
>> no channels.
>
> Well, technically, not endless. AFAIK, the kernel only retries when a
> new driver is probed, which should hopefully settle down rather
> quickly.
>

Plus each time a new driver is loaded for whatever reason.

Also, are you sure that leaving a device in deferred probe state doesn't
have undesirable side effects ? For example, would driver_probe_done()
ever return true ?

Guenter
