Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36512 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZIjM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 04:39:12 -0400
MIME-Version: 1.0
In-Reply-To: <1490369323-13866-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org> <1490369323-13866-3-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 26 Mar 2017 10:38:24 +0200
Message-ID: <CAMuHMdUMksHLC_0Nnhi=vWHTgQLbHMRdpWCCM4S3Bew+i1ffKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: Documentation: Add max9611 sysfs documentation
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

On Fri, Mar 24, 2017 at 4:28 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
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
> +What:          /sys/bus/iio/devices/iio:deviceX/in_shunt_resistor_power
> +Date:          March 2017
> +KernelVersion: 4.12
> +Contact:       linux-iio@vger.kernel.org
> +Description:   The value of the shunt resistor used to compute power drain on
> +                common input voltage pin (RS+). In micro Ohms.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/in_shunt_resistor_current
> +Date:          March 2017
> +KernelVersion: 4.12
> +Contact:       linux-iio@vger.kernel.org
> +Description:   The value of the shunt resistor used to compute current flowing
> +                between RS+ and RS- voltage sense inputs. In micro Ohms.

I'd add a blank line here, to make it clear the following paragraph applies
to both attributes above.

> +               This attributes describe a single physical component, exposed

These attributes

> +               as two distinct attributes as it is used to calculate two
> +               different values.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
