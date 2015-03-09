Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43387 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbCINbH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 09:31:07 -0400
Message-ID: <54FDA09A.6060705@kernel.org>
Date: Mon, 09 Mar 2015 13:31:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/9] iio: doc: Describe scale attributes for event thresholds
References: <20150219141553.27001.18825.stgit@localhost> <20150219141604.27001.24235.stgit@localhost>
In-Reply-To: <20150219141604.27001.24235.stgit@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/02/15 14:16, Martin Fuzzey wrote:
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Applied to the togreg branch of iio.git. 
These have been in the effective ABI for a while even if
we didn't have them documented so this patch stands
fine on it's own.

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ab592dd..d15a61d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -613,6 +613,24 @@ Description:
>  		value is in raw device units or in processed units (as _raw
>  		and _input do on sysfs direct channel read attributes).
>  
> +What:		/sys/.../events/in_accel_scale
> +What:		/sys/.../events/in_accel_peak_scale
> +What:		/sys/.../events/in_anglvel_scale
> +What:		/sys/.../events/in_magn_scale
> +What:		/sys/.../events/in_rot_from_north_magnetic_scale
> +What:		/sys/.../events/in_rot_from_north_true_scale
> +What:		/sys/.../events/in_voltage_scale
> +What:		/sys/.../events/in_voltage_supply_scale
> +What:		/sys/.../events/in_temp_scale
> +What:		/sys/.../events/in_illuminance_scale
> +What:		/sys/.../events/in_proximity_scale
> +KernelVersion:	3.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Specifies the conversion factor from the standard units
> +                to device specific units used to set the event trigger
> +                threshold.
> +
>  What:		/sys/.../events/in_accel_x_thresh_rising_hysteresis
>  What:		/sys/.../events/in_accel_x_thresh_falling_hysteresis
>  What:		/sys/.../events/in_accel_x_thresh_either_hysteresis
> 

