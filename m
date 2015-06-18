Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20850 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754139AbbFRLpe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Jun 2015 07:45:34 -0400
From: Cristina Ciocan <cristina.ciocan@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	Cristina Ciocan <cristina.ciocan@intel.com>
Subject: [PATCH v3 0/1] iio:light: Add support for APDS9930 ALS and proximity
Date: Thu, 18 Jun 2015 14:44:21 +0300
Message-Id: <1434627862-30908-1-git-send-email-cristina.ciocan@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

The current patch version adds support for Avago APDS9930 sensor on top of
APDS9300. The v2 patch set is the independent driver version, this is the one
suggested at review, combined with APDS9300.

Changes since v2:
	- added APDS9930 on top of APDS9300
	- added enable/disable functionality for both ALS and proximity (from
	sysfs)
	- code cleanup as suggested in v2 review

Cristina Ciocan (1):
  iio:light: Avago APDS9930 ALS and proximity sensor

 drivers/iio/light/apds9300.c | 1361 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 1248 insertions(+), 113 deletions(-)

--
1.8.1.2

