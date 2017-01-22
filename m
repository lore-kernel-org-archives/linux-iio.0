Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40408 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdAVNtU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 08:49:20 -0500
Subject: Re: [PATCH v3 3/3] iio: distance: srf08: add driver ABI documentation
To: Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ktsai@capellamicro.com,
        wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, trivial@kernel.org, mranostay@gmail.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
References: <20170117135006.GA22903@andreas>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2e87aeed-a611-e160-c245-f5b16f2ef304@kernel.org>
Date: Sun, 22 Jan 2017 13:41:02 +0000
MIME-Version: 1.0
In-Reply-To: <20170117135006.GA22903@andreas>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 13:50, Andreas Klinger wrote:
> Add sysfs-bus-iio-distance-srf08 for individual attributes of the driver,
> especially:
>  - sensitivity which the device documentation calls gain for amplifying the
>    signal
>  - max_range for limiting the maximum distance for expected echos and
>    therefore limiting the time waiting for telegrams
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../ABI/testing/sysfs-bus-iio-distance-srf08       | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> new file mode 100644
> index 000000000000..e96c28064748
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> @@ -0,0 +1,27 @@
> +What		/sys/bus/iio/devices/iio:deviceX/in_distance_raw
> +Date:		January 2017
> +KernelVersion:	4.11
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Get the current distance in meters between the sensor and
> +		the first object recognized
Generally no need to document what are effectively standard elements.
Just leads to the possibility of disagreements in the docs! 
Still no harm here really.
> +
> +What		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
> +Date:		January 2017
> +KernelVersion:	4.11
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Show or set the gain boost of the amp, from 0-31 range.
> +		default 31
> +
> +What		/sys/bus/iio/devices/iio:deviceX/sensor_max_range
> +Date:		January 2017
> +KernelVersion:	4.11
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Show or set the maximum range between the sensor and the
> +		first object echoed in millimeters.
> +		This setting limits the time the driver is waiting for a
> +		echo.
> +		Can be set between 43 and 11008 in a grid of 43 mm.
> +		default 6020
This needs to be in the same units as the range - so m.
I'm not 100% sure this is the best ABI we can do for this. However, supporting
this as a legacy abi if we come up with something more general will be a very
small burden, so lets not stall the driver on this!

Jonathan
> 

