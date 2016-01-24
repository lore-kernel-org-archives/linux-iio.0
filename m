Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45533 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbcAXQb0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2016 11:31:26 -0500
Subject: Re: [PATCH] Staging: iio: Documentation: Remove unused sysfs
 attributes
To: Shraddha Barke <shraddha.6596@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Jon Brenner <Jon.Brenner@ams.com>
References: <1453359179-9675-1-git-send-email-shraddha.6596@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A4FC5B.30100@kernel.org>
Date: Sun, 24 Jan 2016 16:31:23 +0000
MIME-Version: 1.0
In-Reply-To: <1453359179-9675-1-git-send-email-shraddha.6596@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/01/16 06:52, Shraddha Barke wrote:
> This patch removes the unused sysfs attributes range, range_available,
> adc_resolution and adc_resolution_available.
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
Applied,

If you are of a mind to do it, it would also be good to prune general attributes
that are mirrored in Documentation/ABI/testing/sysfs-bus-iio* out of this staging
version as well.

That would clear
in_illuminance0_[raw|input]
in_proximity0_[raw|input]
intensity_infrared_[raw|input] (though this one is bogus anyway given the lack of prefix).
in_illuminance0_integration_time
in_intensity_clear...
in_intensity_red... (though curiously some of these are not documented in the Documentation
dir but should be as their integration_time parts are!)

Other elements in here don't look to be used in staging either so could at least be dropped
from this file.

CCT. I'm having trouble remembering which part resulted in this being added!  It was a
patch from Jon at TAOS (now AMS).  cc'd on off chance he can provide more info or get
back to us with a driver or two ;) I'd actually be inclined to just move this particular
bit of documentation directly to the non staging file. It's used by out of tree drivers
(presumably given Jon had some reason to propose it) and supported by the core so
lets just lift the ABI doc out of staging.

lux_table - this was always black magic and part specific - nasty non linear mappings -
not much we can do about this one so leave it there until the two taos driver using it
move out of staging then stick it in a taos specific ABI doc.
target - much the same.
on_chip_ambient_infrared_supression - much the same.

Anyhow, just a few thoughts.  Keep up the good work!

Jonathan


> ---
>  .../staging/iio/Documentation/sysfs-bus-iio-light  | 28 ----------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> index 17e5c9c..7c7cd84 100644
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
> @@ -1,31 +1,3 @@
> -
> -What:		/sys/bus/iio/devices/device[n]/range
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Hardware dependent ADC Full Scale Range used for some ambient
> -		light sensors in calculating lux.
> -
> -What:		/sys/bus/iio/devices/device[n]/range_available
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Hardware dependent supported vales for ADC Full Scale Range.
> -
> -What:		/sys/bus/iio/devices/device[n]/adc_resolution
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Hardware dependent ADC resolution of the ambient light sensor
> -		used in calculating the lux.
> -
> -What:		/sys/bus/iio/devices/device[n]/adc_resolution_available
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Hardware dependent list of possible values supported for the
> -		adc_resolution of the given sensor.
> -
>  What:		/sys/bus/iio/devices/device[n]/in_illuminance0[_input|_raw]
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
> 

