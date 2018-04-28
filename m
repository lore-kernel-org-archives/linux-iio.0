Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757745AbeD1Rgk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Apr 2018 13:36:40 -0400
Date: Sat, 28 Apr 2018 18:36:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, daniel.baluta@nxp.com,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/9] staging: iio: Documentation: Add missing sysfs
 docs for angle channel
Message-ID: <20180428183634.1c7e2769@archlinux>
In-Reply-To: <7c715bd223b129faa9e5e484a3e4b8e6eba0abeb.1524432236.git.davidjulianveenstra@gmail.com>
References: <cover.1524432236.git.davidjulianveenstra@gmail.com>
        <7c715bd223b129faa9e5e484a3e4b8e6eba0abeb.1524432236.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 23 Apr 2018 00:04:10 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> The iio resolver drivers in staging use angle channels. This patch
> add missing documentation for this type of channel.
> 
> As was discussed in [1], radians is chosen as the unit, to match the
> unit of angular velocity.
> 
> [1] https://marc.info/?l=linux-driver-devel&m=152190078308330&w=2
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Great, no point in waiting on the other patches for the ABI docs
as we are fine with this.

Applied,

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Remove axis modifier on in_angle.
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6a5f34b4d5b9..240287e2343a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -190,6 +190,13 @@ Description:
>  		but should match other such assignments on device).
>  		Units after application of scale and offset are m/s^2.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_angl_raw
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Angle of rotation. Units after application of scale and offset
> +		are radians.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
> @@ -297,6 +304,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_rot_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_angl_offset
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -350,6 +358,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_countY_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_angl_scale
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:

