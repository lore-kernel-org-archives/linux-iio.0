Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.171]:8428 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932104AbaBRPlG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 10:41:06 -0500
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: [PATCH 0/3] drivers/mcb: Bus support for MEN Chameleon Bus
Date: Tue, 18 Feb 2014 16:34:11 +0100
Message-ID: <1392737654-22682-1-git-send-email-johannes.thumshirn@men.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch-set introduces the MEN Chameleon Bus (MCB). MCB is not a "real" bus
like PCI, but a header section in the beginning of the FPGAs memory. This
headers are used to describe the IP-Cores inside that FPGA.

The MCB driver parses this header section and creates devices for the single
IP-Cores. It also provides an interface for device drivers to access these
resources.

Currently the bus driver has some limitations, for example IRQ handling or
memory mapped memory support, which will be addressed once drivers that need
these features are submitted.

As a first driver using the new bus, men_z188_adc.c, an IIO ADC driver, is
included in this patch-set.

Johannes Thumshirn (3):
  drivers: Introduce MEN Chameleon Bus
  mcb: Add PCI carrier for MEN Chameleon Bus
  iio: adc: Add MEN 16z188 ADC driver

 MAINTAINERS                     |   6 +
 drivers/Kconfig                 |   2 +
 drivers/Makefile                |   1 +
 drivers/iio/adc/Kconfig         |  10 +
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/men_z188_adc.c  | 172 ++++++++++++++++
 drivers/mcb/Kconfig             |  29 +++
 drivers/mcb/Makefile            |   7 +
 drivers/mcb/mcb-core.c          | 420 ++++++++++++++++++++++++++++++++++++++++
 drivers/mcb/mcb-internal.h      | 118 +++++++++++
 drivers/mcb/mcb-parse.c         | 159 +++++++++++++++
 drivers/mcb/mcb-pci.c           | 108 +++++++++++
 include/linux/mcb.h             | 113 +++++++++++
 include/linux/mod_devicetable.h |   5 +
 14 files changed, 1151 insertions(+)
 create mode 100644 drivers/iio/adc/men_z188_adc.c
 create mode 100644 drivers/mcb/Kconfig
 create mode 100644 drivers/mcb/Makefile
 create mode 100644 drivers/mcb/mcb-core.c
 create mode 100644 drivers/mcb/mcb-internal.h
 create mode 100644 drivers/mcb/mcb-parse.c
 create mode 100644 drivers/mcb/mcb-pci.c
 create mode 100644 include/linux/mcb.h

--
1.8.5.4

