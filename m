Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36867 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760406Ab3DBTaS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Apr 2013 15:30:18 -0400
Message-ID: <515B31C6.2030609@kernel.org>
Date: Tue, 02 Apr 2013 20:30:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new stuff and staging graduations (IIO set 3
 for the 3.10 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 03b7f67bd1a085572539788d07c4630489108a35:

  staging: ti-soc-thermal: Add get_trend support (2013-04-01 12:27:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.10c

for you to fetch changes up to beca9e767e27f756d6aed9a62665e3f73546aabb:

  iio: at91_adc: fix missing Sample and Hold time (2013-04-02 19:22:16 +0100)

----------------------------------------------------------------
Third round of IIO cleanups, graduations and new stuff for the 3.10 cycle.

A small set including 3 things.
1) A short cleanup series for the ak8975.
2) Graduation of ak8975 out of staging.
3) Some additional bits for the at91 adc driver to cover low resolution
   modes, sleep and a little bit of missing documentation.

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (2):
      iio: at91_adc: add sleep mode support
      iio: at91_adc: fix missing Sample and Hold time

Jonathan Cameron (4):
      staging:iio:magnetometer:ak8975 drop unused eoc_irq
      staging:iio:magnetometer:ak8975 drop I2C_M_NOSTART flag in read_data
      staging:iio:magnetometer:ak8975 use standard i2c_smbus read functions.
      iio:magnetometer:ak8975 move driver out of staging

Ludovic Desroches (1):
      iio: at91_adc: add low and high res support

 .../devicetree/bindings/arm/atmel-adc.txt          | 13 ++++
 drivers/iio/adc/at91_adc.c                         | 90 ++++++++++++++++++++--
 drivers/iio/magnetometer/Kconfig                   | 11 +++
 drivers/iio/magnetometer/Makefile                  |  1 +
 drivers/{staging => }/iio/magnetometer/ak8975.c    | 69 ++++-------------
 drivers/staging/iio/magnetometer/Kconfig           | 11 ---
 drivers/staging/iio/magnetometer/Makefile          |  1 -
 7 files changed, 127 insertions(+), 69 deletions(-)
 rename drivers/{staging => }/iio/magnetometer/ak8975.c (90%)
