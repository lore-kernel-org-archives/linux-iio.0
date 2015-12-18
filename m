Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32912 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933050AbbLRRYO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Dec 2015 12:24:14 -0500
Received: by mail-wm0-f41.google.com with SMTP id p187so73775245wmp.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Dec 2015 09:24:14 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH v4 0/2] IIO version of INA2xx
Date: Fri, 18 Dec 2015 18:23:50 +0100
Message-Id: <1450459432-16057-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v4:
 * squash previous small fixes into one patch and catch up with fixes from
   linux-iio git, 'testing' branch.
 * fix endianness hint by the use of IIO_CPU, following Andrew's comment
 * fix spacing issue.
 * add separate ABI documentation entry

v3 and earlier : see http://www.spinics.net/lists/linux-iio/msg22100.html

Marc Titinger (2):
  iio: ina2xx: add support for TI INA2xx Power Monitors
  iio: ina2xx: add ABI documentation entry sysfs-bus-iio-ina2xx-adc

 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc |  24 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ina2xx-adc.c                       | 745 +++++++++++++++++++++
 4 files changed, 780 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
 create mode 100644 drivers/iio/adc/ina2xx-adc.c

-- 
1.9.1

