Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33772 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeJIRuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Oct 2018 13:50:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so1257277wrs.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Oct 2018 03:33:47 -0700 (PDT)
Date: Tue, 9 Oct 2018 11:33:42 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, IIO and Input due for the
 v4.20 merge window
Message-ID: <20181009103342.GR4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180630103318.25355-1-vigneshr@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Enjoy!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-input-v4.20

for you to fetch changes up to 7a39915b723ae46e78c5189dfb3fc889df976a8d:

  Input: ti_am335x_tsc: Mark IRQ as wakeup capable (2018-10-09 11:28:31 +0100)

----------------------------------------------------------------
Immutable branch between MFD, IIO and Input due for the v4.20 merge window

----------------------------------------------------------------
Vignesh R (5):
      mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
      Input: ti_am335x_tsc: Mark TSC device as wakeup source
      mfd: ti_am335x_tscadc: Keep ADC interface on if child is wakeup capable
      iio: adc: ti_am335x_adc: Disable ADC during suspend unconditionally
      Input: ti_am335x_tsc: Mark IRQ as wakeup capable

 drivers/iio/adc/ti_am335x_adc.c           | 12 ++++--------
 drivers/input/touchscreen/ti_am335x_tsc.c | 22 +++++++++++++++++-----
 drivers/mfd/ti_am335x_tscadc.c            | 14 +++++++++++++-
 3 files changed, 34 insertions(+), 14 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
