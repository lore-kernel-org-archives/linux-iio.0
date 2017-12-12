Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39495 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbdLLQFp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Dec 2017 11:05:45 -0500
Date: Tue, 12 Dec 2017 17:05:37 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH v4 0/2] Add support for cros-ec-rtc driver.
Message-ID: <20171212160537.GF8318@piout.net>
References: <20171110215553.20696-1-enric.balletbo@collabora.com>
 <CAFqH_53pDkcXXpzvPqF9OS0ahmhHCV87925E82d0p7ym5gq=VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFqH_53pDkcXXpzvPqF9OS0ahmhHCV87925E82d0p7ym5gq=VQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/12/2017 at 16:41:39 +0100, Enric Balletbo Serra wrote:
> +   Alessandro Zummo
> +   Alexandre Belloni
> 
> 2017-11-10 22:55 GMT+01:00 Enric Balletbo i Serra
> <enric.balletbo@collabora.com>:
> > Dear all,
> >
> > This is an attempt to revive some patches from that [1] patchset, some
> > of them are still under discussion but I think there is no reason to not
> > have the other two in this fourth version to land upstream meanwhile we
> > discuss about the others.
> >
> > [1] https://lkml.org/lkml/2017/7/12/182
> >
> > Changes since v3:
> > * Rebased an retested with current mainline using a Samsung Chromebook Plus
> > * Removed from patchset
> >   * 1/4 mfd: cros_ec: Get rid of cros_ec_check_features from cros_ec_dev.
> >   * 4/4 mfd: cros_ec: add RTC as mfd subdevice.
> >
> > Changes since v2:
> > - Rebase on top of mainline.
> > - Removed patch 'mfd: cros-ec: Fix host command buffer size' from series
> > as was already picked.
> >
> > Changes since v1:
> > - Removed patch 'iio: cros_ec_sensors: Fix return value to get raw and
> > calibbias data' from series as was already picked.
> > - Removed patch 'iio: cros_ec_sensors: Fix return value to get raw and
> > calibbias data' from series as was already picked.
> > - Patch 2/5: Acked-by: Jonathan Cameron <***@kernel.org>
> >
> > Best regards,
> >
> >  Enric
> >
> > Stephen Barber (2):
> >   mfd: cros_ec: Introduce RTC commands and events definitions.
> >   rtc: cros-ec: add cros-ec-rtc driver.
> >
> >  drivers/rtc/Kconfig                  |  10 +
> >  drivers/rtc/Makefile                 |   1 +
> >  drivers/rtc/rtc-cros-ec.c            | 413 +++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/cros_ec_commands.h |   8 +
> >  4 files changed, 432 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-cros-ec.c
> >
> > --
> > 2.9.3
> >
> 
> Sorry, I just noticed that my script to add the email recipients
> failed and I did not add the RTC maintainers :( So this is a gentle
> ping cc'ing the maintainers to take in consideration these patches. If
> you want I resend or something else just let me know please.
> 

I don't remember the specifics but I think the patches have the
necessary acks from me to go through the mfd tree (didn't we agree on
that ?)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
