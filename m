Return-Path: <sst@poczta.fm>
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 08/10] iio: common: hid-sensors: use tab for indention
Date: Thu, 14 Apr 2016 21:36:40 +0200
Message-Id: <1460662602-2951-9-git-send-email-sst@poczta.fm>
In-Reply-To: <1460662602-2951-1-git-send-email-sst@poczta.fm>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
List-ID: <linux-iio@vger.kernel.org>

This fixes the error reported by checkpatch.pl:

ERROR: code indent should use tabs where possible

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 5955110..5b41f9d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -115,7 +115,7 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 		return ret;
 	}
 
- 	return 0;
+	return 0;
 #else
 	atomic_set(&st->user_requested_state, state);
 	return _hid_sensor_power_state(st, state);
-- 
2.8.0
