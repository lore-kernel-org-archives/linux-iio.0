Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46981 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab2IHJdi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Sep 2012 05:33:38 -0400
Message-ID: <504B10EB.7090401@kernel.org>
Date: Sat, 08 Sep 2012 10:33:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	"J. August Brenner" <jbrenner@taosinc.com>
Subject: Re: [PATCH] iio staging: cleanup documentation for tsl2583
References: <1346951329-20693-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1346951329-20693-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/06/2012 06:08 PM, Peter Meerwald wrote:
> drop Documentation/sysfs-bus-iio-light-tsl2583 and merge content with
> Documentation/light/sysfs-bus-iio-light-tsl2583 together with some obvious
> fixes:
> in_illuminance0_calibrate -> illuminance0_calibrate

Hmm. arguably it is the driver that is wrong for this first one, not the
documentation.  If we ever put calibrate into the core it will be named
in_illuminance0_calibrate given it is easier to over specify the channel
type than to work out when we don't need to say it is an input.

Otherwise a sensible patch.

Jon, would how much pain would changing the interface to add the in_ prefix
hurt your customers?  At an absolute push we could keep the existing and add
a version with the in_ prefix as well (and the deprecate the old one over
a couple of cycles).

On another note, we should look at doing any other cleanup (beyond this
good work by Peter!) with a view to getting the TAOS light drivers out of
staging...


> lux_table -> illuminance0_lux_table
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: J. August Brenner <jbrenner@taosinc.com>
> ---
>  .../light/sysfs-bus-iio-light-tsl2583              |   16 +++++++++++++++-
>  .../iio/Documentation/sysfs-bus-iio-light-tsl2583  |   20 --------------------
>  2 files changed, 15 insertions(+), 21 deletions(-)
>  delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
> 
> diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583 b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
> index 470f7ad..e9716b9 100644
> --- a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
> +++ b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
> @@ -1,6 +1,20 @@
> -What:		/sys/bus/iio/devices/device[n]/in_illuminance0_calibrate
> +What:		/sys/bus/iio/devices/device[n]/illuminance0_lux_table
> +KernelVersion:	2.6.37
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This property gets/sets the table of coefficients
> +		used in calculating illuminance in lux.
> +
> +What:		/sys/bus/iio/devices/device[n]/illuminance0_calibrate
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		This property causes an internal calibration of the als gain trim
>  		value which is later used in calculating illuminance in lux.
> +
> +What:		/sys/bus/iio/devices/device[n]/illuminance0_input_target
> +KernelVersion:	2.6.37
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This property is the known externally illuminance (in lux).
> +		It is used in the process of calibrating the device accuracy.
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583 b/drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
> deleted file mode 100644
> index 660781d..0000000
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -What:		/sys/bus/iio/devices/device[n]/lux_table
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This property gets/sets the table of coefficients
> -		used in calculating illuminance in lux.
> -
> -What:		/sys/bus/iio/devices/device[n]/illuminance0_calibrate
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This property causes an internal calibration of the als gain trim
> -		value which is later used in calculating illuminance in lux.
> -
> -What:		/sys/bus/iio/devices/device[n]/illuminance0_input_target
> -KernelVersion:	2.6.37
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This property is the known externally illuminance (in lux).
> -		It is used in the process of calibrating the device accuracy.
> 
