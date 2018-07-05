Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.steuer-voss.de ([85.183.69.95]:59072 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753134AbeGEJeS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jul 2018 05:34:18 -0400
Message-Id: <cover.1530782560.git.nikolaus.voss@loewensteinmedical.de>
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date: Thu, 5 Jul 2018 11:22:40 +0200
Subject: [PATCH v4 0/2] IIO: st_sensors_i2c: improve device enumeration
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de,
        Javier Martinez Canillas <javier@dowhile0.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When trying to instantiate a st_accel_i2c device from an ACPI based
system, I ran into some problems:

For my device, there is no ACPI match table entry, so rather than
creating /allocating a new ACPI HID for the device, I wanted to use an
existing DT table compatible entry via creating an ACPI_DT_NAMESPACE_HID
/PRP0001 HID ACPI entry (see Documentation/acpi/enumeration.txt).

This did not work because st_accel_i2c.c bails out if there is a ACPI
node but no ACPI table match. Use device_get_match_data API to get the
right driver data.

acpi_device_get_match_data() currently doesn't return DT compatible
matches. A separate patch is submitted to fix this.

v4:
  - rebased onto linux-next
  - add Andy Shevchenko as reviewer
v3:
  - remove unused i2c_device_id .driver_data fields as suggested by
    Javier Martinez Canillas.
v2:
  - use device_get_match_data API as suggested by Andy Shevchenko
  - removed syncing DT/I2C table names as Jonathan Cameron pointed out
    this would be an ABI change
  - converting from probe() to probe_new() is moved into a separate
    patch (as suggested by Jonathan Cameron)


Nikolaus Voss (2):
  IIO: st_accel_i2c.c: Simplify access to driver data
  IIO: st_accel_i2c.c: Use probe_new() instead of probe()

 drivers/iio/accel/st_accel_i2c.c | 64 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

-- 
2.17.1

