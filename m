Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34475 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbdFVDTs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jun 2017 23:19:48 -0400
From: Jack Andersen <jackoalan@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Andersen <jackoalan@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH] DLN2 module for ADC interface
Date: Wed, 21 Jun 2017 17:19:08 -1000
Message-Id: <1498101549-6252-1-git-send-email-jackoalan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I've been having to blacklist the dln2 module in order to use Diolan's iffy
libusb-based "driver". I'd much rather use dln2, but the lack of ADC support
has been an issue for my robotics application.

I've extended the dln2 module with an additional platform driver to expose the
ADC using the IIO subsystem. It supports triggered buffering via the event
handle kept by dln2, as well as direct raw reads. The voltage scale is fixed
at 3.3v over 10-bits, since that appears to be the maximum resolution supported
by the hardware.

I've tested the module under 4.11.6 and everything appears to be stable.
However, this is my first patch, so it's possible I've missed something.

Jack Andersen (1):
  iio: adc: Add support for DLN2 ADC

 drivers/iio/adc/Kconfig    |   9 +
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/dln2-adc.c | 648 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/dln2.c         |  12 +
 4 files changed, 670 insertions(+)
 create mode 100644 drivers/iio/adc/dln2-adc.c

-- 
1.9.1

