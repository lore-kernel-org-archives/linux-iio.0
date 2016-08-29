Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55529 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756147AbcH2Cs4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Aug 2016 22:48:56 -0400
From: "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Pandruvada Srinivas <srinivas.pandruvada@intel.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Lim Lee Booi <lee.booi.lim@intel.com>,
        Lay Kuan Loon <kuan.loon.lay@intel.com>,
        Ooi Joyce <joyce.ooi@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
Subject: [PATCH] iio: fix pressure data output unit in hid-sensor-attributes
Date: Mon, 29 Aug 2016 18:50:56 +0800
Message-Id: <1472467856-14526-1-git-send-email-hock.leong.kweh@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: "Kweh, Hock Leong" <hock.leong.kweh@intel.com>

According to IIO ABI definition, IIO_PRESSURE data output unit is
kilopascal:
http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio

This patch fix output unit of HID pressure sensor IIO driver from pascal to
kilopascal to follow IIO ABI definition.

Signed-off-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index e81f434..dc33c1d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -56,8 +56,8 @@ static struct {
 	{HID_USAGE_SENSOR_ALS, 0, 1, 0},
 	{HID_USAGE_SENSOR_ALS, HID_USAGE_SENSOR_UNITS_LUX, 1, 0},
 
-	{HID_USAGE_SENSOR_PRESSURE, 0, 100000, 0},
-	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL, 1, 0},
+	{HID_USAGE_SENSOR_PRESSURE, 0, 100, 0},
+	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL, 0, 1000},
 };
 
 static int pow_10(unsigned power)
-- 
1.7.9.5

