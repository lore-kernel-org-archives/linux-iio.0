Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55884 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756946Ab3FKUKr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 16:10:47 -0400
Message-ID: <51B78445.6090203@kernel.org>
Date: Tue, 11 Jun 2013 21:10:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Alexandre Relange <alexandre@relange.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: ABI doc: update scan_elements sysfs paths
References: <1370962336-20739-1-git-send-email-alexandre@relange.org>
In-Reply-To: <1370962336-20739-1-git-send-email-alexandre@relange.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/2013 03:52 PM, Alexandre Relange wrote:
> update ABI documentation with current paths related to scan_elements folder
> 
> Paths changed long time ago in commit: 26d25ae3f0d8ffe350aacc75b71198d6b35bd1f4
Good spot, that's been wrong for a long time.
> 
> Signed-off-by: Alexandre Relange <alexandre@relange.org>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 90 ++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2e33dc6..dda81ff 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -690,45 +690,45 @@ Description:
>  		Actually start the buffer capture up.  Will start trigger
>  		if first device and appropriate.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/buffer/scan_elements
> +What:		/sys/bus/iio/devices/iio:deviceX/scan_elements
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Directory containing interfaces for elements that will be
>  		captured for a single triggered sample set in the buffer.
>  
> -What:		/sys/.../buffer/scan_elements/in_accel_x_en
> -What:		/sys/.../buffer/scan_elements/in_accel_y_en
> -What:		/sys/.../buffer/scan_elements/in_accel_z_en
> -What:		/sys/.../buffer/scan_elements/in_anglvel_x_en
> -What:		/sys/.../buffer/scan_elements/in_anglvel_y_en
> -What:		/sys/.../buffer/scan_elements/in_anglvel_z_en
> -What:		/sys/.../buffer/scan_elements/in_magn_x_en
> -What:		/sys/.../buffer/scan_elements/in_magn_y_en
> -What:		/sys/.../buffer/scan_elements/in_magn_z_en
> -What:		/sys/.../buffer/scan_elements/in_timestamp_en
> -What:		/sys/.../buffer/scan_elements/in_voltageY_supply_en
> -What:		/sys/.../buffer/scan_elements/in_voltageY_en
> -What:		/sys/.../buffer/scan_elements/in_voltageY-voltageZ_en
> -What:		/sys/.../buffer/scan_elements/in_incli_x_en
> -What:		/sys/.../buffer/scan_elements/in_incli_y_en
> -What:		/sys/.../buffer/scan_elements/in_pressureY_en
> -What:		/sys/.../buffer/scan_elements/in_pressure_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_x_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_y_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_z_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_magn_x_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_magn_y_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_magn_z_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_voltageY-voltageZ_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
> +What:		/sys/.../iio:deviceX/scan_elements/in_pressure_en
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Scan element control for triggered data capture.
>  
> -What:		/sys/.../buffer/scan_elements/in_accel_type
> -What:		/sys/.../buffer/scan_elements/in_anglvel_type
> -What:		/sys/.../buffer/scan_elements/in_magn_type
> -What:		/sys/.../buffer/scan_elements/in_incli_type
> -What:		/sys/.../buffer/scan_elements/in_voltageY_type
> -What:		/sys/.../buffer/scan_elements/in_voltage_type
> -What:		/sys/.../buffer/scan_elements/in_voltageY_supply_type
> -What:		/sys/.../buffer/scan_elements/in_timestamp_type
> -What:		/sys/.../buffer/scan_elements/in_pressureY_type
> -What:		/sys/.../buffer/scan_elements/in_pressure_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_accel_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_magn_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_incli_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_voltage_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
> +What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -752,29 +752,29 @@ Description:
>  		For other storage combinations this attribute will be extended
>  		appropriately.
>  
> -What:		/sys/.../buffer/scan_elements/in_accel_type_available
> +What:		/sys/.../iio:deviceX/scan_elements/in_accel_type_available
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		If the type parameter can take one of a small set of values,
>  		this attribute lists them.
>  
> -What:		/sys/.../buffer/scan_elements/in_voltageY_index
> -What:		/sys/.../buffer/scan_elements/in_voltageY_supply_index
> -What:		/sys/.../buffer/scan_elements/in_accel_x_index
> -What:		/sys/.../buffer/scan_elements/in_accel_y_index
> -What:		/sys/.../buffer/scan_elements/in_accel_z_index
> -What:		/sys/.../buffer/scan_elements/in_anglvel_x_index
> -What:		/sys/.../buffer/scan_elements/in_anglvel_y_index
> -What:		/sys/.../buffer/scan_elements/in_anglvel_z_index
> -What:		/sys/.../buffer/scan_elements/in_magn_x_index
> -What:		/sys/.../buffer/scan_elements/in_magn_y_index
> -What:		/sys/.../buffer/scan_elements/in_magn_z_index
> -What:		/sys/.../buffer/scan_elements/in_incli_x_index
> -What:		/sys/.../buffer/scan_elements/in_incli_y_index
> -What:		/sys/.../buffer/scan_elements/in_timestamp_index
> -What:		/sys/.../buffer/scan_elements/in_pressureY_index
> -What:		/sys/.../buffer/scan_elements/in_pressure_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_x_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_y_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_z_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_magn_x_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_magn_y_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_magn_z_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_index
> +What:		/sys/.../iio:deviceX/scan_elements/in_pressure_index
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> 
