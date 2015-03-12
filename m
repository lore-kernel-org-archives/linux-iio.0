Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <20150312145536.GA20026@haneen-vb>
References: <20150312145536.GA20026@haneen-vb>
Date: Thu, 12 Mar 2015 17:06:01 +0200
Message-ID: <CAEnQRZAK-aLWvcgMrJy0+xiHFAX+2kGgy4nek+q_OtqCmkrwPQ@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] iio: Add ABI documentation for
 proximity scan_emlements
From: Daniel Baluta <daniel.baluta@intel.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: outreachy-kernel@googlegroups.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 12, 2015 at 4:55 PM, Haneen Mohammed
<hamohammed.sa@gmail.com> wrote:
> This patch adds ABI documentation entries for in_proximity_en,
> in_proximity_type, and in_proximity_index in the scan_elements.
> At lease one user for these is present, the AS3935 Franklin lightning sensor.
>
> Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

I know that Greg won't accept patches outside of drivers/staging/. I
think this should go via linux-iio tree.

Thanks Haneen!

Daniel.

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 9a1a5fc..fd026d9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -999,6 +999,7 @@ What:               /sys/.../iio:deviceX/scan_elements/in_incli_y_en
>  What:          /sys/.../iio:deviceX/scan_elements/in_pressureY_en
>  What:          /sys/.../iio:deviceX/scan_elements/in_pressure_en
>  What:          /sys/.../iio:deviceX/scan_elements/in_rot_quaternion_en
> +What:          /sys/.../iio:deviceX/scan_elements/in_proximity_en
>  KernelVersion: 2.6.37
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> @@ -1015,6 +1016,7 @@ What:             /sys/.../iio:deviceX/scan_elements/in_timestamp_type
>  What:          /sys/.../iio:deviceX/scan_elements/in_pressureY_type
>  What:          /sys/.../iio:deviceX/scan_elements/in_pressure_type
>  What:          /sys/.../iio:deviceX/scan_elements/in_rot_quaternion_type
> +What:          /sys/.../iio:deviceX/scan_elements/in_proximity_type
>  KernelVersion: 2.6.37
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> @@ -1066,6 +1068,7 @@ What:             /sys/.../iio:deviceX/scan_elements/in_timestamp_index
>  What:          /sys/.../iio:deviceX/scan_elements/in_pressureY_index
>  What:          /sys/.../iio:deviceX/scan_elements/in_pressure_index
>  What:          /sys/.../iio:deviceX/scan_elements/in_rot_quaternion_index
> +What:          /sys/.../iio:deviceX/scan_elements/in_proximity_index
>  KernelVersion: 2.6.37
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> --
> 1.9.1
>
> --
