Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33264 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJBZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Nov 2018 04:01:25 -0500
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Remove platform data and introduce DT bindings
Date: Sat, 17 Nov 2018 04:17:04 +0530
Message-Id: <20181116224704.24294-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset introduces device tree bindings for adt7316
driver and removes the usage of platform data from it.
Also, it sets the data field to it's appropriate value in 
the i2c read function which was nowhere being set before.

Shreeya Patel (7):
  Staging: iio: adt7316: Set the data field
  Staging: iio: adt7316: Add an extra check for 'ret' equals to 0
  Staging: iio: adt7316: Add of_device_id table
  Staging: iio: adt7316: Use device tree data to set ldac_pin
  Staging: iio: adt7316: Switch irq_flags to a local variable
  Staging: iio: adt7316: Change the name from irq_flags to irq_type
  Staging: iio: adt7316: Use device tree data to assign irq_type

 drivers/staging/iio/addac/adt7316-i2c.c | 19 +++++++++++-
 drivers/staging/iio/addac/adt7316-spi.c |  1 -
 drivers/staging/iio/addac/adt7316.c     | 39 ++++++++++++++++++-------
 drivers/staging/iio/addac/adt7316.h     |  1 -
 4 files changed, 47 insertions(+), 13 deletions(-)

-- 
2.17.1
