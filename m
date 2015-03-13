Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1426261018-6025-1-git-send-email-darshanapadmadas@gmail.com>
References: <1426261018-6025-1-git-send-email-darshanapadmadas@gmail.com>
Date: Fri, 13 Mar 2015 18:26:40 +0200
Message-ID: <CAEnQRZDpEMogqDwpqqH0hAPgV+xoo=p9VTxme4DP=8aJt1JT4Q@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v2] iio: Add ABI documentation for
 in_magn offset value
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Darshana Padmadas <darshanapadmadas@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Mar 13, 2015 at 5:36 PM, Darshana Padmadas
<darshanapadmadas@gmail.com> wrote:
> This patch adds ABI documentation entries for in_magn_offset.
> There is one user, hid-sensor-magn-3d in drivers/iio/magnetometer.
>
> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
> Changes in v2:
>     - Removed attribute in_magn_raw as no driver in drivers/iio/magnetometer
>       or staging/iio/magnetometer has info_mask_separate set to
>       IIO_CHAN_INFO_RAW without any modifiers.
>     - Changed subject and commit message accordingly.
>
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 9a70c31..4fd3976 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -253,6 +253,7 @@ What:               /sys/bus/iio/devices/iio:deviceX/in_temp_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_pressure_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_magn_offset
>  KernelVersion: 2.6.35
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> --
> 1.9.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1426261018-6025-1-git-send-email-darshanapadmadas%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
