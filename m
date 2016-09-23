Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35234 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbcIWWr2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2016 18:47:28 -0400
Date: Fri, 23 Sep 2016 17:47:26 -0500
From: Rob Herring <robh@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Message-ID: <20160923224726.GA4639@rob-hp-laptop>
References: <cover.1474634475.git.hns@goldelico.com>
 <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 23, 2016 at 02:41:09PM +0200, H. Nikolaus Schaller wrote:
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
> 
> A new feature is to introduce scaling the min/max ADC values to the screen
> size.
> 
> This makes it possible to pre-calibrate the touch so that is (almost)
> exactly matches the LCD pixel coordinates it is glued onto. This allows to
> well enough operate the touch before a user space calibration step can
> improve the precision.
> 
> Finally, calculate_pressure has been renamed to calculate_resistance
> because that is what it is doing.

Seems like you are breaking compatibility with old DTs. I can't tell for 
sure though.

> 
> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../bindings/input/touchscreen/tsc2007.txt         |  20 ++--
>  drivers/input/touchscreen/tsc2007.c                | 126 +++++++++++++++++----
>  include/linux/i2c/tsc2007.h                        |   8 ++
>  3 files changed, 123 insertions(+), 31 deletions(-)
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

Seems like these could be common too. They make more sense than giving x 
and y sizes in pixel units which really should come from the panel.

>  - ti,poll-period: how much time to wait (in milliseconds) before reading again the
> -  values from the tsc2007.
> +  values from the tsc2007 (default 1).
>  
>  [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> +[2]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>  
>  Example:
>  	&i2c1 {
> @@ -35,6 +39,8 @@ Example:
>  			interrupts = <0x0 0x8>;
>  			gpios = <&gpio4 0 0>;
>  			ti,x-plate-ohms = <180>;
> +			touchscreen-size-x = <640>;
> +			touchscreen-size-y = <480>;
>  		};
>  
>  		/* ... */
