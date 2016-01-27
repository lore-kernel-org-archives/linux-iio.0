Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34738 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbcA0Cef (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2016 21:34:35 -0500
Received: by mail-pa0-f41.google.com with SMTP id uo6so109819753pac.1
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2016 18:34:35 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 0/3] iio: chemical: add Atlas pH-SM sensor support
Date: Tue, 26 Jan 2016 18:34:28 -0800
Message-Id: <1453862071-1610-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v4:
* Correct temp scaling value
* Disable runtime pm if iio_device_register fails
* Add comment on toggling interrupt line

Matt Ranostay (3):
  devicetree: add Atlas Scientific LLC vendor prefix
  iio: ph: add IIO_PH channel type
  iio: chemical: add Atlas pH-SM sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |   7 +
 .../bindings/iio/chemical/atlas,ph-sm.txt          |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/chemical/Kconfig                       |  13 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/atlas-ph-sensor.c             | 511 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/uapi/linux/iio/types.h                     |   1 +
 8 files changed, 557 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 drivers/iio/chemical/atlas-ph-sensor.c

-- 
2.7.0.rc3

