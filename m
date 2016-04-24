Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36350 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbcDXUnX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Apr 2016 16:43:23 -0400
Received: by mail-pa0-f65.google.com with SMTP id i5so13539348pag.3
        for <linux-iio@vger.kernel.org>; Sun, 24 Apr 2016 13:43:23 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 0/2] iio: chemical: atlas-ph-sensor: add conductivity sensor support
Date: Sun, 24 Apr 2016 13:43:14 -0700
Message-Id: <1461530596-2142-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset series adds the following functionality to the atlas-ph-sensor driver:
* Allow other sensor chips to share the core driver functionality
* Add support for the Atlas EC-SM OEM conductivity sensor

Matt Ranostay (2):
  iio: chemical: atlas-ph-sensor: reorg driver to allow multiple chips
  iio: chemical: atlas-ph-sensor: add EC feature

 .../bindings/iio/chemical/atlas,ec-sm.txt          |  22 ++
 drivers/iio/chemical/Kconfig                       |   8 +-
 drivers/iio/chemical/atlas-ph-sensor.c             | 244 ++++++++++++++++-----
 3 files changed, 221 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt

-- 
2.7.4

