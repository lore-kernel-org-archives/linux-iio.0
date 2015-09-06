Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35895 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbIFU1b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 6 Sep 2015 16:27:31 -0400
Received: by padbj2 with SMTP id bj2so2603372pad.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2015 13:27:31 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 0/1] iio: humidity: add HDC100x support
Date: Sun,  6 Sep 2015 13:27:38 -0700
Message-Id: <1441571259-29334-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v3:
* Cleanup the switch statements
* Add comments on why i2c_smbus_read_word_data() cannot be used
  to get measurement data.

Matt Ranostay (1):
  iio: humidity: add HDC100x support

 .../ABI/testing/sysfs-bus-iio-humidity-hdc100x     |   9 +
 drivers/iio/humidity/Kconfig                       |  10 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc100x.c                     | 319 +++++++++++++++++++++
 4 files changed, 339 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
 create mode 100644 drivers/iio/humidity/hdc100x.c

-- 
1.9.1

