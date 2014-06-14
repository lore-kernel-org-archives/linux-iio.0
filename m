Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44044 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbaFNPDX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 11:03:23 -0400
Message-ID: <539C64B0.8070806@kernel.org>
Date: Sat, 14 Jun 2014 16:05:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 06/12] iio: Move documentation of iio-trig-sysfs to
 ABI/testing
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net> <1402549229-4449-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-7-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 06:00, Peter Meerwald wrote:
> iio-trig-sysfs has left staging with commit e64e7d5c
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Thanks,

Applied to the togreg branch of iio.git

J
> ---
>   Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs         | 11 +++++++++++
>   drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs | 11 -----------
>   2 files changed, 11 insertions(+), 11 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
>   delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
> new file mode 100644
> index 0000000..5235e6c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
> @@ -0,0 +1,11 @@
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

