Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:44653
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752390Ab2EBLzL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 2 May 2012 07:55:11 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Wed, 2 May 2012 12:55:09 +0100
Subject: RE: [PATCH] iio: documentation: Add out_altvoltage and friends
Message-ID: <544AC56F16B56944AEC3BD4E3D5917714E79716CB1@LIMKCMBX1.ad.analog.com>
References: <1335957844-6172-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1335957844-6172-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

I wonder how we want to organize our documentation.
Maintain only one file Documentation/ABI/testing/sysfs-bus-iio?

Or potentially multiple in Documentation/iio covering
untypical and device specific attributes?

Documentation/iio/sysfs-bus-frequency-xxx
Documentation/iio/sysfs-bus-light-xxx
...

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


> -----Original Message-----
> From: michael.hennerich@analog.com
> [mailto:michael.hennerich@analog.com]
> Sent: Wednesday, May 02, 2012 1:24 PM
> To: jic23@kernel.org
> Cc: linux-iio@vger.kernel.org; device-drivers-
> devel@blackfin.uclinux.org; Hennerich, Michael
> Subject: [PATCH] iio: documentation: Add out_altvoltage and friends
>
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> Continuous frequency/clock generating devices, such as DDSs or PLLs
> should use out_altvolatge.
>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |   31
> +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> b/Documentation/ABI/testing/sysfs-bus-iio
> index 2ce4dad..f757a30 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -219,6 +219,7 @@ What:
>       /sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
>  What:
>       /sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
>  What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_scale
>  What:                /sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
> +What:
>       /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
>  What:                /sys/bus/iio/devices/iio:deviceX/in_accel_scale
>  What:                /sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
>  What:                /sys/bus/iio/devices/iio:deviceX/in_anglvel_scale
> @@ -273,6 +274,7 @@ What:
>       /sys/bus/iio/devices/iio:deviceX/in_accel_scale_available
>  What:                /sys/.../iio:deviceX/in_voltageX_scale_available
>  What:                /sys/.../iio:deviceX/in_voltage-
> voltage_scale_available
>  What:                /sys/.../iio:deviceX/out_voltageX_scale_available
> +What:                /sys/.../iio:deviceX/out_altvoltageX_scale_available
>  What:                /sys/.../iio:deviceX/in_capacitance_scale_available
>  KernelVersion:       2.635
>  Contact:     linux-iio@vger.kernel.org
> @@ -291,14 +293,19 @@ Description:
>               gives the 3dB frequency of the filter in Hz.
>
>  What:                /sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
> +What:                /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_raw
>  KernelVersion:       2.6.37
>  Contact:     linux-iio@vger.kernel.org
>  Description:
>               Raw (unscaled, no bias etc.) output voltage for
>               channel Y.  The number must always be specified and
>               unique if the output corresponds to a single channel.
> +             While DAC like devices typically use out_voltage,
> +             a continuous frequency generating device, such as
> +             a DDS or PLL should use out_altvolatge.
>
>  What:                /sys/bus/iio/devices/iio:deviceX/out_voltageY&Z_raw
> +What:
>       /sys/bus/iio/devices/iio:deviceX/out_altvoltageY&Z_raw
>  KernelVersion:       2.6.37
>  Contact:     linux-iio@vger.kernel.org
>  Description:
> @@ -309,6 +316,8 @@ Description:
>
>  What:
>       /sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown_mode
>  What:
>       /sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown_mode
> +What:
>       /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown_mode
> +What:
>       /sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown_mode
>  KernelVersion:       2.6.38
>  Contact:     linux-iio@vger.kernel.org
>  Description:
> @@ -323,6 +332,8 @@ Description:
>
>  What:
>       /sys/.../iio:deviceX/out_votlageY_powerdown_mode_available
>  What:
>       /sys/.../iio:deviceX/out_voltage_powerdown_mode_available
> +What:
>       /sys/.../iio:deviceX/out_altvotlageY_powerdown_mode_available
> +What:
>       /sys/.../iio:deviceX/out_altvoltage_powerdown_mode_available
>  KernelVersion:       2.6.38
>  Contact:     linux-iio@vger.kernel.org
>  Description:
> @@ -331,6 +342,8 @@ Description:
>
>  What:
>       /sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
>  What:
>       /sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
> +What:
>       /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
> +What:
>       /sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown
>  KernelVersion:       2.6.38
>  Contact:     linux-iio@vger.kernel.org
>  Description:
> @@ -339,6 +352,24 @@ Description:
>               normal operation. Y may be suppressed if all outputs are
>               controlled together.
>
> +What:
>       /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
> +KernelVersion:       3.4.0
> +Contact:     linux-iio@vger.kernel.org
> +Description:
> +             Output frequency for channel Y in Hz. The number must
> always be
> +             specified and unique if the output corresponds to a single
> +             channel.
> +
> +What:
>       /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
> +KernelVersion:       3.4.0
> +Contact:     linux-iio@vger.kernel.org
> +Description:
> +             Phase in radians of one frequency/clock output Y
> +             (out_altvoltageY) relative to another frequency/clock
> output
> +             (out_altvoltageZ) of the device X. The number must always
> be
> +             specified and unique if the output corresponds to a single
> +             channel.
> +
>  What:                /sys/bus/iio/devices/iio:deviceX/events
>  KernelVersion:       2.6.35
>  Contact:     linux-iio@vger.kernel.org
> --
> 1.7.0.4


