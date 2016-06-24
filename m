Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36495 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbcFXMIB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2016 08:08:01 -0400
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
	linux-iio@vger.kernel.org, harald@ccbib.org,
	stefan.wahren@i2se.com, fabio.estevam@freescale.com,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v3 0/4] mxs-lradc: Split driver into MFD
Date: Fri, 24 Jun 2016 14:07:55 +0200
Message-Id: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Split existing driver mxs-lradc into MFD with touchscreen and
IIO part.

Tested on i.MX28.

Ksenija Stanojevic (4):
  mfd: mxs-lradc: Add support for mxs-lradc MFD
  iio: adc: mxs-lradc: Add support for adc driver
  input: touchscreen: mxs-lradc: Add support for touchscreen
  iio: adc: mxs-lradc: Remove driver

 drivers/iio/adc/Kconfig                  |   27 +-
 drivers/iio/adc/Makefile                 |    2 +-
 drivers/iio/adc/mxs-lradc-adc.c          |  811 ++++++++++++++
 drivers/iio/adc/mxs-lradc.c              | 1775 ------------------------------
 drivers/input/touchscreen/Kconfig        |   10 +
 drivers/input/touchscreen/Makefile       |    1 +
 drivers/input/touchscreen/mxs-lradc-ts.c |  729 ++++++++++++
 drivers/mfd/Kconfig                      |   17 +
 drivers/mfd/Makefile                     |    1 +
 drivers/mfd/mxs-lradc.c                  |  217 ++++
 include/linux/mfd/mxs-lradc.h            |  204 ++++
 11 files changed, 2004 insertions(+), 1790 deletions(-)
 create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
 delete mode 100644 drivers/iio/adc/mxs-lradc.c
 create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

-- 
1.9.1

