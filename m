Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43362 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdCYQkA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 12:40:00 -0400
Subject: Re: [PATCH v3 2/4] iio: Documentation: Add max9611 sysfs
 documentation
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
 <1490369323-13866-3-git-send-email-jacopo+renesas@jmondi.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b87974aa-a9f5-9af6-af7f-1b2176deb83b@kernel.org>
Date: Sat, 25 Mar 2017 16:32:52 +0000
MIME-Version: 1.0
In-Reply-To: <1490369323-13866-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/17 15:28, Jacopo Mondi wrote:
> Add documentation for max9611 driver.
> Document attributes describing value of shunt resistor installed between
> RS+ and RS- voltage sense inputs.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
> new file mode 100644
> index 0000000..9c60824
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor_power
> +Date:		March 2017
> +KernelVersion:	4.12
> +Contact:	linux-iio@vger.kernel.org
> +Description: 	The value of the shunt resistor used to compute power drain on
> +                common input voltage pin (RS+). In micro Ohms.
Unfortunately this has ended up with a name that made me initially think it was
the power rating of the resistor in question (why we'd want to know that I've no
idea).  We might need to make this even more explicit to avoid idiots like me ;)

It's the shunt resistor for the power measurement so I think it should probably be...
in_power_shunt_resistance
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor_current
> +Date:		March 2017
> +KernelVersion:	4.12
> +Contact:	linux-iio@vger.kernel.org
> +Description: 	The value of the shunt resistor used to compute current flowing
> +                between RS+ and RS- voltage sense inputs. In micro Ohms.
> +		This attributes describe a single physical component, exposed
> +		as two distinct attributes as it is used to calculate two
> +		different values.
> 
Same as above...

Jonathan

