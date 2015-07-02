Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44424 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279AbbGBW2r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 2 Jul 2015 18:28:47 -0400
From: Andreas Dannenberg <dannenberg@ti.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v3 0/2] iio: light: add support for TI's opt3001 light sensor
Date: Thu, 2 Jul 2015 17:27:57 -0500
Message-ID: <1435876079-26287-1-git-send-email-dannenberg@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

TI's opt3001 light sensor is a simple and yet powerful
little device. The device provides 99% IR rejection,
automatic full-scale, very low power consumption and
measurements from 0.01 to 83k lux.

This patch adds support for that device using the IIO
framework.

See http://www.ti.com/product/opt3001 for more information.

Patch History:
v3
  Add "ti,opt3001" device tree compatible string
  Add device tree binding documentation
v2 (Addressing feedback from Peter Meerwald + additional fixes)
  Fix restoring of IRQ mutex functionality in error case
  Use managed IIO device alloc/registration
  Add parenthesis to improve formula readability
  Fix error message number formatting
  Improve integration time parameter checks
  Clean up redundant return value assignments
  Fix broken lookup table algorithm
  Fix duplicate lookup table entry
  Disallow writing of negative event values

The individual commits can be reviewed at:
http://git.ti.com/cgit/cgit.cgi/ti-analog-linux-kernel/adannenb-analog.git/log/?h=opt3001

 .../devicetree/bindings/iio/light/opt3001.txt      |  18 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/opt3001.c                        | 804 +++++++++++++++++++++
 4 files changed, 833 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/opt3001.txt
 create mode 100644 drivers/iio/light/opt3001.c

-- 
1.9.1

