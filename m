Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36481 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbcGBWFb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Jul 2016 18:05:31 -0400
Received: by mail-pf0-f180.google.com with SMTP id t190so50302664pfb.3
        for <linux-iio@vger.kernel.org>; Sat, 02 Jul 2016 15:05:31 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [RFC 0/2] iio: add support for LMP91000EVM potentiostat board
Date: Sat,  2 Jul 2016 15:05:25 -0700
Message-Id: <1467497127-32431-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

LMP91000EVM evaluation board has LMP91000 potentiostat along with an
16-bit ADC for chemical sensoring applications.

 * add support for the TI LMP91000 potentiostat
 * add support for ADC141S626 and ADC161S626 ADC chips

Matt Ranostay (2):
  iio: adc: ti-adc1x1s: add support for TI 1-channel differential ADCs
  iio: potentiostat: add LMP91000 support

 .../devicetree/bindings/iio/adc/ti-adc1x1s.txt     |  16 ++
 .../bindings/iio/potentiostat/lmp91000.txt         |  28 ++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-adc1x1s.c                       | 233 ++++++++++++++++
 drivers/iio/potentiostat/Kconfig                   |  21 ++
 drivers/iio/potentiostat/Makefile                  |   6 +
 drivers/iio/potentiostat/lmp91000.c                | 303 +++++++++++++++++++++
 10 files changed, 622 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc1x1s.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
 create mode 100644 drivers/iio/adc/ti-adc1x1s.c
 create mode 100644 drivers/iio/potentiostat/Kconfig
 create mode 100644 drivers/iio/potentiostat/Makefile
 create mode 100644 drivers/iio/potentiostat/lmp91000.c

-- 
2.7.4

