Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:36071 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbbHFHdN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 03:33:13 -0400
MIME-Version: 1.0
In-Reply-To: <998736994e24f0bc3e7864b1e6b6e0de607c8447.1438793211.git.cristina.opriceana@gmail.com>
References: <998736994e24f0bc3e7864b1e6b6e0de607c8447.1438793211.git.cristina.opriceana@gmail.com>
Date: Thu, 6 Aug 2015 10:33:11 +0300
Message-ID: <CAEnQRZAKq-Fp8YcKT2z_ADrEjSs5zoh2qBvJ8jKbCZ5S6N2F6g@mail.gmail.com>
Subject: Re: [PATCH] iio: Documentation: Add trigger name attribute ABI documentation
From: Daniel Baluta <daniel.baluta@intel.com>
To: Cristina Opriceana <cristina.opriceana@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-api@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

+ linux-iio.

On Wed, Aug 5, 2015 at 8:09 PM, Cristina Opriceana
<cristina.opriceana@gmail.com> wrote:
> This patch adds an entry in the ABI Documentation for the
> name attribute issued when a trigger is created.
>
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
> index 5235e6c..85c8e4d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
> @@ -9,3 +9,12 @@ Description:
>                 automated testing or in situations, where other trigger methods
>                 are not applicable. For example no RTC or spare GPIOs.
>                 X is the IIO index of the trigger.
> +
> +What:          /sys/bus/iio/devices/triggerX/name
> +KernelVersion: 2.6.39
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               The name attribute holds a description string for the current
> +               trigger. A device should write this name string to
> +               /sys/bus/iio/devices/iio:deviceX/trigger/current_trigger
> +               in order to use this trigger.

Better, "In order to associate this trigger with an IIO device one
should write this name string to /sys/bus/...".
Also, please use iio:deviceY instead of iio:deviceX to make it clear
that trigger and device indexes are not
related.

thanks,
Daniel.
