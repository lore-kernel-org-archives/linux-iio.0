Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36436 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbcEYE30 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2016 00:29:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id g132so4110762pfb.3
        for <linux-iio@vger.kernel.org>; Tue, 24 May 2016 21:29:26 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/3] atlas-ph-sensor: add conductivity sensor support
Date: Tue, 24 May 2016 21:29:17 -0700
Message-Id: <1464150560-1186-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v1:
 * Add IIO_ELECTRICALCONDUCTIVITY type rather than do doing weird conversion to ppm
 * move device tree mapping table above probe for of_match_device

Changes from v2:
 * IIO_ELECTRICALCONDUCTIVITY defined as siemens per meter
 * Add IIO_CHAN_INFO_SCALE for IIO_ELECTRICALCONDUCTIVITY channel

Matt Ranostay (3):
  iio: chemical: atlas-ph-sensor: reorg driver to allow multiple chips
  iio: electricalconductivity: add IIO_ELECTRICALCONDUCTIVITY type
  iio: chemical: atlas-ph-sensor: add EC feature

 Documentation/ABI/testing/sysfs-bus-iio            |   7 +
 .../bindings/iio/chemical/atlas,ec-sm.txt          |  22 ++
 drivers/iio/chemical/Kconfig                       |   8 +-
 drivers/iio/chemical/atlas-ph-sensor.c             | 267 ++++++++++++++++-----
 drivers/iio/industrialio-core.c                    |   1 +
 include/uapi/linux/iio/types.h                     |   1 +
 6 files changed, 246 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt

-- 
2.7.4

