Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40243 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeDMQhh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2018 12:37:37 -0400
Received: by mail-qk0-f193.google.com with SMTP id o64so9694867qkl.7
        for <linux-iio@vger.kernel.org>; Fri, 13 Apr 2018 09:37:37 -0700 (PDT)
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 00/14] Move ad7746 driver out of staging
Date: Fri, 13 Apr 2018 13:36:37 -0300
Message-Id: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Version 2 of the series trying to move ad7746 our of staging.

Changes in v2: (v1-> https://lkml.org/lkml/2018/3/21/406)
* Fix some issues pointed out by Jonathan
* Power down device on remove
* Add new ABI for the use case

Hernán Gonzalez (14):
  staging: iio: ad7746: Automatically swap values in readings/writings
  staging: iio: ad7746: Adjust arguments to match open parenthesis
  staging: iio: ad7746: Fix bound checkings
  staging: iio: ad7746: Fix multiple line dereference
  staging: iio: ad7746: Reorder includes alphabetically
  staging: iio: ad7746: Reorder variable declarations
  staging: iio: ad7746: Remove unused defines
  staging: iio: ad7746: Add dt-bindings
  staging: iio: ad7746: Add remove()
  staging: iio: ad7746: Add comments
  staging: iio: ad7746: Add devicetree bindings documentation
  staging: iio: ad7746: Add ABI documentation
  Move ad7746 out of staging
  staging: iio: Remove ad7746 from staging

 Documentation/ABI/testing/sysfs-bus-iio-ad7746     |  17 +++
 .../devicetree/bindings/iio/cdc/ad7746.txt         |  34 +++++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/cdc/Kconfig                            |  16 ++
 drivers/iio/cdc/Makefile                           |   5 +
 drivers/{staging => }/iio/cdc/ad7746.c             | 162 ++++++++++++++++-----
 drivers/staging/iio/cdc/Kconfig                    |  10 --
 drivers/staging/iio/cdc/Makefile                   |   1 -
 .../staging => include/linux}/iio/cdc/ad7746.h     |   9 --
 10 files changed, 201 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad7746
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ad7746.txt
 create mode 100644 drivers/iio/cdc/Kconfig
 create mode 100644 drivers/iio/cdc/Makefile
 rename drivers/{staging => }/iio/cdc/ad7746.c (85%)
 rename {drivers/staging => include/linux}/iio/cdc/ad7746.h (70%)

-- 
2.7.4

