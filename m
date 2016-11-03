Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:35404 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756576AbcKCM5n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Nov 2016 08:57:43 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 0/9] staging: iio: tsl2583: i2c cleanups
Date: Thu,  3 Nov 2016 08:56:11 -0400
Message-Id: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is my next round of staging cleanups to the tsl2581 light driver
in IIO staging. It mostly contains cleanups to the i2c code. I verified
that the driver still functions correctly using a TSL2581 hooked up to
a Raspberry Pi 2.

This patch set lays the foundation for moving to the regmap API.

Brian Masney (9):
  staging: iio: tsl2583: i2c_smbus_write_byte() / i2c_smbus_read_byte()
    migration
  staging: iio: tsl2583: removed unused code from device probing
  staging: iio: tsl2583: fixed ordering of comments
  staging: iio: tsl2583: remove redundant power off sequence in
    taos_chip_on()
  staging: iio: tsl2583: don't shutdown chip when updating the lux table
  staging: iio: tsl2583: remove redudant i2c call in
    taos_als_calibrate()
  staging: iio: tsl2583: fix issue with changes to calibscale and
    int_time not being set on the chip
  staging: iio: tsl2583: check if chip is suspended in
    in_illuminance_calibrate_store
  staging: iio: tsl2583: remove redundant write to the control register
    in taos_probe()

 drivers/staging/iio/light/tsl2583.c | 352 +++++++++++++-----------------------
 1 file changed, 126 insertions(+), 226 deletions(-)

-- 
2.5.5

