Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46405 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdBYQEo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 11:04:44 -0500
Subject: Re: [PATCH 2/4] iio: Documentation: Add max961x sysfs documentation
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, meerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
 <1487948756-25172-3-git-send-email-jacopo+renesas@jmondi.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56b35a65-a23d-68ac-17d6-cf46f9352ab7@kernel.org>
Date: Sat, 25 Feb 2017 15:54:45 +0000
MIME-Version: 1.0
In-Reply-To: <1487948756-25172-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/02/17 15:05, Jacopo Mondi wrote:
> Add documentation for max961x driver.
> The only attribute to document is the current sense shunt resistor
> value.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Interestingly generic as it only applies to some of the channels.
We might need to have the channel where it is effecting the output specified in the
name, even if we end up with several repeats of the same thing for different
computed channels.

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-max961x | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max961x b/Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
> new file mode 100644
> index 0000000..dbd5e75
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
> @@ -0,0 +1,5 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
> +Date:		February 2017
> +KernelVersion:	4.10
> +Contact:	linux-iio@vger.kernel.org
> +Description: 	The value of the shunt resistor in micro Ohms.
> 

