Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36152 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764AbaEEJ7e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 May 2014 05:59:34 -0400
Message-ID: <53676162.8090903@kernel.org>
Date: Mon, 05 May 2014 11:01:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: Fix unit conversion
References: <1399251720-8158-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1399251720-8158-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/14 02:02, Srinivas Pandruvada wrote:
> When no units are specified the default units are milli-gauss. So
> need to divide by 1000 to get iio default of Gauss.
> Similarly the default units conversion from degrees to radians.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Seeing as I hadn't pushed the patch this is fixing out to the togreg branch
of kernel.org yet, I've applied this as a fixup patch to
4500173cd9abbf3dc8f48a5caca783cd4debe288 iio: hid-sensors: Convert units and exponent

> ---
>   drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 29185a0..3729646 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -44,10 +44,10 @@ struct {
>   	{HID_USAGE_SENSOR_GYRO_3D,
>   		HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND, 0, 17453},
>
> -	{HID_USAGE_SENSOR_COMPASS_3D, 0, 1000, 0},
> +	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000},
>   	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
>
> -	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 17453, 0},
> +	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453},
>   	{HID_USAGE_SENSOR_INCLINOMETER_3D,
>   		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453},
>   	{HID_USAGE_SENSOR_INCLINOMETER_3D,
>

