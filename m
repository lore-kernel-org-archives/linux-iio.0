Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41264 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdLPFBR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Dec 2017 00:01:17 -0500
Received: by mail-pg0-f68.google.com with SMTP id o2so7091062pgc.8
        for <linux-iio@vger.kernel.org>; Fri, 15 Dec 2017 21:01:17 -0800 (PST)
Date: Fri, 15 Dec 2017 21:01:14 -0800
From: Brian Norris <briannorris@chromium.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>, bleung@chromium.org,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: Re: [PATCH v4 2/2] rtc: cros-ec: add cros-ec-rtc driver.
Message-ID: <20171216050114.GA53653@google.com>
References: <20171110215553.20696-3-enric.balletbo@collabora.com>
 <20171216045750.GB52366@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171216045750.GB52366@google.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

+ RTC maintainers

On Fri, Dec 15, 2017 at 08:57:50PM -0800, Brian Norris wrote:
> On Fri, Nov 10, 2017 at 10:55:53PM +0100, Enric Balletbo i Serra wrote:
> > From: Stephen Barber <smbarber@chromium.org>
> > 
> > On platforms with a Chrome OS EC, the EC can function as a simple RTC.
> > Add a basic driver with this functionality.
> > 
> > Signed-off-by: Stephen Barber <smbarber@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Acked-by: Benson Leung <bleung@chromium.org>
> > ---
> >  drivers/rtc/Kconfig       |  10 ++
> >  drivers/rtc/Makefile      |   1 +
> >  drivers/rtc/rtc-cros-ec.c | 413 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 424 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-cros-ec.c
> 
> This isn't quite super-helpful without the CrOS-EC / MFD additions to
> actually create the device, but it's a good start, and I don't see any
> problems with it. Any reason this isn't merged? Are the RTC maintainers
> intendending to merge this, or should Lee (for the MFD header)? I
> thought normally Lee deferred to other subsystem maintainers when the
> only "MFD" stuff was a simple header change (such as in patch 1).
> 
> Anyway, FWIW:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>
