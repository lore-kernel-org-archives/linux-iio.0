Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:57293 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcDWT7Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2016 15:59:24 -0400
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V3 0/3] iio: mxs-lradc: simplify TS handling
Date: Sat, 23 Apr 2016 19:57:56 +0000
Message-Id: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series simplifies TS handling of mxs-lradc.

These patches has been tested with i.MX23 and i.MX28 but without
a touchscreen. I added only a bogus touchscreen in devicetree.

It would be nice if someone with a real touchscreen could test it.

Changes in V3:
- remove dev.parent assignment as suggested by Dimitry
- add new patch to remove mxs_lradc_ts_unregister
- remove PM implementation from series in order to wait until 
  Ksenija has split the driver

Changes in V2:
- rebase on iio/testing since patch 2 and 3 from V1 has been applied
- also remove input_unregister_device in patch 1
- use mask of virtual channels for IRQ disabling in patch 2

Stefan Wahren (3):
  iio: mxs-lradc: simplify TS registration
  iio: mxs-lradc: remove mxs_lradc_ts_unregister
  iio: mxs-lradc: disable only masked channels in     
    mxs_lradc_hw_stop

 drivers/iio/adc/mxs-lradc.c |   34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

-- 
1.7.9.5

