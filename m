Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34776 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbIQRBg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2015 13:01:36 -0400
Date: Thu, 17 Sep 2015 19:01:33 +0200
From: Luis de Bethencourt <luis@debethencourt.com>
To: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: Fix module autoload for OF platform drivers
Message-ID: <20150917170133.GA27387@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

These patches add the missing MODULE_DEVICE_TABLE() for OF to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (2):
  iio: adc: twl6030-gpadc: Fix module autoload for OF platform driver
  iio: dac: max5821: Fix module autoload for OF platform driver

 drivers/iio/adc/twl6030-gpadc.c | 1 +
 drivers/iio/dac/max5821.c       | 1 +
 2 files changed, 2 insertions(+)

-- 
2.4.6

