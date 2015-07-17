Return-Path: <qingsong.gou@ck-telecom.com>
From: Jandy Gou <qingsong.gou@ck-telecom.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com,
	viorel.suman@intel.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jandy Gou <qingsong.gou@ck-telecom.com>
Subject: [PATCH 0/2] Add DT binding support for mmc35240
Date: Fri, 17 Jul 2015 16:34:34 +0800
Message-Id: <1437122076-29816-1-git-send-email-qingsong.gou@ck-telecom.com>
List-ID: <linux-iio@vger.kernel.org>

Add basic DT binding for mmc35240
Add DT binding doc for mmc35240

Jandy Gou (2):
  iio: magnetometer: mmc35240: Add DT binding
  iio: magnetometer: mmc35240: Add DT binding doc

 .../devicetree/bindings/iio/magnetometer/mmc35240.txt       | 13 +++++++++++++
 drivers/iio/magnetometer/mmc35240.c                         |  7 +++++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt

-- 
1.9.1
