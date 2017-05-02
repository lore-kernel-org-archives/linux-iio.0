Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36504 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdEBTVP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2017 15:21:15 -0400
MIME-Version: 1.0
In-Reply-To: <1491488454-22468-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org> <1491488454-22468-3-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 May 2017 21:21:13 +0200
Message-ID: <CAMuHMdUVRO3y+BfU1ynWuRddOOB59DgpbnmXMbYopT6RQ5K8BQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] iio: Documentation: Add max9611 sysfs documentation
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jacopo,

On Thu, Apr 6, 2017 at 4:20 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add documentation for max9611 driver.
> Document attributes describing value of shunt resistor installed between
> RS+ and RS- voltage sense inputs.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
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
> +What:          /sys/bus/iio/devices/iio:deviceX/in_power_shunt_resistor
> +Date:          March 2017
> +KernelVersion: 4.12
> +Contact:       linux-iio@vger.kernel.org
> +Description:   The value of the shunt resistor used to compute power drain on
> +                common input voltage pin (RS+). In Ohms.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/in_current_shunt_resistor
> +Date:          March 2017
> +KernelVersion: 4.12
> +Contact:       linux-iio@vger.kernel.org
> +Description:   The value of the shunt resistor used to compute current flowing
> +                between RS+ and RS- voltage sense inputs. In Ohms.
> +
> +These attributes describe a single physical component, exposed as two distinct
> +attributes as it is used to calculate two different values: power load and
> +current flowing between RS+ and RS- inputs.

On my Salvator-X, the value is "5.000", which matches milli-Ohms?

DT says: "shunt-resistor-micro-ohms = <5000>;"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
