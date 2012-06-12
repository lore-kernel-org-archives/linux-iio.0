Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:43721 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab2FLKvV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jun 2012 06:51:21 -0400
Message-ID: <4FD71F27.9010001@cam.ac.uk>
Date: Tue, 12 Jun 2012 11:51:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: nitpicking on sysfs-bus-iio
References: <1339494541-15018-1-git-send-email-pmeerw@pmeerw.net> <1339494541-15018-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339494541-15018-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/12/2012 10:49 AM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
Thanks for doing this.  I'm fine with the vast majority of these.
Exceptions are the period after etc.
and I'd prefer the powerdown mode options to be documented
under the current location. +  they are not examples
but rather the complete list of accepted options. Any
new ones must be documented here (if any have slipped
by do point them out!).

> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
>
> ---
>   Documentation/ABI/testing/sysfs-bus-iio |   58 +++++++++++++++----------------
>   1 files changed, 28 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5bc8a47..8b0dc4f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -42,7 +42,7 @@ Description:
>   		resulting sampling frequency.  In many devices this
>   		parameter has an effect on input filters etc rather than
>   		simply controlling when the input is sampled.  As this
> -		effects datardy triggers, hardware buffers and the sysfs
> +		effects data ready triggers, hardware buffers and the sysfs
>   		direct access interfaces, it may be found in any of the
>   		relevant directories.  If it effects all of the above
>   		then it is to be found in the base device directory.
> @@ -148,10 +148,9 @@ KernelVersion:	2.6.35
>   Contact:	linux-iio@vger.kernel.org
>   Description:
>   		Angular velocity about axis x, y or z (may be arbitrarily
> -		assigned) Data converted by application of offset then scale to
> -		radians per second. Has all the equivalent parameters as
> -		per voltageY. Units after application of scale and offset are
> -		radians per second.
> +		assigned). Has all the equivalent parameters as	per voltageY.
> +		Units after application of scale and offset are	radians per
> +		second.
>
>   What:		/sys/bus/iio/devices/iio:deviceX/in_incli_x_raw
>   What:		/sys/bus/iio/devices/iio:deviceX/in_incli_y_raw
> @@ -161,7 +160,7 @@ Contact:	linux-iio@vger.kernel.org
>   Description:
>   		Inclination raw reading about axis x, y or z (may be
>   		arbitrarily assigned). Data converted by application of offset
> -		and scale to Degrees.
> +		and scale to degrees.
>
>   What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_raw
>   What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_raw
> @@ -203,7 +202,7 @@ Contact:	linux-iio@vger.kernel.org
>   Description:
>   		If known for a device, offset to be added to<type>[Y]_raw prior
>   		to scaling by<type>[Y]_scale in order to obtain value in the
> -		<type>  units as specified in<type>[y]_raw documentation.
> +		<type>  units as specified in<type>[Y]_raw documentation.
>   		Not present if the offset is always 0 or unknown. If Y or
>   		axis<x|y|z>  is not present, then the offset applies to all
>   		in channels of<type>.
> @@ -248,7 +247,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibbias
>   KernelVersion:	2.6.35
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> -		Hardware applied calibration offset. (assumed to fix production
> +		Hardware applied calibration offset (assumed to fix production
>   		inaccuracies).
>
>   What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
> @@ -265,7 +264,7 @@ what		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
>   KernelVersion:	2.6.35
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> -		Hardware applied calibration scale factor. (assumed to fix
> +		Hardware applied calibration scale factor (assumed to fix
>   		production inaccuracies).  If shared across all channels,
>   		<type>_calibscale is used.
>
> @@ -277,7 +276,7 @@ What:		/sys/.../iio:deviceX/in_capacitance_scale_available
>   KernelVersion:	2.635
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> -		If a discrete set of scale values are available, they
> +		If a discrete set of scale values is available, they
>   		are listed in this attribute.
>
>   What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
> @@ -301,7 +300,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
>   KernelVersion:	2.6.37
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> -		Raw (unscaled, no bias etc.) output voltage for
> +		Raw (unscaled, no bias etc) output voltage for
>   		channel Y.  The number must always be specified and
>   		unique if the output corresponds to a single channel.
>
> @@ -309,7 +308,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY&Z_raw
>   KernelVersion:	2.6.37
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> -		Raw (unscaled, no bias etc.) output voltage for an aggregate of
> +		Raw (unscaled, no bias etc) output voltage for an aggregate of
etc should always be followed by a period...
>   		channel Y, channel Z, etc.  This interface is available in cases
>   		where a single output sets the value for multiple channels
>   		simultaneously.
> @@ -319,22 +318,20 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown_mode
>   KernelVersion:	2.6.38
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> -		Specifies the output powerdown mode.
> -		DAC output stage is disconnected from the amplifier and
> -		1kohm_to_gnd: connected to ground via an 1kOhm resistor
> -		100kohm_to_gnd: connected to ground via an 100kOhm resistor
> -		three_state: left floating
> -		For a list of available output power down options read
> -		outX_powerdown_mode_available. If Y is not present the
> -		mode is shared across all outputs.
> +		Specifies the output powerdown mode. For a list of available
> +		output power down options read outX_powerdown_mode_available.
> +		If Y is	not present the	mode is shared across all outputs.
>
>   What:		/sys/.../iio:deviceX/out_votlageY_powerdown_mode_available
>   What:		/sys/.../iio:deviceX/out_voltage_powerdown_mode_available
>   KernelVersion:	2.6.38
>   Contact:	linux-iio@vger.kernel.org
>   Description:
> -		Lists all available output power down modes.
> -		If Y is not present the mode is shared across all outputs.
> +		Lists all available output power down modes (e.g. 1kohm_to_gnd:
> +		connected to ground via an 1kOhm resistor, 100kohm_to_gnd:
> +		connected to ground via an 100kOhm resistor, three_state:
> +		left floating).	If Y is not present the mode is shared across
> +		all outputs.
I'd rather see the listing under out_voltageY_powerdown_mode than here.
That's the key sysfs element, this one is just a convenient listing of 
what is available.
>
>   What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
>   What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
> @@ -342,9 +339,10 @@ KernelVersion:	2.6.38
>   Contact:	linux-iio@vger.kernel.org
>   Description:
>   		Writing 1 causes output Y to enter the power down mode specified
> -		by the corresponding outY_powerdown_mode. Clearing returns to
> -		normal operation. Y may be suppressed if all outputs are
> -		controlled together.
> +		by the corresponding outY_powerdown_mode. DAC output stage is
> +		disconnected from the amplifier.Clearing returns to normal
> +		operation. Y may be suppressed if all outputs are controlled
> +		together.
>
>   What:		/sys/bus/iio/devices/iio:deviceX/events
>   KernelVersion:	2.6.35
> @@ -390,12 +388,12 @@ Description:
>   		different values, but the device can only enable both thresholds
>   		or neither.
>   		Note the driver will assume the last p events requested are
> -		to be enabled where p is however many it supports (which may
> -		vary depending on the exact set requested. So if you want to be
> +		to be enabled where p is how many it supports (which may vary
> +		depending on the exact set requested. So if you want to be
>   		sure you have set what you think you have, check the contents of
>   		these attributes after everything is configured. Drivers may
>   		have to buffer any parameters so that they are consistent when
> -		a given event type is enabled a future point (and not those for
> +		a given event type is enabled at a future point (and not those for
>   		whatever event was previously enabled).
>
>   What:		/sys/.../iio:deviceX/events/in_accel_x_roc_rising_en
> @@ -671,7 +669,7 @@ What:		/sys/.../buffer/scan_elements/in_anglvel_type
>   What:		/sys/.../buffer/scan_elements/in_magn_type
>   What:		/sys/.../buffer/scan_elements/in_incli_type
>   What:		/sys/.../buffer/scan_elements/in_voltageY_type
> -What:		/sys/.../buffer/scan_elements/in_voltage-in_type
> +What:		/sys/.../buffer/scan_elements/in_voltage_type
>   What:		/sys/.../buffer/scan_elements/in_voltageY_supply_type
>   What:		/sys/.../buffer/scan_elements/in_timestamp_type
>   KernelVersion:	2.6.37
> @@ -692,7 +690,7 @@ Description:
>   		the buffer output value appropriately.  The storagebits value
>   		also specifies the data alignment.  So s48/64>>2 will be a
>   		signed 48 bit integer stored in a 64 bit location aligned to
> -		a a64 bit boundary. To obtain the clean value, shift right 2
> +		a 64 bit boundary. To obtain the clean value, shift right 2
>   		and apply a mask to zero the top 16 bits of the result.
>   		For other storage combinations this attribute will be extended
>   		appropriately.

