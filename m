Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:56719 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757213AbbGQIwr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 Jul 2015 04:52:47 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 0/8] bmc150_magn fix and cleanup
Date: Fri, 17 Jul 2015 10:52:23 +0200
Message-Id: <cover.1437090791.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some issues I spotted during review of this driver. First three are quite
obvious problems, the rest may be matter of taste or intended to stay 
in the original form. Opinions welcome.

Hartmut Knaack (8):
  iio:magnetometer:bmc150_magn: add regmap dependency
  iio:magnetometer:bmc150_magn: sort entry alphabetically
  iio:magnetometer:bmc150_magn: output intended variable
  iio:magnetometer:bmc150_magn: replace magic value
  iio:magnetometer:bmc150_magn: add error handling on gpio probe
  iio:magnetometer:bmc150_magn: protect runtime_resume with mutex
  iio:magnetometer:bmc150_magn: expand mutex in trigger_handler
  iio:magnetometer:bmc150_magn: use descriptive name for mask

 drivers/iio/magnetometer/Kconfig       | 32 ++++++++++++++++++--------------
 drivers/iio/magnetometer/Makefile      |  3 +--
 drivers/iio/magnetometer/bmc150_magn.c | 31 ++++++++++++++++++++++---------
 3 files changed, 41 insertions(+), 25 deletions(-)

-- 
2.4.3

