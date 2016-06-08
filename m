Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33428 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161912AbcFHOoI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2016 10:44:08 -0400
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
	linux-iio@vger.kernel.org, harald@ccbib.org,
	stefan.wahren@i2se.com, fabio.estevam@freescale.com,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v2 0/4] mxs-lradc: Split driver into MFD
Date: Wed,  8 Jun 2016 16:43:57 +0200
Message-Id: <cover.1465396835.git.ksenija.stanojevic@gmail.com>
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
 drivers/iio/adc/mxs-lradc-adc.c          |  813 ++++++++++++++
 drivers/iio/adc/mxs-lradc.c              | 1775 ------------------------------
 drivers/input/touchscreen/Kconfig        |   10 +
 drivers/input/touchscreen/Makefile       |    1 +
 drivers/input/touchscreen/mxs-lradc-ts.c |  726 ++++++++++++
 drivers/mfd/Kconfig                      |   17 +
 drivers/mfd/Makefile                     |    1 +
 drivers/mfd/mxs-lradc.c                  |  215 ++++
 include/linux/mfd/mxs-lradc.h            |  204 ++++
 11 files changed, 2001 insertions(+), 1790 deletions(-)
 create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
 delete mode 100644 drivers/iio/adc/mxs-lradc.c
 create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

-- 
1.9.1

