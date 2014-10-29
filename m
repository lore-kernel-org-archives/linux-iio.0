Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:11316 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398AbaJ2Upj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Oct 2014 16:45:39 -0400
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <jic23@kernel.org>,
	<Naidu.Tellapati@imgtec.com>, <james.hartley@imgtec.com>,
	<abrestic@chromium.org>
CC: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 0/2] iio: Add Cosmic Circuits ADC support
Date: Wed, 29 Oct 2014 20:45:29 +0000
Message-ID: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

This series adds support for a ADC IP block from Cosmic Circuits.
The device is a low resolution 10-bit ADC, with 8 channels.

The driver itself is quite simple and any feedback is welcome!

Based on v3.18-rc2.

Phani Movva (2):
  iio: adc: Cosmic Circuits 10001 ADC driver
  DT: iio: adc: Add CC_10001 binding documentation

 .../devicetree/bindings/iio/adc/cc_10001_adc.txt   |  19 +
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/cc_10001_adc.c                     | 421 +++++++++++++++++++++
 4 files changed, 448 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
 create mode 100644 drivers/iio/adc/cc_10001_adc.c

-- 
2.1.2

