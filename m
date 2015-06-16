Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1434487003-7248-1-git-send-email-pmeerw@pmeerw.net>
References: <1434487003-7248-1-git-send-email-pmeerw@pmeerw.net>
Date: Tue, 16 Jun 2015 23:57:41 +0300
Message-ID: <CAEnQRZAwOBfLXuNG3qU8WbXrEfyhWAOvhZ6TxDLWnB_+4cEaBQ@mail.gmail.com>
Subject: Re: [PATCH] iio: ABI: Fix typo in in_proximity_raw description
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jun 16, 2015 at 11:36 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Oh, didn't see that :)

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3befcb1..7d909a4 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1162,7 +1162,7 @@ KernelVersion:    3.4
>  Contact:       linux-iio@vger.kernel.org
>  Description:
>                 Proximity measurement indicating that some
> -               object is near the sensor, usually be observing
> +               object is near the sensor, usually by observing
>                 reflectivity of infrared or ultrasound emitted.
>                 Often these sensors are unit less and as such conversion
>                 to SI units is not possible.  Where it is, the units should
> --
