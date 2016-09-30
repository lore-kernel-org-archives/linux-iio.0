Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34848 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933334AbcI3QXg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2016 12:23:36 -0400
MIME-Version: 1.0
In-Reply-To: <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com>
From: Christ van Willegen <cvwillegen@gmail.com>
Date: Fri, 30 Sep 2016 18:23:14 +0200
Message-ID: <CA+Ot1Owa_evu62LJpH+TdUkLWd0n+0Dm30Q1-5KFJ6w_UBPfQQ@mail.gmail.com>
Subject: Re: [Letux-kernel] [PATCH v3 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I saw this earlier, but didn't think it important to mention, but:


On Fri, Sep 23, 2016 at 2:41 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:

> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
> index 5d0cd51..9a11509 100644
> --- a/drivers/input/touchscreen/tsc2007.c
> +++ b/drivers/input/touchscreen/tsc2007.c

> +                       /* scale ADC values to desired output range */
> +                       sx = (ts->prop.max_x * (tc.x - ts->min_x))
> +                               / (ts->max_x - ts->min_x);
> +                       sy = (ts->prop.max_y * (tc.y - ts->min_y))
> +                               / (ts->max_y - ts->min_y);
> +                       rt = (input->absinfo[ABS_PRESSURE].maximum * rt) /
> +                               ts->max_rt;

If ts->max_rt is zero, or ts->max_x == ts->min_x, or ts->max_y ==
ts->min_y, these yield a division by zero error.

Ofcourse, this is under control of the DT-maintainer(s) of the device
(if I'm not mistaking), but throwing an error on DT parse if (one of)
these condition(s) is met yields better info to the DT-maintainer than
a /0 error...

If you (or others) agree, could you add this to the patch?

Regards,

Christ van Willegen
