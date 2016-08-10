Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35727 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcHJDSr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2016 23:18:47 -0400
Received: by mail-pf0-f194.google.com with SMTP id h186so1960934pfg.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Aug 2016 20:18:46 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 0/3] iio: chemical: atlas-ph-sensor: add support for ORP part
Date: Tue,  9 Aug 2016 20:05:56 -0700
Message-Id: <1470798359-4919-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for the Oxidation-Reduction Potential SM OEM module from Atlas
Scientific part, and some regmap + locking cleanups.

Matt Ranostay (3):
  iio: chemical: atlas-ph-sensor: switch to iio_device_*_direct_mode
    helpers
  iio: chemical: atlas-ph-sensor: switch to REGCACHE_NONE regmap tree
  iio: chemical: atlas-ph-sensor: add ORP feature

 .../bindings/iio/chemical/atlas,orp-sm.txt         | 22 +++++++
 drivers/iio/chemical/Kconfig                       |  1 +
 drivers/iio/chemical/atlas-ph-sensor.c             | 75 ++++++++++++++++------
 3 files changed, 79 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt

-- 
2.7.4

