Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1413208420-12226-1-git-send-email-vlad.dogaru@intel.com>
References: <1413208420-12226-1-git-send-email-vlad.dogaru@intel.com>
Date: Tue, 14 Oct 2014 12:35:08 +0300
Message-ID: <CAEnQRZCo_sMp+ySPBfsD+vTpcCyfK2JEqvnbnxuDrNqBy7io8w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: add ABI documentation for scaled pressure
From: Daniel Baluta <daniel.baluta@intel.com>
To: Vlad Dogaru <vlad.dogaru@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 13, 2014 at 4:53 PM, Vlad Dogaru <vlad.dogaru@intel.com> wrote:
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
> Since v1: also mention channel Y, for uniformity with the description of
> the raw channel above.
>
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d760b02..d3d67b6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -200,6 +200,13 @@ Description:
>                 Raw pressure measurement from channel Y. Units after
>                 application of scale and offset are kilopascal.
>
> +What:          /sys/bus/iio/devices/iio:deviceX/in_pressureY_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_pressure_input
> +KernelVersion: 3.8
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Scaled pressure measurement from channel Y, in kilopascal.
> +
>  What:          /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
>  KernelVersion: 3.14
>  Contact:       linux-iio@vger.kernel.org
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
