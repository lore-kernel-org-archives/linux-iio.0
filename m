Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:59286 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbbFUKQK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 21 Jun 2015 06:16:10 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Phani Movva <Phani.Movva@imgtec.com>
Subject: [PATCH 0/2] cc10001_adc Kconfig and Makefile fixes
Date: Sun, 21 Jun 2015 12:15:49 +0200
Message-Id: <cover.1434844874.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adresses the cc10001_adc dependency issue pointed out by
Jonathan [1] and moves up its entries in Kconfig and Makefile, which
suffered from a merge with Sebastian Reichels tree, to get in the da9150.

[1] https://marc.info/?l=linux-iio&m=142774444503561

Hartmut Knaack (2):
  iio:adc:cc10001_adc: fix Kconfig dependency
  iio:adc:cc10001_adc: resort entry in Kconfig and Makefile

 drivers/iio/adc/Kconfig  | 21 ++++++++++-----------
 drivers/iio/adc/Makefile |  2 +-
 2 files changed, 11 insertions(+), 12 deletions(-)

-- 
2.3.6

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
