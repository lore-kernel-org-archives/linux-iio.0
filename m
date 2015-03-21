Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59340 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbCUL4Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2015 07:56:24 -0400
Message-ID: <550D5C67.2020804@kernel.org>
Date: Sat, 21 Mar 2015 11:56:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Darshana Padmadas <darshanapadmadas@gmail.com>,
	outreachy-kernel@googlegroups.com
CC: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add ABI documentation for illuminance raw and scale
 values in light
References: <1426506500-11836-1-git-send-email-darshanapadmadas@gmail.com>
In-Reply-To: <1426506500-11836-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/03/15 11:48, Darshana Padmadas wrote:
> This patchset adds ABI documentation for the following attributes:
> 
> in_illuminance_scale, used atleast once in al3320a staging/iio/light/
> in_illuminance_calibscale, used atleast once in cm32181
> in_illuminance_input, used in cm3232 at least once
> in_illuminance_raw used atleast once in al3320a
> in_illuminance_clear_raw and in_illuminance_ir_raw exposed by
> gp2ap020a00f with modifiers IIO_MOD_LIGHT_CLEAR and
> IIO_MOD_LIGHT_IR respectively.
> 
> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 4fd3976..4d1cbba 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -297,6 +297,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_scale
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -337,6 +338,7 @@ what		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
>  what		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -1144,9 +1146,13 @@ Description:
>  		values should behave in the same way as a distance, i.e. lower
>  		values indicate something is closer to the sensor.
>  
> +What:		/sys/.../iio:deviceX/in_illuminance_input
> +What:		/sys/.../iio:deviceX/in_illuminance_raw
>  What:		/sys/.../iio:deviceX/in_illuminanceY_input
>  What:		/sys/.../iio:deviceX/in_illuminanceY_raw
>  What:		/sys/.../iio:deviceX/in_illuminanceY_mean_raw
> +What:		/sys/.../iio:deviceX/in_illuminance_ir_raw
> +What:		/sys/.../iio:deviceX/in_illuminance_clear_raw
>  KernelVersion:	3.4
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> 

