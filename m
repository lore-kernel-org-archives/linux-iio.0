Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36292 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbaFIT4h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 9 Jun 2014 15:56:37 -0400
Message-ID: <539611E2.2080309@kernel.org>
Date: Mon, 09 Jun 2014 20:58:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 06/12] iio: Move documentation of iio-trig-sysfs to ABI
References: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net> <1402155772-1373-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155772-1373-7-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/06/14 16:42, Peter Meerwald wrote:
> iio-trig-sysfs has left staging with commit e64e7d5c
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Hi Peter,

Good point, but this still wants to have it's own file
Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs as the attribute is specific
to only this device and not part of the more general iio sysfs abi.

Thanks,

> ---
>   Documentation/ABI/testing/sysfs-bus-iio                      | 12 ++++++++++++
>   .../staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs    | 11 -----------
>   2 files changed, 12 insertions(+), 11 deletions(-)
>   delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ed202b3..5e86ee9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -19,6 +19,18 @@ Description:
>   		generalize well and hence are not documented in this file.
>   		X is the IIO index of the trigger.
>
> +What:		/sys/bus/iio/devices/triggerX/trigger_now
> +KernelVersion:	2.6.38
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This file is provided by the iio-trig-sysfs stand-alone trigger
> +		driver. Writing this file with any value triggers an event
> +		driven driver, associated with this trigger, to capture data
> +		into an in kernel buffer. This approach can be valuable during
> +		automated testing or in situations, where other trigger methods
> +		are not applicable. For example no RTC or spare GPIOs.
> +		X is the IIO index of the trigger.
> +
>   What:		/sys/bus/iio/devices/iio:deviceX/buffer
>   KernelVersion:	2.6.35
>   Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs b/drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs
> deleted file mode 100644
> index 5235e6c..0000000
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -What:		/sys/bus/iio/devices/triggerX/trigger_now
> -KernelVersion:	2.6.38
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This file is provided by the iio-trig-sysfs stand-alone trigger
> -		driver. Writing this file with any value triggers an event
> -		driven driver, associated with this trigger, to capture data
> -		into an in kernel buffer. This approach can be valuable during
> -		automated testing or in situations, where other trigger methods
> -		are not applicable. For example no RTC or spare GPIOs.
> -		X is the IIO index of the trigger.
>

