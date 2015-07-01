Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: pmeerw@pmeerw.net,
	jic23@kernel.org,
	christoph.muellner@theobroma-systems.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 8/8] iio: mma8452: leave sysfs namings to the iio core
Date: Wed,  1 Jul 2015 10:22:02 +0200
Message-Id: <1435738922-12580-9-git-send-email-martink@posteo.de>
In-Reply-To: <1435738922-12580-1-git-send-email-martink@posteo.de>
References: <1435738922-12580-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

This doesn't actually change anything since the core names the sysfs folder
for the iio event attributes "events" anyways. It only leaves the job to the
core.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index e23ebd0..2491ed0 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -721,7 +721,6 @@ static struct attribute *mma8452_event_attributes[] = {
 
 static struct attribute_group mma8452_event_attribute_group = {
 	.attrs = mma8452_event_attributes,
-	.name = "events",
 };
 
 #define MMA8452_CHANNEL(axis, idx, bits) { \
-- 
2.1.4
