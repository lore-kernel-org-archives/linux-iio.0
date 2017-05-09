Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36692 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdEILxP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2017 07:53:15 -0400
MIME-Version: 1.0
In-Reply-To: <1494316677-26324-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1494316677-26324-1-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 May 2017 13:53:13 +0200
Message-ID: <CAMuHMdV4T02orob33-WRuGWnp2P4n2063UahrS8mWdRAnhd-HQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max9611: Fix attribute measure unit
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jacopo,

On Tue, May 9, 2017 at 9:57 AM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> The power and current "shunt-resistor" attribute's 'show' function
> displays the resistor value in milli-Ohms, while the ABI description
> specifies it should be displayed in Ohms. Fix it.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

# cat /sys/bus/iio/devices/iio:device*/in_*_shunt_resistor
0.005000
0.005000
0.005000
0.005000
#

$ grep shunt-resistor -- arch/arm64/boot/dts/renesas/salvator-x.dtsi
shunt-resistor-micro-ohms = <5000>;
shunt-resistor-micro-ohms = <5000>;
$

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/iio/adc/max9611.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index ec82106..4580ebd 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -438,10 +438,10 @@ static ssize_t max9611_shunt_resistor_show(struct device *dev,
>         struct max9611_dev *max9611 = iio_priv(dev_to_iio_dev(dev));
>         unsigned int i, r;
>
> -       i = max9611->shunt_resistor_uohm / 1000;
> -       r = max9611->shunt_resistor_uohm % 1000;
> +       i = max9611->shunt_resistor_uohm / 1000000;
> +       r = max9611->shunt_resistor_uohm % 1000000;
>
> -       return sprintf(buf, "%u.%03u\n", i, r);
> +       return sprintf(buf, "%u.%06u\n", i, r);
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
