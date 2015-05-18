Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:45885 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238AbbERReg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 May 2015 13:34:36 -0400
Date: Mon, 18 May 2015 19:34:34 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Daniel Baluta <daniel.baluta@intel.com>
cc: jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] iio: pm_runtime: Introduce PM runtime helper
 functions
In-Reply-To: <1431966328-11058-2-git-send-email-daniel.baluta@intel.com>
Message-ID: <alpine.DEB.2.02.1505181910460.29269@pmeerw.net>
References: <1431966328-11058-1-git-send-email-daniel.baluta@intel.com> <1431966328-11058-2-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 May 2015, Daniel Baluta wrote:

> We need this in order to avoid reimplementing the same functions each time
> we add PM runtime support in a driver.

comments below
 
> Simple grep shows the following users:
> 	* accel/mma9551.c
> 	* accel/mmc9553.c
> 	* accel/kxcjk1013.c
> 	* accel/bmc150-accel.c
> 	* gyro/bmg160.c
> 	* imu/kmx61.c
> 	* common/hid-sensors.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
>  include/linux/iio/pm_runtime.h | 63 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 include/linux/iio/pm_runtime.h
> 
> diff --git a/include/linux/iio/pm_runtime.h b/include/linux/iio/pm_runtime.h
> new file mode 100644
> index 0000000..dc2bca7
> --- /dev/null
> +++ b/include/linux/iio/pm_runtime.h
> @@ -0,0 +1,63 @@
> +/*
> + * Industrial I/O runtime PM helper functions
> + *
> + * Copyright (c) 2015, Intel Corporation.
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + */
> +#ifndef __IIO_PM_RUNTIME
> +#define __IIO_PM_RUNTIME
> +
> +#include <linux/pm_runtime.h>
> +
> +static inline int iio_pm_runtime_setup(struct device *dev, int delay,
> +				       bool ignore_children)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)

just noting: should this be (ret) or (ret < 0)?

pm_runtime_get_sync() below may return negative, 0, and positive
pm_runtime_set_active() seems to return negative or 0

documentation doesn't tell... wondering if (ret < 0) would be safer here?

> +		return ret;
> +
> +	pm_suspend_ignore_children(dev, ignore_children);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, delay);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	return 0;
> +}
> +
> +static inline void iio_pm_runtime_cleanup(struct device *dev)
> +{
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +}
> +
> +static inline int iio_pm_runtime_set_power(struct device *dev, bool on)

why a static inline function in a header file?
these functions do not seem to be performance critical and are substantial 
enough in size to avoid copying the code to every driver

> +{
> +#ifdef CONFIG_PM
> +	int ret;
> +
> +	if (on)
> +		ret = pm_runtime_get_sync(dev);
> +	else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret = pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(dev, "Failed: iio_set_power_state for %d\n", on);

the error message doesn't match the function name, the text, 'for %d', is 
not very clear

> +		if (on)
> +			pm_runtime_put_noidle(dev);
> +
> +		return ret;
> +	}
> +#endif
> +	return 0;
> +}
> +
> +#endif /* __IIO_PM_RUNTIME */
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
