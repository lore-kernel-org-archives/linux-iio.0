Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36671 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbLEXdF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2015 18:33:05 -0500
Received: by pacdm15 with SMTP id dm15so105011591pac.3
        for <linux-iio@vger.kernel.org>; Sat, 05 Dec 2015 15:33:04 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/1] iio: chemical: add AMS iAQ-core support
Date: Sat,  5 Dec 2015 15:33:10 -0800
Message-Id: <1449358391-11851-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v1:
* changed channel masks to IIO_CHAN_INFO_PROCESSED
* return IIO_VAL_INT_PLUS_MICRO/NANO for VOC channels since they don't
  require any special scaling values
* change i2c_msg array to single element
* make sure data->buffer is locked in *_read_raw

Matt Ranostay (1):
  iio: chemical: add AMS iAQ-core support

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 drivers/iio/chemical/Kconfig                       |   8 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/ams-iaq-core.c                | 200 +++++++++++++++++++++
 4 files changed, 210 insertions(+)
 create mode 100644 drivers/iio/chemical/ams-iaq-core.c

-- 
1.9.1

