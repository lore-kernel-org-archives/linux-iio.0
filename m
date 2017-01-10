Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33785 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940710AbdAJSuv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 13:50:51 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, gnurou@gmail.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/3] pc104: Mask PC/104 Kconfig options
Date: Tue, 10 Jan 2017 13:50:28 -0500
Message-Id: <cover.1484073324.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

PC/104 form factor devices serve a specific niche of embedded system
users. Since PC/104 devices and hardware are typically used by just a
subset of Linux users, it would be appropriate to filter PC/104 related
Kconfig options for those uninterested.

This patchset introduces the PC104 Kconfig option, and uses it to mask
PC/104 specific device drivers and options, so that only those users
interested in PC/104 related Kconfig options are exposed to them.

William Breathitt Gray (3):
  pc104: Introduce the PC104 Kconfig option
  gpio: pc104: Mask PC/104 drivers via PC104 Kconfig option
  iio: pc104: Mask PC/104 drivers via the PC104 Kconfig option

 drivers/gpio/Kconfig        | 8 ++++----
 drivers/iio/adc/Kconfig     | 2 +-
 drivers/iio/counter/Kconfig | 2 +-
 init/Kconfig                | 7 +++++++
 4 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.11.0

