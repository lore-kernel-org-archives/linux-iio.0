Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:56216 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132AbbGYWni (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Jul 2015 18:43:38 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 0/8] berlin2-adc fixes and cleanup
Date: Sun, 26 Jul 2015 00:43:18 +0200
Message-Id: <cover.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is some inconsistency in the register definition. Unfortunately, I
could not find a data sheet, so anyone with the data sheet at hand
(Antoine?) needs to check against the first patch before applying that
fix.
The rest are mainly cleanups and code restructuring.

Hartmut Knaack (8):
  iio:adc:berlin2-adc: Fix register definition
  iio:adc:berlin2-adc: pass up real error code
  iio:adc:berlin2-adc: use GENMASK and BIT for masks
  iio:adc:berlin2-adc: constify iio_chan_spec
  iio:adc:berlin2-adc: use short operator format
  iio:adc:berlin2-adc: use channel-array size directly
  iio:adc:berlin2-adc: enable interrupts with mutex locked
  iio:adc:berlin2-adc: coding style cleanup

 drivers/iio/adc/berlin2-adc.c | 115 ++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 56 deletions(-)

-- 
2.4.3

