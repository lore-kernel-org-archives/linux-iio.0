Return-Path: <daniel.baluta@intel.com>
Message-ID: <543BD4EA.2000502@intel.com>
Date: Mon, 13 Oct 2014 16:34:34 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: Re: [PATCH] iio: add ABI documentation for scaled pressure
References: <1413205751-11205-1-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1413205751-11205-1-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 10/13/2014 04:09 PM, Vlad Dogaru wrote:
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> ---
>
> There's at least one user of in_pressure_input, the bmg280 driver I submitted
> earlier.
>
>   Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d760b02..0b771f8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -200,6 +200,13 @@ Description:
>   		Raw pressure measurement from channel Y. Units after
>   		application of scale and offset are kilopascal.
>
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_input
> +KernelVersion:	3.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Scaled pressure measurement in kilopascal.

For consistency, with the pressure raw entry description, this should be:
Scaled pressure measurement from channel Y, in kilopascal.

Another user for this is EPCOS T5403 (pressure/t5403.c).

thanks,
Daniel.
