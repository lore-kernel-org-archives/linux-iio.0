Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f196.google.com ([209.85.212.196]:35954 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbbERSYM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 14:24:12 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1505181910460.29269@pmeerw.net>
References: <1431966328-11058-1-git-send-email-daniel.baluta@intel.com>
	<1431966328-11058-2-git-send-email-daniel.baluta@intel.com>
	<alpine.DEB.2.02.1505181910460.29269@pmeerw.net>
Date: Mon, 18 May 2015 21:24:10 +0300
Message-ID: <CAEnQRZBgsrRUb0-pkHHQth3apppRPA=XehKZHWdkjfJ=iqLSCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] iio: pm_runtime: Introduce PM runtime helper functions
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-pm@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding linux-pm people since Lars suggested that the changes should be
in the PM core.

I agree, that these changes are not "awfully" IIO specific but no
other subsystem uses
this pattern for configuration. In fact iio_pm_runtime_setup can be
done in many more
other ways depending on functionality needed.

On Mon, May 18, 2015 at 8:34 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> On Mon, 18 May 2015, Daniel Baluta wrote:
>
>> We need this in order to avoid reimplementing the same functions each time
>> we add PM runtime support in a driver.
>
> comments below
>
>> Simple grep shows the following users:
>>       * accel/mma9551.c
>>       * accel/mmc9553.c
>>       * accel/kxcjk1013.c
>>       * accel/bmc150-accel.c
>>       * gyro/bmg160.c
>>       * imu/kmx61.c
>>       * common/hid-sensors.
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> ---
>>  include/linux/iio/pm_runtime.h | 63 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>  create mode 100644 include/linux/iio/pm_runtime.h
>>
>> diff --git a/include/linux/iio/pm_runtime.h b/include/linux/iio/pm_runtime.h
>> new file mode 100644
>> index 0000000..dc2bca7
>> --- /dev/null
>> +++ b/include/linux/iio/pm_runtime.h
>> @@ -0,0 +1,63 @@
>> +/*
>> + * Industrial I/O runtime PM helper functions
>> + *
>> + * Copyright (c) 2015, Intel Corporation.
>> + *
>> + * This file is subject to the terms and conditions of version 2 of
>> + * the GNU General Public License.  See the file COPYING in the main
>> + * directory of this archive for more details.
>> + *
>> + */
>> +#ifndef __IIO_PM_RUNTIME
>> +#define __IIO_PM_RUNTIME
>> +
>> +#include <linux/pm_runtime.h>
>> +
>> +static inline int iio_pm_runtime_setup(struct device *dev, int delay,
>> +                                    bool ignore_children)
>> +{
>> +     int ret;
>> +
>> +     ret = pm_runtime_set_active(dev);
>> +     if (ret)
>
> just noting: should this be (ret) or (ret < 0)?
>
> pm_runtime_get_sync() below may return negative, 0, and positive
> pm_runtime_set_active() seems to return negative or 0
>
> documentation doesn't tell... wondering if (ret < 0) would be safer here?

I think this check is correct, I also found the same check in
power/pm2301_charger.c:1116. But there is no problem to add if (ret < 0)
it looks safer.

>
>> +             return ret;
>> +
>> +     pm_suspend_ignore_children(dev, ignore_children);
>> +     pm_runtime_enable(dev);
>> +     pm_runtime_set_autosuspend_delay(dev, delay);
>> +     pm_runtime_use_autosuspend(dev);
>> +
>> +     return 0;
>> +}
>> +
>> +static inline void iio_pm_runtime_cleanup(struct device *dev)
>> +{
>> +     pm_runtime_disable(dev);
>> +     pm_runtime_set_suspended(dev);
>> +     pm_runtime_put_noidle(dev);
>> +}
>> +
>> +static inline int iio_pm_runtime_set_power(struct device *dev, bool on)
>
> why a static inline function in a header file?
> these functions do not seem to be performance critical and are substantial
> enough in size to avoid copying the code to every driver

I know about this, but I was trying to avoid another .config option
that each IIO driver should select when implementing runtime pm support.

I can change this.

>
>> +{
>> +#ifdef CONFIG_PM
>> +     int ret;
>> +
>> +     if (on)
>> +             ret = pm_runtime_get_sync(dev);
>> +     else {
>> +             pm_runtime_mark_last_busy(dev);
>> +             ret = pm_runtime_put_autosuspend(dev);
>> +     }
>> +
>> +     if (ret < 0) {
>> +             dev_err(dev, "Failed: iio_set_power_state for %d\n", on);
>
> the error message doesn't match the function name, the text, 'for %d', is
> not very clear

Correct. Thanks for spotting this!
>
>> +             if (on)
>> +                     pm_runtime_put_noidle(dev);
>> +
>> +             return ret;
>> +     }
>> +#endif
>> +     return 0;
>> +}
>> +
>> +#endif /* __IIO_PM_RUNTIME */
>>
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
