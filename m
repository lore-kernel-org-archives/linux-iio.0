Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34234 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbcL1NBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2016 08:01:30 -0500
Received: by mail-qt0-f171.google.com with SMTP id d45so127091456qta.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 05:00:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMpxmJVpj57s-m_FS58J+QWvu-MnVmaZP-6ECnYHeRVSCfd-Fw@mail.gmail.com>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de> <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de> <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
 <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com>
 <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de> <CAMpxmJVpj57s-m_FS58J+QWvu-MnVmaZP-6ECnYHeRVSCfd-Fw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 28 Dec 2016 14:00:58 +0100
Message-ID: <CACRpkdYam=VTXHh--fnnC+R7g=7z_4wGT8bg+=n01gEMSa5Buw@mail.gmail.com>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
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

On Tue, Dec 13, 2016 at 3:28 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> + Linus
>
> While the new GPIO interface would be very convenient - in our case we
> could simply name the lines appropriately in the device tree - I'm not
> sure this would be the correct approach.
>
> From this year's ELCE in Berlin I remember Linus suggested during his
> talk that it's always better to write a kernel driver. Also: this way
> the relevant GPIO lines would not be reserved for exclusive use by
> power switches.
>
> Linus - do you have any thoughts/suggestions on that subject?

If the probe you are power cycling has its own DT node and is
described as a device per se in the system, then it should have
a device driver grabbing and toggling its own GPIO line.

If the probe is only really known in userspace, and driven
from userspace, it's GPIO reset line should also be driven
from userspace, using the chardev ABI as you describe.

Whether something should have a userspace or kernelspace
driver is a gray area, admittedly. There are cases for both.
The general consideration would be reuse and deployment.
If you expect all users of this probe to always use libiio and
some other userspace, I guess userspace-only makes sense?

Yours,
Linus Walleij
