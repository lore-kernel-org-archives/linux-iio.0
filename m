Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46490 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763252AbdDSOgD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Apr 2017 10:36:03 -0400
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Song Hongyan <hongyan.song@intel.com>,
        hock.leong.kweh@intel.com, linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: hid-sensor: fix return of -EINVAL on invalid values in ret or value
Date: Wed, 19 Apr 2017 15:35:48 +0100
Message-Id: <20170419143548.14130-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Ensure that when an invalid value in ret or value is found -EINVAL
is returned. A previous commit broke the way the return error is
being returned and instead caused the return code in ret to be
re-assigned rather than be returned.

Fixes: 5d9854eaea776 ("iio: hid-sensor: Store restore poll and hysteresis on S3")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 1c0874cdf665..aeb09a85d7a8 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -230,7 +230,7 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 	ret = sensor_hub_set_feature(st->hsdev, st->poll.report_id,
 				     st->poll.index, sizeof(value), &value);
 	if (ret < 0 || value < 0)
-		ret = -EINVAL;
+		return -EINVAL;
 
 	ret = sensor_hub_get_feature(st->hsdev,
 				     st->poll.report_id,
@@ -283,7 +283,7 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
 				     st->sensitivity.index, sizeof(value),
 				     &value);
 	if (ret < 0 || value < 0)
-		ret = -EINVAL;
+		return -EINVAL;
 
 	ret = sensor_hub_get_feature(st->hsdev,
 				     st->sensitivity.report_id,
-- 
2.11.0

