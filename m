Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:37777 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755031AbcGEKX2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 06:23:28 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de
Subject: [PATCH 0/4] iio: light: vcnl4000: cleanup and fixes
Date: Tue,  5 Jul 2016 12:23:17 +0200
Message-Id: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adds some cleanup to the vcnl4000 driver (use of BIT() macro,
rework of read_raw() return path), adds logging for VCNL4010 and VCNL4020
chips, and adds missing locking of the I2C measurement function

Peter Meerwald-Stadler (4):
  iio: light: vcnl4000: Mention and check support for VCNL4010 and
    VCNL4020
  iio: light: vcnl4000: Use BIT() macro
  iio: light: vcnl4000: Cleanup read_raw() returns
  iio: light: vcnl4000: Add missing locking

 drivers/iio/light/Kconfig    |    6 ++--
 drivers/iio/light/vcnl4000.c |   72 +++++++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 32 deletions(-)

-- 
1.7.10.4

