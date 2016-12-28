Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36346 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbcL1NIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2016 08:08:05 -0500
Received: by mail-qk0-f171.google.com with SMTP id n21so239611907qka.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 05:08:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9609b56b-194c-9899-1142-ff2ee285c6bd@metafoo.de>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de> <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de> <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
 <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com>
 <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de> <CAMuHMdX3u4cb2Yq2+VV_eDUaw2EqiOjN2TorW+F5-39Mm=mXmQ@mail.gmail.com>
 <9609b56b-194c-9899-1142-ff2ee285c6bd@metafoo.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 28 Dec 2016 14:08:04 +0100
Message-ID: <CACRpkdY11qxZuYsXXJJ5St7S_oYf_EUOzicm9vXoxYCHkVp4Lw@mail.gmail.com>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
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

On Fri, Dec 23, 2016 at 12:35 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 12/23/2016 11:00 AM, Geert Uytterhoeven wrote:

> Well, it is a policy question. Who gets access to what. Right now it is all
> or nothing, a privileged application gets access to all devices/GPIOs, a
> unprivileged application gets access to nothing. Same for GPIOs as well as
> IIO devices.
>
> iiod at the moment does not have any access control at all, which in itself
> is a problem. We need to add support for that at some point. I don't see an
> issue with implementing a finer grained access scheme when we do so. E.g.
> unprivileged applications only get access to certain pins.

I don't know why this is percieved as such a big practical problem.

It seems to me as more of a theoretical exploit path than a practical one.
(Famous last words...)

We have per-device and not per-line GPIO access restrictions.
/dev/gpiochip0
/dev/gpiochip1
etc
can all have per-device access restrictions.

This is no different from /dev/sda for example. You do not have
per-sector control of the block device, because it doesn't make sense.
Either you access all of the device, or nothing.
The same goes for IIO devices.

This pattern is very clear. You get access to a whole device or none
of it.

As with disks and IIO devices, if you want more granular access
restrictions, that is policy, and should reside in userspace.

Yours,
Linus Walleij
