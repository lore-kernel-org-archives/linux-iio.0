Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53413 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754054AbbDHP0k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 8 Apr 2015 11:26:40 -0400
From: Cristina Ciocan <cristina.ciocan@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	Cristina Ciocan <cristina.ciocan@intel.com>
Subject: [PATCH v2 0/1]  iio:light: Add support for APDS9930 ALS and proximity
Date: Wed,  8 Apr 2015 18:28:06 +0300
Message-Id: <1428506887-7247-1-git-send-email-cristina.ciocan@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This patch adds support for APDS9930. I am not sure about integrating it with
APDS9300 which is similar, I am waiting for reviews and if that is the case, I
shall integrate it in the next patch set.

I kept the threshold changing in the driver because I also adapt the ALS gain,
which leads to different values on the CH0 channel under the same light
conditions, thus the thresholds need adapting as well. The userspace can only
read these thresholds from sysfs, not change them.

Changes since v1:
	- ALS code cleanup
	- added proximity support

Cristina Ciocan (1):
  iio:light: Avago APDS9930 ALS and proximity sensor

 drivers/iio/light/Kconfig    |   10 +
 drivers/iio/light/Makefile   |    1 +
 drivers/iio/light/apds9930.c | 1097 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1108 insertions(+)
 create mode 100644 drivers/iio/light/apds9930.c

--
1.8.1.2

