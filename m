Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35546 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbETF5Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2015 01:57:16 -0400
Received: by wgfl8 with SMTP id l8so40775792wgf.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2015 22:57:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1432052790-26458-1-git-send-email-lars@metafoo.de>
References: <1432052790-26458-1-git-send-email-lars@metafoo.de>
Date: Wed, 20 May 2015 08:57:13 +0300
Message-ID: <CAEnQRZBW7aCmqasFsm5cFwv37BdwVb0W5LXOU7fhEHNbJqj1VA@mail.gmail.com>
Subject: Re: [PATCH] iio: Add I/Q modifiers
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 19, 2015 at 7:26 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> I/Q modifiers can be used to denote signals which are represented by a
> in-phase and a quadrature component.
>
> The ABI documentation describes the I and Q modifiers for current and
> voltage channels for now as those will be the most likely users.
>

Hi Lars,

Is there a driver exposing this ABI?

Daniel.

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 46 +++++++++++++++++++++++++++++++++
>  drivers/iio/industrialio-core.c         |  2 ++
>  include/uapi/linux/iio/types.h          |  2 ++
>  3 files changed, 50 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f66262c..85a8e05 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -71,6 +71,8 @@ Description:
>
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_q_raw
>  KernelVersion: 2.6.35
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> @@ -81,6 +83,11 @@ Description:
>                 unique to allow association with event codes. Units after
>                 application of scale and offset are millivolts.
>
> +               Channels with a 'i' and 'q' modifiers always exists in pairs and both
> +               channels refer to the same signal. The 'i' channel contains the in-phase
> +               component of the signal while the 'q' channel contains the quadrature
> +               component.
> +
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_raw
>  KernelVersion: 2.6.35
>  Contact:       linux-iio@vger.kernel.org
> @@ -246,8 +253,16 @@ What:              /sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_accel_z_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltage_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_i_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_q_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltage_q_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltage_i_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_currentY_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_current_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_currentY_i_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_currentY_q_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_current_q_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_current_i_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_tempY_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_temp_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
> @@ -273,14 +288,22 @@ Description:
>                 to the _raw output.
>
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_i_scale
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_q_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltage_scale
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltage_i_scale
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltage_q_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_currentY_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_currentY_supply_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_current_scale
> +What:          /sys/bus/iio/devices/iio:deviceX/in_currentY_i_scale
> +What:          /sys/bus/iio/devices/iio:deviceX/in_currentY_q_scale
> +What:          /sys/bus/iio/devices/iio:deviceX/in_current_i_scale
> +What:          /sys/bus/iio/devices/iio:deviceX/in_current_q_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_accel_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_anglvel_scale
> @@ -328,6 +351,10 @@ Description:
>
>  What           /sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
>  What           /sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
> +What           /sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
> +What           /sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
> +What           /sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
> +What           /sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
>  What           /sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
>  What           /sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
>  What           /sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
> @@ -1046,6 +1073,10 @@ What:            /sys/.../iio:deviceX/scan_elements/in_timestamp_en
>  What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
>  What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_en
>  What:          /sys/.../iio:deviceX/scan_elements/in_voltageY-voltageZ_en
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_i_en
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_q_en
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltage_i_en
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltage_q_en
>  What:          /sys/.../iio:deviceX/scan_elements/in_incli_x_en
>  What:          /sys/.../iio:deviceX/scan_elements/in_incli_y_en
>  What:          /sys/.../iio:deviceX/scan_elements/in_pressureY_en
> @@ -1064,6 +1095,10 @@ What:            /sys/.../iio:deviceX/scan_elements/in_incli_type
>  What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_type
>  What:          /sys/.../iio:deviceX/scan_elements/in_voltage_type
>  What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_i_type
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_q_type
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltage_i_type
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltage_q_type
>  What:          /sys/.../iio:deviceX/scan_elements/in_timestamp_type
>  What:          /sys/.../iio:deviceX/scan_elements/in_pressureY_type
>  What:          /sys/.../iio:deviceX/scan_elements/in_pressure_type
> @@ -1101,6 +1136,10 @@ Description:
>
>  What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_index
>  What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_supply_index
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_i_index
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltageY_q_index
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltage_i_index
> +What:          /sys/.../iio:deviceX/scan_elements/in_voltage_q_index
>  What:          /sys/.../iio:deviceX/scan_elements/in_accel_x_index
>  What:          /sys/.../iio:deviceX/scan_elements/in_accel_y_index
>  What:          /sys/.../iio:deviceX/scan_elements/in_accel_z_index
> @@ -1260,6 +1299,8 @@ Description:
>                 or without compensation from tilt sensors.
>
>  What:          /sys/bus/iio/devices/iio:deviceX/in_currentX_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_currentX_i_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_currentX_q_raw
>  KernelVersion: 3.18
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> @@ -1268,6 +1309,11 @@ Description:
>                 present, output should be considered as processed with the
>                 unit in milliamps.
>
> +               Channels with a 'i' and 'q' modifiers always exists in pairs and both
> +               channels refer to the same signal. The 'i' channel contains the in-phase
> +               component of the signal while the 'q' channel contains the quadrature
> +               component.
> +
>  What:          /sys/.../iio:deviceX/in_energy_en
>  What:          /sys/.../iio:deviceX/in_distance_en
>  What:          /sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 9688a88..3524b0d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -101,6 +101,8 @@ static const char * const iio_modifier_names[] = {
>         [IIO_MOD_WALKING] = "walking",
>         [IIO_MOD_STILL] = "still",
>         [IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z] = "sqrt(x^2+y^2+z^2)",
> +       [IIO_MOD_I] = "i",
> +       [IIO_MOD_Q] = "q",
>  };
>
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 5c46019..2f8b117 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -70,6 +70,8 @@ enum iio_modifier {
>         IIO_MOD_WALKING,
>         IIO_MOD_STILL,
>         IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z,
> +       IIO_MOD_I,
> +       IIO_MOD_Q,
>  };
>
>  enum iio_event_type {
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
