Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46445 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbdA1Qjk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 11:39:40 -0500
Subject: Re: [PATCH v4 3/3] iio: distance: srf08: add driver ABI documentation
To: Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ktsai@capellamicro.com,
        wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, trivial@kernel.org, mranostay@gmail.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
References: <20170125190747.GA9285@andreas>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a37b9fc9-f69a-6e4d-4c82-a9a29ea939d5@kernel.org>
Date: Sat, 28 Jan 2017 16:39:38 +0000
MIME-Version: 1.0
In-Reply-To: <20170125190747.GA9285@andreas>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/01/17 19:07, Andreas Klinger wrote:
> Add sysfs-bus-iio-distance-srf08 for individual attributes of the driver,
> especially:
>  - sensitivity which the device documentation calls gain for amplifying the
>    signal
>  - max_range for limiting the maximum distance for expected echos and
>    therefore limiting the time waiting for telegrams
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Nice clear docs.  Thanks,

Applied.
> ---
>  .../ABI/testing/sysfs-bus-iio-distance-srf08       | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> new file mode 100644
> index 000000000000..0a1ca1487fa9
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> @@ -0,0 +1,22 @@
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
> +                Show or set the maximum range between the sensor and the
> +		first object echoed in meters. Default value is 6.020.
> +		This setting limits the time the driver is waiting for a
> +		echo.
> +		Showing the range of available values is represented as the
> +		minimum value, the step and the maximum value, all enclosed
> +		in square brackets.
> +		Example:
> +		[0.043 0.043 11.008]
> 

