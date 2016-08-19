Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36742 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755632AbcHSUgR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2016 16:36:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id y134so1933716pfg.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Aug 2016 13:36:17 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/3] iio: chemical: atlas-ph-sensor: add ORP feature
Date: Fri, 19 Aug 2016 13:36:08 -0700
Message-Id: <1471638971-23039-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for the Oxidation-Reduction Potential SM OEM module from Atlas
Scientific part, and some regmap + locking cleanups.

Changes from v1:
* remove double locking of the mlock mutex

Matt Ranostay (3):
  iio: chemical: atlas-ph-sensor: switch to iio_device_*_direct_mode
    helpers
  iio: chemical: atlas-ph-sensor: switch to REGCACHE_NONE regmap tree
  iio: chemical: atlas-ph-sensor: add ORP feature

 .../bindings/iio/chemical/atlas,orp-sm.txt         | 22 ++++++
 drivers/iio/chemical/Kconfig                       |  1 +
 drivers/iio/chemical/atlas-ph-sensor.c             | 81 +++++++++++++++-------
 3 files changed, 80 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt

-- 
2.7.4

