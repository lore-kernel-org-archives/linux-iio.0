Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34222 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759508AbcLWKAV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2016 05:00:21 -0500
MIME-Version: 1.0
In-Reply-To: <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de> <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de> <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
 <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com> <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Dec 2016 11:00:13 +0100
Message-ID: <CAMuHMdX3u4cb2Yq2+VV_eDUaw2EqiOjN2TorW+F5-39Mm=mXmQ@mail.gmail.com>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

On Mon, Dec 12, 2016 at 6:15 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 12/06/2016 12:12 PM, Bartosz Golaszewski wrote:
>> We're already using libiio to read the measured data from the power
>> monitor, that's why we'd like to use the iio framework for
>> power-cycling the devices as well. My question is: would bridging the
>> regulator framework be the right solution? Should we look for
>> something else? Bridge the GPIO framework instead?
>
> I wouldn't necessaries create bridge, but instead just use the GPIO
> framework directly.
>
> We now have the GPIO chardev interface which meant to be used to support
> application specific logic that control the GPIOs, but where you don't want
> to write a kernel driver.
>
> My idea was to add GPIOs and GPIO chips as high level object inside libiio
> that can be accessed through the same context as the IIO devices. Similar to
> the current IIO API you have a API for gpios that allows to enumerate the
> GPIO devices and their pins as well as modify the pin state.

That would mean libiio has access to all GPIOs, allowing a remote person
to not only control through iiod the GPIOs for industrial control, but also the
GPIOs not intended for export, right?

Having a separate GPIO switch driver avoids that, as DT (or some other means)
can be used to specify and label the GPIOs for IIO use.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
