Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40910 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab2KTVNA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Nov 2012 16:13:00 -0500
Message-ID: <50ABF25B.6090005@kernel.org>
Date: Tue, 20 Nov 2012 21:12:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 5/7] iio: Add pressure channel type
References: <1353418611-17614-1-git-send-email-lars@metafoo.de> <1353418611-17614-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1353418611-17614-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/20/2012 01:36 PM, Lars-Peter Clausen wrote:
> This patch adds support for a new IIO channel type for pressure measurements.
> This can for example be used for barometric pressure sensors.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Whilst we have had quite a few pressure drivers mentioned, it is nice
to finally see one turn up!
added to togreg branch of iio.git
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/linux/iio/types.h               |  1 +
>  3 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2f06d40..f08d0f7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -189,6 +189,14 @@ Description:
>  		A computed peak value based on the sum squared magnitude of
>  		the underlying value in the specified directions.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_raw
> +KernelVersion:	3.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw pressure measurement from channel Y. Units after
> +		application of scale and offset are kilopascal.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
> @@ -197,6 +205,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_offset
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -226,6 +236,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_magn_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_scale
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -245,6 +257,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias
>  What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibbias
>  What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibbias
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibbias
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibbias
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -262,6 +276,8 @@ What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
>  What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
>  what		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
>  what		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -275,6 +291,8 @@ What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
>  What:		/sys/.../iio:deviceX/out_voltageX_scale_available
>  What:		/sys/.../iio:deviceX/out_altvoltageX_scale_available
>  What:		/sys/.../iio:deviceX/in_capacitance_scale_available
> +What:		/sys/.../iio:deviceX/in_pressure_scale_available
> +What:		/sys/.../iio:deviceX/in_pressureY_scale_available
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -694,6 +712,8 @@ What:		/sys/.../buffer/scan_elements/in_voltageY_en
>  What:		/sys/.../buffer/scan_elements/in_voltageY-voltageZ_en
>  What:		/sys/.../buffer/scan_elements/in_incli_x_en
>  What:		/sys/.../buffer/scan_elements/in_incli_y_en
> +What:		/sys/.../buffer/scan_elements/in_pressureY_en
> +What:		/sys/.../buffer/scan_elements/in_pressure_en
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -707,6 +727,8 @@ What:		/sys/.../buffer/scan_elements/in_voltageY_type
>  What:		/sys/.../buffer/scan_elements/in_voltage_type
>  What:		/sys/.../buffer/scan_elements/in_voltageY_supply_type
>  What:		/sys/.../buffer/scan_elements/in_timestamp_type
> +What:		/sys/.../buffer/scan_elements/in_pressureY_type
> +What:		/sys/.../buffer/scan_elements/in_pressure_type
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -751,6 +773,8 @@ What:		/sys/.../buffer/scan_elements/in_magn_z_index
>  What:		/sys/.../buffer/scan_elements/in_incli_x_index
>  What:		/sys/.../buffer/scan_elements/in_incli_y_index
>  What:		/sys/.../buffer/scan_elements/in_timestamp_index
> +What:		/sys/.../buffer/scan_elements/in_pressureY_index
> +What:		/sys/.../buffer/scan_elements/in_pressure_index
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 060a404..3dccd6c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -65,6 +65,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_CAPACITANCE] = "capacitance",
>  	[IIO_ALTVOLTAGE] = "altvoltage",
>  	[IIO_CCT] = "cct",
> +	[IIO_PRESSURE] = "pressure",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 87b196a..88bf0f0 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -28,6 +28,7 @@ enum iio_chan_type {
>  	IIO_CAPACITANCE,
>  	IIO_ALTVOLTAGE,
>  	IIO_CCT,
> +	IIO_PRESSURE,
>  };
>  
>  enum iio_modifier {
> 
