Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:41749 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756380AbdLPE5x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Dec 2017 23:57:53 -0500
Received: by mail-io0-f196.google.com with SMTP id o2so4720935ioe.8
        for <linux-iio@vger.kernel.org>; Fri, 15 Dec 2017 20:57:53 -0800 (PST)
Date: Fri, 15 Dec 2017 20:57:50 -0800
From: Brian Norris <briannorris@chromium.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, bleung@chromium.org,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: Re: [PATCH v4 2/2] rtc: cros-ec: add cros-ec-rtc driver.
Message-ID: <20171216045750.GB52366@google.com>
References: <20171110215553.20696-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110215553.20696-3-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Nov 10, 2017 at 10:55:53PM +0100, Enric Balletbo i Serra wrote:
> From: Stephen Barber <smbarber@chromium.org>
> 
> On platforms with a Chrome OS EC, the EC can function as a simple RTC.
> Add a basic driver with this functionality.
> 
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Benson Leung <bleung@chromium.org>
> ---
>  drivers/rtc/Kconfig       |  10 ++
>  drivers/rtc/Makefile      |   1 +
>  drivers/rtc/rtc-cros-ec.c | 413 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 424 insertions(+)
>  create mode 100644 drivers/rtc/rtc-cros-ec.c

This isn't quite super-helpful without the CrOS-EC / MFD additions to
actually create the device, but it's a good start, and I don't see any
problems with it. Any reason this isn't merged? Are the RTC maintainers
intendending to merge this, or should Lee (for the MFD header)? I
thought normally Lee deferred to other subsystem maintainers when the
only "MFD" stuff was a simple header change (such as in patch 1).

Anyway, FWIW:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
