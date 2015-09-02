Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35221 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbbIBD6j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Sep 2015 23:58:39 -0400
Received: by pacfv12 with SMTP id fv12so17995047pac.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2015 20:58:39 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/1] iio: humidty: add HDC100x support
Date: Tue,  1 Sep 2015 20:58:34 -0700
Message-Id: <1441166315-3044-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v2:
* Change 4.2 reference to 4.3
* Removed rogue newline
* Make sure adc_int_us isn't updated on error
* Allow an reading of 0 to be returned from hdc100x_read_measurement

Matt Ranostay (1):
  iio: humidity: add HDC100x support

 .../ABI/testing/sysfs-bus-iio-humidity-hdc100x     |   9 +
 drivers/iio/humidity/Kconfig                       |  10 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc100x.c                     | 317 +++++++++++++++++++++
 4 files changed, 337 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
 create mode 100644 drivers/iio/humidity/hdc100x.c

-- 
1.9.1

