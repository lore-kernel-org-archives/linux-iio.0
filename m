Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51763 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbaD2VMf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Apr 2014 17:12:35 -0400
Message-ID: <5360161F.3020900@kernel.org>
Date: Tue, 29 Apr 2014 22:14:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: Added ABI description for quaternion
References: <1398729107-16748-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1398729107-16748-7-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1398729107-16748-7-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/14 00:51, Srinivas Pandruvada wrote:
> Added documentation for reading quaternion components for 3D rotations.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

I'll push the whole lot out to testing in a sec.

Thanks for you persistence with this set. Nice to finally take it!

Jonathan
> ---
>   Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6e02c50..d2c59f9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -784,6 +784,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
>   What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
>   What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
>   What:		/sys/.../iio:deviceX/scan_elements/in_pressure_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_en
>   KernelVersion:	2.6.37
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> @@ -799,6 +800,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
>   What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
>   What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
>   What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_type
>   KernelVersion:	2.6.37
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> @@ -845,6 +847,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_index
>   What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_index
>   What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_index
>   What:		/sys/.../iio:deviceX/scan_elements/in_pressure_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_index
>   KernelVersion:	2.6.37
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> @@ -891,3 +894,12 @@ Contact:	linux-iio@vger.kernel.org
>   Description:
>   		This attribute is used to get/set the integration time in
>   		seconds.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_quaternion_raw
> +KernelVersion:	3.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw value of quaternion components using a format
> +		x y z w. Here x, y, and z component represents the axis about
> +		which a rotation will occur and w component represents the
> +		amount of rotation.
>

