Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934907AbcJRQXL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Oct 2016 12:23:11 -0400
MIME-Version: 1.0
In-Reply-To: <76746b85957c9f3ef7101a7ee883898a414cabd8.1476712675.git.hns@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com> <76746b85957c9f3ef7101a7ee883898a414cabd8.1476712675.git.hns@goldelico.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 18 Oct 2016 11:22:43 -0500
Message-ID: <CAL_JsqJhzZC6Hw3eRLFDiBA8jih=N507WvEh=TRbPhLS9EjhBQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        letux-kernel@openphoenux.org,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 17, 2016 at 8:57 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
> introduced common DT bindings for touchscreens [1] and a helper function to
> parse the DT.
>
> commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted / swapped axes")
> added another helper for parsing axis inversion and swapping
> and applying them to x and y coordinates.
>
> Both helpers have been integrated to accommodate any orientation of the
> touch panel in relation to the LCD.

Please add the explanation of why this is a compatible change here.

> A new feature is to introduce scaling the min/max ADC values to the screen
> size.

Sounds like a separate change.

> This makes it possible to pre-calibrate the touch so that is (almost)
> exactly matches the LCD pixel coordinates it is glued onto. This allows to
> well enough operate the touch before a user space calibration step can
> improve the precision.
>
> Finally, calculate_pressure has been renamed to calculate_resistance
> because that is what it is doing.
>
> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../bindings/input/touchscreen/tsc2007.txt         |  20 ++--
>  drivers/input/touchscreen/tsc2007.c                | 120 +++++++++++++++++----
>  include/linux/i2c/tsc2007.h                        |   8 ++
>  3 files changed, 118 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> index ec365e1..6e9fd55 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> @@ -6,6 +6,7 @@ Required properties:
>  - ti,x-plate-ohms: X-plate resistance in ohms.
>
>  Optional properties:
> +- generic touch screen properties: see touchscreen binding [2].
>  - gpios: the interrupt gpio the chip is connected to (trough the penirq pin).
>    The penirq pin goes to low when the panel is touched.
>    (see GPIO binding[1] for more details).
> @@ -13,17 +14,20 @@ Optional properties:
>    (see interrupt binding[0]).
>  - interrupts: (gpio) interrupt to which the chip is connected
>    (see interrupt binding[0]).
> -- ti,max-rt: maximum pressure.
> -- ti,fuzzx: specifies the absolute input fuzz x value.
> -  If set, it will permit noise in the data up to +- the value given to the fuzz
> -  parameter, that is used to filter noise from the event stream.
> -- ti,fuzzy: specifies the absolute input fuzz y value.
> -- ti,fuzzz: specifies the absolute input fuzz z value.
> +- ti,max-rt: maximum pressure resistance above which samples are ignored
> +  (default: 4095).
> +- ti,report-resistance: report resistance (no pressure = max_rt) instead
> +  of pressure (no pressure = 0).
> +- ti,min-x: minimum value reported by X axis ADC (default 0).
> +- ti,max-x: maximum value reported by X axis ADC (default 4095).
> +- ti,min-y: minimum value reported by Y axis ADC (default 0).
> +- ti,max-y: maximum value reported by Y axis ADC (default 4095).

I thought these were going to be common? I think they should be.

Rob

>  - ti,poll-period: how much time to wait (in milliseconds) before reading again the
> -  values from the tsc2007.
> +  values from the tsc2007 (default 1).
>
>  [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> +[2]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>
>  Example:
>         &i2c1 {
> @@ -35,6 +39,8 @@ Example:
>                         interrupts = <0x0 0x8>;
>                         gpios = <&gpio4 0 0>;
>                         ti,x-plate-ohms = <180>;
> +                       touchscreen-size-x = <640>;
> +                       touchscreen-size-y = <480>;
>                 };
>
>                 /* ... */
