Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36355 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425872AbdD2Ht3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Apr 2017 03:49:29 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v2 0/4] iio: accel: adxl345: Add support for buffered readings
Date: Sat, 29 Apr 2017 15:48:57 +0800
Message-Id: <cover.1493450577.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduce the DATA_READY trigger and enable triggered buffering. Additional
changes include introduction of functions set_mode and data_ready, allow
either INT1/INT2 pin be used by specifying interrupt-names.

Triggered buffer was tested on both DATA_READY trigger and the hrtimer software
trigger.

~ # ls /sys/bus/iio/devices/
iio:device0  trigger0     trigger1
~ # ls /config/iio/triggers/hrtimer/
t1
~ # cat /sys/bus/iio/devices/trigger0/name
t1
~ # cat /sys/bus/iio/devices/trigger1/name
adxl345-dev0
~ # iio_generic_buffer -n adxl345 -t t1 -c 5 -l 20 -a
iio device number being used is 0
iio trigger number being used is 0
Enabling all channels
Enabling: in_accel_y_en
Enabling: in_accel_x_en
Enabling: in_timestamp_en
Enabling: in_accel_z_en
/sys/bus/iio/devices/iio:device0 t1
0.306400 0.880900 9.575000 1493432411145155964 
0.306400 0.880900 9.575000 1493432411185154872 
0.306400 0.919200 9.536700 1493432411225167667 
0.306400 0.880900 9.536700 1493432411265157809 
0.344700 0.919200 9.536700 1493432411295108767 
Disabling: in_accel_y_en
Disabling: in_accel_x_en
Disabling: in_timestamp_en
Disabling: in_accel_z_en
~ # iio_generic_buffer -n adxl345 -t adxl345-dev0 -c 5 -l 20 -a
iio device number being used is 0
iio trigger number being used is 1
Enabling all channels
Enabling: in_accel_y_en
Enabling: in_accel_x_en
Enabling: in_timestamp_en
Enabling: in_accel_z_en
/sys/bus/iio/devices/iio:device0 adxl345-dev0
0.344700 0.919200 9.689900 1493432411336475189 
0.344700 0.880900 9.575000 1493432411336475189 
0.306400 0.957500 9.651600 1493432411336475189 
0.306400 0.880900 9.575000 1493432411336475189 
0.306400 0.919200 9.536700 1493432411336475189 
Disabling: in_accel_y_en
Disabling: in_accel_x_en
Disabling: in_timestamp_en
Disabling: in_accel_z_en
~ # 

Changes in v2:
* Provide a detailed commit message to those missing it
* Add Rob's Acked-by tag
* Make function naming more clear: drdy -> data_ready
  * Switch from while to do..while
  * Rename regval to val
  * Switch to usleep_range() for shorter delay
  * Add comment to justify delay
  * Change error code -EIO to -EAGAIN
* Endianness issue: scrap the get_triple function entirely, make no
  changes in terms of reading registers in read_raw
* Introduce mutex earlier rather than in succeeding patch
* Probe:
  * Fix random whitespace omission
  * Remove configuring to standby mode, the device powers on in standby
    mode so this is not needed
  * use variable 'regval' to hold value to be written to the register and call
    regmap_write() unconditionally
  * fix line splitting in devm_request_threaded_irq() and devm_iio_trigger_alloc()
  * Switch to devm_iio_trigger_register()
  * Switch to devm_iio_triggered_buffer_setup()
* Move the of_irq_get_byname() check in core file in order to avoid
  introducing another parameter in probe()
* adxl345_irq():
  * return values directly
  * switch from iio_trigger_poll() to iio_trigger_poll_chained(), the former
    should only be called at the top-half not at the bottom-half.
* adxl345_drdy_trigger_set_state():
  * move regmap_get_device() to definition block
  * regmap_update_bits(): line splitting - one parameter per line, remove extra
    parenthesis
* adxl345_trigger_handler()
  * if using external trigger, place a adxl345_data_ready() call before
    performing a bulk read
  * Since get_triple() is scrapped, place a direct bulk read here
  * Move mutex unlocking below goto label
* Remove i2c_check_functionality() that could introduce regression

Eva Rachel Retuya (4):
  dt-bindings: iio: accel: adxl345: Add optional interrupt-names support
  iio: accel: adxl345_core: Introduce set_mode and data_ready functions
  iio: accel: adxl345: Setup DATA_READY trigger
  iio: accel: adxl345: Add support for triggered buffer

 .../devicetree/bindings/iio/accel/adxl345.txt      |   4 +
 drivers/iio/accel/Kconfig                          |   2 +
 drivers/iio/accel/adxl345.h                        |   2 +-
 drivers/iio/accel/adxl345_core.c                   | 281 ++++++++++++++++++++-
 drivers/iio/accel/adxl345_i2c.c                    |   3 +-
 drivers/iio/accel/adxl345_spi.c                    |   2 +-
 6 files changed, 278 insertions(+), 16 deletions(-)

-- 
2.7.4

