Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34646 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbcATFfu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jan 2016 00:35:50 -0500
Received: by mail-pa0-f52.google.com with SMTP id uo6so450616470pac.1
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2016 21:35:50 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 0/3] iio: chemical: add atlas ph sensor support
Date: Tue, 19 Jan 2016 21:35:43 -0800
Message-Id: <1453268146-28388-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v3:
* Allow temp output channel to be read during buffer enable
* Add volatile table for regmap reading/writing
* Make sizeof() parameters consistent

Matt Ranostay (3):
  devicetree: add Atlas Scientific LLC vendor prefix
  iio: ph: add IIO_PH channel type
  iio: chemical: add Atlas pH-SM sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |   7 +
 .../bindings/iio/chemical/atlas,ph-sm.txt          |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/chemical/Kconfig                       |  13 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/atlas-ph-sensor.c             | 497 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/uapi/linux/iio/types.h                     |   1 +
 8 files changed, 543 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 drivers/iio/chemical/atlas-ph-sensor.c

-- 
2.7.0.rc3

