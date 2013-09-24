Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34433 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab3IXMFh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2013 08:05:37 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so3614533pad.9
        for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2013 05:05:37 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 0/8] iio: Introduce devm_iio_device_{register,unregister}
Date: Tue, 24 Sep 2013 17:35:30 +0530
Message-Id: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

With the conversion of iio drivers to use device managed APIs, most of the
drivers now have a remove function with only the iio_device_unregister()
call. Thus introduce device managed version of iio_device_register() to
clean up lot of such code.
Have shown the usage in a few drivers to illustrate the cleanup. Will do
for the rest too.
This is only compile tested as I do not have any actual hardware to test ATM.


Sachin Kamat (8):
  iio: core: Implement devm_iio_device_{register,unregister}
  iio: accel: kxsd9: Use devm_iio_device_register
  iio: adc: mcp320x: Use devm_iio_device_register
  iio: adc: mcp3422: Use devm_iio_device_register
  iio: adc: ti-adc081c: Use devm_iio_device_register
  iio: adc: twl6030-gpadc: Use devm_iio_device_register
  iio: adc: viperboard: Use devm_iio_device_register
  iio: amplifiers: ad8366: Use devm_iio_device_register

 Documentation/driver-model/devres.txt |    2 ++
 drivers/iio/accel/kxsd9.c             |   10 +---------
 drivers/iio/adc/mcp320x.c             |    3 +--
 drivers/iio/adc/mcp3422.c             |    9 +--------
 drivers/iio/adc/ti-adc081c.c          |    3 +--
 drivers/iio/adc/twl6030-gpadc.c       |    5 +----
 drivers/iio/adc/viperboard_adc.c      |   12 +----------
 drivers/iio/amplifiers/ad8366.c       |    4 +---
 drivers/iio/industrialio-core.c       |   35 +++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h               |   25 +++++++++++++++++++++++
 10 files changed, 69 insertions(+), 39 deletions(-)

-- 
1.7.9.5

