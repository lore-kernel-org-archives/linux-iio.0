Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35612 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdASPGH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 10:06:07 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/5] Add GPIO set_multiple callback support for ISA_BUS_API drivers
Date: Thu, 19 Jan 2017 10:05:17 -0500
Message-Id: <cover.1484838095.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Most of the ISA_BUS_API drivers control GPIO via 8-bit ioport registers.
Since updating any given GPIO line involves writing out all 8 bits for
the respective register, it makes sense to add support for the GPIO
set_multiple callback function so that multiple GPIO lines may be set
more efficiently. This patchset adds such support in each respective
driver.

William Breathitt Gray (5):
  gpio: 104-dio-48e: Add set_multiple callback function support
  gpio: 104-idio-16: Add set_multiple callback function support
  gpio: gpio-mm: Add set_multiple callback function support
  gpio: ws16c48: Add set_multiple callback function support
  iio: stx104: Add GPIO set_multiple callback function support

 drivers/gpio/gpio-104-dio-48e.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-104-idio-16.c | 20 ++++++++++++++++++++
 drivers/gpio/gpio-gpio-mm.c     | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-ws16c48.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/stx104.c        | 23 +++++++++++++++++++++++
 5 files changed, 162 insertions(+)

-- 
2.11.0

