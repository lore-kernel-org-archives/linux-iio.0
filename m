Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37932 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdDHQAu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 12:00:50 -0400
Subject: Re: [PATCH v5 2/4] iio: Documentation: Add max9611 sysfs
 documentation
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org>
 <1491488454-22468-3-git-send-email-jacopo+renesas@jmondi.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ca3b2b44-56ca-6bb3-cd8d-40c0a11a4073@kernel.org>
Date: Sat, 8 Apr 2017 17:00:48 +0100
MIME-Version: 1.0
In-Reply-To: <1491488454-22468-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/17 15:20, Jacopo Mondi wrote:
> Add documentation for max9611 driver.
> Document attributes describing value of shunt resistor installed between
> RS+ and RS- voltage sense inputs.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Looks good to me.  There is the small matter that when we generalize this
we will probably loose some detail, but such is life.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
> new file mode 100644
> index 0000000..6d2d2b0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
> @@ -0,0 +1,17 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_power_shunt_resistor
> +Date:		March 2017
> +KernelVersion:	4.12
> +Contact:	linux-iio@vger.kernel.org
> +Description: 	The value of the shunt resistor used to compute power drain on
> +                common input voltage pin (RS+). In Ohms.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current_shunt_resistor
> +Date:		March 2017
> +KernelVersion:	4.12
> +Contact:	linux-iio@vger.kernel.org
> +Description: 	The value of the shunt resistor used to compute current flowing
> +                between RS+ and RS- voltage sense inputs. In Ohms.
> +
> +These attributes describe a single physical component, exposed as two distinct
> +attributes as it is used to calculate two different values: power load and
> +current flowing between RS+ and RS- inputs.
> 

